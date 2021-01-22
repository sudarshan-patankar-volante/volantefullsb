@IsTest(SeeAllData=False)
public class ClaimScheduleTriggerFunction_Test {
    Public Static TestMethod Void testMethod1(){
        Account acc=VG_TU.createAccount('Customer');
        VG_TU.policyCustomSetting();        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        system.debug(pol.VG_Ignore_Validation__c);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        Insert ps;        
        Test.startTest();
        Utilities.SkipMethods('Trigger Context2');
        claim__c cl=VG_TU.createClaim(acc.id,pol.id);
        Claims_Schedule__c cs1=VG_TU.createClaimSchedule(acc.id,ps.id,cl.id);
        Claims_Schedule__c cs2=VG_TU.createClaimSchedule(acc.id,ps.id,cl.id);
        Claims_Schedule__c cs3=VG_TU.createClaimSchedule(acc.id,ps.id,cl.id);
        Utilities.clearMethods();
        Test.stopTest();
        
        
    }
}