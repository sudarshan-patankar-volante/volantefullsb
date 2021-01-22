@IsTest(seeAllData =False)
public class VG_FIDO_PS_Button_Controller_Test {
	public static testMethod void TestMethod1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Vendor');
        Policy__c pol=VG_TU.createPolicy('VFP', acc.id);        
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.Product__c='W&I';
        update ps;
        Policy_Schedule__c ps2=VG_TU.createPolicySchedule(pol.id);
        ps2.Product__c='PI';
        update ps2;
        VG_FIDO_PS_Button_Controller fc=new VG_FIDO_PS_Button_Controller();
        VG_FIDO_PS_Button_Controller.getPolicySchedule(ps.Id);
        VG_FIDO_PS_Button_Controller.createPI_Quote_SheetAttachment(ps.Id);
        VG_FIDO_PS_Button_Controller.bookPolicySchedule(ps.id);
        VG_FIDO_PS_Button_Controller.deletePolicySchedule(ps.id);
        VG_FIDO_PS_Button_Controller.getCurrentUser();
        VG_FIDO_PS_Button_Controller.createPI_Schedule_Attachment(ps2.Id);
    }
}