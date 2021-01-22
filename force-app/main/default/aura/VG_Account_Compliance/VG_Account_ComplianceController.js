({
    recordUpdate: function(component, event, helper) {
        var compStatus = component.get("v.record").Comply_Advantage_Match_Status__c;
        var url = "https://app.complyadvantage.com/#/case-management/search/";
        url = url + component.get("v.record").Comply_Advantage_Search_Id__c;
        component.set("v.complyAdvantageURL",url);
        component.set("v.complianceStatus",compStatus);
        //alert(compStatus);
        if(compStatus == 'Potential Match' || compStatus == 'Pending' || compStatus == 'True Positive' || compStatus == 'True Positive – Reject'){
        	component.set("v.showFailed",true); 
        }else{
            component.set("v.showPassed",true);
        }
    }
})