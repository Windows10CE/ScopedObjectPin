namespace ScopedObjectPin;

public static unsafe class ScopedObjectPinner
{
    public static void Pin(object o, IlHelpers.PtrAction callback)
    {
        IlHelpers.Helper.PinObject(o, callback);
    }
}
