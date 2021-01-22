({
    handlePSClick : function(component, event, helper) {	
        var status;
        var recordId=component.get('v.recordId');
        var InsAcc=component.get('v.InsuredAcc');
        var CC=component.get('v.CurCode');
        //alert(component.get('v.simpleRecord.CurrencyISOCode'));
        //var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Nordics_Step1?id=')+recordId+encodeURIComponent('&Currency=INR&AccountId=0016E00000T6pmT');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Nordics_Step1?id=')+recordId+encodeURIComponent('&Currency='+CC+'&AccountId='+InsAcc);
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
        // $A.enqueueAction(action);
    },
    uploadDocuments : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_BulkAssetsUpload?id=')+recordId+encodeURIComponent('&attType=null&sObjectType=Policy__c');
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
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
                window.open('/Bridge/s/policy/'+basePolicyId,'_blank');
                
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
                if(pol.VG_Is_Renewal__c){
                    component.set("v.basePolicy", true);
                }
                if(pol.Policy_Status__c=='Booked'){
					if(pol.MTA_Cancel_List__c==0 && (pol.VG_Renewal_Policy_Id__c == '' || pol.VG_Renewal_Policy_Id__c == null))
                        component.set('v.pb',true);
                    else if(pol.VG_Renewal_Policy_Id__c != null && pol.MTA_Cancel_List__c==0 && (renewalPol.Policy_Status__c !='Bound' && renewalPol.Policy_Status__c !='Booked'))
                        component.set('v.pb',true);
                    else
                        component.set('v.pb',false);
                    component.set("v.mta", false);
                }else{     
                    component.set("v.mta", true);
                }
                if(pol.Policy_Status__c=='Booked' && pol.MTA_Cancel_List__c>0){
                    component.set("v.ps", false);
                }else if(pol.Policy_Status__c=='Booked' && pol.MTA_Cancel_List__c==0){
                    component.set("v.ps", true);                   
                }
                if(pol.Policy_Status__c=='Quoted' || pol.Policy_Status__c=='NTU'|| pol.Policy_Status__c=='Bound'|| pol.Policy_Status__c=='Booked'){
                    component.set("v.quote", true);              
                }
            }else{
                var errors = response.getError();
                var message = 'Unknown error';
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                
                alert('Policy Button state is '+state+' something wrong reload window '+message);
            }
        });
        $A.enqueueAction(action);
    },
    handleMTAClick : function(component, event, helper) {	
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Revise_Nordics_Step0?PId=')+recordId;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
        // $A.enqueueAction(action);
    },
    checkPolicyAssets : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        window.open('/Bridge/s/sfdcpage/'+encodeURIComponent('/apex/VG_Show_Policy_Assets?id=')+recordId,'_blank','height=500px,top=200px,width=700px;');
    },
    
    handleEditClick : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var editPolicyEvent = $A.get("e.force:editRecord");
        editPolicyEvent.setParams({
            "recordId": recordId
        });
        editPolicyEvent.fire();
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