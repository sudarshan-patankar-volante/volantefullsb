@IsTest(SeeAllData=False)
public class VG_Horizon_PS_Button_Controller_Test {
    public Static Testmethod Void method1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Horizon',acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        Insert ps; 
        VG_Horizon_PS_Button_Controller.getPolicySchedule(ps.id);
        VG_Horizon_PS_Button_Controller.bookPolicySchedule(ps.id);
        VG_Horizon_PS_Button_Controller.createHorizonQuoteAttachment(ps.id);
        VG_Horizon_PS_Button_Controller.getCurrentUser();
        VG_Horizon_PS_Button_Controller.deletePolicySchedule(ps.Id);
    }
}