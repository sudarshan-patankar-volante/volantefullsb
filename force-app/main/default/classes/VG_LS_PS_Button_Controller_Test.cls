@IsTest(seeAllData =False)
public class VG_LS_PS_Button_Controller_Test {
     public static testMethod void TestMethod1() {
         VG_TU.policyCustomSetting();
         Account acc=VG_TU.createAccount('Customer');     
         Policy__c pol=VG_TU.createPolicy('Affinity', acc.id);
         pol.Policy_Status__c='NTU/Decline';
         pol.VG_Sub_Status__c='Approved';
         update pol;
         System.debug('Policy Name::'+pol.Name);
         Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
         ps.Policy__c=pol.id;
         Insert ps; 
         VG_LS_PS_Button_Controller.getPolicySchedule(ps.Id);
         VG_LS_PS_Button_Controller.createELCertificate(ps.Id);
         VG_LS_PS_Button_Controller.createGPAQuoteAttachment(ps.Id);
         VG_LS_PS_Button_Controller.createLSStatementAttachment(ps.Id);
         VG_LS_PS_Button_Controller.createPSGPAAttachment(ps.Id);
     }
}