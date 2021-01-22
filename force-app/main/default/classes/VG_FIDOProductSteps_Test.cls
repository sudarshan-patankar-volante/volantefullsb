@IsTest(SeeAllData=False)
public class VG_FIDOProductSteps_Test {
    public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('VFP',acc.id);
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        Endorsement_Library__c EL=VG_TU.createEndorsementLibrary();
        EL.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
        update EL;
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        ApexPages.currentPage().getParameters().put('Currency', 'USD');
        //Constructor Code 
        VG_FIDOProductSteps fido=new VG_FIDOProductSteps();
        fido.Product='FI - D&O';
        fido.setLPList();
        fido.Product='FI - PI';
        fido.setLPList();
        fido.Product='FI - Crime';
        fido.setLPList();
        fido.Product='FI - Fiduciary';
        fido.setLPList();
        fido.Product='FI - Cyber';
        fido.setLPList();
        fido.Product='FI - Blend';
        fido.setLPList();
        fido.Product='PI';
        fido.setLPList();
        fido.Product='Commercial Crime';
        fido.setLPList();
        fido.LProduct='D7-EPL excl USA';
        fido.Product='D&O';
        fido.setLPList();
        fido.gotostep2();
        //Constructor Code
        //Step 2 Code
        fido.gotostep1();
        fido.sideBRentention=4500;
        fido.sideBCurrencyConvertion();
        fido.sideCCurrencyConvertion();
        fido.rc.VG_Company_Type__c='Public';
        fido.rc.VG_Company_Domicile__c='UK';
        fido.rc.VG_Industry__c='Energy';
        fido.rc.VG_Total_Assets__c=500000;
        fido.rc.VG_Revenue__c   =50000;
        fido.rc.VG_Market_Cap__c=50000;
        fido.rc.VG_Net_Profit__c=50000;
        fido.rc.VG_Net_Equity__c=50000;
        fido.rc.VG_Headcount__c=2;
        fido.rc.VG_Class_1_Employees__c=2;
        fido.rc.VG_No_of_Reinstatements__c = String.valueOf(5);
        fido.rc.VG_Reinstatement_Premiums__c = '1st Reinstatement:10<br>2nd Reinstatement:20<br>3rd Reinstatement:30<br>4th Reinstatement:40';
        fido.generateReinstatement();
        fido.gotostep3();
        //Step 2 Code
        //Step 3 Code
        fido.riskRatingList[0].psa.VG_Coverage__c='BB-Crime';
        fido.riskRatingList[0].psa.VG_Territorial_Limits__c='Nordic';
        fido.riskRatingList[0].psa.VG_Share__c=25.6;
        fido.riskRatingList[0].psa.VG_Deductible__c=5000;
        fido.riskRatingList[0].psa.VG_Sub_limit__c=2000;
        fido.riskRatingList[0].psa.VG_Premium__c=1500;
        fido.riskRatingList[0].psa.VG_Fee_Amounts__c=1500;
        fido.addRR();
        fido.Index='1';
        fido.RemoveRR();
        fido.RRCalc();
        //Step 3 Code
        //Step 4 and 4b code
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('VFP','Sub-limits');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        fido.existingEndorsements1.add(pse);
        fido.gotostep4();
        fido.gotostep4b();
        //fido.LibraryWrapperList1[0].IsSelected=True;
        fido.existingEndorsements1.add(pse);
        fido.gotostep4b();
        //Step 4 and 4b code
        //Step 5 and 5b code
        fido.existingEndorsements.add(pse);
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('VFP','Endorsements');
        fido.gotostep5();
        fido.gotostep5b(); 
        fido.LibraryWrapperList[0].IsSelected=True;
        fido.gotostep5b(); 
        fido.AddCustom();
        //Step 5 and 5b code
        //Step 6 Code
        fido.gotostep6();
        fido.Product='PI';
        fido.ps.Split_Type__c = 'Both';
        fido.gotostep6();
        fido.cancel();
        fido.GrossOrNet='Gross';
        fido.layer='Primary';
        fido.UpdateFinalCalculations();
        fido.Index='0';
        fido.RemoveRR();
        //Step 6 Code
    }
    public static testMethod void TestMethod2() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('VFP',acc.id);
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Product__c='PI';
        ps.Split_Type__c = 'Both';
        ps.VG_Entity_Split_Required__c=True;
        update ps;
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);   
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('VFP','Sub-limits');
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('VFP','Endorsements');
        
        VG_Policy_Schedule_Endorsement__c pse3=VG_TU.createPolicyScheduleEndorsement(ps.id);
        VG_Policy_Schedule_Endorsement__c pse4=VG_TU.createPolicyScheduleEndorsement(ps.id);
        pse4.VG_Type__c = 'Sub-limits';
        update pse4;
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        ApexPages.currentPage().getParameters().put('Currency', 'GBP');
        //Constructor Code 
        VG_FIDOProductSteps fido=new VG_FIDOProductSteps();
        fido.CapacityPaper = '--None--';
        fido.Product = 'PI';
        fido.LProduct = 'F4-Tech & Telco E&O incl USA';
        fido.gotostep2();
        //Constructor Code
        //Step 2 Code
        fido.gotostep1();
        fido.sideBRentention=4500;
        fido.sideBRententionCurrency='AED';
        fido.sideBCurrencyConvertion();
        fido.sideCCurrencyConvertion();
        
        fido.rc.VG_Company_Type__c='Public';
        fido.rc.VG_Company_Domicile__c='UK';
        fido.rc.VG_Industry__c='Energy';
        fido.rc.VG_Total_Assets__c=500000;
        fido.rc.VG_Revenue__c   =50000;
        fido.rc.VG_Market_Cap__c=50000;
        fido.rc.VG_Net_Profit__c=50000;
        fido.rc.VG_Net_Equity__c=50000;
        fido.rc.VG_Headcount__c=2;
        fido.rc.VG_Enterprise_Value__c = 4500;
        fido.rc.VG_De_Minimis_Amount__c =4870;
        fido.rc.VG_Retention_Amount__c=8700;
        fido.rc.VG_Class_1_Employees__c=2;
        fido.rc.VG_No_of_Reinstatements__c = String.valueOf(2);
        fido.generateReinstatement();
        fido.RCCalc();
        fido.Product = 'PI';
        fido.gotostep2();
        fido.gotostep3();
        //Step 2 Code
        //Step 3 Code
        fido.riskRatingList[0].CoverageSelected ='F4-Tech & Telco E&O incl USA';
        fido.riskRatingList[0].psa.VG_Coverage__c='F4-Tech & Telco E&O incl USA';
        fido.riskRatingList[0].psa.VG_Territorial_Limits__c='Nordic';
        fido.riskRatingList[0].psa.VG_Share__c=25.6;
        fido.riskRatingList[0].psa.VG_Deductible__c=5000;
        fido.riskRatingList[0].psa.VG_Sub_limit__c=2000;
        fido.riskRatingList[0].psa.VG_Premium__c=1500;
        fido.riskRatingList[0].psa.VG_Fee_Amounts__c=1500;
        VG_FIDOProductSteps.RRWrapper RRW =new VG_FIDOProductSteps.RRWrapper();
        RRW.psa=rr;
        RRW.CoverageSelected='Property Damage';
        fido.riskRatingList.add(RRW);       
        fido.addRR();
        fido.Index='1';
        fido.RemoveRR();
        fido.RRCalc();
        VG_Policy_Schedule_Endorsement__c pse1=VG_TU.createPolicyScheduleEndorsement(ps.id);
        pse1.VG_Premium__c=1500;
        update pse1;
        Endorsement_Library__c EL3=VG_TU.createEndorsementLibraryCustom('VFP','Sub-limits');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        pse.VG_Premium__c=1500;
        pse.VG_Type__c = 'Sub-limits';
        update pse; 
        fido.gotostep4();
        fido.gotostep4b();
        fido.gotostep5();
        fido.gotostep5b();
        fido.gotostep6();
        fido.gotostep4();
        fido.gotostep4b();
        fido.LibraryWrapperList1[0].IsSelected=True;
        fido.existingEndorsements1.add(pse);
        fido.gotostep4b();
        
        fido.gotostep5();
        fido.gotostep5b();
        fido.LibraryWrapperList[0].IsSelected=True;
        fido.existingEndorsements.add(pse1);
        fido.gotostep5b();
        fido.ps.Split_Type__c = 'Both';
        fido.finish();
        fido.cancel();
        fido.GrossOrNet='Gross';
        fido.layer='Primary';
        fido.UpdateFinalCalculations();
        fido.Index='0';
        fido.RemoveRR();
        //Step 6 Code
    }
    
    public static testMethod void TestMethod3() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('VFP',acc.id);
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Split_Type__c = 'Both';
        ps.VG_Entity_Split_Required__c=True;
        update ps;
        Endorsement_Library__c EL=VG_TU.createEndorsementLibrary();
        EL.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
        update EL;
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        //Constructor Code 
        VG_FIDOProductSteps fido=new VG_FIDOProductSteps();
        fido.Product='W&I';
        fido.setLPList();          
        fido.Product='Cyber';
        fido.setLPList();         
        fido.Product='Combined Cyber/ Tech E&O';
        fido.setLPList();
        
        fido.LProduct='F4-Tech & Telco E&O incl USA';
        fido.gotostep2();
        //Constructor Code
        //Step 2 Code
        fido.gotostep1();
        fido.rc.VG_Company_Type__c='Public';
        fido.rc.VG_Company_Domicile__c='UK';
        fido.rc.VG_Industry__c='Energy';
        fido.rc.VG_Total_Assets__c=500000;
        fido.rc.VG_Revenue__c   =50000;
        fido.rc.VG_Market_Cap__c=50000;
        fido.rc.VG_Net_Profit__c=50000;
        fido.rc.VG_Net_Equity__c=50000;
        fido.rc.VG_Headcount__c=2;
        fido.rc.VG_Class_1_Employees__c=2;
        fido.rc.VG_No_of_Reinstatements__c = String.valueOf(2);
        fido.generateReinstatement();
        fido.gotostep3();
        //Step 2 Code
        //Step 3 Code
        fido.riskRatingList[0].psa.VG_Coverage__c='F4-Tech & Telco E&O incl USA';
        fido.riskRatingList[0].psa.VG_Territorial_Limits__c='Nordic';
        fido.riskRatingList[0].psa.VG_Share__c=25.6;
        fido.riskRatingList[0].psa.VG_Deductible__c=5000;
        fido.riskRatingList[0].psa.VG_Sub_limit__c=2000;
        fido.riskRatingList[0].psa.VG_Premium__c=1500;
        fido.riskRatingList[0].psa.VG_Fee_Amounts__c=1500;
        fido.riskRatingList[0].psa.VG_Information__c=+'<br/>'+'Standard Covers:'
+'<br/>'+'CY-Crisis Management Costs:'
+'<br/>'+'Sum Insured : 4'
+'<br/>'+'Deductible : 5'
+'<br/>'+'Annual Premium : 6'
+'<br/>'+'CY-Privacy / System Wrongful Act Liability:'
+'<br/>'+'Sum Insured : 7'
+'<br/>'+'Deductible : 8'
+'<br/>'+'Annual Premium : 30'
+'<br/>'+'CY-Regulatory Actions from Privacy / Security Breach:'
+'<br/>'+'Sum Insured : 10'
+'<br/>'+'Deductible : 11'
+'<br/>'+'Annual Premium : 12'
+'<br/>'+'CY-Digital Asset Restoration:'
+'<br/>'+'Sum Insured : 13'
+'<br/>'+'Deductible : 14'
+'<br/>'+'Annual Premium : 15'
+'<br/>'+'CY-Business Interruption (Waiting Period):'
+'<br/>'+'Sum Insured : 16'
+'<br/>'+'Deductible : 17'
+'<br/>'+'Annual Premium : null'
+'<br/>'+'CY-Regulatory Compliance Liability:'
+'<br/>'+'Sum Insured : 19'
+'<br/>'+'Deductible : 20'
+'<br/>'+'Annual Premium : 21'
+'<br/>'+'CY-PCI Fines and Penalties: '
+'<br/>'+'Sum Insured : 22'
+'<br/>'+'Deductible : 23'
+'<br/>'+'Annual Premium : 24'
+'<br/>'+'CY-CYber Extortion/Ransom: '
+'<br/>'+'Sum Insured : 25'
+'<br/>'+'Deductible : 26'
+'<br/>'+'Annual Premium : 27'
+'<br/>'+'CY-First Party Computer Replacement:'
+'<br/>'+'Sum Insured : 28'
+'<br/>'+'Deductible : 29'
+'<br/>'+'Annual Premium : null'
+'<br/>'+'CY-First Party Theft of your IP Rights / Trade Secrets:'
+'<br/>'+'Sum Insured : 31'
+'<br/>'+'Deductible : 32'
+'<br/>'+'Annual Premium : 33'
+'<br/>'+'CY-Multimedia Liability:'
+'<br/>'+'Sum Insured : 34'
+'<br/>'+'Deductible : 35'
+'<br/>'+'Annual Premium : 36'
+'<br/>'+'GBMS Specific Additional Covers:'
+'<br/>'+'CY-Liability for Bodily Injury:' 
+'<br/>'+'Sum Insured : 37'
+'<br/>'+'Deductible : 38'
+'<br/>'+'Annual Premium : 39'
+'<br/>'+'CZ-Liability for Property Damage: '
+'<br/>'+'Sum Insured : 40'
+'<br/>'+'Deductible : 41'
+'<br/>'+'Annual Premium : 42'
+'<br/>'+'CZ-Liability for Pollution Damage:' 
+'<br/>'+'Sum Insured : 43'
+'<br/>'+'Deductible : 44'
+'<br/>'+'Annual Premium : 45'
+'<br/>'+'CY-Liability for Theft of Third-Party Funds:'
+'<br/>'+'Sum Insured : 46'
+'<br/>'+'Deductible : 47'
+'<br/>'+'Annual Premium : 48'
+'<br/>'+'CY-Liability for Theft of Third-Party IP Rights / Trade Secrets:'
+'<br/>'+'Sum Insured : 49'
+'<br/>'+'Deductible : 50'
+'<br/>'+'Annual Premium : 51'
+'<br/>'+'CZ-First Party Property Damage:'
+'<br/>'+'Sum Insured : 52'
+'<br/>'+'Deductible : 53'
+'<br/>'+'Annual Premium : 54'
+'<br/>'+'CZ-Burglary / Theft of Property / Vandalism: '
+'<br/>'+'Sum Insured : 55'
+'<br/>'+'Deductible : 56'
+'<br/>'+'Annual Premium : 57'
+'<br/>'+'CY-Squatter Eviction Expenses:'
+'<br/>'+'Sum Insured : 58'
+'<br/>'+'Deductible : 59'
+'<br/>'+'Annual Premium : 60'
+'<br/>'+'CY-Pollution clean-up costs:'
+'<br/>'+'Sum Insured : 61'
+'<br/>'+'Deductible : 62'
+'<br/>'+'Annual Premium : 63'
+'<br/>'+'CY-First party Theft of Funds:' 
+'<br/>'+'Sum Insured : 64'
+'<br/>'+'Deductible : 65'
+'<br/>'+'Annual Premium : 66'
+'<br/>'+'CY-Business Services / Utilities Fraud:'
+'<br/>'+'Sum Insured : 67'
+'<br/>'+'Deductible : 68'
+'<br/>'+'Annual Premium : 69'
+'<br/>'+'Technology Errors and Omissions Liability: '
+'<br/>'+':F4-Tech & Telco E&O incl USA'
+'<br/>'+'Sum Insured : 1'
+'<br/>'+'Deductible : 2'
+'<br/>'+'Annual Premium : 3';
        fido.addRR();
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);   
        VG_FIDOProductSteps.RRWrapper RRW =new VG_FIDOProductSteps.RRWrapper();
        RRW.psa=rr;
        RRW.CoverageSelected='Property Damage';
        fido.riskRatingList.add(RRW);       
        fido.Index='1';
        fido.RemoveRR();
        fido.RRCalc();
        fido.gotostep4();
        fido.gotostep4b();
        fido.gotostep5();
        fido.gotostep5b(); 
        fido.gotostep6();
        fido.finish();
        fido.cancel();
        fido.GrossOrNet='Gross';
        fido.layer='Primary';
        fido.UpdateFinalCalculations();
        fido.Index='0';
        fido.RemoveRR();
        //Step 6 Code
    }
}