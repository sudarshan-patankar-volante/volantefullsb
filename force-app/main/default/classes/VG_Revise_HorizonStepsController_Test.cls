@IsTest(SeeAllData=False)
public class VG_Revise_HorizonStepsController_Test {
    public static testMethod void TestMethod1() {
        //Cover Constructor 
        Test.StartTest();
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Horizon',acc.id);
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Horizon','Sub-limits');
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Horizon','Endorsements');
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Premium_Adjustment_2__c=2000;
        ps.Rate_On_Line__c=20.3;
        ps.Gross_Written_Premium__c=145200;
        ps.Risk_Premium_Pro__c=5000;
        ps.Share__c=25;
        ps.VG_Overider_Percent__c=15;
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 12, 15);
        ps.VG_Brokerage_Amount__c = 4000;
        update ps;
        Risk_Capture__c rc=vg_tu.createRiskCapture(ps.id);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        psa.VG_Minimum_Premium__c=5008;
        psa.VG_Deposit_Premium__c=4560;
        psa.VG_Risk_Premium__c=5000;
        update psa;
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        VG_Policy_Schedule_Endorsement__c pse1=VG_TU.createPolicyScheduleEndorsement(ps.id);
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.ValueOf(Date.newInstance(2017, 12, 18)));
        Test.stopTest();
        VG_Revise_HorizonStepsController hsc=new VG_Revise_HorizonStepsController();
        hsc.WrittenShare=11.5;
        hsc.SignedShare=10.5;
        hsc.GrossWrittenPremium=200000;
        hsc.TechnicalPremium=20000;
        hsc.Brokerage=15.0;
        hsc.Overider=12.3;
        hsc.FeeIncome=50000;
        hsc.PremiumAdjustment=5000;
        hsc.PSRiskPremium=5000;
        hsc.EndorsementPremium=5000;
        hsc.RateOnLine=12.3;
        hsc.Product='Property Per Event';
        hsc.Levies=2000;
        //cover cancel method
        hsc.Cancel();
        //cover step1
        hsc.gotostep1();
        hsc.Product='Property Per Event';
        //cover step2
        hsc.gotostep2();
        hsc.rc.VG_No_of_Reinstatements__c=String.valueOf(2);
        hsc.rc.VG_Plan_Loss_Ratio__c=12.3;
        hsc.rc.VG_Layer__c='1st Layer';
        hsc.rc.VG_Territorial_Scope__c='Asia';
        hsc.rc.VG_Rate_Type__c='Flat Premium';
        hsc.generateReinstatement();
        //cover step3
        hsc.gotostep3();
        hsc.Product='AGG Stop Loss';
        hsc.gotostep3();
        hsc.Product='Property Per Event';
        hsc.gotostep3();
        //cover Step 4a and 4b code 
        Endorsement_Library__c EL3=VG_TU.createEndorsementLibraryCustom('Horizon','Sub-limits');
        hsc.existingEndorsements.add(pse);
        hsc.gotostep4a();
        hsc.gotostep4b();
        hsc.LibraryWrapperList[0].IsSelected=True;
        hsc.gotostep4b();
        hsc.existingEndorsements.add(pse);
        hsc.gotostep4b();
        hsc.AddCustom();
        //cover Step 6a and 6b code
        hsc.existingEndorsements1.add(pse);
        hsc.gotostep6a();
        hsc.gotostep6b();
        hsc.LibraryWrapperList1[0].IsSelected=True;
        hsc.gotostep6b();
        hsc.existingEndorsements1.add(pse);
        hsc.gotostep6b();
        //cover step5
        hsc.gotostep5();
        //cover finish
        hsc.existingEndorsements1.clear();
        hsc.existingEndorsements.clear();
        hsc.existingEndorsements1.add(pse.clone(false,true,false,false));
        hsc.existingEndorsements.add(pse.clone(false,true,false,false));
        hsc.Finish();
        //cover generateReinstatement
        hsc.generateReinstatement();
        //cover cals
        hsc.Calc();
        //cover updatePremiums
        hsc.updatePremiums();
        //cover RiskRatingCalc
        hsc.RiskRatingCalc();
    }
    public static testMethod void TestMethod2() {
        Test.startTest();
        //Cover Constructor 
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Horizon',acc.id);
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Horizon','Sub-limits');
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Horizon','Endorsements');
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Premium_Adjustment_2__c=2000;
        ps.Rate_On_Line__c=20.3;
        ps.Gross_Written_Premium__c=145200;
        ps.Share__c=25;
        ps.VG_Overider_Percent__c=15;
        update ps;
        Risk_Capture__c rc=vg_tu.createRiskCapture(ps.id);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        psa.VG_Limit_Precent__c=50;
        psa.VG_GNPI__c=5400;
        psa.VG_Risk_Premium__c=4000;
        update psa;
        Test.stopTest();
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        VG_Policy_Schedule_Endorsement__c pse1=VG_TU.createPolicyScheduleEndorsement(ps.id);
        ApexPages.currentPage().getParameters().put('Id', ps.id);
        ApexPages.currentPage().getParameters().put('MTAType', '');
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.ValueOf(Date.newInstance(2017, 12, 18)));
        VG_Revise_HorizonStepsController hsc=new VG_Revise_HorizonStepsController();
        hsc.WrittenShare=11.5;
        hsc.SignedShare=10.5;
        hsc.GrossWrittenPremium=200000;
        hsc.TechnicalPremium=20000;
        hsc.Brokerage=15.0;
        hsc.Overider=12.3;
        hsc.FeeIncome=50000;
        hsc.PremiumAdjustment=5000;
        hsc.PSRiskPremium=5000;
        hsc.EndorsementPremium=5000;
        hsc.TotalLayerPremium=15000;
        hsc.RateOnLine=12.3;
        hsc.Product='AGG Stop Loss';
        hsc.Levies=2000;
        //cover cancel method
        hsc.Cancel();
        //cover step1
        hsc.gotostep1();
        hsc.Product='AGG Stop Loss';
        //cover step2
        hsc.gotostep2();
        hsc.rc.VG_No_of_Reinstatements__c=String.valueOf(2);
        hsc.rc.VG_Plan_Loss_Ratio__c=12.3;
        hsc.rc.VG_Layer__c='1st Layer';
        hsc.rc.VG_Territorial_Scope__c='Asia';
        hsc.rc.VG_Rate_Type__c='Flat Premium';
        //cover step3
        hsc.gotostep3();
        hsc.Product='AGG Stop Loss';
        hsc.gotostep3();
        hsc.Product='Property Per Event';
        hsc.gotostep3();
        //cover Step 4a and 4b code 
        Endorsement_Library__c EL3=VG_TU.createEndorsementLibraryCustom('Horizon','Sub-limits');
        hsc.existingEndorsements.add(pse);
        hsc.gotostep4a();
        hsc.gotostep4b();
        hsc.LibraryWrapperList[0].IsSelected=True;
        hsc.gotostep4b();
        hsc.existingEndorsements.add(pse);
        hsc.gotostep4b();
        hsc.AddCustom();
        //cover Step 6a and 6b code
        hsc.existingEndorsements1.add(pse);
        hsc.gotostep6a();
        hsc.gotostep6b();
        hsc.LibraryWrapperList1[0].IsSelected=True;
        hsc.gotostep6b();
        hsc.existingEndorsements1.add(pse);
        hsc.gotostep6b();
        //cover step5
        hsc.gotostep5();
        hsc.RemoveCustom();
        //cover finish
        hsc.existingEndorsements1.clear();
        hsc.existingEndorsements.clear();
        hsc.existingEndorsements1.add(pse.clone(false,true,false,false));
        hsc.existingEndorsements.add(pse.clone(false,true,false,false));
        hsc.Finish();
        //cover generateReinstatement
        hsc.generateReinstatement();
        //cover cals
        hsc.Calc();
        //cover updatePremiums
        hsc.updatePremiums();
        //cover RiskRatingCalc
        hsc.RiskRatingCalc();
    }
}