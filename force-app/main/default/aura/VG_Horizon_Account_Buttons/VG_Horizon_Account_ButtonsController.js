({  
    handlePSClick : function(component, event, helper) {
        var rt=$A.get("$Label.c.Horizon_Policy");
        var recordId=component.get('v.recordId');
        var createPolicyEvent = $A.get("e.force:createRecord");
        createPolicyEvent.setParams({
            "entityApiName": "Policy__c",
            "recordTypeId" : rt,
            "defaultFieldValues": {
                'Name' : 'Do Not Populate',
                'Insured__c' : recordId,
                'RecordTypeId':rt,
                'CurrencyIsoCode': 'EUR' 
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