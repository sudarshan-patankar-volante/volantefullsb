({
    
    getRenewalHelper : function(component, event, helper) {
        
        var msg;
        var rewalPolicy;
        let errorMap = new Map();
        var recordId=component.get('v.recordId');
        var action = component.get("c.createRenewalPolicy");
        action.setParams({
            "policyId": recordId
        });
        action.setCallback(this, function(response) {
            var state=response.getState();
            rewalPolicy=response.getReturnValue();
            if(!rewalPolicy.includes("Fill Required Fields",0)&& !rewalPolicy.includes("Something wrong contact Admin",0)&& !rewalPolicy.includes("An error was encount",0)){
                rewalPolicy=response.getReturnValue();
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": rewalPolicy,
                    "slideDevName": "related"
                });
                navEvt.fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "type":"success",
                    "message": "The Renewal Policy Created successfully..."
                });
                toastEvent.fire();
            }else{
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": recordId,
                    "slideDevName": "related"
                });
                navEvt.fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Policy Renewal Unsuccessful!",
                    "type":"error",
                    "mode":"sticky",
                    "message": rewalPolicy
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})