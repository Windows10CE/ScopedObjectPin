namespace ScopedObjectPin;

public static unsafe class ScopedObjectPinner
{
    public static void Pin(object o, IlHelpers.Helper.PtrAction callback)
    {
        IlHelpers.Helper.PinObject(o, callback);
    }
}
