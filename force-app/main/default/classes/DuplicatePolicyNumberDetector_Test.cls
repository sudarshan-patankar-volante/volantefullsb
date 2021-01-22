@IsTest(SeeAllData=False)
public class DuplicatePolicyNumberDetector_Test {
public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        List<Policy_Schedule__c> pslist = new List<Policy_Schedule__c>();
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Policy_Schedule__c ps1=VG_TU.createPolicySchedule(pol.id);
        pslist.add(ps);
        pslist.add(ps1);    
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);         
        VG_UMR__c umr = VG_TU.createUMR(acc.id);
        VG_ReInsurance__c RI = VG_TU.createReInsurance(ps.id,umr.id);
        Test.startTest();  
        DuplicatePolicyNumberDetector dpnd = new DuplicatePolicyNumberDetector();  
        DataBase.executeBatch(dpnd);
        dpnd.execute( null );
        Test.stopTest(); 
    }
}