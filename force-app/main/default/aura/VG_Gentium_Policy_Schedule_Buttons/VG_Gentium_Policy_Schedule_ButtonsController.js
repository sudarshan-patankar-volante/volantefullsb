({
    doInit  : function(component, event, helper) {
        var ps;
        var recordId=component.get('v.recordId');
        var action = component.get("c.getPolicySchedule");
        action.setParams({
            "psId": recordId
        });
        action.setCallback(this, function(response) {
           var action = component.get("c.getCurrentUser");
           var user=$A.get("$Label.c.Delete_PS"); 
            action.setCallback(this, function(response) {
                var state=response.getState();
                if(state=="SUCCESS"){
                    if(response.getReturnValue() == user){                 
                    	component.set("v.allowDelete", true);
                	}
                }
            });
            $A.enqueueAction(action); 
            var state=response.getState();
            if(state=="SUCCESS"){
                ps=response.getReturnValue();
                component.set("v.product", ps.Product__c);
                if(ps.Policy__r.Policy_Status__c == 'Quoted'){                 
                    component.set("v.quote", true);
                }
                if((!ps.VG_Is_MTA__c && ps.Policy__r.Policy_Status__c == 'Booked')|| (ps.VG_Is_MTA__c && ps.VG_Status__c == 'Booked')){                 
                    component.set("v.mta", true);
                }
                if(ps.VG_Status__c !='Booked' && ps.VG_Is_MTA__c && (ps.VG_MTA_Type__c=='Revision of Cover'||ps.VG_MTA_Type__c=='Extension'||ps.VG_MTA_Type__c=='Cancellation'||ps.VG_MTA_Type__c=='Declaration')){
                    component.set("v.booked", true);
                }
                if(ps.VG_MTA_Type__c == null){
                    component.set("v.booked", false);
                }
            }
        });
        $A.enqueueAction(action);                    
    },
    Booked : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.bookPolicySchedule");
        action.setParams({
            "psId": recordId
        });
        action.setCallback(this,
                           function(response){
                               if(response.getState() == "SUCCESS"){
                                   $A.get('e.force:refreshView').fire();
                                   var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type": "success",
                                       "message": "Policy Schedule Booked."
                                   });
                                   toastEvent.fire(); 
                                   
                               }
                           }
                          );
        $A.enqueueAction(action);        
    },
    handleReviseClick : function(component, event, helper) {
        var status;
        var recordId=component.get('v.recordId');
        var product=component.get('v.product');
        var url;
        if(product == 'Fleet'){          
            url='/sfdcpage/'+encodeURIComponent('/apex/VG_Revise_Gentium_Edit1?PSID=')+recordId;
        }else {
            url='/sfdcpage/'+encodeURIComponent('/apex/VG_Revise_Gentium_Edit5?PSID=')+recordId;
        }
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        
        urlEvent.fire();            
        //$A.enqueueAction(action);        
    },
    handlePFClick : function(component, event, helper) {
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Payment_Details?Id=')+recordId;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();            
    },
    handleROCClick : function(component, event, helper) {
        var url;
        var recordId=component.get('v.recordId');
        var product=component.get('v.product');
        if(product == 'Fleet'){
            url='/sfdcpage/'+encodeURIComponent('/apex/VG_MTA_Step1?PSId=')+recordId+encodeURIComponent('&RecordType=GentiumFleet');
        }else {
            url='/sfdcpage/'+encodeURIComponent('/apex/VG_MTA_Step1?PSId=')+recordId+encodeURIComponent('&RecordType=GentiumScheme');
        }
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();            
        //$A.enqueueAction(action);        
    }, 
    deletePS : function(component, event, helper) {
        var policyID;
        var recordId=component.get('v.recordId');
        var action = component.get("c.deletePolicySchedule");
        action.setParams({
            "psId": recordId
        }); 
        action.setCallback(this, function(response) {
            var state=response.getState();
            if(state=="SUCCESS"){
                policyID=response.getReturnValue();
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": policyID,
                    "slideDevName": "detail"
                });
                navEvt.fire();
            }
        });
        $A.enqueueAction(action); 
    } 
})