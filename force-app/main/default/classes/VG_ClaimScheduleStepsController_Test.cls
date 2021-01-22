@IsTest(SeeAllData=False)
public class VG_ClaimScheduleStepsController_Test {
	Public Static TestMethod Void testMethod1(){
        Account acc=VG_TU.createAccount('Customer');
        SystemConstants__c cs = new SystemConstants__c();
        cs.Name='Latest Policy Name';
        cs.DocumentId__c = 'Reset';
        Insert cs;
        Policy_Record_Type__c prt = new Policy_Record_Type__c ();
        prt.Name='Edison Motor';
        prt.Code__c = 'EM';
        Insert prt;
        Policy_LOB__c lob = new Policy_LOB__c();
        lob.Name='Motor';
        lob.Code__c = 'MTR';
        Insert lob;
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        Insert ps;
        Asset__c ass=VG_TU.createAsset(acc.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        claim__c cl=VG_TU.createClaim(acc.id,pol.id);        
        ApexPages.currentPage().getParameters().put('id', cl.Id);
        Apexpages.currentpage().getparameters().put('selectedPS',ps.id);
        Apexpages.currentpage().getparameters().put('PID',pol.id);
        
        VG_ClaimScheduleStepsController css=new VG_ClaimScheduleStepsController();        
        VG_ClaimScheduleStepsController.RiskRatingWrapper csr=new VG_ClaimScheduleStepsController.RiskRatingWrapper();        
        csr.isSelected=True;
        css.RiskRatingWrapperList.add(csr);
        VG_ClaimScheduleStepsController.RCWrapper csrc=new VG_ClaimScheduleStepsController.RCWrapper();        
        csrc.isSelected=True;
        css.rcwList.add(csrc);
        VG_ClaimScheduleStepsController.AssetWrapper csas=new VG_ClaimScheduleStepsController.AssetWrapper();
        csas.isSelected=true;
        css.AWList.add(csas);
        VG_ClaimScheduleStepsController.PSEndorsementWrapper cspse=new VG_ClaimScheduleStepsController.PSEndorsementWrapper();
        cspse.isSelected=True;
        css.PSEWList.add(cspse);
        css.claim=cl;
        css.gotoStep1();        
        css.gotoStep2();
        css.gotoStep2a();
        css.gotoStep3();
        css.gotoStep4();
        css.gotoStep5();        
        css.gotoStep6();
        css.finish();
        css.Cancel();
        css.selectedPS='--select--';
        css.gotoStep2();
   }  
}