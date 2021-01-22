({
     handleSelectQuote : function (component, event, helper) {    
        var recordId=component.get('v.recordId');
        component.set("v.picklistField.Policy_Status__c",component.get("v.stepName"));                
        component.find("record").saveRecord($A.getCallback(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                component.find('notifLib').showToast({
                    "variant": "success",
                    "message": "Record was updated sucessfully",
                    "mode" : "sticky"
                });
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": recordId,
                    "slideDevName": "detail"
                });
                navEvt.fire();
            } else {
                component.find('notifLib').showToast({
                    "variant": "info",
                    "message": saveResult.error[0].message,
                    "mode" : "sticky"
                });
            }
        }));
    },
    handleSelect : function (component, event, helper) {     
        var stepName = event.getParam("detail").value; 
        var recordId=component.get('v.recordId');
        component.set("v.stepName", stepName);
        if(stepName != "NTU/Decline" && stepName != "Quoted"){
            component.set("v.picklistField.Policy_Status__c",stepName);
            component.find("record").saveRecord($A.getCallback(function(saveResult) {
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    component.find('notifLib').showToast({
                        "variant": "success",
                        "message": "Record was updated sucessfully",
                        "mode" : "sticky"
                    });
                    var navEvt = $A.get("e.force:navigateToSObject");
                    navEvt.setParams({
                        "recordId": recordId,
                        "slideDevName": "detail"
                    });
                    navEvt.fire();
                } else {
                    component.find('notifLib').showToast({
                        "variant": "info",
                        "message": saveResult.error[0].message,
                        "mode" : "sticky"
                    });
                }
            }));
        }else if(stepName == "Quoted"){
            	var message;            
                var action1 = component.get("c.getPSGWP");
                action1.setParams({
                    "policyId": recordId
                });
                action1.setCallback(this, function(response) {
                    var state=response.getState();
                    if(state=="SUCCESS"){
                        message=response.getReturnValue();                         
                        if(message != null && message != ''){
                        	component.set("v.isQuoted", true); 
                            component.set("v.message",message);
                        }else{
                            component.set("v.picklistField.Policy_Status__c",stepName);
                            component.find("record").saveRecord($A.getCallback(function(saveResult) {
                                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                                    component.find('notifLib').showToast({
                                        "variant": "success",
                                        "message": "Record was updated sucessfully",
                                        "mode" : "sticky"
                                    });                    
                                    var navEvt = $A.get("e.force:navigateToSObject");
                                    navEvt.setParams({
                                        "recordId": recordId,
                                        "slideDevName": "detail"
                                    });
                                    navEvt.fire();
                                } else {
                                    component.find('notifLib').showToast({
                                        "variant": "info",
                                        "message": saveResult.error[0].message,
                                        "mode" : "sticky"
                                    });
                                }
                            }));
                            
                        }
                    }else{
                        alert('state is '+state+' something wrong reload window '+response.getError());
                    } 
            });                   
            $A.enqueueAction(action1);            
        }else{
            var a = component.get('c.openModel');
            $A.enqueueAction(a);
        }
    },
    openModel: function(component, event, helper) {
        component.set("v.isOpen", true);
    },
    closeModel: function(component, event, helper) {
        component.set("v.isOpen", false);
        component.set("v.Quoted", false);
        var recordId=component.get('v.recordId');
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordId,
            "slideDevName": "detail"
        });
        navEvt.fire();
    }
})