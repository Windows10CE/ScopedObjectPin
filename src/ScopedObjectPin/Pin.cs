using System;
using System.Runtime.CompilerServices;
using ScopedObjectPin.IlHelpers;

namespace ScopedObjectPin;

public static unsafe class Pin
{
    public static void Handle(object o, PtrAction callback)
    {
        Helper.PinObjectWithOffset(o, default, callback);
    }

    private static readonly IntPtr ObjectDataOffset = Helper.GetObjectDataOffset();

    public static void Object(object? o, PtrAction callback)
    {
        switch (o)
        {
            case string s:
                fixed (char* p = s)
                {
                    callback(p);
                }
                break;
            case Array a:
                Helper.PinArray(a, callback);
                break;
            case null:
                callback(null);
                break;
            default:
                Helper.PinObjectWithOffset(o, ObjectDataOffset, callback);
                break;
        }
    }

    public static void Array(Array? a, PtrAction callback)
    {
        if (a is null)
            callback(null);
        else
            Helper.PinArray(a, callback);
    }

#if NETSTANDARD1_0_OR_GREATER || NET20_OR_GREATER // generic APIs
    public static void Object<T>(object? o, PtrAction<T> callback)
    {
        switch (o)
        {
            case string s:
                fixed (char* p = s)
                {
                    callback((T*)p);
                }
                break;
            case Array a:
                Helper.PinArray(a, callback);
                break;
            case null:
                callback(null);
                break;
            default:
                Helper.PinObjectWithOffset(o, ObjectDataOffset, callback);
                break;
        }
    }
    public static void Object<T, TState>(object? o, TState state, StatefulPtrAction<T, TState> callback)
    {
        switch (o)
        {
            case string s:
                fixed (char* p = s)
                {
                    callback((T*)p, state);
                }
                break;
            case Array a:
                Helper.PinArray(a, state, callback);
                break;
            case null:
                callback(null, state);
                break;
            default:
                Helper.PinObjectWithOffset(o, state, ObjectDataOffset, callback);
                break;
        }
    }
    public static void Array<T>(T[]? a, PtrAction<T> callback)
    {
        fixed (T* p = a)
        {
            callback(p);
        }
    }

    public static void Array<T, TState>(T[]? a, TState state, StatefulPtrAction<T, TState> callback)
    {
        fixed (T* p = a)
        {
            callback(p, state);
        }
    }

    public static void String(string? s, PtrAction<char> callback)
    {
        fixed (char* p = s)
        {
            callback(p);
        }
    }

    public static void String<TState>(string? s, TState state, StatefulPtrAction<char, TState> callback)
    {
        fixed (char* p = s)
        {
            callback(p, state);
        }
    }
#endif
#if NETSTANDARD1_1 || NET45
    public static void Span<T>(ReadOnlySpan<T> s, PtrAction<T> callback)
    {
        fixed (T* p = s)
        {
            callback(p);
        }
    }
    
    public static void Span<T, TState>(ReadOnlySpan<T> s, TState state, StatefulPtrAction<T, TState> callback)
    {
        fixed (T* p = s)
        {
            callback(p, state);
        }
    }
#endif
}
