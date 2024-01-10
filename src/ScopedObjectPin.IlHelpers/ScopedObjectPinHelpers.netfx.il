.assembly extern mscorlib {}

.assembly ScopedObjectPin.IlHelpers {}

.class public auto ansi abstract sealed ScopedObjectPin.IlHelpers.Helper extends System.Object {
    .class nested public auto ansi sealed PtrAction extends [mscorlib]System.MulticastDelegate {
        .method public hidebysig specialname rtspecialname instance void .ctor(object 'object', native int 'method') runtime managed {}
        .method public hidebysig newslot virtual instance void Invoke(void* p) runtime managed {}
    }
    .method public hidebysig static void PinObject(object o, class ScopedObjectPin.IlHelpers.Helper/PtrAction callback) cil managed {
        .locals (
            object pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        conv.u
        callvirt instance void ScopedObjectPin.IlHelpers.Helper/PtrAction::Invoke(void*)
        ret
    }
}