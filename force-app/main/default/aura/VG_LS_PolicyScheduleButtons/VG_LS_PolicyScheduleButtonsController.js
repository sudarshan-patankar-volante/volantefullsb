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
                //component.set("v.policyCurrency",ps.CurrencyIsoCode);
                if(ps.Policy__r.Policy_Status__c == 'Quoted'){                 
                    component.set("v.quote", true);
                }else if(ps.Policy__r.Policy_Status__c=='Bound'){
                    component.set("v.schedule",true);
                }
                if((!ps.VG_Is_MTA__c && ps.Policy__r.Policy_Status__c == 'Booked')|| (ps.VG_Is_MTA__c && ps.VG_Status__c == 'Booked')){   
                    component.set("v.mta", true);
                }
                if(ps.VG_Status__c !='Booked' && ps.VG_Is_MTA__c && (ps.VG_MTA_Type__c == 'Revision of Cover' || ps.VG_MTA_Type__c=='Run-Off' || ps.VG_MTA_Type__c == 'Extension' || ps.VG_MTA_Type__c == 'Cancellation' || ps.VG_MTA_Type__c == 'Declaration' || ps.VG_MTA_Type__c == 'Reduction')){
                    component.set("v.booked", true);
                }
                if(ps.VG_MTA_Type__c == null){
                    component.set("v.booked", false);
                }
                if(ps.Product__c == 'PA'){                 
                    component.set("v.gpa", true);                   
                }
                if(ps.Product__c=='Liability'){
                    if(ps.Policy__r.Policy_Status__c=='Bound'){
               			component.set("v.el", true);
                    }
                    
                }    
               
            }else{
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
                               var toastEvent = $A.get("e.force:showToast");
                               if(response.getState() == "SUCCESS"){
                                   $A.get('e.force:refreshView').fire();
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type": "success",
                                       "message": "Policy Schedule Booked."
                                   });                                   
                               }else{
                                   var errors = response.getError();
                                   $A.get('e.force:refreshView').fire();                                   
                                   toastEvent.setParams({
                                       "title": "You encountered some errors when trying to save this record",
                                       "type": "info",
                                       "message": errors[0].pageErrors[0].message,
                                       "mode" : "sticky"
                                   }); 
                               }
                               toastEvent.fire(); 
                           }
                          );
        $A.enqueueAction(action);        
    },
    handleReviseClick : function(component, event, helper) {
        var status;
        var recordId=component.get('v.recordId');
        //var policyCurrency=component.get('v.policyCurrency');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Revise_LS_Step_1?Id=')+recordId;
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
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_MTA_Step1?PSId=')+recordId+encodeURIComponent('&RecordType=Affinity');
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
    },
    handlestatement: function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createLSStatementAttachment");
        action.setParams({
            "psId": recordId
        });
        action.setCallback(this,
                           function(response){
                               if(response.getState() == "SUCCESS"){
                                   var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type": "success",
                                       "message": "LS Statement Attachment added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);  
    },    
    handleLSGPASchedule: function(component, event, helper) {
           var recordId=component.get('v.recordId');
        var action = component.get("c.createPSGPAAttachment");
        action.setParams({
            "psId": recordId
        });
        action.setCallback(this,
                           function(response){
                               if(response.getState() == "SUCCESS"){
                                   var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type": "success",
                                       "message": "Group Personal Accident Schedule Attachment added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);  
    },
    
    handleLSGPAQuote: function(component, event, helper) {
           var recordId=component.get('v.recordId');
        var action = component.get("c.createGPAQuoteAttachment");
        action.setParams({
            "psId": recordId
        });
        action.setCallback(this,
                           function(response){
                               if(response.getState() == "SUCCESS"){
                                   var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type": "success",
                                       "message": "Group Personal Accident Quote Attachment added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);  
    },
    handleELCertificate: function(component, event, helper) {
           var recordId=component.get('v.recordId');
        var action = component.get("c.createELCertificate");
        action.setParams({
            "psId": recordId
        });
        action.setCallback(this,
                           function(response){
                               if(response.getState() == "SUCCESS"){
                                   var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type": "success",
                                       "message": "EL Certificate Attachment added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);  
    }
})