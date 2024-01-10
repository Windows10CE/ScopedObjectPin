.assembly extern mscorlib {}

.assembly ScopedObjectPin.IlHelpers {}

.class public auto ansi sealed ScopedObjectPin.IlHelpers.PtrAction extends [mscorlib]System.MulticastDelegate {
    .method public hidebysig specialname rtspecialname instance void .ctor(object 'object', native int 'method') runtime managed {}
    .method public hidebysig newslot virtual instance void Invoke(void* p) runtime managed {}
    .method public hidebysig newslot virtual instance class [mscorlib]System.IAsyncResult BeginInvoke (
        void* pointer,
        class [mscorlib]System.AsyncCallback callback,
        object 'object'
    ) runtime managed {}
    .method public hidebysig newslot virtual instance void EndInvoke (class [mscorlib]System.IAsyncResult result) runtime managed {}
}
.class public auto ansi abstract sealed ScopedObjectPin.IlHelpers.Helper extends System.Object {

    .method public hidebysig static void PinObject(object o, class ScopedObjectPin.IlHelpers.PtrAction callback) cil managed {
        .locals (
            object pinned pinnedObj
        )
        
        ldarg o
        stloc pinnedObj
        ldarg callback
        ldloc pinnedObj
        conv.u
        callvirt instance void ScopedObjectPin.IlHelpers.PtrAction::Invoke(void*)
        ret
    }
}