@IsTest(seeAllData =False)
public class VG_LSDocumentController_Test {   
     public static testMethod void TestMethod2() {
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
        ps.Product__c='Liability';
        update ps; 
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);       
        psa.VG_Coverage__c='Employers Liability';
        update psa;        
        Policy_Schedule__c ps1=VG_TU.createPolicySchedule(pol.id);
        ps1.Product__c='D&O';
        update ps1; 
        VG_Policy_Schedule_Asset__c psa3=VG_TU.createPolicyScheduleAsset(ps1.id);       
        psa3.VG_Coverage__c='D&O';
        update psa3; 
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        rc.VG_Additional_Information__c='Employer’s Liability :'+'Covered'+'<br/>'
            +'Public and Products Liability :'+'Covered'+'<br/>'
            +'Professional Indemnity :'+'Covered'+'<br/>'
            +'Additional Insured, policy type:'+'Covered'+'<br/>'
                +'Additional Insured, employer name:'+'test'+'<br/>'
                +'Additional Insured, employer, ERN exempt flag:'+'yes'+'<br/>'
                +'Additional Insured, employer reference number:'+'262'+'<br/>';
        update rc;         
        Risk_Capture__c rc1=VG_TU.createRiskCapture(ps1.id);
        rc1.VG_Additional_Information__c='Directors & Officers Liability :'+'Covered'+'<br/>';
        update rc1;
        Test.startTest();
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        VG_LSDocumentController fdc=new VG_LSDocumentController();
        Test.stopTest();
    }
    public static testMethod void TestMethod3() {
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
        ps.Product__c='Property';
        update ps;      
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        VG_Policy_Schedule_Asset__c psa4=VG_TU.createPolicyScheduleAsset(ps.id);
        psa4.VG_Coverage__c='Money';
        psa4.VG_Perils__c ='Business Hours';
        psa4.VG_Sum_Insured__c=null; 
        update psa4;
        VG_Policy_Schedule_Asset__c psa7=VG_TU.createPolicyScheduleAsset(ps.id);
        psa7.VG_Coverage__c='Money';
        psa7.VG_Perils__c ='Annual Carryings (Own Employees)';
        psa7.VG_Sum_Insured__c=null;
        update psa7;
        VG_Policy_Schedule_Asset__c psa5=VG_TU.createPolicyScheduleAsset(ps.id);
        psa5.VG_Coverage__c='Money';
        psa5.VG_Perils__c ='Annual Carryings (Security Company)';
        psa5.VG_Sum_Insured__c=100;       
        update psa5;
        VG_Policy_Schedule_Asset__c psa6=VG_TU.createPolicyScheduleAsset(ps.id);
        psa6.VG_Coverage__c='Money';
        psa6.VG_Perils__c ='Money in Safes';
        update psa6;
       
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        rc.VG_Additional_Information__c='Property Damage : '+'covered'+'<br/>'+
            'Business Interruption : '+'covered'+'<br/>'+
            'Loss of Licence  : '+'covered'+'<br/>'+
            'Goods in Transit :'+'covered'+'<br/>'+
            'Money and Assault  :'+'covered'+'<br/>'+
            'Fidelity :'+'covered'+'<br/>'+
            'Subsidence Cover :'+'covered'+'<br/>'+
            'Playing Surfaces :'+'covered'+'<br/>'+
            'Terrorism :'+'covered'+'<br/>'+
            'Inflation Value :'+'10'+'%'+'<br/>'+
            '<b>'+'Business Interruption | Max Indemnity Period'+'</b><br/>'+
            'Gross Profit :'+'covered'+'<br/>'+
            'Gross Revenue :'+'covered'+'<br/>'+
            'Increased Cost of Working :'+'covered'+'<br/>'+
            'Additional Increased cost of working :'+'covered'+'<br/>'+
            'Rent Receivable :'+'covered'+'<br/>'+
            'Book Debts :'+'covered'+'<br/>';
        update rc;
      
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        VG_LSDocumentController fdc=new VG_LSDocumentController();       
    }
    public static testMethod void TestMethod4() {
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
        ps.Product__c='Property';
        update ps;  
        VG_Policy_Schedule_Asset__c psa4=VG_TU.createPolicyScheduleAsset(ps.id);
        psa4.VG_Coverage__c='Money';
        psa4.VG_Perils__c ='Business Hours';
        psa4.VG_Sum_Insured__c=400; 
        update psa4;
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        VG_Policy_Schedule_Asset__c psa7=VG_TU.createPolicyScheduleAsset(ps.id);
        psa7.VG_Coverage__c='Money';
        psa7.VG_Perils__c ='Annual Carryings (Own Employees)';
        psa7.VG_Sum_Insured__c=1000;
        update psa7;
        VG_Policy_Schedule_Asset__c psa8=VG_TU.createPolicyScheduleAsset(ps.id);
        psa8.VG_Coverage__c='Money';
        psa8.VG_Perils__c ='In transit (employees)';
        psa8.VG_Sum_Insured__c=1000;
        update psa8;
        VG_Policy_Schedule_Asset__c psa9=VG_TU.createPolicyScheduleAsset(ps.id);
        psa9.VG_Coverage__c='Money';
        psa9.VG_Perils__c ='In transit (security co.)';
        psa9.VG_Sum_Insured__c=100;
        update psa9;
         Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        rc.VG_Additional_Information__c='Property Damage : '+'covered'+'<br/>'+
            'Business Interruption : '+'covered'+'<br/>'+
            'Loss of Licence  : '+'covered'+'<br/>'+
            'Goods in Transit :'+'covered'+'<br/>'+
            'Money and Assault  :'+'covered'+'<br/>'+
            'Fidelity :'+'covered'+'<br/>'+
            'Subsidence Cover :'+'covered'+'<br/>'+
            'Playing Surfaces :'+'covered'+'<br/>'+
            'Terrorism :'+'covered'+'<br/>'+
            'Inflation Value :'+'10'+'<br/>'+
            '<b>'+'Business Interruption | Max Indemnity Period'+'</b><br/>'+
            'Gross Profit :'+'covered'+'<br/>'+
            'Gross Revenue :'+'covered'+'<br/>'+
            'Increased Cost of Working :'+'covered'+'<br/>'+
            'Additional Increased cost of working :'+'covered'+'<br/>'+
            'Rent Receivable :'+'covered'+'<br/>'+
            'Book Debts :'+'covered'+'<br/>';
        update rc;      
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        VG_LSDocumentController fdc=new VG_LSDocumentController();       
    }    
}