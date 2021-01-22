public with Sharing class VG_Policy_TimeLine_Controller {
    @AuraEnabled
    public static List<Policy_Schedule__c> getPolicySchedule(Id polId){
        List<Policy_Schedule__c> psList=new List<Policy_Schedule__c>([select id,Name,VG_MTA_Start_Date__c,VG_MTA_Cancellation_Date__c,VG_MTA_End_Date__c,VG_Status__c,VG_MTA_Type__c,VG_Is_MTA__c from Policy_Schedule__c where Policy__c=:polId  order by CreatedDate desc]);
        System.debug('PSList::'+psList);
        return psList;
    }
}