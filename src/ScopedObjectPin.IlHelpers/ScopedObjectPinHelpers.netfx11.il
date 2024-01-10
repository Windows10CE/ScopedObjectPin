.assembly extern mscorlib {}

.assembly ScopedObjectPin.IlHelpers {}

.class private auto ansi '<Module>' extends class [mscorlib]System.Object {}

.class public auto ansi sealed ScopedObjectPin.IlHelpers.PtrAction extends [mscorlib]System.MulticastDelegate {
    .method public hidebysig specialname rtspecialname instance void .ctor(class [mscorlib]System.Object 'object', native int 'method') runtime managed {}
    .method public hidebysig newslot virtual instance void Invoke(void* p) runtime managed {}
    .method public hidebysig newslot virtual instance class [mscorlib]System.IAsyncResult BeginInvoke (
        void* pointer,
        class [mscorlib]System.AsyncCallback callback,
        class [mscorlib]System.Object 'object'
    ) runtime managed {}
    .method public hidebysig newslot virtual instance void EndInvoke (class [mscorlib]System.IAsyncResult result) runtime managed {}
}
.class public auto ansi abstract sealed ScopedObjectPin.IlHelpers.Helper extends [mscorlib]System.Object {
    .method public hidebysig static void PinObject(class [mscorlib]System.Object o, class ScopedObjectPin.IlHelpers.PtrAction callback) cil managed {
        .locals (
            class [mscorlib]System.Object pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        conv.u
        callvirt instance void ScopedObjectPin.IlHelpers.PtrAction::Invoke(void*)
        ret
    }
    .method public hidebysig static void PinObjectWithOffset(class [mscorlib]System.Object o, native int offset, class ScopedObjectPin.IlHelpers.PtrAction callback) cil managed {
        .locals (
            class [mscorlib]System.Object pinned pinnedObj
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
    .method public hidebysig static void PinArray(class [mscorlib]System.Array o, class ScopedObjectPin.IlHelpers.PtrAction callback) cil managed {
        .locals (
            class [mscorlib]System.Array pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        ldc.i4.0
        call native int [mscorlib]System.Runtime.InteropServices.Marshal::UnsafeAddrOfPinnedArrayElement(class [mscorlib]System.Array, int32)
        callvirt instance void ScopedObjectPin.IlHelpers.PtrAction::Invoke(void*)
        ret
    }
    .class nested public auto ansi sealed ByteBox extends [mscorlib]System.Object {
        .field public class [mscorlib]System.Byte Data
        .method public hidebysig specialname rtspecialname instance void .ctor() cil managed {
            ldarg.0
            call instance void [mscorlib]System.Object::.ctor()
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
        ldflda class [mscorlib]System.IntPtr ScopedObjectPin.IlHelpers.Helper/ByteBox::Data
        conv.u
        sub
        ret
    }
}
