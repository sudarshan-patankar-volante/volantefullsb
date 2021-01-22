@IsTest(SeeAllData=False)
public class TaxTriggerFunction_Test {
	public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.Technical_UW_Premium__c=5000;
        Ps.Levies__c =450;
        update ps;
        VG_Payment_Frequency__c pf=new VG_Payment_Frequency__c();
        pf.Name='pfTest';
        pf.VG_Policy_Schedule__c=ps.id;
        pf.VG_Outstanding_taxes__c=100;
        pf.VG_Payment_Percent__c=50;
        pf.VG_Due_Date__c=Date.newInstance(2019, 4, 18);
        Insert pf;
        VG_Taxes__c tx=new VG_Taxes__c();
        tx.Name='taxTest';
        tx.VG_Policy_Schedule__c=ps.id;
        tx.VG_Tax_Percent__c=12;
        tx.VG_Taxable_Amount__c=5000;
        Insert tx;
    }
}