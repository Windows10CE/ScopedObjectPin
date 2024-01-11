using System;
using System.Runtime.CompilerServices;
using ScopedObjectPin.IlHelpers;

namespace ScopedObjectPin;

public static unsafe class ScopedObjectPinner
{
    public static void Pin(object o, PtrAction callback)
    {
        Helper.PinObject(o, callback);
    }

    private static readonly IntPtr ObjectDataOffset = Helper.GetObjectDataOffset();
    private static readonly IntPtr StringDataOffset = (IntPtr)RuntimeHelpers.OffsetToStringData;

    public static void PinDataVoid(object o, PtrAction callback)
    {
        switch (o)
        {
            case string s:
                Helper.PinObjectWithOffset(s, StringDataOffset, callback);
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
    
#if NETSTANDARD1_0 || NET20 // generic APIs
    public static void PinData<T>(object o, PtrAction<T> callback)
    {
        switch (o)
        {
            case string s:
                Helper.PinObjectWithOffset(s, StringDataOffset, callback);
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
    public static void PinData<T, TState>(object o, TState state, StatefulPtrAction<T, TState> callback)
    {
        switch (o)
        {
            case string s:
                Helper.PinObjectWithOffset(s, state, StringDataOffset, callback);
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
#endif
}
