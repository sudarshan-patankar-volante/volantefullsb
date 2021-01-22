@isTest(seeAllData=false)
public class VG_GentiumSteps3_Controller_Test {
	public static testmethod void TesMethod1(){
        VG_TU.policyCustomSetting();      
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Cancellation');
        VG_GentiumSteps3_Controller gen=new VG_GentiumSteps3_Controller();
    }
    public static testmethod void TesMethod2(){
        VG_TU.policyCustomSetting();      
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Declaration');
        VG_GentiumSteps3_Controller gen=new VG_GentiumSteps3_Controller();
        gen.Next();
    }
    public static testmethod void TesMethod3(){
        VG_TU.policyCustomSetting();      
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', null);
        VG_GentiumSteps3_Controller gen=new VG_GentiumSteps3_Controller();
        gen.Next();
        gen.previous();
    }
    public static testmethod void TesMethod4(){
        VG_TU.policyCustomSetting();      
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        VG_GentiumSteps3_Controller gen=new VG_GentiumSteps3_Controller();
        gen.Next();
        gen.rc=rc;
        gen.AddRisk();
        gen.Index='0';
        gen.RemoveRisk();
        gen.rc=rc;
        gen.EditRisk();
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        gen.Cancel();
    }
    public static testmethod void TesMethod5(){
        VG_TU.policyCustomSetting();      
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Extension');
        VG_GentiumSteps3_Controller gen=new VG_GentiumSteps3_Controller();
        gen.previous();
        gen.rc=rc;
        gen.AddRisk();
        gen.Index='0';
        gen.RemoveRisk();
        gen.rc=rc;
        gen.EditRisk();
        gen.Next();
        gen.MTAType='Extension';
        gen.wrcList.clear();
        Risk_Capture__c rc1=VG_TU.createRiskCapture(ps.id);        
        VG_GentiumSteps3_Controller.WrapperRisk gw=new VG_GentiumSteps3_Controller.WrapperRisk();
        gw.rc=rc1;
        gen.wrcList.add(gw);
        gen.Next();
    }
}