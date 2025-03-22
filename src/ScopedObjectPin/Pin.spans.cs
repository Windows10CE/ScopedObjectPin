using System;
using ScopedObjectPin.IlHelpers;

namespace ScopedObjectPin;

public static unsafe partial class Pin
{
    public static void Span<T>(ReadOnlySpan<T> s, PtrAction<T> callback)
    {
        fixed (T* p = s)
        {
            callback(p);
        }
    }
    
    public static void Span<T, TState>(ReadOnlySpan<T> s, TState state, StatefulPtrAction<T, TState> callback)
#if NET9_0_OR_GREATER
        where TState : allows ref struct
#endif
    {
        fixed (T* p = s)
        {
            callback(p, state);
        }
    }
}
