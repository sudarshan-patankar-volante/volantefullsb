({
    handleClick : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_BulkAssetsUpload?id=')+recordId+encodeURIComponent('&attType=Assets File&sObjectType=Account');
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
    }, 
    handleDocClick : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var url='/sfdcpage/'+encodeURIComponent('/apex/VG_BulkAssetsUpload?id=')+recordId+encodeURIComponent('&sObjectType=Account');
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": url
        });
        urlEvent.fire();
    }, 
    handlePSClick : function(component, event, helper) {
        var rt=$A.get("$Label.c.Gentium_Policy");
        var recordId=component.get('v.recordId');
        var createPolicyEvent = $A.get("e.force:createRecord");
        createPolicyEvent.setParams({
            "entityApiName": "Policy__c",
            "recordTypeId" : rt,
            "defaultFieldValues": {
                'Name' : 'Do Not Populate',
                'Insured__c' : recordId,
                'RecordTypeId':rt
            }
        });
        createPolicyEvent.fire();
    },
    recordUpdate: function(component, event, helper) {
        var compStatus = component.get("v.record").Comply_Advantage_Match_Status__c;
        var manualOverride = component.get("v.record").Manual_Compliance_Override__c;
        var url = "https://app.complyadvantage.com/#/case-management/search/";
        url = url + component.get("v.record").Comply_Advantage_Search_Id__c;
        //alert(compStatus);
        if(compStatus == 'Potential Match' || compStatus == 'Pending' || compStatus == 'True Positive' || compStatus == 'True Positive – Reject'){
            component.set("v.showPassed",false);
        }else{
            component.set("v.showPassed",true);
        }
    }
})