@IsTest(seeAllData=false)
public class VG_GentiumStep5_Controller_Test {
	public static testmethod void method1(){       
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');    
        VG_UMR__c u=VG_TU.createUMR(acc.id,'Gentium');
        Utilities.SkipMethods('Bridge Context');
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        pol.VG_Expiry_Date__c=Date.newInstance(2018, 12, 18);
        update pol;
        Test.startTest();
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.VG_Base_Policy__c=true;
        ps.IPT_Percent__c=null;
        ps.Base_Creation_End_Date__c=Date.newInstance(2018, 12, 19);
        ps.Base_Creation_Start_Date__c=Date.newInstance(2017, 12, 19);
        ps.VG_MTA_Cancellation_Date__c=Date.newInstance(2018, 12, 19);
        ps.VG_Pre_MTA_Expiry_Date__c=Date.newInstance(2018, 12, 19);
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 12, 19);
        ps.VG_MTA_End_Date__c=Date.newInstance(2019, 12, 19);
        ps.Name='Testps';
        update ps;
        
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        Risk_Capture__c rc1=VG_TU.createRiskCapture(ps.id);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        VG_Policy_Schedule_Asset__c psa1=VG_TU.createPolicyScheduleAsset(ps.id);
        VG_Policy_Schedule_Endorsement__c pse1=vg_tu.createPolicyScheduleEndorsement(ps.id);
        VG_Policy_Schedule_Endorsement__c pse=new VG_Policy_Schedule_Endorsement__c();
        pse.Name='Test';
        pse.VG_Policy_Schedule__c=ps.id;
        pse.VG_Endorsement_Details__c='Test';
        pse.VG_Premium__c=125695;
        pse.VG_Title__c='Test';
        Insert pse;
        List<VG_Policy_Schedule_Asset__c> psaList=new List<VG_Policy_Schedule_Asset__c>();
        psaList.add(psa);
        List<VG_Policy_Schedule_Endorsement__c> pseList=new List<VG_Policy_Schedule_Endorsement__c>();
        pseList.add(pse);
        Map<Id,Policy_Schedule__c> psMap=new Map<Id,Policy_Schedule__c>();
        psMap.put(ps.id,ps);
        List<Risk_Capture__c> rcList=new List<Risk_Capture__c>();
        rcList.add(rc);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('policyid', pol.Id);
        ApexPages.currentPage().getParameters().put('OriginalId', ps.Id); 
        ApexPages.currentPage().getParameters().put('MTAType', null);
        VG_GentiumStep5_Controller gen=new VG_GentiumStep5_Controller();       
        ApexPages.currentPage().getParameters().put('MTAType', 'Cancellation');
        VG_GentiumStep5_Controller gen5=new VG_GentiumStep5_Controller();
        gen5.pSchedule=ps;
        gen5.psaList=psaList;
        gen5.pseList=pseList;
        gen5.rcList=rcList;
        gen5.psList=psMap;
        gen5.Previous();
        gen5.pSchedule.VG_MTA_Cancellation_Date__c = null;
        gen5.pSchedule.VG_Brokerage_Percent__c=null;
        gen5.pSchedule.Premium_Adjustment__c=null;
        gen5.pSchedule.IPT_Percent__c = null;
        gen5.pSchedule.Levies__c=null;
        gen5.pSchedule.VG_Fee_Income__c=null;
        gen5.technicalPremiumPro=25000;
        gen5.updateCancelExtendCalc();
        gen5.MTAType='Extension';
        gen5.pSchedule.VG_MTA_End_Date__c=Date.newInstance(2018,2,2);
        gen5.pSchedule.VG_MTA_Start_Date__c=Date.newInstance(2017,2,2);
        gen5.updateCancelExtendCalc();
        gen5.pSchedule.VG_MTA_End_Date__c=null;
        gen5.updateCancelExtendCalc();
        Utilities.clearMethods();
        Test.stopTest();
    }
    
    public static testmethod void method2(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Test.startTest();
        Utilities.SkipMethods('Bridge Context');
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.VG_Base_Policy__c=true;
        ps.VG_Declaration_Type_percent__c=25;
        ps.Base_Creation_End_Date__c=Date.newInstance(2018,12,12);
        ps.Base_Creation_Start_Date__c=Date.newInstance(2017,12,12);
        update ps;
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        psa.VG_Premium__c=12555;
        update psa;
        VG_Policy_Schedule_Endorsement__c pse=new VG_Policy_Schedule_Endorsement__c();
        pse.Name='Test';
        pse.VG_Policy_Schedule__c=ps.id;
        pse.VG_Endorsement_Details__c='Test';
        pse.VG_Premium__c=125695;
        pse.VG_Title__c='Test';
        Insert pse;
        List<VG_Policy_Schedule_Asset__c> psaList=new List<VG_Policy_Schedule_Asset__c>();
        psaList.add(psa);
        Map<Id,Policy_Schedule__c> psMap=new Map<Id,Policy_Schedule__c>();
        psMap.put(ps.id,ps);
        List<VG_Policy_Schedule_Endorsement__c> pseList=new List<VG_Policy_Schedule_Endorsement__c>();
        pseList.add(pse);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        List<Risk_Capture__c> rcList=new List<Risk_Capture__c>();
        rcList.add(rc);
        
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('policyid', pol.Id);
        ApexPages.currentPage().getParameters().put('OriginalId', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Declaration');
        VG_GentiumStep5_Controller gen5=new VG_GentiumStep5_Controller();
        gen5.psaList=psaList;
        gen5.pseList=pseList;
        gen5.rcList=rcList;
        gen5.psList=psMap;
        gen5.Previous();
        gen5.psaList=psaList;
        gen5.rcList=rcList;
        gen5.psList=psMap;
        gen5.pseList=pseList;
        gen5.Finish();
        gen5.psaList=psaList;
        gen5.pseList=pseList;
        gen5.psList=psMap;
        gen5.rcList=rcList;
        gen5.Finish();
        gen5.psaList=psaList;
        gen5.pseList=pseList;
        gen5.psList=psMap;
        gen5.rcList=rcList;
        gen5.Cancel();
        gen5.psaList=psaList;
        gen5.rcList=rcList;
        gen5.psList=psMap;
        gen5.pseList=pseList;
        gen5.pSchedule.VG_Brokerage_Percent__c=null;
        gen5.pSchedule.Premium_Adjustment__c=null;
        gen5.pSchedule.IPT_Percent__c = null;
        gen5.pSchedule.Levies__c=null;
        gen5.pSchedule.VG_Fee_Income__c=null;
        gen5.technicalPremiumPro=25000;
        gen5.updateCalc();
        gen5.pSchedule.VG_Fee_Income__c=null;
        gen5.pSchedule.Levies__c=2000;
        gen5.updateCalc();
        gen5.pSchedule.VG_Fee_Income__c=2000;
        gen5.pSchedule.Levies__c=null;
        gen5.updateCalc();
        Utilities.clearMethods();
        Test.stopTest();
    }
   
    public static testmethod void method8(){
        //Main focus to Cover all codes for updateCancelExtendCalc()
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');    
        VG_UMR__c u=VG_TU.createUMR(acc.id,'Gentium');
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        pol.VG_Expiry_Date__c=Date.newInstance(2018, 12, 18);
        update pol;
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.VG_Base_Policy__c=true;
        ps.IPT_Percent__c=null;
        ps.Base_Creation_End_Date__c=Date.newInstance(2018, 12, 19);
        ps.Base_Creation_Start_Date__c=Date.newInstance(2017, 12, 19);
        ps.VG_MTA_Cancellation_Date__c=Date.newInstance(2018, 12, 19);
        ps.VG_Pre_MTA_Expiry_Date__c=Date.newInstance(2018, 12, 19);
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 12, 19);
        ps.VG_MTA_End_Date__c=Date.newInstance(2019, 12, 19);
        ps.Name='Testps';
        update ps;
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('policyid', pol.Id);
        ApexPages.currentPage().getParameters().put('OriginalId', ps.Id); 
        ApexPages.currentPage().getParameters().put('MTAType', 'Cancellation');
        VG_GentiumStep5_Controller gen5=new VG_GentiumStep5_Controller();
        gen5.updateCancelExtendCalc();
        gen5.pSchedule.VG_MTA_Cancellation_Date__c=date.newInstance(2018,12,01);
        gen5.updateCancelExtendCalc();
        
    }
    public static testmethod void method3(){
        VG_TU.policyCustomSetting();
        Utilities.SkipMethods('Bridge Context');
        Account acc=VG_TU.createAccount('Customer');    
        VG_UMR__c u=VG_TU.createUMR(acc.id,'Gentium');
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.VG_Base_Policy__c=true;
        ps.IPT_Percent__c=null;
        ps.Base_Creation_End_Date__c=Date.newInstance(2018, 12, 19);
        ps.Base_Creation_Start_Date__c=Date.newInstance(2017, 12, 19);
        ps.VG_MTA_Cancellation_Date__c=Date.newInstance(2018, 12, 19);
        ps.VG_Pre_MTA_Expiry_Date__c=Date.newInstance(2018, 12, 19);
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 12, 19);
        ps.VG_MTA_End_Date__c=Date.newInstance(2019, 12, 19);
        ps.Name='Testps';
        update ps;
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        psa.VG_Premium__c=12555;
        update psa;
		
        VG_Policy_Schedule_Endorsement__c pse=new VG_Policy_Schedule_Endorsement__c();
        pse.Name='Test';
        pse.VG_Policy_Schedule__c=ps.id;
        pse.VG_Endorsement_Details__c='Test';
        pse.VG_Premium__c=125695;
        pse.VG_Title__c='Test';
        Insert pse;
		
        List<VG_Policy_Schedule_Asset__c> psaList=new List<VG_Policy_Schedule_Asset__c>();
        psaList.add(psa);
		
        Map<Id,Policy_Schedule__c> psMap=new Map<Id,Policy_Schedule__c>();
        psMap.put(ps.id,ps);
        List<VG_Policy_Schedule_Endorsement__c> pseList=new List<VG_Policy_Schedule_Endorsement__c>();
        pseList.add(pse);
		
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        List<Risk_Capture__c> rcList=new List<Risk_Capture__c>();
        rcList.add(rc);
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('policyid', pol.Id);
        ApexPages.currentPage().getParameters().put('OriginalId', ps.Id); 
        ApexPages.currentPage().getParameters().put('MTAType', 'Cancellation');
        test.startTest();
        VG_GentiumStep5_Controller gen5=new VG_GentiumStep5_Controller();
        gen5.psaList=psaList;
        gen5.pseList=pseList;
        gen5.rcList=rcList;
        gen5.psList=psMap;
        gen5.Previous();
        gen5.Finish();
        gen5.psaList=psaList;
        gen5.pseList=pseList;
        gen5.psList=psMap;
        gen5.rcList=rcList;
        gen5.pSchedule.VG_MTA_Cancellation_Date__c=date.newInstance(2018,12,01); 
        gen5.IsCancellation = True;
        gen5.MTAType='Cancellation';
        gen5.Finish();
        Utilities.clearMethods();
        test.stopTest();
    }
    
   
}