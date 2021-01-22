({
	handleEditClick : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var editCBXEvent = $A.get("e.force:editRecord");
        editCBXEvent.setParams({
            "recordId": recordId
        }); 
        editCBXEvent.fire();
    }
})