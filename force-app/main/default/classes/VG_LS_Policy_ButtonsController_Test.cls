@IsTest(SeeAllData=False)
public class VG_LS_Policy_ButtonsController_Test {
    public Static Testmethod Void method1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity', acc.id);        
        Policy__c pol1=pol.clone(false,true,false,false);
        pol1.VG_Renewal_Policy_Id__c = pol.id;       
        Insert pol1;        
        Test.startTest();
        VG_LS_Policy_ButtonsController.getPolicyStatus(pol1.id);
        VG_LS_Policy_ButtonsController.createLSQuoteAttachment(pol.Id);
        VG_LS_Policy_ButtonsController.createLSScheduleAttachment(pol.Id);
        VG_LS_Policy_ButtonsController.createLSStatementAttachment(pol.Id);
        VG_LS_Policy_ButtonsController.getBasePolicy(pol.Id);
        VG_LS_Policy_ButtonsController.createRenewalPolicy(pol.Id);
        Test.stopTest();
    }
}