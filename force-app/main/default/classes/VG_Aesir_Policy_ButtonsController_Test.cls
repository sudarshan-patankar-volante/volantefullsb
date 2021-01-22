@IsTest(SeeAllData=False)
public class VG_Aesir_Policy_ButtonsController_Test {
    Public Static TestMethod Void testMethod1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Aesir', acc.id);        
        Policy__c pol1=pol.clone(false,true,false,false);
        pol1.VG_Renewal_Policy_Id__c = pol.id;       
        Insert pol1;        
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Test.startTest();       
        VG_Aesir_Policy_ButtonsController.createRenewalPolicy(pol.id);
        VG_Aesir_Policy_ButtonsController.getPolicyStatus(pol1.id);
        VG_Aesir_Policy_ButtonsController.getBasePolicy(pol.id);
        Test.stopTest();
        
    }
}