.assembly extern System.Runtime {
    .ver 4:0:0:0
    .publickey = (00 24 00 00 04 80 00 00 94 00 00 00 06 02 00 00 00 24 00 00 52 53 41 31 00 04 00 00 01 00 01 00 07 d1 fa 57 c4 ae d9 f0 a3 2e 84 aa 0f ae fd 0d e9 e8 fd 6a ec 8f 87 fb 03 76 6c 83 4c 99 92 1e b2 3b e7 9a d9 d5 
dc c1 dd 9a d2 36 13 21 02 90 0b 72 3c f9 80 95 7f c4 e1 77 10 8f c6 07 77 4f 29 e8 32 0e 92 ea 05 ec e4 e8 21 c0 a5 ef e8 f1 64 5c 4c 0c 93 c1 ab 99 28 5d 62 2c aa 65 2c 1d fa d6 3d 74 5d 6f 2d e5 f1 7e 5e af 
0f c4 96 3d 26 1c 8a 12 43 65 18 20 6d c0 93 34 4d 5a d2 93)
}

.assembly ScopedObjectPin.IlHelpers {
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.InternalsVisibleToAttribute::.ctor(string) = (
        01 00 0f 53 63 6f 70 65 64 4f 62 6a 65 63 74 50 69 6e 00 00
    )
}

.class private auto ansi '<Module>' extends class [System.Runtime]System.Object {}

.class public auto ansi sealed ScopedObjectPin.IlHelpers.PtrAction extends [System.Runtime]System.MulticastDelegate {
    .method public hidebysig specialname rtspecialname instance void .ctor(class [System.Runtime]System.Object 'object', native int 'method') runtime managed {}
    .method public hidebysig newslot virtual instance void Invoke(void* p) runtime managed {}
    .method public hidebysig newslot virtual instance class [System.Runtime]System.IAsyncResult BeginInvoke (
        void* pointer,
        class [System.Runtime]System.AsyncCallback callback,
        class [System.Runtime]System.Object 'object'
    ) runtime managed {}
    .method public hidebysig newslot virtual instance void EndInvoke (class [System.Runtime]System.IAsyncResult result) runtime managed {}
}
.class public auto ansi sealed ScopedObjectPin.IlHelpers.PtrAction`1<T> extends [System.Runtime]System.MulticastDelegate {
    .method public hidebysig specialname rtspecialname instance void .ctor(class [System.Runtime]System.Object 'object', native int 'method') runtime managed {}
    .method public hidebysig newslot virtual instance void Invoke(!T* p) runtime managed {}
    .method public hidebysig newslot virtual instance class [System.Runtime]System.IAsyncResult BeginInvoke (
        !T* pointer,
        class [System.Runtime]System.AsyncCallback callback,
        class [System.Runtime]System.Object 'object'
    ) runtime managed {}
    .method public hidebysig newslot virtual instance void EndInvoke (class [System.Runtime]System.IAsyncResult result) runtime managed {}
}
.class public auto ansi sealed ScopedObjectPin.IlHelpers.StatefulPtrAction`2<T, TState> extends [System.Runtime]System.MulticastDelegate {
    .method public hidebysig specialname rtspecialname instance void .ctor(class [System.Runtime]System.Object 'object', native int 'method') runtime managed {}
    .method public hidebysig newslot virtual instance void Invoke(!T* p, !TState state) runtime managed {}
    .method public hidebysig newslot virtual instance class [System.Runtime]System.IAsyncResult BeginInvoke (
        !T* pointer,
        !TState state,
        class [System.Runtime]System.AsyncCallback callback,
        class [System.Runtime]System.Object 'object'
    ) runtime managed {}
    .method public hidebysig newslot virtual instance void EndInvoke (class [System.Runtime]System.IAsyncResult result) runtime managed {}
}
.class private auto ansi abstract sealed ScopedObjectPin.IlHelpers.Helper extends [System.Runtime]System.Object {
    .method public hidebysig static void PinObject(class [System.Runtime]System.Object o, class ScopedObjectPin.IlHelpers.PtrAction callback) cil managed {
        .locals (
            class [System.Runtime]System.Object pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        conv.u
        callvirt instance void ScopedObjectPin.IlHelpers.PtrAction::Invoke(void*)
        ret
    }
    .method public hidebysig static void PinObjectWithOffset(class [System.Runtime]System.Object o, native int offset, class ScopedObjectPin.IlHelpers.PtrAction callback) cil managed {
        .locals (
            class [System.Runtime]System.Object pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        conv.u
        ldarg offset
        add
        callvirt instance void ScopedObjectPin.IlHelpers.PtrAction::Invoke(void*)
        ret
    }
    .method public hidebysig static void PinObjectWithOffset<T>(class [System.Runtime]System.Object o, native int offset, class ScopedObjectPin.IlHelpers.PtrAction`1<!!T> callback) cil managed {
        .locals (
            class [System.Runtime]System.Object pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        conv.u
        ldarg offset
        add
        callvirt instance void ScopedObjectPin.IlHelpers.PtrAction`1::Invoke(!!T*)
        ret
    }
    .method public hidebysig static void PinObjectWithOffset<T, TState>(class [System.Runtime]System.Object o, !!TState state, native int offset, class ScopedObjectPin.IlHelpers.StatefulPtrAction`2<!!T, !!TState> callback) cil managed {
        .locals (
            class [System.Runtime]System.Object pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        conv.u
        ldarg offset
        add
        ldarg state
        callvirt instance void ScopedObjectPin.IlHelpers.StatefulPtrAction`2::Invoke(!!T*, !!TState)
        ret
    }
    .method public hidebysig static void PinArray(class [System.Runtime]System.Array o, class ScopedObjectPin.IlHelpers.PtrAction callback) cil managed {
        .locals (
            class [System.Runtime]System.Array pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        ldc.i4.0
        call native int [System.Runtime]System.Runtime.InteropServices.Marshal::UnsafeAddrOfPinnedArrayElement(class [System.Runtime]System.Array, int32)
        callvirt instance void ScopedObjectPin.IlHelpers.PtrAction::Invoke(void*)
        ret
    }
    .method public hidebysig static void PinArray<T>(class [System.Runtime]System.Array o, class ScopedObjectPin.IlHelpers.PtrAction`1<!!T> callback) cil managed {
        .locals (
            class [System.Runtime]System.Array pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        ldc.i4.0
        call native int [System.Runtime]System.Runtime.InteropServices.Marshal::UnsafeAddrOfPinnedArrayElement(class [System.Runtime]System.Array, int32)
        callvirt instance void ScopedObjectPin.IlHelpers.PtrAction`1::Invoke(!!T*)
        ret
    }
    .method public hidebysig static void PinArray<T, TState>(class [System.Runtime]System.Array o, !!TState state, class ScopedObjectPin.IlHelpers.StatefulPtrAction`2<!!T, !!TState> callback) cil managed {
        .locals (
            class [System.Runtime]System.Array pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        ldc.i4.0
        call native int [System.Runtime]System.Runtime.InteropServices.Marshal::UnsafeAddrOfPinnedArrayElement(class [System.Runtime]System.Array, int32)
        ldarg state
        callvirt instance void ScopedObjectPin.IlHelpers.StatefulPtrAction`2::Invoke(!!T*)
        ret
    }
    .class nested public auto ansi sealed ByteBox extends [System.Runtime]System.Object {
        .field public class [System.Runtime]System.Byte Data
        .method public hidebysig specialname rtspecialname instance void .ctor() cil managed {
            ldarg.0
            call instance void [System.Runtime]System.Object::.ctor()
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
        conv.u
        ldloc boxed
        ldflda class [System.Runtime]System.IntPtr ScopedObjectPin.IlHelpers.Helper/ByteBox::Data
        conv.u
        sub
        ret
    }
}
