@IsTest(SeeAllData=False)
public class VG_VFP_Policy_ButtonsController_Test {
	Public Static TestMethod Void testMenthod1(){  
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('VFP', acc.id);        
        Policy__c pol1=pol.clone(false,true,false,false);
        pol1.VG_Renewal_Policy_Id__c = pol.id;       
        Insert pol1;        
        Test.startTest();
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        VG_VFP_Policy_ButtonsController.createRenewalPolicy(pol.id);
        VG_VFP_Policy_ButtonsController.getPolicyStatus(pol1.id);
        VG_VFP_Policy_ButtonsController.getBasePolicy(pol.Id);
        VG_VFP_Policy_ButtonsController.createVSR_Quote_SheetAttachment(pol.Id);
        VG_VFP_Policy_ButtonsController.createVSR_Schedule_SheetAttachment(pol.Id);
        Test.stopTest();
    }
}