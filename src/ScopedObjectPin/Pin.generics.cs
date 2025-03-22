using System;
using System.Runtime.InteropServices;
using ScopedObjectPin.IlHelpers;

namespace ScopedObjectPin;

public static unsafe partial class Pin
{
    public static void Object<T>(object? o, PtrAction<T> callback)
#if NET9_0_OR_GREATER
        where T : allows ref struct
#endif
    {
        switch (o)
        {
            case string s:
                fixed (char* p = s)
                {
                    callback((T*)p);
                }
                break;
            case null:
                callback(null);
                break;
#if NET10_0_OR_GREATER
            case Array a:
                using (var handle = new TempPinHolder(a))
                {
                    callback((T*)Marshal.UnsafeAddrOfPinnedArrayElement(a, 0));
                }
                break;
            default:
                using (var handle = new TempPinHolder(o))
                {
                    callback((T*)handle.GCHandle.GetAddressOfObjectData());
                }
                break;
#else
            case Array a:
                Helper.PinArray(a, callback);
                break;
            default:
                Helper.PinObjectWithOffset(o, ObjectDataOffset, callback);
                break;
#endif
        }
    }
    public static void Object<T, TState>(object? o, TState state, StatefulPtrAction<T, TState> callback)
#if NET9_0_OR_GREATER
        where T : allows ref struct
        where TState : allows ref struct
#endif
    {
        switch (o)
        {
            case string s:
                fixed (char* p = s)
                {
                    callback((T*)p, state);
                }
                break;
            case null:
                callback(null, state);
                break;
#if NET10_0_OR_GREATER
            case Array a:
                using (var handle = new TempPinHolder(a))
                {
                    callback((T*)Marshal.UnsafeAddrOfPinnedArrayElement(a, 0), state);
                }
                break;
            default:
                using (var handle = new TempPinHolder(o))
                {
                    callback((T*)handle.GCHandle.GetAddressOfObjectData(), state);
                }
                break;
#else
            case Array a:
                Helper.PinArray(a, state, callback);
                break;
            default:
                Helper.PinObjectWithOffset(o, state, ObjectDataOffset, callback);
                break;
#endif
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
#if NET9_0_OR_GREATER
        where TState : allows ref struct
#endif
    {
        fixed (T* p = a)
        {
            callback(p, state);
        }
    }

    public static void Array<T>(Array? a, PtrAction<T> callback)
#if NET9_0_OR_GREATER
        where T : allows ref struct
#endif
    {
        if (a is null)
        {
            callback(null);
        }
        else
        {
#if NET10_0_OR_GREATER
            using var handle = new TempPinHolder(a);
            callback((T*)Marshal.UnsafeAddrOfPinnedArrayElement(a, 0));
#else
            Helper.PinArray(a, callback);
#endif
        }
    }

    public static void Array<T, TState>(Array? a, TState state, StatefulPtrAction<T, TState> callback)
#if NET9_0_OR_GREATER
        where T : allows ref struct
        where TState : allows ref struct
#endif
    {
        if (a is null)
        {
            callback(null, state);
        }
        else
        {
#if NET10_0_OR_GREATER
            using var handle = new TempPinHolder(a);
            callback((T*)Marshal.UnsafeAddrOfPinnedArrayElement(a, 0), state);
#else
            Helper.PinArray(a, state, callback);
#endif
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
#if NET9_0_OR_GREATER
        where TState : allows ref struct
#endif
    {
        fixed (char* p = s)
        {
            callback(p, state);
        }
    }
    
    public static void String<T>(string? s, PtrAction<T> callback)
#if NET9_0_OR_GREATER
        where T : allows ref struct
#endif
    {
        fixed (char* p = s)
        {
            callback((T*)p);
        }
    }

    public static void String<T, TState>(string? s, TState state, StatefulPtrAction<T, TState> callback)
#if NET9_0_OR_GREATER
        where T : allows ref struct
        where TState : allows ref struct
#endif
    {
        fixed (char* p = s)
        {
            callback((T*)p, state);
        }
    }

}