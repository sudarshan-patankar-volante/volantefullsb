@IsTest(seeAllData =False)
public class VG_PolicySheduleButton_Controller_Test {
    public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Vendor');       
        List<VG_UMR__c> uList=new List<VG_UMR__c>();
        VG_UMR__c u=new VG_UMR__c();
        u.VG_Account__c=acc.id;
        u.Name='Test';
        u.RecordTypeId=Schema.SObjectType.VG_UMR__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        u.VG_RI_Product__c='Cyber';
        u.VG_RI_Coverage__c='M6 - Third Party Only';
        u.VG_RI_Type__c='Net';
        u.VG_RI_Share_Type__c='Proportional';
        u.VG_RI_Inception_Date__c=Date.newInstance(2017, 11, 18);
        u.VG_RI_Expiry_Date__c=Date.newInstance(2018, 12, 18);
        u.VG_RI_Binder_Broker__c=acc.Id;
        u.VG_Currency__c='CAD';
        u.VG_RI_Share__c=52;
        u.VG_MGA_Commission__c=45;
        u.VG_RI_Binder_Commission__c=28;
        u.VG_RI_Referral_Limit_Sum_Insured__c=125685;
        u.VG_RI_Referral_Limit_Premium__c=1528;
        u.VG_RI_Sum_Insured_Limit__c=1258888;
        u.VG_Capacity_Manager__c=UserInfo.getUserId();
        uList.add(u);
        VG_UMR__c u2=new VG_UMR__c();
        u2.VG_Account__c=acc.id;
        u2.Name='Test';
        u2.RecordTypeId=Schema.SObjectType.VG_UMR__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        u2.VG_RI_Product__c='Cyber';
        u2.VG_RI_Coverage__c='M6 - Third Party Only';
        u2.VG_RI_Type__c='Net';
        u2.VG_RI_Share_Type__c='Proportional';
        u2.VG_RI_Inception_Date__c=Date.newInstance(2017, 11, 18);
        u2.VG_RI_Expiry_Date__c=Date.newInstance(2018, 12, 18);
        u2.VG_RI_Binder_Broker__c=acc.Id;
        u2.VG_Currency__c='CAD';
        u2.VG_RI_Share__c=52;
        u2.VG_MGA_Commission__c=45;
        u2.VG_RI_Binder_Commission__c=28;
        u2.VG_RI_Referral_Limit_Sum_Insured__c=125685;
        u2.VG_RI_Referral_Limit_Premium__c=1528;
        u2.VG_RI_Sum_Insured_Limit__c=1258888;
        u2.VG_Capacity_Manager__c=UserInfo.getUserId();
        uList.add(u2);
        Insert uList;
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        //Code added by siddik on 26.2.2018
        pol.Policy_Status__c='NTU/Decline';
        pol.VG_Sub_Status__c='NTU - Price';
        pol.NTU_Or_Declined__c='NTU';
        update pol;
        //Code added finished  on 26.2.2018 
        System.debug('Policy Name::'+pol.Name);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        Insert ps; 
        VG_PolicySheduleButton_Controller.getPolicySchedule(ps.id);
        VG_PolicySheduleButton_Controller.getCurrentUser();
        VG_PolicySheduleButton_Controller.bookPolicySchedule(ps.id);
        VG_PolicySheduleButton_Controller.createActiveNoteAttachment(ps.id);
        VG_PolicySheduleButton_Controller.createEdisonQuotationAttachment(ps.id);
        VG_PolicySheduleButton_Controller.createEdisonScheduleAttachment(ps.id);
        VG_PolicySheduleButton_Controller.createMotorCertificateAttachment(ps.Id);
        VG_PolicySheduleButton_Controller.deletePolicySchedule(ps.id);
    }
}