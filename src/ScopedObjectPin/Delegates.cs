#if NET10_0_OR_GREATER
namespace ScopedObjectPin.IlHelpers;

public unsafe delegate void PtrAction(void* ptr);
public unsafe delegate void PtrAction<T>(T* ptr) where T : allows ref struct;
public unsafe delegate void StatefulPtrAction<T, in TState>(T* ptr, TState state) where T : allows ref struct where TState : allows ref struct;
#elif !NET10
using System.Runtime.CompilerServices;
using ScopedObjectPin.IlHelpers;

[assembly: TypeForwardedTo(typeof(PtrAction))]
[assembly: TypeForwardedTo(typeof(PtrAction<>))]
[assembly: TypeForwardedTo(typeof(StatefulPtrAction<,>))]
#endif
