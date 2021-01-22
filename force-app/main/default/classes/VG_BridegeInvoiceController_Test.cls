@IsTest(seeAllData =False)
public class VG_BridegeInvoiceController_Test {
    public static testMethod void TestMethod1() { 
        VG_TU.policyCustomSetting();       
        Document d1=new Document();
        d1.Name='Bridge Logo';
        d1.Body=blob.valueOf('Hai');
        d1.FolderId='0050O0000078Mug';
        insert d1;
        Document d2=new Document();
        d2.Name='Motor Felt';
        d2.Body=blob.valueOf('Hai');
        d2.FolderId='0050O0000078Mug';
        insert d2;
        Document d3=new Document();
        d3.Name='Volante_Global_logo';
        d3.Body=blob.valueOf('Hai');
        d3.FolderId='0050O0000078Mug';
        insert d3;
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Bridge', acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Product__c='Property';
        ps.Policy__c=pol.id;
        ps.Gross_Written_Premium__c=50000;
        ps.VG_Brokerage_Amount__c=4500;
        ps.IPT__c=4500;
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 11, 12);
        Insert ps;
        VG_Payment_Frequency__c pf= VG_TU.createPaymentFrequency(ps.Id);
        VG_Taxes__c tx=new VG_Taxes__c();
        tx.Name='test';
        tx.VG_Policy_Schedule__c=ps.id;
        tx.VG_Taxable_Amount__c=4500;
        tx.VG_Tax_Administered_By__c='Insurer';
        tx.VG_Tax_Percent__c=45;
        Insert tx;
        VG_Taxes__c tx1=new VG_Taxes__c();
        tx1.Name='test';
        tx1.VG_Policy_Schedule__c=ps.id;
        tx1.VG_Taxable_Amount__c=4500;
        tx1.VG_Tax_Amount__c=4800;
        tx1.VG_Tax_Administered_By__c='Broker';
        tx1.VG_Tax_Percent__c=45;
        Insert tx1;
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        ApexPages.currentPage().getParameters().put('PFId', pf.id);
        VG_BridegeInvoiceController BD=new VG_BridegeInvoiceController();
    }   
}