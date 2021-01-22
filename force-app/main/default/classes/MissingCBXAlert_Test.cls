@IsTest(SeeAllData=False)
public class MissingCBXAlert_Test {
	public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        List<Policy_Schedule__c> pslist = new List<Policy_Schedule__c>();
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Policy_Schedule__c ps1=VG_TU.createPolicySchedule(pol.id);
        pslist.add(ps);
        pslist.add(ps1);
        VG_UMR__c umr = VG_TU.createUMR(acc.id);
        VG_ReInsurance__c RI = VG_TU.createReInsurance(ps.id,umr.id);
    	Test.startTest();  
        MissingCBXAlert mcbx = new MissingCBXAlert();  
        mcbx.execute( null );  
        Test.stopTest(); 
    }
}