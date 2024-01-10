.assembly extern mscorlib {}

.assembly ScopedObjectPin.IlHelpers {}

.class private auto ansi '<Module>' {}

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
.class public auto ansi abstract sealed ScopedObjectPin.IlHelpers.Helper extends class [mscorlib]System.Object {

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
}