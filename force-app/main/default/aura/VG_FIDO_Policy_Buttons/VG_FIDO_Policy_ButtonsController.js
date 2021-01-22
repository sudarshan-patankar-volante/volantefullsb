({
    handlePSClick : function(component, event, helper) {	
        var status;
        var recordId=component.get('v.recordId');
        var InsAcc=component.get('v.InsuredAcc');
        var CC=component.get('v.CurCode');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_FIDO_Step1?id=')+recordId+encodeURIComponent('&Currency=')+CC;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
        // $A.enqueueAction(action);
    },
    
    uploadDocuments : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_LSAssetsUpload?id=')+recordId+encodeURIComponent('&attType=null&sObjectType=Policy__c');
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
    },
    renewpolicy : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var toastEvent = $A.get("e.force:showToast");
        component.set("v.isOpen", false);
        toastEvent.setParams({
            "title": "Message",
            "type":"Info",
            "message": "Please wait while the Renewal Policy is being created..."
        });
        toastEvent.fire();
        component.set("v.spinner", true); 
        helper.getRenewalHelper(component, event, helper);     
    },
    conformRenew : function(component, event, helper) {
        component.set("v.isOpen", true);
    },
    cancelRenew : function(component, event, helper) {
        component.set("v.isOpen", false);        
    },
    gotoBasePolicy : function(component, event, helper) {
        var policyName=component.get('v.policyName');
        var recordId=component.get('v.recordId');
        var action = component.get("c.getBasePolicy");
        var basePolicyId;
        action.setParams({
            "polId": recordId
        });
        action.setCallback(this, function(response) {
            var state=response.getState();
            basePolicyId=response.getReturnValue();
            if(state=="SUCCESS" && basePolicyId != null){
                window.open('/VFP/s/policy/'+basePolicyId,'_blank');                
            }else{
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": recordId,
                    "slideDevName": "related"
                });
                navEvt.fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "type":"error",
                    "mode":"sticky",
                    "message": "Original Policy is missing Contact admin...!"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
     PrintVSRQuote : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createVSR_Quote_SheetAttachment");
        action.setParams({
            "polId": recordId
        });
        action.setCallback(this,
                           function(response){
                               if(response.getState() == "SUCCESS"){
                                   var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type": "success",
                                       "message": "VFP VSR Quote Attachment added to the Policy Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);        
    },
    
     PrintVSRSchedule : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.createVSR_Schedule_SheetAttachment");
        action.setParams({
            "polId": recordId
        });
        action.setCallback(this,
                           function(response){
                               if(response.getState() == "SUCCESS"){
                                   var toastEvent = $A.get("e.force:showToast");
                                   toastEvent.setParams({
                                       "title": "Success!",
                                       "type": "success",
                                       "message": "VFP VSR Schedule Attachment added to the Policy Successfully."
                                   });
                                   toastEvent.fire(); 
                               }
                           }
                          );
        $A.enqueueAction(action);        
    },    
    doInit : function(component, event, helper) {       
        
        var pol;
        var renewalPol;
        var polList;
        var recordId=component.get('v.recordId');   
        var action = component.get("c.getPolicyStatus");
        action.setParams({
            "polId": recordId
        });
        action.setCallback(this, function(response) {
            var state=response.getState();
            if(state=="SUCCESS"){
                polList=response.getReturnValue();
                if(polList.length > 1){
                    pol=polList[0];
                    renewalPol=polList[1];
                }else{
                    pol=polList[0];                   
                }
                component.set("v.policyName",pol.Name);
                component.set("v.CurCode", pol.CurrencyIsoCode);
                component.set("v.InsuredAcc", pol.Insured__c);
                if((pol.VG_Renewal_Policy_Id__c == '' || pol.VG_Renewal_Policy_Id__c == null) && pol.Policy_Status__c=='Booked' && pol.MTA_Cancel_List__c==0){
                    component.set("v.notRenewal", true);    
                }
                if(pol.VG_Renewal_Policy_Id__c != null && pol.MTA_Cancel_List__c==0){                    
                    component.set("v.ps", true);
                }else if(pol.VG_Renewal_Policy_Id__c == null && pol.MTA_Cancel_List__c==0 && pol.Policy_Status__c=='Booked'){
                    component.set("v.ps", true);
                }
                 if((pol.Policy_Status__c == 'Quoted' || pol.Policy_Status__c == 'NTU' || pol.Policy_Status__c == 'Bound' || pol.Policy_Status__c=='Booked')){//&& pol.VG_Sub_Status__c=='Approved'){                                                  
                    component.set("v.quote", true);
                }
                if((pol.Policy_Status__c == 'Quoted' || pol.Policy_Status__c == 'NTU' || pol.Policy_Status__c == 'Bound' || pol.Policy_Status__c=='Booked')){//} && pol.VG_Sub_Status__c=='Approved'){                                                  
                    component.set("v.bound", true);
                }
                if(pol.Policy_Status__c!='Booked'){
                    component.set("v.mta", true);
                }
                if(pol.VG_Is_Renewal__c){
                    component.set("v.basePolicy", true);
                }
            }else{                
                alert('state is '+state+' something wrong reload window '+response.getError());
            }
        });
        $A.enqueueAction(action);
    },    
    handleEditClick : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var editPolicyEvent = $A.get("e.force:editRecord");
        editPolicyEvent.setParams({
            "recordId": recordId
        });
        editPolicyEvent.fire();
    },
    handleMTAClick : function(component, event, helper) {	
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_MTA_Step1?PId=')+recordId;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
    },
    createClaim : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var createClaim = $A.get("e.force:createRecord");
        var InsAcc=component.get('v.InsuredAcc');
        createClaim.setParams({
            "entityApiName": "Claim__c",
            "defaultFieldValues": {
                'Policy_Number__c' : recordId,
                'Account__c'	   : InsAcc
            }
        });
        createClaim.fire();
    },
    handleGCClick : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Edit_Governance_Compliance?id=')+recordId;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
    }
})