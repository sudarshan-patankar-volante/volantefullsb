public with sharing class VG_Alpha_Policy_ButtonsController {
    @AuraEnabled
    public static List<Policy__c> getPolicyStatus(Id polId){
        List<Policy__c> polList=new List<Policy__c>();
        Policy__c pol=[select id,Name,Policy_Status__c,VG_Is_Renewal__c,CurrencyIsoCode,VG_Renewal_Policy_Id__c,Insured__c,MTA_Cancel_List__c from Policy__c where id=:polId limit 1];
        polList.add(pol);
        if(pol.VG_Renewal_Policy_Id__c!=null){
            Policy__c renewalPol=[select id,Name,Policy_Status__c,VG_Is_Renewal__c,CurrencyIsoCode,VG_Renewal_Policy_Id__c,Insured__c,MTA_Cancel_List__c from Policy__c where id=:pol.VG_Renewal_Policy_Id__c limit 1];
            polList.add(renewalPol);
        }
        return polList;
    }    
    
    @AuraEnabled
    public static String createRenewalPolicy(Id policyId){
        return  VG_RenewalController.createRenewalPolicy(policyId,'Imara');
    }
    
    @AuraEnabled
    public static Id getBasePolicy(Id polId){
        Policy__c pol = [select id, Name, Policy_Status__c, CurrencyIsoCode, VG_Renewal_Policy_Id__c, Insured__c, VG_Is_Renewal__c, MTA_Cancel_List__c from Policy__c where VG_Renewal_Policy_Id__c=:polId limit 1];
        System.debug('polid:'+pol.id);
        return pol.id;
    }
}