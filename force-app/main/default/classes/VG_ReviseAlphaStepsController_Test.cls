@IsTest(SeeAllData=False)
public class VG_ReviseAlphaStepsController_Test {
    public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer'); 
        Policy__c pol=VG_TU.createPolicy('Imara',acc.id);
        pol.VG_Inception_Date__c=Date.newInstance(2018, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2019, 3, 2);
		update pol;
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id); 
        ps.Premium_Adjustment_2__c=45800;
		ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 12, 15);
        ps.VG_Brokerage_Amount__c = 4000;
        update ps;
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Imara','Sub-limits');
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Imara','Endorsements');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        VG_Policy_Schedule_Endorsement__c pse1=VG_TU.createPolicyScheduleEndorsement(ps.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        rc.VG_Additional_Information__c='Insurer :a+<br/>+Insurer Policy Number :b+<br/>+Insurer Policy Currency :USD+<br/>+Insurer Policy Limit :1554<br/>+Insurer Policy Dedctible :5203<br/>+Insurer Policy Premium :4500<br/>+Insurer Policy Share :15';
        update rc;
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        psa.VG_Risk_Premium__c=5000;
        Update psa;        
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.valueOf(Date.newInstance(2019, 7, 17)));                
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');                
        VG_ReviseAlphaStepsController alp=new VG_ReviseAlphaStepsController();
        alp.Structure_Select='Proportional';
        alp.SubStructure_Select='Per Event';
        alp.WrittenShare=5;
        alp.SignedShare=10;
        alp.GrossWrittenPremium=1547;
        alp.PremiumAdjustment=5500;
        alp.TechnicalPremium=4501;
        alp.Brokerage=52;
        alp.BrokerageAmount=4578;
        alp.ActualPremium=4587;
        alp.Overider=15;
        alp.FeeIncome=145;
        alp.RiskPremium=4500;
        alp.EndorsementPremium=154;
        alp.RateOnLine=154;
        alp.Levies=145;
        alp.TechnicalLossRatio=568;
        alp.TotalLayerPremium=0;
        alp.rr.name='Test';
        alp.rr.VG_Premium__c=15252;
        alp.rr.VG_Policy_Schedule__c=ps.id;       
        alp.rr.VG_Minimum_Premium__c=4521;
        alp.rc.VG_Additional_Information__c='Insurer :a+<br/>+Insurer Policy Number :b+<br/>+Insurer Policy Currency :USD+<br/>+Insurer Policy Limit :1554<br/>+Insurer Policy Dedctible :5203<br/>+Insurer Policy Premium :4500<br/>+Insurer Policy Share :15';
        alp.PolicyDetails='Insurer :a+<br/>+Insurer Policy Number :b+<br/>+Insurer Policy Currency :USD+<br/>+Insurer Policy Limit :1554<br/>+Insurer Policy Dedctible :5203<br/>+Insurer Policy Premium :4500<br/>+Insurer Policy Share :15';
        alp.gotostep1();
        alp.RI_Select='Treaty Reinsurance';
        alp.Structure_Select='Non-Proportional';
        alp.rr.VG_Minimum_Premium__c=10;
        alp.rr.VG_Rate_on_Income__c=1500;
        alp.rr.VG_GNPI__c=452;
        alp.rr.VG_Deposit_Premium__c=14;
        alp.rr.VG_No_Claims_Bonus__c=4521;
        alp.rr.VG_Provisional_Rate__c=45;
        alp.rr.VG_Expected_Premium_Income__c =4578;
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.ValueOf(Date.newInstance(2017, 12, 18)));
        Test.startTest();
        
        VG_ReviseAlphaStepsController alp3=new VG_ReviseAlphaStepsController();
        alp3.gotostep1();
        alp3.RI_Select='Facultative Reinsurance';
        alp3.Structure_Select='Non-Proportional';
        alp3.gotostep2();
        pol.VG_Inception_Date__c=Date.newInstance(2019, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2020, 3, 30);
        update pol;
        pol.VG_Inception_Date__c=Date.newInstance(2020, 3, 30);
        pol.VG_Expiry_Date__c=Date.newInstance(2021, 3, 30);
        update pol;
        VG_ReviseAlphaStepsController alp5=new VG_ReviseAlphaStepsController();
        alp5.gotostep1();
        alp5.RI_Select='Facultative Reinsurance';
        alp5.Structure_Select='Proportional';
        alp5.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2018, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2019, 3, 2);
		update pol;
        VG_ReviseAlphaStepsController alp4=new VG_ReviseAlphaStepsController();
        alp4.gotostep1();
        alp.setProductList();
        alp4.cancel();
        VG_ReviseAlphaStepsController alp2=new VG_ReviseAlphaStepsController();
        alp2.gotostep1(); 
        alp2.RI_Select =  '--None--';
        alp2.Structure_Select = '--None--';
        alp2.setSubStructureList();
        alp2.Product_Select='';
        alp2.setProductList();
        alp2.RiskRatingCalc();
        alp2.RiskRatingCalc2();
        alp2.rr.VG_Cession__c=15;
        alp2.rr.VG_Expected_Premium_Income__c=1545;
        alp2.rr.VG_Expected_Loss_Ratio__c=15;
        alp2.rr.VG_Ceding_Commission__c=1542;
        alp2.rr.VG_Retention_Line__c=4521;
        alp2.rr.VG_No_of_Surplus_Lines__c=15;
        alp2.RiskRatingCalc2();        
        alp2.gotostep2();
        alp2.gotostep3();
        alp2.gotostep4();
        alp2.gotostep5();
        alp2.gotostep5b();
         //Step 4 and 4b code
        //Step 5 and 5b code
        alp2.gotostep6();
        alp2.gotostep6b(); 
        alp2.AddCustom();
        alp2.SignedShare=15;
        alp2.GrossWrittenPremium=5000;
        alp2.TechnicalLossRatio=145;
        alp2.Brokerage=20;
        alp2.Overider=15;
        alp2.rr.VG_Limit__c=2500;
        alp2.rr.VG_Deductible__c=2000;
        alp2.rr.VG_Limit_Precent__c=150;
        alp2.rr.VG_Deductible_Precent__c=200;
        alp2.Calc();   
        alp2.Finish();    
        Test.stopTest();
    }
    public static testMethod void TestMethod2() {
        //Cover Constructor 
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer'); 
        Policy__c pol=VG_TU.createPolicy('Imara',acc.id);
        pol.VG_Inception_Date__c=Date.newInstance(2018, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2019, 3, 2);
		pol.Type_of_Insurance__c = 'Treaty Reinsurance';
        pol.VG_Is_Renewal__c = false;
        update pol;        
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Imara','Sub-limits');
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Imara','Endorsements');
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id); 
        ps.Premium_Adjustment_2__c=45800;
		ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 12, 15);
        ps.VG_Brokerage_Amount__c = 4000;
        ps.Product__c='Excess of Loss';        
        update ps;
        VG_Policy_Schedule_Endorsement__c pse3=VG_TU.createPolicyScheduleEndorsement(ps.id);
        
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        rc.VG_Additional_Information__c='Insurer :'+'TestAcc'+'<br/>'
       +'Insurer Policy Number :'+'123354'+'<br/>'
       +'Insurer Policy Currency :'+'ISD'+'<br/>'
       +'Insurer Policy Limit :'+'158725'+'<br/>'
       +'Insurer Policy Dedctible :'+'450000'+'<br/>'
       +'Insurer Policy Premium :'+'45000'+'<br/>'
       +'Insurer Policy Share :'+'154'+'<br/>';
        rc.VG_Reinstatement_Premiums__c='3';
        update rc;
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        psa.VG_Risk_Premium__c=5000;
        psa.VG_Expected_Premium_Income__c=4500;
        psa.VG_Provisional_Rate__c=4520;
        psa.VG_Expected_Loss_Ratio__c=45;
        psa.VG_No_of_Surplus_Lines__c=40;
        psa.VG_GNPI__c=4200;
        psa.VG_Rate_on_Income__c=4500;
        psa.VG_Provisional_Rate__c=4587;
        psa.VG_Minimum_Premium__c=4780;
        psa.VG_Deposit_Premium__c=4856;
        psa.VG_No_Claims_Bonus__c=4852;
        psa.VG_Perils__c='Fire & Allied Perils; Motor Physical Damage;';
        Update psa;
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.valueOf(Date.newInstance(2019, 7, 17)));                
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');                
        Test.startTest();
        VG_ReviseAlphaStepsController alp1=new VG_ReviseAlphaStepsController();
        alp1.gotostep1();        
        alp1.CapacityPaper= '--None--';
        alp1.RI_Select='Treaty Reinsurance';
        alp1.Structure_Select ='Proportional';
        alp1.setProductList();
        alp1.Product_Select  = 'Aggregate Stop Loss';        
        alp1.gotostep2();
        alp1.RiskRatingCalc();
        alp1.RiskRatingCalc2();
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        pol.VG_Inception_Date__c=Date.newInstance(2019, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2020, 2, 27);
        update pol;
        VG_ReviseAlphaStepsController alp=new VG_ReviseAlphaStepsController();
        alp.gotostep1();
        alp.RI_Select='Treaty Reinsurance';
        alp.Structure_Select ='Proportional';
        alp.Product_Select = 'Quota Share';
        alp.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2020, 3, 30);
        pol.VG_Expiry_Date__c=Date.newInstance(2021, 3, 30);
        update pol;
        VG_ReviseAlphaStepsController alp3=new VG_ReviseAlphaStepsController();
        alp3.gotostep1();
        alp3.Structure_Select ='Proportional';
        alp3.Product_Select = 'Excess of Loss Per Risk';        
        alp3.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2020, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2021, 2, 27);
        update pol;
        VG_ReviseAlphaStepsController alp2=new VG_ReviseAlphaStepsController();
        alp2.gotostep1();       
        alp2.MTAType = null;
        alp2.RI_Select = 'Facultative Reinsurance'; 
        alp2.Structure_Select = 'Non-Proportional';
        alp2.setSubStructureList();
        alp2.Product_Select='Quota Share';        
        alp2.gotostep2();  
        alp2.rr.VG_Perils__c = 'Fire & Allied Perils; Motor Physical Damage;';
        alp2.gotostep3();
        alp2.gotostep4();
        alp2.gotostep5();
        alp2.gotostep5b();
        alp2.gotostep6();
        alp2.gotostep6b();
        alp2.Finish();    
        Test.stopTest();
    }
    public static testMethod void TestMethod3() {
        //Cover Constructor 
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer'); 
        Policy__c pol=VG_TU.createPolicy('Imara',acc.id);
        pol.VG_Inception_Date__c=Date.newInstance(2020, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2021, 2, 27);
        update pol;
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Imara','Sub-limits');
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Imara','Endorsements');
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.VG_MTA_Type__c = null;
        ps.Premium_Adjustment_2__c=45800;
		ps.VG_Brokerage_Amount__c = 4000;
        update ps;
        VG_Policy_Schedule_Endorsement__c pse3=VG_TU.createPolicyScheduleEndorsement(ps.id);
        
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        rc.VG_Additional_Information__c='Insurer :'+'TestAcc'+'<br/>'
       +'Insurer Policy Number :'+'123354'+'<br/>'
       +'Insurer Policy Currency :'+'ISD'+'<br/>'
       +'Insurer Policy Limit :'+'158725'+'<br/>'
       +'Insurer Policy Dedctible :'+'450000'+'<br/>'
       +'Insurer Policy Premium :'+'45000'+'<br/>'
       +'Insurer Policy Share :'+'154'+'<br/>';
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        psa.VG_Risk_Premium__c=5000;
        psa.VG_Expected_Premium_Income__c=4500;
        psa.VG_Provisional_Rate__c=4520;
        psa.VG_Expected_Loss_Ratio__c=45;
        psa.VG_No_of_Surplus_Lines__c=40;
        psa.VG_GNPI__c=4200;
        psa.VG_Rate_on_Income__c=4500;
        psa.VG_Provisional_Rate__c=4587;
        psa.VG_Minimum_Premium__c=4780;
        psa.VG_Deposit_Premium__c=4856;
        psa.VG_No_Claims_Bonus__c=4852;
        Update psa;
        
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        Test.startTest();
        VG_ReviseAlphaStepsController alp2=new VG_ReviseAlphaStepsController();
        alp2.gotostep1();
        alp2.RI_Select='Treaty Reinsurance';
        alp2.Structure_Select ='Proportional';
        alp2.Product_Select = 'Surplus';        
        alp2.gotostep2();
        alp2.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2019, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2020, 3, 30);
        update pol;
        
        VG_ReviseAlphaStepsController alp3=new VG_ReviseAlphaStepsController();
        alp3.gotostep1();
        alp3.RI_Select='Treaty Reinsurance';   
        alp3.Product_Select='Excess of Loss Per Risk';
        alp3.gotostep2();
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        pol.VG_Inception_Date__c=Date.newInstance(2019, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2020, 2, 27);
        update pol;
        VG_ReviseAlphaStepsController alp=new VG_ReviseAlphaStepsController();
        alp.gotostep1();
        alp.PolicyDetails='';
        alp.RI_Select='Treaty Reinsurance';
        alp.Structure_Select ='Proportional';
        alp.Product_Select = 'Excess of Loss';         
   		alp.RiskRatingCalc();
        alp.RiskRatingCalc2();
        alp.gotostep2();
        alp.rc.VG_No_of_Reinstatements__c = String.valueOf(2);
        alp.generateReinstatement();
        alp.gotostep3();
        alp.gotostep4();
        Endorsement_Library__c EL3=VG_TU.createEndorsementLibraryCustom('Imara','Sub-limits');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        pse.VG_Premium__c=1500;
        update pse;
        alp.existingEndorsements1.add(pse);
        alp.gotostep5();
        alp.gotostep5b();
        alp.LibraryWrapperList1[0].IsSelected=True;
        alp.existingEndorsements1.add(pse);
        alp.gotostep5b();
        //Step 4 and 4b code
        //Step 5 and 5b code
        Endorsement_Library__c EL4=VG_TU.createEndorsementLibraryCustom('Imara','Endorsements');
        VG_Policy_Schedule_Endorsement__c pse1=VG_TU.createPolicyScheduleEndorsement(ps.id);
        pse1.VG_Premium__c=1500;
        pse1.VG_Type__c = 'Endorsements';
        update pse1;
        alp.existingEndorsements.add(pse1);       
        alp.gotostep6();
        alp.gotostep6b(); 
        alp.LibraryWrapperList[0].IsSelected=True;
        alp.gotostep6b(); 
        alp.AddCustom();
        alp.Finish();          
        alp.cancel();
        alp.setStructureList();
        alp.setSubStructureList();
        alp.RemoveCustom();       
        System.debug('existingEndorsements::'+alp.existingEndorsements.size());
        Test.stopTest();
    }   
    
    public static testMethod void TestMethod4() {
        //Cover Constructor 
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer'); 
        Policy__c pol=VG_TU.createPolicy('Imara',acc.id);
        pol.VG_Inception_Date__c=Date.newInstance(2020, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2021, 2, 27);
        update pol;
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Imara','Sub-limits');
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Imara','Endorsements');
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.VG_MTA_Type__c = null;
        ps.Premium_Adjustment_2__c=45800;
		ps.VG_Brokerage_Amount__c = 4000;
        update ps;
        VG_Policy_Schedule_Endorsement__c pse3=VG_TU.createPolicyScheduleEndorsement(ps.id);
        
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        rc.VG_Additional_Information__c='Insurer :'+'TestAcc'+'<br/>'
       +'Insurer Policy Number :'+'123354'+'<br/>'
       +'Insurer Policy Currency :'+'ISD'+'<br/>'
       +'Insurer Policy Limit :'+'158725'+'<br/>'
       +'Insurer Policy Dedctible :'+'450000'+'<br/>'
       +'Insurer Policy Premium :'+'45000'+'<br/>'
       +'Insurer Policy Share :'+'154'+'<br/>';
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        psa.VG_Risk_Premium__c=5000;
        psa.VG_Expected_Premium_Income__c=4500;
        psa.VG_Provisional_Rate__c=4520;
        psa.VG_Expected_Loss_Ratio__c=45;
        psa.VG_No_of_Surplus_Lines__c=40;
        psa.VG_GNPI__c=4200;
        psa.VG_Rate_on_Income__c=4500;
        psa.VG_Provisional_Rate__c=4587;
        psa.VG_Minimum_Premium__c=4780;
        psa.VG_Deposit_Premium__c=4856;
        psa.VG_No_Claims_Bonus__c=4852;
        psa.VG_Coverage__c = 'Motor;Liability;Agriculture;Health;Travel;PVT;Marine;Property Risk;Agriculture;Energy;Credit;Engineering;Aviation;';
        psa.VG_Perils__c = 'Fire & Allied Perils; Motor Physical Damage;'; 
        Update psa;
        
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        Test.startTest();
        VG_ReviseAlphaStepsController alp2=new VG_ReviseAlphaStepsController();
        alp2.gotostep1();
        alp2.RI_Select='Treaty Reinsurance';
        alp2.Structure_Select ='Proportional';
        alp2.Product_Select = 'Aggregate Stop Loss';
        alp2.gotostep2();
        alp2.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2019, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2020, 3, 30);
        update pol;
        
        VG_ReviseAlphaStepsController alp3=new VG_ReviseAlphaStepsController();
        alp3.gotostep1();
        alp3.RI_Select='Treaty Reinsurance';
        alp3.Structure_Select ='Proportional';
        alp3.Product_Select = 'Quota Share';       
        alp3.gotostep2();
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        pol.VG_Inception_Date__c=Date.newInstance(2019, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2020, 2, 27);
        update pol;
        VG_ReviseAlphaStepsController alp=new VG_ReviseAlphaStepsController();
        alp.gotostep1();
        alp.PolicyDetails='';
        alp.RI_Select ='Facultative Reinsurance';
        alp.Structure_Select = 'Proportional';
        alp.setSubStructureList();
        alp.Product_Select='Excess of Loss';                
   		alp.RiskRatingCalc();
        alp.RiskRatingCalc2();
        alp.gotostep2();
        alp.rc.VG_No_of_Reinstatements__c = String.valueOf(5);
        alp.rc.VG_Rate_Type__c ='Rate On Income';
        alp.generateReinstatement();
        alp.gotostep3();
        alp.rr.VG_Coverage__c = 'Motor;Liability;Agriculture;Health;Travel;PVT;Marine;Property Risk;Agriculture;';                
        alp.rr.VG_Perils__c = 'Fire & Allied Perils; Motor Physical Damage;';        
        alp.gotostep4();
        Endorsement_Library__c EL3=VG_TU.createEndorsementLibraryCustom('Imara','Sub-limits');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        pse.VG_Premium__c=1500;
        update pse;
        alp.existingEndorsements1.add(pse);
        alp.gotostep5();
        alp.gotostep5b();
        alp.LibraryWrapperList1[0].IsSelected=True;
        alp.existingEndorsements1.add(pse);
        alp.gotostep5b();
        //Step 4 and 4b code
        //Step 5 and 5b code
        Endorsement_Library__c EL4=VG_TU.createEndorsementLibraryCustom('Imara','Endorsements');
        VG_Policy_Schedule_Endorsement__c pse1=VG_TU.createPolicyScheduleEndorsement(ps.id);
        pse1.VG_Premium__c=1500;
        pse1.VG_Type__c = 'Endorsements';
        update pse1;
        alp.existingEndorsements.add(pse1);       
        alp.gotostep6();
        alp.gotostep6b(); 
        alp.LibraryWrapperList[0].IsSelected=True;
        alp.gotostep6b(); 
        alp.AddCustom();
        alp.Finish();    
        alp.cancel();
        alp.setStructureList();
        alp.setSubStructureList();
        alp.RemoveCustom();       
        System.debug('existingEndorsements::'+alp.existingEndorsements.size());
        Test.stopTest();
    }   
}