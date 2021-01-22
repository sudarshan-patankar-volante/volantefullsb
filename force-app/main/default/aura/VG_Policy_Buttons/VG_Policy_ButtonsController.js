({
    handlePSClick : function(component, event, helper) {	
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_EdisonPS_Ins1?id=')+recordId
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
    handleMTAClick : function(component, event, helper) {	
        var status;
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_EdisonPS_MTA0?PId=')+recordId;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
        // $A.enqueueAction(action);
    },
    
    doInit : function(component, event, helper) {
        var pol;
        var polList;
        var renewalPol;
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
                component.set("v.InsuredAcc", pol.Insured__c);
                if((pol.VG_Renewal_Policy_Id__c=='' || pol.VG_Renewal_Policy_Id__c==null  ) && pol.Policy_Status__c=='Booked' ){
                    component.set("v.notRenewal", true);    
                }
                if(pol.Policy_Status__c=='Booked'){
                    component.set("v.mta", false);
                }else{     
                    component.set("v.mta", true);
                }
                if(pol.Policy_Status__c=='Booked' && pol.MTA_Cancel_List__c>0){
                    component.set("v.ps", false);
                }else if(pol.Policy_Status__c=='Booked' && pol.MTA_Cancel_List__c==0){
                    component.set("v.ps", true);                   
                }
            }else{
                alert('state is '+state+' something wrong reload window '+response.getError());
            }
        });
        $A.enqueueAction(action);
    },
    checkPolicyAssets : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        /*var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Show_Policy_Assets?id=')+recordId
        var url='/apex/VG_Show_Policy_Assets?id='+recordId
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url":url
        });
        urlEvent.fire(); */
        window.open('/Edison/s/sfdcpage/'+encodeURIComponent('/apex/VG_Show_Policy_Assets?id=')+recordId,'_blank','height=500px,top=200px,width=700px;');
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
    renewpolicy : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_Edison_Policy_Renewal_Step1?id=')+recordId;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
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