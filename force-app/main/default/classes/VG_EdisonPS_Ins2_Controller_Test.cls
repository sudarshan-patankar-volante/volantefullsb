@isTest(SeeAllData = False)
public class VG_EdisonPS_Ins2_Controller_Test {
    public static testmethod void TesMethod1(){
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
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Cancellation');
        VG_EdisonPS_Ins2_Controller eps2=new VG_EdisonPS_Ins2_Controller();
        
    }
    public static testmethod void TesMethod2(){
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
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Declaration');
        VG_EdisonPS_Ins2_Controller eps2=new VG_EdisonPS_Ins2_Controller();
        eps2.previous();
        
    }
    public static testmethod void TesMethod3(){
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
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        VG_EdisonPS_Ins2_Controller eps2=new VG_EdisonPS_Ins2_Controller();
        
    }
    public static testmethod void TesMethod4(){
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
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Extension');
        VG_EdisonPS_Ins2_Controller eps2=new VG_EdisonPS_Ins2_Controller();
        
        eps2.rc=rc;
        eps2.AddRisk();
        eps2.Index='0';
        eps2.RemoveRisk();
        eps2.rc=rc;
        eps2.EditRisk();
        //eps2.previous();
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        VG_Policy_Schedule_Endorsement__c pse=VG_TU.createPolicyScheduleEndorsement(ps.id);
        eps2.Cancel();
    }
    public static testmethod void TesMethod5(){
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
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        VG_EdisonPS_Ins2_Controller eps2=new VG_EdisonPS_Ins2_Controller();
        eps2.previous();
        eps2.rc=rc;
        eps2.AddRisk();
        eps2.Index='0';
        eps2.RemoveRisk();
        eps2.rc=rc;
        eps2.EditRisk();
        eps2.Next();
        eps2.MTAType='Extension';
        eps2.wrcList.clear();
        Risk_Capture__c rc1=new Risk_Capture__c();
        rc1.Name='Test';
        rc1.Drivers_DOB__c=Date.newInstance(1956, 02, 16);
        rc1.Drivers_Claims__c='nil';
        rc1.Drivers_License_Ban_Details__c='Never';
        rc1.Drivers_Name__c='Test Driver';
        rc1.Drivers_Conviction_Points__c='25256';
        rc1.Drivers_Medical_Conditions__c='fit';
        rc1.Drivers_Convictions__c='AC10';
        VG_EdisonPS_Ins2_Controller.WrapperRisk ew=new VG_EdisonPS_Ins2_Controller.WrapperRisk();
        ew.rc=rc1;
        eps2.wrcList.add(ew);
        eps2.Next();
        
        //Cover MTA Type not equal null code on controller
        ApexPages.currentPage().getParameters().put('MTAType', 'Extension');
        ApexPages.currentPage().getParameters().put('OriginalId', ps.id);
        VG_EdisonPS_Ins2_Controller eps3=new VG_EdisonPS_Ins2_Controller();
    }
}