/*

*Created By : Siddik

*Created On : 24-11-2017

*JIRA.No    : VG-11

*/

@IsTest(SeeAllData=False)
Public Class PolicyScheduleTriggerFunctionTest{    
    Public Static TestMethod Void testMethod1(){
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
        PolicyScheduleTriggerFunction.allowInsertRI=True;
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.VG_Status__c='Booked';
        ps.Gross_Written_Premium__c=50000;
        ps.IPT__c=50000;
        ps.Levies__c=5000;
        ps.VG_Brokerage_Amount__c=50000;
        
        update ps;
    }
    Public Static TestMethod Void testMethod2(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Vendor');
        
        List<VG_UMR__c> uList=new List<VG_UMR__c>();
        VG_UMR__c u=new VG_UMR__c();
        u.VG_Account__c=acc.id;
        u.Name='Test';
        u.RecordTypeId=Schema.SObjectType.VG_UMR__c.getRecordTypeInfosByName().get('Horizon').getRecordTypeId();
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
        u.VG_Capacity_Paper__c='Fidelis';
        uList.add(u);
        VG_UMR__c u2=new VG_UMR__c();
        u2.VG_Account__c=acc.id;
        u2.Name='Test';
        u2.RecordTypeId=Schema.SObjectType.VG_UMR__c.getRecordTypeInfosByName().get('Horizon').getRecordTypeId();
        u2.VG_RI_Product__c='Cyber';
        u2.VG_RI_Coverage__c='M6 - Third Party Only';
        u2.VG_RI_Type__c='Net';
        u2.VG_RI_Share_Type__c='Proportional';
        u2.VG_RI_Inception_Date__c=Date.newInstance(2015, 11, 18);
        u2.VG_RI_Expiry_Date__c=Date.newInstance(2020, 12, 18);
        u2.VG_RI_Binder_Broker__c=acc.Id;
        u2.VG_Currency__c='CAD';
        u2.VG_Capacity_Paper__c='Greenlight Re';
        u2.VG_RI_Share__c=52;
        u2.VG_MGA_Commission__c=45;
        u2.VG_RI_Binder_Commission__c=28;
        u2.VG_RI_Referral_Limit_Sum_Insured__c=125685;
        u2.VG_RI_Referral_Limit_Premium__c=1528;
        u2.VG_RI_Sum_Insured_Limit__c=1258888;
        u2.VG_Capacity_Manager__c=UserInfo.getUserId();
        uList.add(u2);
        Insert uList;
        Policy__c pol=VG_TU.createPolicy('Horizon', acc.id);
        PolicyScheduleTriggerFunction.allowInsertRI=True;
        Policy_Schedule__c ps=new Policy_Schedule__c();
        ps.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Horizon').getRecordTypeId();
        ps.Name='Test';
        ps.Policy__c=pol.id;  
        ps.Gross_Written_Premium__c=500;
        ps.VG_Capacity_Paper__c='Greenlight Re';
        ps.Transaction_GWP__c=0;
        ps.Share__c=20;
        Insert ps;
        VG_Payment_Frequency__c pf=VG_TU.createPaymentFrequency(ps.id);
        ps.VG_Status__c='Booked';
        ps.Gross_Written_Premium__c=50000;
        ps.IPT__c=50000;
        ps.Levies__c=5000;
        ps.VG_Brokerage_Amount__c=50000; 
        ps.VG_Capacity_Paper__c='Fidelis';        
        ps.Bordereaux_Override__c = 'No';
        update ps;
    }
}