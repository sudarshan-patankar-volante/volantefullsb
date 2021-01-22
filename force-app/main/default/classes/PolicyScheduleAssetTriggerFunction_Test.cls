@IsTest(SeeAllData=False)
public class PolicyScheduleAssetTriggerFunction_Test {
    Public Static TestMethod Void testMethod1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Vendor');
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        VG_Policy_Schedule_Asset__c psa = VG_TU.createPolicyScheduleAsset(ps.id);
        VG_Policy_Schedule_Asset__c psa1 = VG_TU.createPolicyScheduleAsset(ps.id);
        psa1.VG_Number_of_Vehicles__c=20;
        psa1.VG_Coverage__c='Named perils';
        update psa1;
    }
}