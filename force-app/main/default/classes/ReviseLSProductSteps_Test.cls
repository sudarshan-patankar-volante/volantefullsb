@IsTest(SeeAllData=False)
public class ReviseLSProductSteps_Test {
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
        ps.Product__c='Liability';
        ps.VG_Brokerage_Amount__c=5000;
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 12, 15);
        ps.VG_Brokerage_Amount__c = 4000;
        ps.Share__c=20;
        update ps;
        Policy_Schedule__c ps1=VG_Tu.createPolicySchedule(pol.id);
        psList2.add(ps);
        psList2.add(ps1);
        Risk_Capture__c rc=new Risk_Capture__c();
        rc.Name='Test';
        rc.Policy_Schedule__c=ps.id;  
        rc.VG_Additional_Information__c='Employer’s Liability :'+'Covered'+'<br/>'+'Public and Products Liability :'+'Covered'+'<br/>' +'Professional Indemnity :'+'Covered'+'<br/>'+'Additional Insured, policy type:'+'Covered'+'<br/>'+'Additional Insured, employer name:'+'test'+'<br/>'+'Additional Insured, employer, ERN exempt flag:'+'yes'+'<br/>'+'Additional Insured, employer reference number:'+'262'+'<br/>';
        Insert rc;        
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);       
        ApexPages.currentPage().getParameters().put('id', ps.id);   
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.valueOf(Date.newInstance(2019, 7, 17)));                
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');                
        Test.startTest();
        ReviseLSProductSteps ls=new ReviseLSProductSteps();
        ls.Product='Liability';
        ls.netModelPremium=14500 ;
        ls.RiskPremium=4585 ;
        ls.writtenShare =10;
        ls.sharePercent=15;
        ls.actualPremium=52000;
        ls.brokerage=50;
        ls.brokerageAmount=145;
        ls.grossWrittenPremium =45000;
        ls.adjustmentTechPremium=45003;
        ls.adjustment=45000;
        ls.IPTAmount=14000;
        ls.IPTPercent=15;
        ls.feeIncome=14000 ;
        ls.levies=1400;
        ls.GrossOrNet ='Gross' ;
        ls.sumInsured=50000;
        ls.vat=4;
        ls.vatamount=4500;
        ls.taxamount=4500;
        ls.uwPremium=4500 ;
        ls.techModelPremium=5266;
        ls.aInfo='Employer’s Liability :'+'Covered'+'<br/>'+'Public and Products Liability :'+'Covered'+'<br/>' +'Professional Indemnity :'+'Covered'+'<br/>'+'Additional Insured, policy type:'+'Covered'+'<br/>'+'Additional Insured, employer name:'+'test'+'<br/>'+'Additional Insured, employer, ERN exempt flag:'+'yes'+'<br/>'+'Additional Insured, employer reference number:'+'262'+'<br/>';
        ls.rc.VG_Additional_Information__c='Employer’s Liability :'+'Covered'+'<br/>'+'Public and Products Liability :'+'Covered'+'<br/>' +'Professional Indemnity :'+'Covered'+'<br/>'+'Additional Insured, policy type:'+'Covered'+'<br/>'+'Additional Insured, employer name:'+'test'+'<br/>'+'Additional Insured, employer, ERN exempt flag:'+'yes'+'<br/>'+'Additional Insured, employer reference number:'+'262'+'<br/>';
        ls.Product='Liability';
        ls.setLPList();
        ls.Product='--None--';
        ls.gotostep1();
        ls.gotostep2();       
        ls.Product='Property';
        ls.setLPList();
        ls.Product='PA';
        ls.setLPList();
        ls.Product='D&O';
        ls.setLPList();
        ls.Product='Legal';
        ls.setLPList();
        ls.Product='Liability';
        ls.rc.VG_Additional_Information__c='Employer’s Liability :'+'Covered'+'<br/>'+'Public and Products Liability :'+'Covered'+'<br/>' +'Professional Indemnity :'+'Covered'+'<br/>'+'Additional Insured, policy type:'+'Covered'+'<br/>'+'Additional Insured, employer name:'+'test'+'<br/>'+'Additional Insured, employer, ERN exempt flag:'+'yes'+'<br/>'+'Additional Insured, employer reference number:'+'262'+'<br/>';        
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
        ReviseLSProductSteps.LibraryWrapper lw =new ReviseLSProductSteps.LibraryWrapper();
        lw.el=EL2;
        lw.isSelected=true;
        ls.LibraryWrapperList.add(lw);      
        ReviseLSProductSteps.LibraryWrapper lw1 =new ReviseLSProductSteps.LibraryWrapper();
        lw1.el=EL1;
        lw1.isSelected=true;
        ls.LibraryWrapperList1.add(lw1);              
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
        ls.finish();
        ls.cancel();
        Test.stopTest();
    }
    public static testMethod void TestMethod2(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Product__c='Property';
        ps.VG_Brokerage_Amount__c=5500;
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 12, 15);
        ps.VG_Brokerage_Amount__c = 4000;
        ps.Share__c=20;
        update ps;
        Risk_Capture__c rc=new Risk_Capture__c();
        rc.Name='Test';
        rc.Policy_Schedule__c=ps.id;  
        rc.VG_Additional_Information__c='Property Damage : '+'Covered'+'<br/>'+'Business Interruption : '+'Test'+'<br/>'+'Loss of Licence  : '+'Covered'+'<br/>'+'Goods in Transit :'+'Covered'+'<br/>'+'Money and Assault  :'+'Covered'+'<br/>'+'Fidelity :'+'Covered'+'<br/>'+'Subsidence Cover :'+'Covered'+'<br/>'+'Playing Surfaces :'+'Covered'+'<br/>'+'Terrorism :'+'Covered'+'<br/>'+'Inflation Value :'+'Covered'+'%'+'<br/>'+'<b>'+'Business Interruption | Max Indemnity Period'+'</b><br/>'+'Gross Profit :'+'Covered'+'<br/>'+'Gross Revenue :'+'Covered'+'<br/>'+'Increased Cost of Working :'+'Covered'+'<br/>'+'Additional Increased cost of working :'+'Covered'+'<br/>'+'Rent Receivable :'+'Covered'+'<br/>'+'Book Debts :'+'Covered'+'<br/>'+'Pool Re Rating Zone :'+'Covered'+'<br/>';
        Insert rc;        
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);       
        ApexPages.currentPage().getParameters().put('id', ps.id); 
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.valueOf(Date.newInstance(2019, 7, 17)));                
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');                
        Test.startTest();
        ReviseLSProductSteps ls=new ReviseLSProductSteps();
        ls.Product='Property';
        ls.netModelPremium=14500 ;
        ls.RiskPremium=4585 ;
        ls.writtenShare =10;
        ls.sharePercent=15;
        ls.actualPremium=52000;
        ls.brokerage=50;
        ls.brokerageAmount=145;
        ls.grossWrittenPremium =45000;
        ls.adjustmentTechPremium=45003;
        ls.adjustment=45000;
        ls.IPTAmount=14000;
        ls.IPTPercent=15;
        ls.feeIncome=14000 ;
        ls.levies=1400;
        ls.GrossOrNet ='Gross' ;
        ls.sumInsured=50000;
        ls.vat=4;
        ls.vatamount=4500;
        ls.taxamount=4500;
        ls.uwPremium=4500 ;
        ls.techModelPremium=5266;     
        ls.rc.VG_Additional_Information__c='Property Damage : '+'Covered'+'<br/>'+'Business Interruption : '+'Covered'+'<br/>'+'Loss of Licence  : '+'Covered'+'<br/>'+'Goods in Transit :'+'Covered'+'<br/>'+'Money and Assault  :'+'Covered'+'<br/>'+'Fidelity :'+'Covered'+'<br/>'+'Subsidence Cover :'+'Covered'+'<br/>'+'Playing Surfaces :'+'Covered'+'<br/>'+'Terrorism :'+'Covered'+'<br/>'+'Inflation Value :'+'Covered'+'%'+'<br/>'+'<b>'+'Business Interruption | Max Indemnity Period'+'</b><br/>'+'Gross Profit :'+'Covered'+'<br/>'+'Gross Revenue :'+'Covered'+'<br/>'+'Increased Cost of Working :'+'Covered'+'<br/>'+'Additional Increased cost of working :'+'Covered'+'<br/>'+'Rent Receivable :'+'Covered'+'<br/>'+'Book Debts :'+'Covered'+'<br/>';
        ls.Product='Property';
        ls.setLPList();
        ls.rc.VG_Additional_Information__c='Property Damage : '+'Covered'+'<br/>'+'Business Interruption : '+'Covered'+'<br/>'+'Loss of Licence  : '+'Covered'+'<br/>'+'Goods in Transit :'+'Covered'+'<br/>'+'Money and Assault  :'+'Covered'+'<br/>'+'Fidelity :'+'Covered'+'<br/>'+'Subsidence Cover :'+'Covered'+'<br/>'+'Playing Surfaces :'+'Covered'+'<br/>'+'Terrorism :'+'Covered'+'<br/>'+'Inflation Value :'+'Covered'+'%'+'<br/>'+'<b>'+'Business Interruption | Max Indemnity Period'+'</b><br/>'+'Gross Profit :'+'Covered'+'<br/>'+'Gross Revenue :'+'Covered'+'<br/>'+'Increased Cost of Working :'+'Covered'+'<br/>'+'Additional Increased cost of working :'+'Covered'+'<br/>'+'Rent Receivable :'+'Covered'+'<br/>'+'Book Debts :'+'Covered'+'<br/>';
        ls.gotostep1();
        ls.gotostep2();
        ls.gotostep3();
        ReviseLSProductSteps.RRWrapper RRW =new ReviseLSProductSteps.RRWrapper();
        RRW.psa=rr;
        RRW.CoverageSelected='Property Damage';
        ls.riskRatingList.add(RRW);        
        ls.riskRatingList[0].psa.VG_Coverage__c='Property Damage';
        ls.riskRatingList[0].psa.VG_Perils__c='Computer';
        ls.riskRatingList[0].psa.VG_Share__c=25.6;
        ls.riskRatingList[0].psa.VG_Deductible__c=5000;
        ls.riskRatingList[0].psa.VG_Sub_limit__c=2000;
        ls.riskRatingList[0].psa.VG_Premium__c=1500;
        ls.riskRatingList[0].psa.VG_Fee_Amounts__c=1500;
        ls.riskRatingList[0].psa.VG_Base_Premium_Rate__c=12.3;
        ls.riskRatingList[0].psa.VG_Declared_Value__c=1500;
        ls.RRCalc();
        ls.gotostep4();
        ls.gotostep4b();
        ls.gotostep5();
        ls.gotostep5b();
        ls.gotostep6();
        ls.finish();
        Test.stopTest();
    }
    public static testMethod void TestMethod3(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc.id);
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Product__c='PA';
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 12, 15);
        ps.VG_Brokerage_Amount__c = 4000;
        ps.Share__c=20;
        update ps;
        Risk_Capture__c rc=new Risk_Capture__c();
        rc.Name='Test';
        rc.Policy_Schedule__c=ps.id;  
        rc.VG_Additional_Information__c='Personal Accident :'+'Covered'+'<br/>'+'Benefit :'+'Covered'+'<br/>'+'Medical Costs :'+'Covered'+'<br/>'+'Loss of Income :'+'Covered'+'<br/>'+'Coma Benefit :'+'Covered'+'<br/>'+'Childcare Expenses :'+'Covered'+'<br/>'+'Continued Education Expenses :'+'Covered'+'<br/>'+'Domestic Expenses :'+'Covered'+'<br/>'+'Driver Expenses :'+'Covered'+'<br/>'+'Funeral Expenses :'+'Covered'+'<br/>'+'Hospital In-Patents Expenses  :'+'Covered'+'<br/>'+'Home Modification Expenses  :'+'Covered'+'<br/>'+'Number of adult members :'+'Covered'+'<br/>'+'Number of Junior members :'+'Covered'+'<br/>'+'Referees / coaches / Officials :'+'Covered'+'<br/>'+'Clubs :'+'Covered'+'<br/>';
        Insert rc;        
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);   
        VG_Policy_Schedule_Asset__c rr1=VG_TU.createPolicyScheduleAsset(ps.id);       
        
        ApexPages.currentPage().getParameters().put('id', ps.id);
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.valueOf(Date.newInstance(2019, 7, 17)));                
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');                
        Test.startTest();
        ReviseLSProductSteps ls=new ReviseLSProductSteps();
        ls.Product='PA';
        ls.netModelPremium=14500 ;
        ls.RiskPremium=4585 ;
        ls.writtenShare =10;
        ls.sharePercent=15;
        ls.actualPremium=52000;
        ls.brokerage=50;
        ls.brokerageAmount=145;
        ls.grossWrittenPremium =45000;
        ls.adjustmentTechPremium=45003;
        ls.adjustment=45000;
        ls.IPTAmount=14000;
        ls.IPTPercent=15;
        ls.feeIncome=14000 ;
        ls.levies=1400;
        ls.GrossOrNet ='Gross' ;
        ls.sumInsured=50000;
        ls.vat=4;
        ls.vatamount=4500;
        ls.taxamount=4500;
        ls.uwPremium=4500 ;
        ls.techModelPremium=5266;
        System.debug('product:'+ls.Product);       
        ls.rc.VG_Additional_Information__c='Personal Accident :'+'Covered'+'<br/>'+'Benefit :'+'Covered'+'<br/>'+'Medical Costs :'+'Covered'+'<br/>'+'Loss of Income :'+'Covered'+'<br/>'+'Coma Benefit :'+'Covered'+'<br/>'+'Childcare Expenses :'+'Covered'+'<br/>'+'Continued Education Expenses :'+'Covered'+'<br/>'+'Domestic Expenses :'+'Covered'+'<br/>'+'Driver Expenses :'+'Covered'+'<br/>'+'Funeral Expenses :'+'Covered'+'<br/>'+'Hospital In-Patents Expenses  :'+'Covered'+'<br/>'+'Home Modification Expenses  :'+'Covered'+'<br/>'+'Number of adult members :'+'Covered'+'<br/>'+'Number of Junior members :'+'Covered'+'<br/>'+'Referees / coaches / Officials :'+'Covered'+'<br/>'+'Clubs :'+'Covered'+'<br/>';
        ls.Product='PA';
        ls.setLPList();
        ls.rc.VG_Additional_Information__c='Personal Accident :'+'Covered'+'<br/>'+'Benefit :'+'Covered'+'<br/>'+'Medical Costs :'+'Covered'+'<br/>'+'Loss of Income :'+'Covered'+'<br/>'+'Coma Benefit :'+'Covered'+'<br/>'+'Childcare Expenses :'+'Covered'+'<br/>'+'Continued Education Expenses :'+'Covered'+'<br/>'+'Domestic Expenses :'+'Covered'+'<br/>'+'Driver Expenses :'+'Covered'+'<br/>'+'Funeral Expenses :'+'Covered'+'<br/>'+'Hospital In-Patents Expenses  :'+'Covered'+'<br/>'+'Home Modification Expenses  :'+'Covered'+'<br/>'+'Number of adult members :'+'Covered'+'<br/>'+'Number of Junior members :'+'Covered'+'<br/>'+'Referees / coaches / Officials :'+'Covered'+'<br/>'+'Clubs :'+'Covered'+'<br/>';               
        ls.gotostep1();
        System.debug('product:'+ls.Product);        
        ls.gotostep2();
        ls.gotostep3();
        ReviseLSProductSteps.RRWrapper RRW =new ReviseLSProductSteps.RRWrapper();
        RRW.psa=rr;
        RRW.CoverageSelected='Property Damage';
        ls.riskRatingList.add(RRW);
        
        ls.RRCalc();
        ls.addRR();
        ls.AddCustom();
        ls.RemoveCustom();
        ls.RemoveRR();
        ls.gotostep4();
        ls.gotostep4b();
        ls.gotostep5();
        ls.gotostep5b();
        ls.gotostep6();
        ls.finish();
        Test.stopTest();
    }
}