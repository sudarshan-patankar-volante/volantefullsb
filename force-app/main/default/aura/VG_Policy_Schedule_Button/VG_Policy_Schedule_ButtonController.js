({
    doInit  : function(component, event, helper) {
        var status;
        var status2;
        var ps;
        var recordId=component.get('v.recordId');
        var action = component.get("c.getPolicySchedule");
        action.setParams({
            "psId": recordId
        });
        action.setCallback(this, function(response) {
            var state=response.getState();
            
            if(state=="SUCCESS"){
                ps=response.getReturnValue();
                component.set("v.policyid", ps.Policy__c);
                console.log('ps::'+ps.Name);
                if(ps.VG_Status__c == 'Booked'){                 
                    component.set("v.mta", true);
                    
                }else if(ps.VG_Status__c !='Booked' && ps.VG_Is_MTA__c && (ps.VG_MTA_Type__c=='Revision of Cover'||ps.VG_MTA_Type__c=='Extension'||ps.VG_MTA_Type__c=='Cancellation'||ps.VG_MTA_Type__c=='Declaration')){
                    component.set("v.booked", true);
                }else{
                    component.set("v.mta", false); 
                }
                if((ps.Policy__r.Policy_Status__c == 'Quoted' || ps.Policy__r.Policy_Status__c == 'NTU' || ps.Policy__r.Policy_Status__c == 'Bound' || ps.Policy__r.Policy_Status__c=='Booked')&& ps.Policy__r.VG_Sub_Status__c=='Approved'){                 
                    component.set("v.quote", true);
                }
                if(ps.VG_Is_MTA__c==false && (ps.Policy__r.Policy_Status__c == 'Bound' || ps.Policy__r.Policy_Status__c == 'Booked')){
                    component.set("v.bound", true);                 
                }else if(ps.VG_Is_MTA__c==true && ps.VG_Status__c == 'Booked'){
                    component.set("v.bound", true);                      
                }
                
            }
            
        });
        $A.enqueueAction(action);
    },
    handlePFClick : function(component, event, helper) {
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Payment_Details?Id=')+recordId+encodeURIComponent('&RecordType=Edison Motor');
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();            
    },
    handleMTAClick : function(component, event, helper) {
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_EdisonPS_MTA0?PSId=')+recordId
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();            
        //$A.enqueueAction(action);        
    },
    handleReviseClick : function(component, event, helper) {
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_EdisonPS_Edit1?PSId=')+recordId;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();            
        //$A.enqueueAction(action);        
    },
    GenerateDoc : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createActiveNoteAttachment");
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
                                       "message": "Advice Note added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);        
    },
    GenerateEdisonQuotation : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createEdisonQuotationAttachment");
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
                                       "message": "Quote added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);        
    },
    GenerateEdisonSchedule : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createEdisonScheduleAttachment");
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
                                       "message": "Schedule added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }else{
                                   
                               }
                           }
                          );
        $A.enqueueAction(action);        
    },
    GenerateMotorCertificate : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createMotorCertificateAttachment");
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
                                       "message": "Motor Certificate added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }else{
                                   
                               }
                           }
                          );
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
    checkPolicyAssets : function(component, event, helper) {
        var polid=component.get('v.policyid');
        window.open('/Edison/s/sfdcpage/'+encodeURIComponent('/apex/VG_Show_Policy_Assets?id=')+polid,'_blank','height=500px,top=200px,width=700px;');
    }
})