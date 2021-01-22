@IsTest(SeeAllData=False)
public class VG_Revise_FIDOProductSteps_Test {
    public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('VFP',acc.id);
        pol.VG_Inception_Date__c=Date.newInstance(2018, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2019, 3, 2);
        update pol;
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.VG_Side_B_Retention_Currency__c='GBP';
        ps.VG_Side_C_Retention_Currency__c='SEK';
        update ps;
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('VFP','Sub-limits');
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('VFP','Endorsements');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        VG_Policy_Schedule_Endorsement__c pse1=VG_TU.createPolicyScheduleEndorsement(ps.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        Test.startTest();
        Utilities.SkipMethods('Bridge Context');
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.ValueOf(Date.newInstance(2017, 12, 18)));
        VG_Revise_FIDOProductSteps fido1=new VG_Revise_FIDOProductSteps();
        fido1.gotostep1();
        fido1.LProduct='D7-EPL excl USA';
        fido1.Product='Commercial Crime';
        fido1.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2019, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2020, 2, 27);
        update pol;
        VG_Revise_FIDOProductSteps fido2=new VG_Revise_FIDOProductSteps();
        fido2.gotostep1();
        fido2.LProduct='D7-EPL excl USA';
        fido2.Product='Commercial Crime';
        fido2.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2020, 3, 30);
        pol.VG_Expiry_Date__c=Date.newInstance(2021, 3, 30);
        update pol;
        VG_Revise_FIDOProductSteps fido3=new VG_Revise_FIDOProductSteps();
        fido3.gotostep1();
        fido3.LProduct='D7-EPL excl USA';
        fido3.Product='Commercial Crime';
        fido3.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2020, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2021, 2, 27);
        update pol;
        VG_Revise_FIDOProductSteps fido4=new VG_Revise_FIDOProductSteps();
        fido4.gotostep1();
        fido4.LProduct='D7-EPL excl USA';
        fido4.Product='Commercial Crime';
        fido4.cancel();
        VG_Revise_FIDOProductSteps fido=new VG_Revise_FIDOProductSteps();        
        fido.LProduct='D7-EPL excl USA';
        fido.Product='Commercial Crime';
        fido.netModelPremium=20000;
        fido.RiskPremium=10000;
        fido.lmt=2000;
        fido.attachment=2000;
        fido.writtenShare =12.3;
        fido.sharePercent=12.3;
        fido.actualPremium=15000;
        fido.brokerage=12.3;
        fido.brokerageAmount=2000;
        fido.grossWrittenPremium =20000;
        fido.adjustmentTechPremium=12000;
        fido.adjustment=2000;
        fido.IPTAmount=2000;
        fido.IPTPercent=22;
        fido.feeIncome=2000;
        fido.levies=2000;
        fido.sumInsured=400000;
        fido.vat=12.3;
        fido.vatamount=5000;
        fido.taxamount=500;
        fido.uwPremium=5000;
        fido.techModelPremium=5000;
        fido.GrossOrNet ='NET';
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
        fido.Product='D&O';
        fido.setLPList();
        fido.Product='PI';
        fido.setLPList();
        fido.Product='Commercial Crime';
        fido.setLPList();
        fido.LProduct='D7-EPL excl USA';
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
        fido.rc.VG_No_of_Reinstatements__c=String.valueOf(2);
        fido.rc.VG_Retention_Amount__c=4500;
        fido.rc.VG_Enterprise_Value__c=5000;
        fido.rc.VG_De_Minimis_Amount__c=4560;
        fido.generateReinstatement();
        fido.RCCalc();
        fido.gotostep3();
        //Step 2 Code
        //Step 3 Code
        fido.addRR();
        fido.Index='1';
        //Step 3 Code
        //Step 4 and 4b code
        Endorsement_Library__c EL3=VG_TU.createEndorsementLibraryCustom('VFP','Sub-limits');
        fido.existingEndorsements1.add(pse);
        fido.gotostep4();
        fido.gotostep4b();
        //fido.LibraryWrapperList1[0].IsSelected=True;
        fido.existingEndorsements1.add(pse);
        fido.gotostep4b();
        //Step 4 and 4b code
        //Step 5 and 5b code
        fido.existingEndorsements.add(pse);
        Endorsement_Library__c EL4=VG_TU.createEndorsementLibraryCustom('VFP','Endorsements');
        fido.gotostep5();
        fido.gotostep5b(); 
        fido.LibraryWrapperList[0].IsSelected=True;
        fido.gotostep5b(); 
        fido.AddCustom();
        //Step 5 and 5b code
        //Step 6 Code
        fido.gotostep6();
        fido.Product='PI';
        fido.gotostep6();
        fido.Product='Commercial Crime';
        fido.existingEndorsements.add(pse);
        fido.existingEndorsements1.add(pse1);
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
        pol.VG_Inception_Date__c=Date.newInstance(2018, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2019, 3, 2);
        utilities.SkipMethods('Trigger Context2'); 
        update pol;
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.VG_Side_B_Retention_Currency__c='GBP';
        ps.VG_Side_C_Retention_Currency__c='SEK';
        ps.VG_MTA_Type__c = null;
        ps.Split_Type__c = 'EEA';
        update ps;
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('VFP','Sub-limits');
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('VFP','Endorsements');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        VG_Policy_Schedule_Endorsement__c pse1=VG_TU.createPolicyScheduleEndorsement(ps.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        Test.startTest();
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        //ApexPages.currentPage().getParameters().put('MTAType', '');
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.ValueOf(Date.newInstance(2017, 12, 18)));
        VG_Revise_FIDOProductSteps fido1=new VG_Revise_FIDOProductSteps();
        fido1.gotostep1();
        fido1.LProduct='D7-EPL excl USA';
        fido1.Product='Commercial Crime';
        fido1.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2019, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2020, 2, 27);
        update pol;
        VG_Revise_FIDOProductSteps fido2=new VG_Revise_FIDOProductSteps();
        fido2.gotostep1();
        fido2.LProduct='D7-EPL excl USA';
        fido2.Product='Commercial Crime';
        fido2.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2020, 3, 30);
        pol.VG_Expiry_Date__c=Date.newInstance(2021, 3, 30);
        update pol;
        VG_Revise_FIDOProductSteps fido3=new VG_Revise_FIDOProductSteps();
        fido3.gotostep1();
        fido3.LProduct='D7-EPL excl USA';
        fido3.Product='Commercial Crime';
        fido3.cancel();
        pol.VG_Inception_Date__c=Date.newInstance(2020, 2, 28);
        pol.VG_Expiry_Date__c=Date.newInstance(2021, 2, 27);
        update pol;
        VG_Revise_FIDOProductSteps fido4=new VG_Revise_FIDOProductSteps();
        fido4.gotostep1();
        fido4.LProduct='D7-EPL excl USA';
        fido4.Product='Commercial Crime';
        fido4.cancel();
        VG_Revise_FIDOProductSteps fido=new VG_Revise_FIDOProductSteps();        
        fido.LProduct='D7-EPL excl USA';
        fido.Product='Commercial Crime';
        fido.netModelPremium=20000;
        fido.RiskPremium=10000;
        fido.lmt=2000;
        fido.attachment=2000;
        fido.writtenShare =12.3;
        fido.sharePercent=12.3;
        fido.actualPremium=15000;
        fido.brokerage=12.3;
        fido.brokerageAmount=2000;
        fido.grossWrittenPremium =20000;
        fido.adjustmentTechPremium=12000;
        fido.adjustment=2000;
        fido.IPTAmount=2000;
        fido.IPTPercent=22;
        fido.feeIncome=2000;
        fido.levies=2000;
        fido.sumInsured=400000;
        fido.vat=12.3;
        fido.vatamount=5000;
        fido.taxamount=500;
        fido.uwPremium=5000;
        fido.techModelPremium=5000;
        fido.GrossOrNet ='NET';
        fido.Product='FI - D&O';
        fido.setLPList();
        fido.gotostep1();
        fido.gotostep2();
        fido.gotostep3();
        //Step 2 Code
        //Step 3 Code
        fido.addRR();
        fido.Index='1';
        //Step 3 Code
        //Step 4 and 4b code
        Endorsement_Library__c EL3=VG_TU.createEndorsementLibraryCustom('VFP','Sub-limits');
        fido.existingEndorsements1.add(pse);
        fido.gotostep4();
        fido.gotostep4b();
        //fido.LibraryWrapperList1[0].IsSelected=True;
        fido.existingEndorsements1.add(pse);
        fido.gotostep4b();
        //Step 4 and 4b code
        //Step 5 and 5b code
        fido.existingEndorsements.add(pse);
        Endorsement_Library__c EL4=VG_TU.createEndorsementLibraryCustom('VFP','Endorsements');
        fido.gotostep5();
        fido.gotostep5b(); 
        fido.LibraryWrapperList[0].IsSelected=True;
        fido.gotostep5b(); 
        fido.AddCustom();
        fido.RemoveCustom();
        //Step 5 and 5b code
        //Step 6 Code
        fido.gotostep6();
        fido.gotostep6();
        fido.existingEndorsements.add(pse);
        fido.existingEndorsements1.add(pse1);
        fido.cancel();
        fido.GrossOrNet='Gross';
        fido.layer='Primary';
        fido.UpdateFinalCalculations();
        fido.Index='0';
        fido.RemoveRR();
        utilities.clearMethods();
        //Step 6 Code
    }
    
    public static testMethod void TestMethod3() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Test.startTest();
        Utilities.SkipMethods('Bridge Context');
        Policy__c pol=VG_TU.createPolicy('VFP',acc.id);
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Product__c='Combined Cyber/ Tech E&O';
        ps.VG_Side_B_Retention_Currency__c='GBP';
        ps.VG_Side_C_Retention_Currency__c='SEK';
        ps.Split_Type__c = 'Both';
        ps.VG_Entity_Share__c=50;
        ps.Premium_Adjustment_2__c=500;
        update ps;
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('VFP','Endorsements');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        psa.VG_Information__c='Standard Covers:'
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
        update psa;
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.ValueOf(Date.newInstance(2017, 12, 18)));       
        VG_Revise_FIDOProductSteps fido=new VG_Revise_FIDOProductSteps();
        fido.Product='W&I';
        fido.sideBAmount=10;
        fido.netModelPremium=20000;
        fido.RiskPremium=10000;
        fido.lmt=2000;
        fido.attachment=2000;
        fido.writtenShare =12.3;
        fido.sharePercent=12.3;
        fido.actualPremium=15000;
        fido.brokerage=12.3;
        fido.brokerageAmount=2000;
        fido.grossWrittenPremium =20000;
        fido.adjustmentTechPremium=12000;
        fido.adjustment=2000;
        fido.IPTAmount=2000;
        fido.IPTPercent=22;
        fido.feeIncome=2000;
        fido.levies=2000;
        fido.sumInsured=400000;
        fido.vat=12.3;
        fido.vatamount=5000;
        fido.taxamount=500;
        fido.uwPremium=5000;
        fido.techModelPremium=5000;
        fido.GrossOrNet ='NET';
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
        fido.EEAPS = ps;
        fido.EEAPS.VG_Entity_Share__c = 50;
        fido.EEAPS.Premium_Adjustment_2__c = 1000;
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
        fido.rc.VG_No_of_Reinstatements__c= String.valueOf(2);
        fido.generateReinstatement();
        fido.gotostep3();
        //Step 2 Code
        //Step 3 Code
        fido.addRR();
        fido.Index='1';
        //fido.RemoveRR();
        //fido.RRCalc();
        fido.gotostep4();
        fido.gotostep4b();
        fido.gotostep5();
        fido.gotostep5b();
        fido.gotostep6();
        fido.ps.Split_Type__c = 'Both';
        fido.seletedProrateoption='Prorated';
        fido.finish();
        fido.cancel();
        fido.GrossOrNet='Gross';
        fido.layer='Primary';
        fido.UpdateFinalCalculations();
        fido.Index='0';
        fido.total();
        Utilities.clearMethods();
        Test.stopTest();
        //Step 6 Code
    }

    
    public static testMethod void TestMethod4() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Test.startTest();
        Utilities.SkipMethods('Bridge Context');
        Policy__c pol=VG_TU.createPolicy('VFP',acc.id);
        pol.CurrencyIsoCode='USD';
        update pol;
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Product__c='Combined Cyber/ Tech E&O';
        ps.VG_Side_B_Retention_Currency__c='GBP';
        ps.VG_Side_C_Retention_Currency__c='SEK';
		ps.Premium_Adjustment_2__c=500;
        ps.Split_Type__c = 'Non EEA';
        update ps;
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('VFP','Endorsements');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        ApexPages.currentPage().getParameters().put('MTAType', '');
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.ValueOf(Date.newInstance(2017, 12, 18)));       
        VG_Revise_FIDOProductSteps fido=new VG_Revise_FIDOProductSteps();
        fido.sideBAmount=10;
        fido.netModelPremium=20000;
        fido.RiskPremium=10000;
        fido.lmt=2000;
        fido.attachment=2000;
        fido.writtenShare =12.3;
        fido.sharePercent=12.3;
        fido.actualPremium=15000;
        fido.brokerage=12.3;
        fido.brokerageAmount=2000;
        fido.grossWrittenPremium =20000;
        fido.adjustmentTechPremium=12000;
        fido.adjustment=2000;
        fido.IPTAmount=2000;
        fido.IPTPercent=22;
        fido.feeIncome=2000;
        fido.levies=2000;
        fido.sumInsured=400000;
        fido.vat=12.3;
        fido.vatamount=5000;
        fido.taxamount=500;
        fido.uwPremium=5000;
        fido.techModelPremium=5000;
        fido.GrossOrNet ='NET';
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
        fido.EEAPS = ps;
        fido.EEAPS.VG_Entity_Share__c = 50;
        fido.EEAPS.Premium_Adjustment_2__c = 1000;
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
        fido.rc.VG_No_of_Reinstatements__c= '2';
        fido.generateReinstatement();
        fido.gotostep3();
        //Step 2 Code
        //Step 3 Code
        fido.addRR();
        fido.Index='1';
        //fido.RemoveRR();
        //fido.RRCalc();
        fido.gotostep4();
        fido.gotostep4b();
        fido.gotostep5();
        fido.gotostep5b();
        fido.gotostep6();
        //fido.ps.Split_Type__c = 'Both';
        fido.ps.VG_Entity_Split_Required__c=False;
        fido.finish();        
        Utilities.clearMethods();
        Test.stopTest();
        //Step 6 Code
    }
    
    public static testMethod void TestMethod5() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Test.startTest();
        Utilities.SkipMethods('Bridge Context');
        Policy__c pol=VG_TU.createPolicy('VFP',acc.id);
        pol.CurrencyIsoCode='USD';
        update pol;
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Product__c='Combined Cyber/ Tech E&O';
        ps.VG_Side_B_Retention_Currency__c='GBP';
        ps.VG_Side_C_Retention_Currency__c='SEK';
		ps.Premium_Adjustment_2__c=500;
        update ps;
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('VFP','Endorsements');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.ValueOf(Date.newInstance(2017, 12, 18)));       
        VG_Revise_FIDOProductSteps fido=new VG_Revise_FIDOProductSteps();
        fido.sideBAmount=10;
        fido.netModelPremium=20000;
        fido.RiskPremium=10000;
        fido.lmt=2000;
        fido.attachment=2000;
        fido.writtenShare =12.3;
        fido.sharePercent=12.3;
        fido.actualPremium=15000;
        fido.brokerage=12.3;
        fido.brokerageAmount=2000;
        fido.grossWrittenPremium =20000;
        fido.adjustmentTechPremium=12000;
        fido.adjustment=2000;
        fido.IPTAmount=2000;
        fido.IPTPercent=22;
        fido.feeIncome=2000;
        fido.levies=2000;
        fido.sumInsured=400000;
        fido.vat=12.3;
        fido.vatamount=5000;
        fido.taxamount=500;
        fido.uwPremium=5000;
        fido.techModelPremium=5000;
        fido.GrossOrNet ='NET';
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
        fido.EEAPS = ps;
        fido.EEAPS.VG_Entity_Share__c = 50;
        fido.EEAPS.Premium_Adjustment_2__c = 1000;
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
        fido.rc.VG_No_of_Reinstatements__c= '2';
        fido.generateReinstatement();
        fido.gotostep3();
        //Step 2 Code
        //Step 3 Code
        fido.addRR();
        fido.Index='1';
        //fido.RemoveRR();
        //fido.RRCalc();
        fido.gotostep4();
        fido.gotostep4b();
        fido.gotostep5();
        fido.gotostep5b();
        fido.gotostep6();
        //fido.ps.Split_Type__c = 'Both';
        fido.ps.VG_Entity_Split_Required__c=False;
        fido.finish();        
        Utilities.clearMethods();
        Test.stopTest();
        //Step 6 Code
    }
}