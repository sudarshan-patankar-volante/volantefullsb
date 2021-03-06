@IsTest(seeAllData =False)
public class VG_FIDODocumentController_Test {
    public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('VFP', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        List<Document> dList=new List<Document>();
        Document d1=new Document();
        d1.Name='Motor Felt';
        d1.Body=blob.valueOf('Hai'); 
        d1.FolderId='0050O0000078Mug';
        dList.add(d1);
        Document d2=new Document();
        d2.Name='VG PI Logo';
        d2.Body=blob.valueOf('Hai');
        d2.FolderId='0050O0000078Mug';
        dList.add(d2);
        Document d3=new Document();
        d3.Name='VG_Edison_Quote';
        d3.Body=blob.valueOf('Hai');
        d3.FolderId='0050O0000078Mug';
        dList.add(d3);
        Document d4=new Document();
        d4.Name='Kristy_Sign';
        d4.Body=blob.valueOf('Hai');
        d4.FolderId='0050O0000078Mug';
        dList.add(d4);
        Document d5=new Document();
        d5.Name='W&I UW Sign';
        d5.Body=blob.valueOf('Hai');
        d5.FolderId='0050O0000078Mug';
        dList.add(d5);
        Document d6=new Document();
        d6.Name='VFP phone';
        d6.Body=blob.valueOf('Hai');
        d6.FolderId='0050O0000078Mug';
        dList.add(d6);
        Document d7=new Document();
        d7.Name='VFP Email';
        d7.Body=blob.valueOf('Hai');
        d7.FolderId='0050O0000078Mug';
        dList.add(d7);
        Document d8=new Document();
        d8.Name='VFP Global';
        d8.Body=blob.valueOf('Hai');
        d8.FolderId='0050O0000078Mug';
        dList.add(d8);
        insert dList;
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        rc.VG_Proposal_form_date__c=Date.newInstance(2020, 02, 17);
        update rc;
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        Test.startTest();
        VG_FIDODocumentController fdc=new VG_FIDODocumentController();       
        ps.Gross_Written_Premium__c=5000;
        ps.VG_VAT__c=20;
        ps.VG_Witholding_Tax_Amount__c=2000;
        ps.IPT__c=20;
        ps.VG_Capacity_Paper__c = 'PI Liberty Co';
        update ps;         
        VG_FIDODocumentController fdc1=new VG_FIDODocumentController();
        ps.VG_Capacity_Paper__c = 'PI Liberty 100%';
        update ps;
        VG_FIDODocumentController fdc2=new VG_FIDODocumentController();
        ps.VG_Capacity_Paper__c = 'PI Liberty Lloyds';
        update ps;
        VG_FIDODocumentController fdc3=new VG_FIDODocumentController();
        Test.stopTest();
    }
}