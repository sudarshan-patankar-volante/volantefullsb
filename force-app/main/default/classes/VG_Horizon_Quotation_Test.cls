@IsTest(seeAllData =False)
public class VG_Horizon_Quotation_Test {
	public static testMethod void TestMethod1() {
        SystemConstants__c cs = new SystemConstants__c();
        cs.Name='Latest Policy Name';
        cs.DocumentId__c = 'Reset';
        Insert cs;
        Policy_Record_Type__c prt = new Policy_Record_Type__c ();
        prt.Name='Horizon';
        prt.Code__c = 'HOZ';
        Insert prt;
        Policy_LOB__c lob = new Policy_LOB__c();
        lob.Name='Motor';
        lob.Code__c = 'MTR';
        Insert lob;
        Document d1=new Document();
        d1.Name='Volante_Global_logo';
        d1.Body=blob.valueOf('Hai');
        d1.FolderId='0050O0000078Mug';
        insert d1;
        Document d2=new Document();
        d2.Name='Motor Felt';
        d2.Body=blob.valueOf('Hai');
        d2.FolderId='0050O0000078Mug';
        insert d2;
        Document d3=new Document();
        d3.Name='Horizon Logo';
        d3.Body=blob.valueOf('Hai');
        d3.FolderId='0050O0000078Mug';
        insert d3;
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Horizon', acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 11, 12);
        Insert ps;
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        VG_Horizon_Quotation hoz=new VG_Horizon_Quotation();
    }
}