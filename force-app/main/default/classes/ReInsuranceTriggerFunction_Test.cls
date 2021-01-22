@IsTest(SeeAllData=False)
public class ReInsuranceTriggerFunction_Test {
    public static testmethod void testmethod1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        //Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.Id);
        Policy_Schedule__c ps=new Policy_Schedule__c();
        ps.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        ps.Name='Test';
        ps.Policy__c=pol.id;  
        ps.VG_Is_MTA__c=True;
        ps.VG_Status__c='Booked';
        ps.Levies__c=14;
        ps.Premium_Adjustment__c=5000;
        ps.Endorsement_Premium_Pro__c=25000;
        ps.Risk_Premium_Pro__c=26000;
        ps.VG_Brokerage_Percent__c=12.5;
        ps.VG_MTA_Type__c='Cancellation';
        ps.VG_Fee_Income__c=2000;
        Insert ps;
        //Policy_Schedule__c ps2=VG_TU.createPolicySchedule(pol.Id);
        VG_UMR__c UMR=VG_TU.createUMR(acc.Id,'Edison Motor');
        VG_ReInsurance__c ri=VG_TU.createReInsurance(ps.Id,UMR.Id);
        VG_ReInsurance__c ri2=VG_TU.createReInsurance(ps.Id,UMR.Id);        
    }
}