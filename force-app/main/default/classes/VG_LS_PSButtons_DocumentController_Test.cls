@IsTest(seeAllData =False)
public class VG_LS_PSButtons_DocumentController_Test {
	public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');                
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
        d3.Name='VG_LS_Affnity_Logo';
        d3.Body=blob.valueOf('Hai');
        d3.FolderId='0050O0000078Mug';
        dList.add(d3);
        Document d4=new Document();
        d4.Name='David Sign';
        d4.Body=blob.valueOf('Hai');
        d4.FolderId='0050O0000078Mug';
        dList.add(d4);
        Document d5=new Document();
        d5.Name='LS EL_Image';
        d5.Body=blob.valueOf('Hai');
        d5.FolderId='0050O0000078Mug';
        dList.add(d5);
        Document d6=new Document();
        d6.Name='Talbir Bains';
        d6.Body=blob.valueOf('Hai');
        d6.FolderId='0050O0000078Mug';
        dList.add(d6);
        insert dList;
        Policy__c pol=VG_TU.createPolicy('Affinity', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.Product__c='PA';
        update ps;   
        VG_Policy_Schedule_Asset__c psa9=VG_TU.createPolicyScheduleAsset(ps.id);
        psa9.VG_Coverage__c='Personal Accident';
        psa9.VG_Perils__c ='Death';
        psa9.VG_Sum_Insured__c=100;
        update psa9;
       Risk_Capture__c rc1=VG_TU.createRiskCapture(ps.id);
        rc1.VG_Additional_Information__c='Personal Accident :'+'Covered'+'<br/>'
            +'Benefit :'+'Covered'+'<br/>'
            +'Medical Costs :'+'Covered'+'<br/>'
            +'Loss of Income :'+'Covered'+'<br/>'
            +'Coma Benefit :'+'Covered'+'<br/>'
            +'Childcare Expenses :'+'Yes'+'<br/>'
            +'Continued Education Expenses :'+'Yes'+'<br/>'
            +'Domestic Expenses :'+'Yes'+'<br/>'
            +'Driver Expenses :'+'Yes'+'<br/>'
            +'Funeral Expenses :'+'Yes'+'<br/>'
            +'Hospital In-Patents Expenses  :'+'Yes'+'<br/>'
            +'Home Modification Expenses  :'+'Yes'+'<br/>'
            +'Number of adult members :'+'100'+'<br/>'
            +'Number of Junior members :'+'500'+'<br/>'
            +'Referees / coaches / Officials :'+'54'+'<br/>'
            +'Clubs :'+'150'+'<br/>';
        update rc1;
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        VG_LS_PSButtons_DocumentController fdc=new VG_LS_PSButtons_DocumentController();
    }
}