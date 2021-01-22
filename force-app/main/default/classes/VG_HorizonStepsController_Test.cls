@IsTest(SeeAllData=False)
public class VG_HorizonStepsController_Test {
    public static testMethod void TestMethod1() {
        //Cover Constructor 
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Horizon',acc.id);
        Endorsement_Library__c EL1=VG_TU.createEndorsementLibraryCustom('Horizon','Sub-limits');
        Endorsement_Library__c EL2=VG_TU.createEndorsementLibraryCustom('Horizon','Endorsements');
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        VG_Policy_Schedule_Endorsement__c pse1=VG_TU.createPolicyScheduleEndorsement(ps.id);
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        VG_HorizonStepsController hsc=new VG_HorizonStepsController();
        //cover cancel method
        hsc.Cancel();
        //cover step1
        hsc.gotostep1();
        hsc.Product='Property Per Event';
        //cover step2
        hsc.gotostep2();
        hsc.rc.VG_No_of_Reinstatements__c = String.valueOf(2);
        hsc.rc.VG_Plan_Loss_Ratio__c=12.3;
        hsc.rc.VG_Layer__c='1st Layer';
        hsc.rc.VG_Territorial_Scope__c='Asia';
        hsc.rc.VG_Rate_Type__c='Flat Premium';
        hsc.NOIList.add(5);
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
}