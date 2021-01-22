({
    handleEdit : function(component, event, helper) { 
        var pName;
        var recordId=component.get('v.recordId');
        var editPolicyEvent = $A.get("e.force:editRecord");
        editPolicyEvent.setParams({
            "recordId": recordId
        });
        var action = component.get("c.getProfileName");
        action.setCallback(this, function(response) {
            var state=response.getState();
            if(state=="SUCCESS"){
                pName=response.getReturnValue();
                console.log(pName);
                if(pName==='System Administrator'){
                    editPolicyEvent.fire();
                }else{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Access Denied",
                        "type": "warning",
                        "message": "cant edit."
                    });
                    toastEvent.fire();  
                }
            }else{
                console.log('state::'+state);
            }
        });
        $A.enqueueAction(action);
    },
    handleDelete: function(component, event, helper) {
        var returnResult;
        var pName;
        var polid;
        var recordId=component.get('v.recordId');
        var action = component.get("c.getUserInfo");
        action.setParams({
            "psid": recordId
        });
        action.setCallback(this, function(response) {
            var state=response.getState();
            if(state=="SUCCESS"){
                returnResult=response.getReturnValue().split(',');
                pName=returnResult[0];
                polid=returnResult[1];
                console.log('Names::'+polid+returnResult+pName);
                if(pName==='System Administrator'){
                    component.find("recordHandler").deleteRecord($A.getCallback(function(deleteResult) {
                        if (deleteResult.state === "SUCCESS" || deleteResult.state === "DRAFT") {
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                "title": "Success",
                                "type": "Success",
                                "message": "Record Deleted."
                            });
                            toastEvent.fire();  
                            var relatedListEvent = $A.get("e.force:navigateToSObject");
                            relatedListEvent.setParams({
                                "recordId": polid,
                                "slideDevName": "related"
                            });
                            relatedListEvent.fire();
                        }else {
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                "title": "Somthing Problem",
                                "type": "Error",
                                "message": "Cant Delete."+JSON.stringify(deleteResult.error)
                            });
                            toastEvent.fire();
                        }
                    }));
                }else{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Access Denied",
                        "type": "warning",
                        "message": "Cant Delete."
                    });
					 toastEvent.fire();                   
                }
            }else{
                console.log('state::'+state);
            }
        });
        $A.enqueueAction(action);
    }
})