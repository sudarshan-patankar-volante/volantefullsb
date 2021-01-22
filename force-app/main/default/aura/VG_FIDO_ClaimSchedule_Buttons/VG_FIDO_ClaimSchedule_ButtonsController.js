({
	createClaimExpense : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var createClaim = $A.get("e.force:createRecord");
        createClaim.setParams({
            "entityApiName": "Claims_Progression__c",
            'recordTypeId'		 : '0121q0000004NMA',
            "defaultFieldValues": {
                'VG_Claims_Schedule__c' : recordId,
            }
            
        });
        createClaim.fire();
    },
    createClaimFinancial : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var createClaim = $A.get("e.force:createRecord");
        createClaim.setParams({
            "entityApiName": "Claims_Progression__c",
            'recordTypeId'		 : '0121q0000004NMB',
            "defaultFieldValues": {
                'VG_Claims_Schedule__c' : recordId,
            }
        });
        createClaim.fire();
    },
    createClaimRecovery : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var createClaim = $A.get("e.force:createRecord");
        createClaim.setParams({
            "entityApiName": "Claims_Progression__c",
            'recordTypeId'		 : '0121q0000004NMC',
            "defaultFieldValues": {
                'VG_Claims_Schedule__c' : recordId,
            }
        });
        createClaim.fire();
    }
})