public with sharing class VG_GetProfile  {
    @AuraEnabled
    public static String getProfileName(){
        Profile p=[select id,Name from Profile where id=:UserInfo.getProfileId() limit 1];
        return p.Name;
    }
    @AuraEnabled
    public static String getUserInfo(Id psid){
        Profile p=[select id,Name from Profile where id=:UserInfo.getProfileId() limit 1];
        Policy_Schedule__c ps=[select id,Name,Policy__c from Policy_Schedule__c where id=:psid];
        String s=p.Name+','+ps.Policy__c;
        return s;
    }
}