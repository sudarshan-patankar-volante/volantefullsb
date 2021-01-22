@IsTest(SeeAllData=False)
public class VG_GetProfile_Test {
    public Static Testmethod Void method1(){
        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        SystemConstants__c cs = new SystemConstants__c();
        cs.Name='Latest Policy Name';
        cs.DocumentId__c = 'Reset';
        Insert cs;
        Policy_Record_Type__c prt = new Policy_Record_Type__c ();
        prt.Name='Edison Motor';
        prt.Code__c = 'EM';
        Insert prt;
        Policy_LOB__c lob = new Policy_LOB__c();
        lob.Name='Motor';
        lob.Code__c = 'MTR';
        Insert lob;
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.Id);
        VG_GetProfile.getProfileName();
        VG_GetProfile.getUserInfo(ps.id);
    }
}