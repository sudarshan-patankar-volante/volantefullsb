@IsTest(SeeAllData=false)
public class VG_Edison_PolicyRenewalController_Test {
    public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Test.startTest();
        Utilities.SkipMethods('Bridge Context');
        Account acc=VG_TU.createAccount('Customer');
        Account ba=VG_TU.createAccount('Broker');
        ba.VG_Volante_Entities__c = 'VIL';
        update ba;
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        pol.VG_Volante_Entities__c = 'VIL';
        pol.Broker_Name__c = ba.id;
        update pol;
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        List<Risk_Capture__c> rcList=new List<Risk_Capture__c>();
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        Risk_Capture__c rc1=VG_TU.createRiskCapture(ps.id);       
        Endorsement_Library__c el1=VG_TU.createEndorsementLibrary();
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        VG_Policy_Schedule_Asset__c psa1=VG_TU.createPolicyScheduleAsset(ps.id);
        Endorsement_Library__c EL3=VG_TU.createEndorsementLibraryCustom('Edison Motor','Sub-limits');
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        VG_Edison_PolicyRenewalController pr=new VG_Edison_PolicyRenewalController();
        pr.gotostep1();
        pr.gotostep2();
        pr.rrWrapList[0].isSelected=true;
        pr.gotostep3();
        pr.pseWrapList[0].IsSelected=True;
        pr.Next();
        pr.Cancel();
        Utilities.clearMethods();
        Test.stopTest();
    }
}