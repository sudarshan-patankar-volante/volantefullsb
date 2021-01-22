@IsTest(SeeAllData=False)
public class ClaimTriggerFunction_Test {
	Public Static TestMethod Void testMethod1(){
        Test.startTest();       
        Account acc=VG_TU.createAccount('Customer');
        VG_TU.policyCustomSetting();
        Utilities.SkipMethods('Bridge Context');
        Policy__c pol=VG_TU.createPolicy('Bridge', acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        Insert ps;       
        claim__c cl=VG_TU.createClaim(acc.id,pol.id);
		claim__c cl1=VG_TU.createClaim(acc.id,pol.id);
		claim__c cl2=VG_TU.createClaim(acc.id,pol.id);
		Utilities.clearMethods();       
        Test.stopTest();
    }
}