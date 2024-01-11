#include "coreassembly.h"

#ifdef NETSTANDARD
.assembly extern INTEROP_SERVICES { .ver 4:0:0:0 }
#endif

.assembly ScopedObjectPin.IlHelpers {
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.InternalsVisibleToAttribute::.ctor(string) = (
        01 00 0f 53 63 6f 70 65 64 4f 62 6a 65 63 74 50 69 6e 00 00
    )
}

.class private auto ansi '<Module>' extends class [CORE_ASSEMBLY]System.Object
{
}

.class public auto ansi sealed ScopedObjectPin.IlHelpers.PtrAction extends [CORE_ASSEMBLY]System.MulticastDelegate {
    .method public hidebysig specialname rtspecialname instance void .ctor(class [CORE_ASSEMBLY]System.Object 'object', native int 'method') runtime managed {}
    .method public hidebysig newslot virtual instance void Invoke(void* p) runtime managed {}
    .method public hidebysig newslot virtual instance class [CORE_ASSEMBLY]System.IAsyncResult BeginInvoke (
        void* pointer,
        class [CORE_ASSEMBLY]System.AsyncCallback callback,
        class [CORE_ASSEMBLY]System.Object 'object'
    ) runtime managed {}
    .method public hidebysig newslot virtual instance void EndInvoke (class [CORE_ASSEMBLY]System.IAsyncResult result) runtime managed {}
}

#ifndef NET11
.class public auto ansi sealed ScopedObjectPin.IlHelpers.PtrAction`1<T> extends [CORE_ASSEMBLY]System.MulticastDelegate {
    .method public hidebysig specialname rtspecialname instance void .ctor(class [CORE_ASSEMBLY]System.Object 'object', native int 'method') runtime managed {}
    .method public hidebysig newslot virtual instance void Invoke(!T* p) runtime managed {}
    .method public hidebysig newslot virtual instance class [CORE_ASSEMBLY]System.IAsyncResult BeginInvoke (
        !T* p,
        class [CORE_ASSEMBLY]System.AsyncCallback callback,
        class [CORE_ASSEMBLY]System.Object 'object'
    ) runtime managed {}
    .method public hidebysig newslot virtual instance void EndInvoke (class [CORE_ASSEMBLY]System.IAsyncResult result) runtime managed {}
}

.class public auto ansi sealed ScopedObjectPin.IlHelpers.StatefulPtrAction`2<T, TState> extends [CORE_ASSEMBLY]System.MulticastDelegate {
    .method public hidebysig specialname rtspecialname instance void .ctor(class [CORE_ASSEMBLY]System.Object 'object', native int 'method') runtime managed {}
    .method public hidebysig newslot virtual instance void Invoke(!T* p, !TState state) runtime managed {}
    .method public hidebysig newslot virtual instance class [CORE_ASSEMBLY]System.IAsyncResult BeginInvoke (
        !T* p,
        !TState state,
        class [CORE_ASSEMBLY]System.AsyncCallback callback,
        class [CORE_ASSEMBLY]System.Object 'object'
    ) runtime managed {}
    .method public hidebysig newslot virtual instance void EndInvoke (class [CORE_ASSEMBLY]System.IAsyncResult result) runtime managed {}
}
#endif

.class private auto ansi abstract sealed ScopedObjectPin.IlHelpers.Helper extends [CORE_ASSEMBLY]System.Object {
    .method public hidebysig static void PinObjectWithOffset(class [CORE_ASSEMBLY]System.Object o, native int offset, class ScopedObjectPin.IlHelpers.PtrAction callback) cil managed {
        .locals (
            class [CORE_ASSEMBLY]System.Object pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        conv.u
        ldarg offset
        add
        callvirt instance void class ScopedObjectPin.IlHelpers.PtrAction::Invoke(void*)
        ret
    }
#ifndef NET11
    .method public hidebysig static void PinObjectWithOffset<T>(class [CORE_ASSEMBLY]System.Object o, native int offset, class ScopedObjectPin.IlHelpers.PtrAction`1<!!T> callback) cil managed {
        .locals (
            class [CORE_ASSEMBLY]System.Object pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        conv.u
        ldarg offset
        add
        callvirt instance void class ScopedObjectPin.IlHelpers.PtrAction`1<!!T>::Invoke(!0*)
        ret
    }
    .method public hidebysig static void PinObjectWithOffset<T, TState>(class [CORE_ASSEMBLY]System.Object o, !!TState state, native int offset, class ScopedObjectPin.IlHelpers.StatefulPtrAction`2<!!T, !!TState> callback) cil managed {
        .locals (
            class [CORE_ASSEMBLY]System.Object pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        conv.u
        ldarg offset
        add
        ldarg state
        callvirt instance void class ScopedObjectPin.IlHelpers.StatefulPtrAction`2<!!T, !!TState>::Invoke(!0*, !1)
        ret
    }
#endif
    .method public hidebysig static void PinArray(class [CORE_ASSEMBLY]System.Array o, class ScopedObjectPin.IlHelpers.PtrAction callback) cil managed {
        .locals (
            class [CORE_ASSEMBLY]System.Array pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        ldc.i4.0
        call native int [INTEROP_SERVICES]System.Runtime.InteropServices.Marshal::UnsafeAddrOfPinnedArrayElement(class [CORE_ASSEMBLY]System.Array, int32)
        callvirt instance void class ScopedObjectPin.IlHelpers.PtrAction::Invoke(void*)
        ret
    }
#ifndef NET11
    .method public hidebysig static void PinArray<T>(class [CORE_ASSEMBLY]System.Array o, class ScopedObjectPin.IlHelpers.PtrAction`1<!!T> callback) cil managed {
        .locals (
            class [CORE_ASSEMBLY]System.Array pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        ldc.i4.0
        call native int [INTEROP_SERVICES]System.Runtime.InteropServices.Marshal::UnsafeAddrOfPinnedArrayElement(class [CORE_ASSEMBLY]System.Array, int32)
        conv.u
        callvirt instance void class ScopedObjectPin.IlHelpers.PtrAction`1<!!T>::Invoke(!0*)
        ret
    }
    .method public hidebysig static void PinArray<T, TState>(class [CORE_ASSEMBLY]System.Array o, !!TState state, class ScopedObjectPin.IlHelpers.StatefulPtrAction`2<!!T, !!TState> callback) cil managed {
        .locals (
            class [CORE_ASSEMBLY]System.Array pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        ldc.i4.0
        call native int [INTEROP_SERVICES]System.Runtime.InteropServices.Marshal::UnsafeAddrOfPinnedArrayElement(class [CORE_ASSEMBLY]System.Array, int32)
        conv.u
        ldarg state
        callvirt instance void class ScopedObjectPin.IlHelpers.StatefulPtrAction`2<!!T, !!TState>::Invoke(!0*, !1)
        ret
    }
#endif
    .class nested public auto ansi sealed ByteBox extends [CORE_ASSEMBLY]System.Object {
        .field public valuetype [CORE_ASSEMBLY]System.Byte Data
        .method public hidebysig specialname rtspecialname instance void .ctor() cil managed {
            ldarg.0
            call instance void [CORE_ASSEMBLY]System.Object::.ctor()
            ret
        }
    }
    .method public hidebysig static native int GetObjectDataOffset() cil managed {
        .locals (
            class ScopedObjectPin.IlHelpers.Helper/ByteBox pinned boxed
        )
        newobj instance void ScopedObjectPin.IlHelpers.Helper/ByteBox::.ctor()
        stloc boxed
        ldloc boxed
        ldflda valuetype [CORE_ASSEMBLY]System.Byte ScopedObjectPin.IlHelpers.Helper/ByteBox::Data
        conv.u
        ldloc boxed
        conv.u
        sub
        ret
    }
}
