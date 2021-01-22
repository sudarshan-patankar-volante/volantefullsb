@IsTest(SeeAllData=False)
public class PathSettingController_Test {
    Public Static TestMethod Void testMenthod1(){  
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('VFP', acc.id);        
        List<String> psIds = new List<String>();
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Policy_Schedule__c ps1=VG_TU.createPolicySchedule(pol.id);
        psIds.add(ps.id);
        psIds.add(ps1.id);
        Test.startTest();        
        PathSettingController.getPSGWP(pol.id);
        //PathSettingController.bookPS(psIds);
        //PathSettingController.getPS(pol.id);
        Test.stopTest();
    }
}