({
    createClaimSchedule : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var action = component.get("c.getPolicyId");
        action.setParams({
            "claimId": recordId
        }); 
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var claim= response.getReturnValue();
                var url='/sfdcpage/'+encodeURIComponent('/apex/VG_ClaimSchedule_Step1?id=')+recordId+encodeURIComponent('&Pid=')+claim.Policy_Number__c;               
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": url
                });
                urlEvent.fire();
            }
        });        
        $A.enqueueAction(action);
    }
})