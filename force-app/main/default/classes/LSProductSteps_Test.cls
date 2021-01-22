@isTest(SeeAllData = false)
public class LSProductSteps_Test {
    public static testMethod void TestMethod1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Affinity','Sub-limits');        
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Affinity','Endorsements');
        Endorsement_Library__c el=new Endorsement_Library__c();
        el.Endorsement_Title__c='Test title';
        el.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        el.Type__c='Endorsements';
        el.Text__c='this is test class text';
        Insert el;
        Endorsement_Library__c el5=new Endorsement_Library__c();
        el5.Endorsement_Title__c='Test title';
        el5.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        el5.Type__c='Endorsements';
        el5.Text__c='this is test class text';
        Insert el5;
        List<Policy_Schedule__c> psList2=new List<Policy_Schedule__c>();
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        Policy_Schedule__c ps1=VG_Tu.createPolicySchedule(pol.id);
        psList2.add(ps);
        psList2.add(ps1);
        Risk_Capture__c rc=new Risk_Capture__c();
        rc.Name='Test';
        rc.Policy_Schedule__c=ps.id;
        rc.VG_Additional_Information__c='';
        Insert rc;        
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);       
        ApexPages.currentPage().getParameters().put('id', pol.id);   
        ApexPages.currentPage().getParameters().put('policyCurrency', pol.id);                
        LSProductSteps ls=new LSProductSteps();
        ls.Product='--None--';
        ls.gotostep1();
        ls.gotostep2();       
        ls.Product='Property';
        ls.setLPList();
        ls.Product='Liability';
        ls.setLPList();
        ls.Product='PA';
        ls.setLPList();
        ls.Product='D&O';
        ls.setLPList();
        ls.Product='Legal';
        ls.setLPList();
        ps.Product__c='Liability';
        update ps;
        rc.VG_Additional_Information__c='Employer’s Liability :'+'Covered'+'<br/>'
            +'Public and Products Liability :'+'Covered'+'<br/>'
            +'Professional Indemnity :'+'Covered'+'<br/>'
            +'Additional Insured, policy type:'+'Covered'+'<br/>'
                +'Additional Insured, employer name:'+'test'+'<br/>'
                +'Additional Insured, employer, ERN exempt flag:'+'yes'+'<br/>'
                +'Additional Insured, employer reference number:'+'262'+'<br/>';
        update rc;
        EL1.VG_Product__c=ls.Product;
        update EL1;
        EL2.VG_Product__c=ls.Product;
        update EL2;
        ls.gotostep3();
        Endorsement_Library__c EL3=VG_TU.createEndorsementLibraryCustom('Affinity','Sub-limits');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        ls.existingEndorsements1.add(pse);
        ls.gotostep4();
        ls.gotostep4b();
        ls.LibraryWrapperList1[0].IsSelected=True;
        ls.existingEndorsements1.add(pse);
        ls.gotostep4b();
        //Step 4 and 4b code
        //Step 5 and 5b code
        Endorsement_Library__c EL4=VG_TU.createEndorsementLibraryCustom('Affinity','Endorsements');
        VG_Policy_Schedule_Endorsement__c pse1=VG_TU.createPolicyScheduleEndorsement(ps.id);       
        ls.existingEndorsements.add(pse1);       
        ls.gotostep5();
        ls.gotostep5b(); 
        ls.LibraryWrapperList[0].IsSelected=True;
        ls.gotostep5b(); 
        ls.AddCustom();
        System.debug('existingEndorsements::'+ls.existingEndorsements.size());
        ls.gotostep6();   
    }
    public static testMethod void TestMethod2(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c();
        ps.Product__c='Property';
        ps.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        ps.Name='Test/PS/0';
        ps.Policy__c=pol.id;
        Insert ps;
        List<Policy_Schedule__c> psList2=new List<Policy_Schedule__c>();
        psList2.add(ps);        
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Affinity','Sub-limits');        
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Affinity','Endorsements');       
        Endorsement_Library__c EL=VG_TU.createEndorsementLibrary();
        EL.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        EL.VG_Product__c='Property';        
        update EL;
        Risk_Capture__c rc=new Risk_Capture__c();
        rc.Name='Test';
        rc.Policy_Schedule__c=ps.id;
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
        Insert rc;
        Policy_Schedule__c ps1=new Policy_Schedule__c();
        ps1.Product__c='Liability';
        ps1.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        ps1.Name='Test/PS/1';
        ps1.Policy__c=pol.id;
        Insert ps1;
        psList2.add(ps1);                
        Risk_Capture__c rc1=new Risk_Capture__c();
        rc1.Name='Test';
        rc1.Policy_Schedule__c=ps1.id;        
        rc1.VG_Additional_Information__c='Employer’s Liability :'+'Covered'+'<br/>'
            +'Public and Products Liability :'+'Covered'+'<br/>'
            +'Professional Indemnity :'+'Covered'+'<br/>'
            +'Additional Insured, policy type:'+'Covered'+'<br/>'
                +'Additional Insured, employer name:'+'test'+'<br/>'
                +'Additional Insured, employer, ERN exempt flag:'+'yes'+'<br/>'
                +'Additional Insured, employer reference number:'+'262'+'<br/>';
        Insert rc1;
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);
        ApexPages.currentPage().getParameters().put('Id', pol.id);        
        ApexPages.currentPage().getParameters().put('policyCurrency', pol.id);                
        LSProductSteps ls=new LSProductSteps();
        ls.Product='Property';
        ls.setLPList();
        ls.gotostep1();      
        ls.gotostep2();
        //Step 2 Code
        //Step 3 Code
        ls.gotostep3();
        ls.riskRatingList[0].psa.VG_Coverage__c='Property Damage';
        ls.riskRatingList[0].psa.VG_Perils__c='Computer';
        ls.riskRatingList[0].psa.VG_Share__c=25.6;
        ls.riskRatingList[0].psa.VG_Deductible__c=5000;
        ls.riskRatingList[0].psa.VG_Sub_limit__c=2000;
        ls.riskRatingList[0].psa.VG_Premium__c=1500;
        ls.riskRatingList[0].psa.VG_Fee_Amounts__c=1500;
        ls.riskRatingList[0].psa.VG_Base_Premium_Rate__c=12.3;
        ls.riskRatingList[0].psa.VG_Declared_Value__c=1500;
        
        ls.addRR();
        ls.Index='1';
        ls.RemoveRR();
        ls.RRCalc();
        ls.gotostep4();
        ls.gotostep4b();
        ls.gotostep5();
        ls.gotostep5b(); 
        ls.gotostep6();  
        ls.finish();
    }
    public static testMethod void TestMethod3(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        Policy_Schedule__c ps1=new Policy_Schedule__c();
        ps1.Product__c='Liability';
        ps1.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        ps1.Name='Test/PS/0';
        ps1.Policy__c=pol.id;
        Insert ps1;
        Risk_Capture__c rc1=new Risk_Capture__c();
        rc1.Name='Test';
        rc1.Policy_Schedule__c=ps1.id;        
        rc1.VG_Additional_Information__c='Employer’s Liability :'+'Covered'+'<br/>'
            +'Public and Products Liability :'+'Covered'+'<br/>'
            +'Professional Indemnity :'+'Covered'+'<br/>'
            +'Additional Insured, policy type:'+'Covered'+'<br/>'
                +'Additional Insured, employer name:'+'test'+'<br/>'
                +'Additional Insured, employer, ERN exempt flag:'+'yes'+'<br/>'
                +'Additional Insured, employer reference number:'+'262'+'<br/>';
        Insert rc1;
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Affinity','Sub-limits');        
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Affinity','Endorsements');       
        Endorsement_Library__c EL=VG_TU.createEndorsementLibrary();
        EL.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        EL.VG_Product__c='Liability';        
        update EL;
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps1.id);
        ApexPages.currentPage().getParameters().put('Id', pol.id);        
        ApexPages.currentPage().getParameters().put('policyCurrency', pol.id);                
        LSProductSteps ls=new LSProductSteps();
        ls.Product='Liability';
        ls.setLPList();
        ls.gotostep1();      
        ls.gotostep2();
        //Step 2 Code
        //Step 3 Code
        ls.gotostep3();
        ls.gotostep4();
        ls.gotostep4b();
        ls.gotostep5();
        ls.gotostep5b(); 
        ls.gotostep6();  
        ls.finish();
    }
    public static testMethod void TestMethod4(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        Policy_Schedule__c ps1=new Policy_Schedule__c();
        ps1.Product__c='PA';
        ps1.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        ps1.Name='Test/PS/0';
        ps1.Policy__c=pol.id;
        Insert ps1;
        Risk_Capture__c rc1=new Risk_Capture__c();
        rc1.Name='Test';
        rc1.Policy_Schedule__c=ps1.id;        
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
        Insert rc1;        
        ApexPages.currentPage().getParameters().put('Id', pol.id);        
        ApexPages.currentPage().getParameters().put('policyCurrency', pol.id);                
        LSProductSteps ls=new LSProductSteps();
        ls.Product='PA';
        ls.setLPList();
        ls.gotostep1();      
        ls.gotostep2();
        //Step 2 Code
        //Step 3 Code
        ls.gotostep3();
        ls.riskRatingList[0].psa.VG_Coverage__c='Property Damage';
        ls.riskRatingList[0].psa.VG_Perils__c='Computer';
        ls.riskRatingList[0].psa.VG_Share__c=25.6;
        ls.riskRatingList[0].psa.VG_Deductible__c=5000;
        ls.riskRatingList[0].psa.VG_Sub_limit__c=2000;
        ls.riskRatingList[0].psa.VG_Premium__c=1500;
        ls.riskRatingList[0].psa.VG_Fee_Amounts__c=1500;
        ls.riskRatingList[0].psa.VG_Base_Premium_Rate__c=12.3;
        ls.riskRatingList[0].psa.VG_Declared_Value__c=1500;
        ls.riskRatingList[0].psa.VG_Sum_Insured__c=2000;
        ls.addRR();
        ls.Index='1';
        ls.RemoveRR();
        ls.RRCalc();
        ls.gotostep4();
        ls.gotostep4b();
        ls.gotostep5();
        ls.gotostep5b(); 
        ls.gotostep6();  
        ls.finish();
    }
    public static testMethod void TestMethod5(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        Policy_Schedule__c ps1=new Policy_Schedule__c();
        ps1.Product__c='D&O';
        ps1.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        ps1.Name='Test/PS/2';
        ps1.Policy__c=pol.id;
        Insert ps1;
        Risk_Capture__c rc1=new Risk_Capture__c();
        rc1.Name='Test';
        rc1.Policy_Schedule__c=ps1.id;        
        rc1.VG_Additional_Information__c='Directors & Officers Liability :'+'Covered'+'<br/>';
        Insert rc1;
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Affinity','Sub-limits');        
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Affinity','Endorsements');       
        Endorsement_Library__c EL=VG_TU.createEndorsementLibrary();
        EL.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        EL.VG_Product__c='D&O';        
        update EL;
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps1.id);
        ApexPages.currentPage().getParameters().put('Id', pol.id);        
        ApexPages.currentPage().getParameters().put('policyCurrency', pol.id);                
        LSProductSteps ls=new LSProductSteps();
        ls.Product='D&O';
        ls.setLPList();
        ls.gotostep1();      
        ls.gotostep2();
        //Step 2 Code
        //Step 3 Code
        ls.gotostep3();
        ls.gotostep4();
        ls.gotostep4b();
        ls.gotostep5();
        ls.gotostep5b(); 
        ls.gotostep6();  
        ls.finish();
    }
     public static testMethod void TestMethod6(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        Policy_Schedule__c ps1=new Policy_Schedule__c();
        ps1.Product__c='Legal';
        ps1.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        ps1.Name='Test/PS/3';
        ps1.Policy__c=pol.id;
        Insert ps1;
        Risk_Capture__c rc1=new Risk_Capture__c();
        rc1.Name='Test';
        rc1.Policy_Schedule__c=ps1.id;        
        rc1.VG_Additional_Information__c='Legal Expenses :'+'Covered'+'<br/>';
        Insert rc1;
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Affinity','Sub-limits');        
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Affinity','Endorsements');       
        Endorsement_Library__c EL=VG_TU.createEndorsementLibrary();
        EL.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
        EL.VG_Product__c='Legal';        
        update EL;
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps1.id);
        ApexPages.currentPage().getParameters().put('Id', pol.id);        
        ApexPages.currentPage().getParameters().put('policyCurrency', pol.id);                
        LSProductSteps ls=new LSProductSteps();
        ls.Product='Legal';
        ls.setLPList();
        ls.gotostep1();      
        ls.gotostep2();
        //Step 2 Code
        //Step 3 Code
        ls.gotostep3();
        ls.gotostep4();
        ls.gotostep4b();
        ls.gotostep5();
        ls.gotostep5b(); 
        ls.gotostep6();  
        ls.finish();
        ls.cancel();
    }
}