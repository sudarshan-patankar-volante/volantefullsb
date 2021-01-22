public class VG_ClaimButtonsController {
    @AuraEnabled
    public static Claim__c getPolicyId(Id claimId){
        Claim__c cl=[select id,Policy_Number__c from Claim__c where id=:claimId limit 1];
        System.debug('cl::'+cl);
        return cl;
    }
}