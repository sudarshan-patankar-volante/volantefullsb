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
            var action1 = component.get("c.getMTAStartdate");
            action1.setParams({
                "psId": recordId
            });
            action1.setCallback(this, function(response) {
                var state=response.getState();
                if(state=="SUCCESS"){
                    component.set("v.MTAstartdate", response.getReturnValue());
                }
            });
            $A.enqueueAction(action1);
            var state=response.getState();
            if(state=="SUCCESS"){
                ps=response.getReturnValue();
                component.set("v.psProduct",ps.Product__c);
                component.set("v.MTAType",ps.VG_MTA_Type__c);
                component.set("v.MTAStartdate",ps.VG_MTA_Start_Date__c);                
                component.set("v.policyCurrency",ps.CurrencyIsoCode);
                if((ps.Policy__r.Policy_Status__c == 'Quoted' || ps.Policy__r.Policy_Status__c == 'NTU' || ps.Policy__r.Policy_Status__c == 'Bound' || ps.Policy__r.Policy_Status__c=='Booked')&& ps.Policy__r.VG_Sub_Status__c=='Approved'){                 
                    component.set("v.quote", true);                    
                }               
                if(ps.VG_Status__c == 'Booked' || ps.Policy__r.Policy_Status__c=='Bound' || ps.Policy__r.Policy_Status__c=='Booked'){
                    component.set("v.ps", true);                 
                }
                if(ps.VG_Status__c == 'Booked' || ps.Policy__r.Policy_Status__c == 'Bound'){                 
                    component.set("v.bound", true);
                }
                if((!ps.VG_Is_MTA__c && ps.Policy__r.Policy_Status__c == 'Booked') && ps.VG_Co_Insurance_type__c != 'Child'|| (ps.VG_Is_MTA__c && ps.VG_Status__c == 'Booked' && ps.VG_Co_Insurance_type__c != 'Child')){                 
                    component.set("v.mta", true);                   
                }
                if((!ps.VG_Is_MTA__c && ps.Policy__r.Policy_Status__c != 'Booked' && ps.VG_Co_Insurance_type__c != 'Child')|| (ps.VG_Is_MTA__c && ps.VG_Status__c != 'Booked' && ps.VG_Co_Insurance_type__c != 'Child') ){                 
                    component.set("v.Revise", true);                   
                }
                if(ps.VG_Status__c !='Booked' && ps.VG_Is_MTA__c && (ps.VG_MTA_Type__c=='Revision of Cover'||ps.VG_MTA_Type__c=='Extension'||ps.VG_MTA_Type__c=='Cancellation'||ps.VG_MTA_Type__c=='Declaration')){
                    component.set("v.booked", true);
                }
                if(ps.VG_MTA_Type__c == null){
                    component.set("v.booked", false);
                }
                if(ps.VG_Is_Co_Insurance__c){
                    component.set("v.MCI", true);
                }
            }
        });
        $A.enqueueAction(action);                    
    },
    handleReviseClick : function(component, event, helper) {
        var status;
        var recordId=component.get('v.recordId');
        var policyCurrency=component.get('v.policyCurrency');
        var MTAType=component.get('v.MTAType');
        var MTAstartdate=component.get('v.MTAStartdate');
        if(component.get("v.psProduct")!='Commercial Combined'){
            var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Revise_Nordics_Step1?PSId=')+recordId+encodeURIComponent('&policyCurrency=')+policyCurrency;            
        }else{
           var url='/sfdcpage/'+encodeURIComponent('/apex/VG_CC_Revise_Nordics_Step2?PSId=')+recordId+encodeURIComponent('&policyCurrency=')+policyCurrency;
        }      
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();            
        //$A.enqueueAction(action);        
    },
    handleROCClick : function(component, event, helper) {
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_MTA_Step3?PSId=')+recordId+encodeURIComponent('&RecordType=Bridge');
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();            
        //$A.enqueueAction(action);        
    },
    mCIClick : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Manage_Co_Insurance?id=')+recordId;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();                   
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
    GenerateQuotationEnglish : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createBridgeEnglishQuoteAttachment");
        var product=component.get('v.psProduct');
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
                                       "message": "Bridge Quote Summary English Version Attachment added to the Policy Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        
        
        var action3 = component.get("c.createBS_Quote_SheetAttachment");
        action3.setParams({
            "psId": recordId
        });
        action3.setCallback(this,
                            function(response){
                                if(response.getState() == "SUCCESS"){
                                    var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        "title": "Success!",
                                        "type": "success",
                                        "message": "BS_English_Quote_Sheet Attachment added to the Policy Schedule Successfully."
                                    });
                                    toastEvent.fire();                                                                        
                                }
                            }
                           );
        
        $A.enqueueAction(action); 
        $A.enqueueAction(action3);
    },             
    GenerateQuotationSwedish : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createBridgeSwedishQuoteAttachment");
        var product=component.get('v.psProduct');
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
                                       "message": "Bridge Quote Summary Swedish Version Attachment added to the Policy Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        
        var action3 = component.get("c.createBS_Swedish_Quote_SheetAttachment");
        action3.setParams({
            "psId": recordId
        });
        action3.setCallback(this,
                            function(response){
                                if(response.getState() == "SUCCESS"){
                                    var toastEvent = $A.get("e.force:showToast");
                                    toastEvent.setParams({
                                        "title": "Success!",
                                        "type": "success",
                                        "message": "BS_Swedish_Quote_Sheet Attachment added to the Policy Schedule Successfully."
                                    });
                                    toastEvent.fire(); 
                                }
                            }
                           );
        $A.enqueueAction(action);
        $A.enqueueAction(action3);        
    },
    GeneratePSEnglish : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createBS_Quote_Sheet_P_CC_Attachment");
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
                                       "message": "BS_English Policy Schedule Attachment added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);        
    },
    GeneratePSSwedish : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createBS_Swedish_Policy_Schedule_Attachment");
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
                                       "message": "BS_Swedish Policy Schedule Attachment added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);        
    },
    GenerateEnglishInvoiceQuotation : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createBridge_English_InvoiceAttachment");
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
                                       "message": "Bridge English Invoice Attachment added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);        
    },
    GenerateSwedishInvoiceQuotation : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createBridge_Swedish_InvoiceAttachment");
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
                                       "message": "Bridge Swedish Invoice Attachment added to the Policy Schedule Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);        
    }
})