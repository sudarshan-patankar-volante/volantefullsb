@IsTest(seeAllData =False)
public class VG_Bridge_Quotation_Test {
    public static testMethod void TestMethod1() {
        SystemConstants__c cs = new SystemConstants__c();
        cs.Name='Latest Policy Name';
        cs.DocumentId__c = 'Reset';
        Insert cs;
        Policy_Record_Type__c prt = new Policy_Record_Type__c ();
        prt.Name='Bridge';
        prt.Code__c = 'BDG';
        Insert prt;
        Policy_LOB__c lob = new Policy_LOB__c();
        lob.Name='Motor';
        lob.Code__c = 'MTR';
        Insert lob;
        
        Document d6=new Document();
        d6.Name='Bridge Loge For English Quote';
        d6.Body=blob.valueOf('Hai');
        d6.FolderId='0050O0000078Mug';
        insert d6;
        Document d7=new Document();
        d7.Name='Peter Forsberg';
        d7.Body=blob.valueOf('Hai');
        d7.FolderId='0050O0000078Mug';
        insert d7;
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Bridge', acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 11, 12);
        ps.Gross_Written_Premium__c=150000;
        Insert ps;
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        VG_Bridge_Quotation quote=new VG_Bridge_Quotation();        
    }
}