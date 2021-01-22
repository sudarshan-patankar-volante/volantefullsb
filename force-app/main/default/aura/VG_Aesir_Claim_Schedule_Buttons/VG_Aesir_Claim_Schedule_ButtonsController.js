({
	createClaimExpense : function(component, event, helper) {
        var recordId=component.get('v.recordId');
        var createClaim = $A.get("e.force:createRecord");
        createClaim.setParams({
            "entityApiName": "Claims_Progression__c",
            'recordTypeId'		 : '0126E000000B1p9',
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
            'recordTypeId'		 : '0126E000000B1p4',
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
            'recordTypeId'		 : '0126E000000B1pE',
            "defaultFieldValues": {
                'VG_Claims_Schedule__c' : recordId,
            }
        });
        createClaim.fire();
    }
})