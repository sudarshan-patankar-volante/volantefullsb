@isTest(seeAllData=false)
public class VG_GentiumStep2a_Controller_Test {
    public static testmethod void TesMethod1(){  
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');  
        Test.startTest();
        Utilities.SkipMethods('Bridge Context');
        Policy__c pol=VG_TU.createPolicy('Gentium',acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.VG_Declaration_Type__c = '1st Quarter';
        update ps;
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id); 
        VG_UMR__c umr=VG_TU.createUMR(acc.id,'Gentium');
        VG_ReInsurance__c ri=VG_TU.createReInsurance(ps.id, umr.id);
        ApexPages.currentPage().getParameters().put('id', pol.Id);
        ApexPages.currentPage().getParameters().put('MTAType', null);
        List<Policy_Schedule__c> lstps =new List<Policy_Schedule__c>();
        lstps.add(ps);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        Policy_Schedule__c ps1=VG_TU.createPolicySchedule(pol.id);
        ps1.VG_Declaration_Type__c = '2nd Quarter';
        update ps1;
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(lstps);
        ApexPages.currentPage().getParameters().put('PSID',ps.id);
        VG_GentiumStep2a_Controller gc21=new VG_GentiumStep2a_Controller(stdSetController);
        ApexPages.currentPage().getParameters().put('MTAType', 'Cancellation');
        ApexPages.currentPage().getParameters().put('PSID', null);
        ApexPages.currentPage().getParameters().put('OriginalId', ps.Id);
        VG_GentiumStep2a_Controller gc22=new VG_GentiumStep2a_Controller(stdSetController);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        VG_GentiumStep2a_Controller gc23=new VG_GentiumStep2a_Controller(stdSetController);
        ApexPages.currentPage().getParameters().put('MTAType', 'Declaration');
        VG_GentiumStep2a_Controller gc24=new VG_GentiumStep2a_Controller(stdSetController);
        ApexPages.currentPage().getParameters().put('MTAType', 'Extension');
        ApexPages.currentPage().getParameters().put('PSID',ps.id);
        VG_GentiumStep2a_Controller gc25=new VG_GentiumStep2a_Controller(stdSetController);
        gc25.Previous();
        gc25.ps.Product__c='Public Sector';             
        gc25.Next();
        gc25.updateDeclarationRate();
        gc25.Index='0';
        gc25.RemoveAsset();
        gc25.addAsset();
        Utilities.clearMethods();
        Test.stopTest();
        gc25.Cancel();
        
    }
    public static testmethod void TesMethod2(){  
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer'); 
        Test.startTest();
        Utilities.SkipMethods('Bridge Context');
        Policy__c pol=VG_TU.createPolicy('Gentium',acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ps.VG_Declaration_Type__c = '2nd Quarter';
        update ps;
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id); 
        VG_UMR__c umr=VG_TU.createUMR(acc.id,'Gentium');
        VG_ReInsurance__c ri=VG_TU.createReInsurance(ps.id, umr.id);
        ApexPages.currentPage().getParameters().put('id', pol.Id);
        ApexPages.currentPage().getParameters().put('MTAType', null);
        List<Policy_Schedule__c> lstps =new List<Policy_Schedule__c>();
        lstps.add(ps);
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        Policy_Schedule__c ps1=VG_TU.createPolicySchedule(pol.id);
        ps1.VG_Declaration_Type__c = '2nd Quarter';
        update ps1;
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(lstps);
        ApexPages.currentPage().getParameters().put('PSID',ps.id);
        VG_GentiumStep2a_Controller gc21=new VG_GentiumStep2a_Controller(stdSetController);
        ApexPages.currentPage().getParameters().put('MTAType', 'Cancellation');
        ApexPages.currentPage().getParameters().put('PSID', null);
        ApexPages.currentPage().getParameters().put('OriginalId', ps.Id);
        VG_GentiumStep2a_Controller gc22=new VG_GentiumStep2a_Controller(stdSetController);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        VG_GentiumStep2a_Controller gc23=new VG_GentiumStep2a_Controller(stdSetController);
        ApexPages.currentPage().getParameters().put('MTAType', 'Declaration');
        VG_GentiumStep2a_Controller gc24=new VG_GentiumStep2a_Controller(stdSetController);
        ApexPages.currentPage().getParameters().put('MTAType', 'Extension');
        ApexPages.currentPage().getParameters().put('PSID',ps.id);
        VG_GentiumStep2a_Controller gc25=new VG_GentiumStep2a_Controller(stdSetController);
        gc25.Previous();
        gc25.ps.Product__c='Public Sector';             
        gc25.Next();
        gc25.updateDeclarationRate();
        gc25.Index='0';
        gc25.RemoveAsset();
        gc25.addAsset();
        gc25.Cancel();
        Utilities.clearMethods();
        Test.stopTest();
    }
    public static testmethod void TesMethod3(){  
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');      
        Policy__c pol=VG_TU.createPolicy('Gentium',acc.id);
        ApexPages.currentPage().getParameters().put('id', pol.Id);
        ApexPages.currentPage().getParameters().put('MTAType', null);
        List<Policy__c> lstps =new List<Policy__c>();
        lstps.add(pol);
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(lstps);
        ApexPages.currentPage().getParameters().put('PSID',null);
        VG_GentiumStep2a_Controller gc25=new VG_GentiumStep2a_Controller(stdSetController);
        gc25.Previous();
        gc25.ps.Product__c='Public Sector';             
        gc25.Next();
        gc25.updateDeclarationRate();
        gc25.Index='0';
        gc25.RemoveAsset();
        gc25.addAsset();
        gc25.Cancel();
        
    }
    public static testmethod void TesMethod4(){ 
        VG_Tu.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Gentium',acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test/PS/0');
        ps.Policy__c=pol.id;
        ps.Product__c='Fleet';
        ps.VG_MTA_Type__c='Revision of Cover';
        List<Policy_Schedule__c> psList=new List<Policy_Schedule__c>();
        psList.add(ps);
        Insert psList;
        List<VG_Policy_Schedule_Asset__c> psaList=new List<VG_Policy_Schedule_Asset__c>();
        VG_Policy_Schedule_Asset__c psa=new VG_Policy_Schedule_Asset__c();
        psa.name='Test1';
        psa.RecordTypeId=Schema.SObjectType.VG_Policy_Schedule_Asset__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();
        psa.VG_Policy_Schedule__c=ps.id;
        psa.VG_Rate_Per_Vehicle__c=20;
        psa.VG_Number_of_Vehicles__c=10;
        psa.VG_Coverage__c='M3 - Fully Comprehensive';
        psa.VG_Vehicle_Type__c='Cars';
        psa.VG_Use__c='Public Hire';
        psa.VG_Technical_UW_Rate_Annual__c=10000;
        psaList.add(psa);
        VG_UMR__c umr=VG_TU.createUMR(acc.id,'Gentium');
        ApexPages.currentPage().getParameters().put('PSID', ps.id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        List<Policy__c> lstps =new List<Policy__c>();
        lstps.add(pol);
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(lstps);
        VG_GentiumStep2a_Controller gc26=new VG_GentiumStep2a_Controller(stdSetController);
        gc26.pseList=new List<VG_Policy_Schedule_Endorsement__c>();
        gc26.pseListDup=new List<VG_Policy_Schedule_Endorsement__c>();
        VG_GentiumStep2a_Controller.WrapperAsset wa = new VG_GentiumStep2a_Controller.WrapperAsset();
        wa.Counter='0';
        wa.psa=psa;
        wa.techPremium=2000;
        gc26.Index='0';
        gc26.Next();
        gc26.PSId=null;
        gc26.Next();
        gc26.MTAType='Revision of Cover';
        gc26.PSId=null;
        gc26.Next();
        gc26.MTAType='Declaration';
        gc26.PSId=null;
        gc26.Next();
        gc26.MTAType='Revision of Cover';
        gc26.PSId=null;
        gc26.ps.VG_MTA_Start_Date__c=null;
        gc26.Next();
        gc26.MTAType='Revision of Cover';
        gc26.PSId=null;
        gc26.ps.VG_MTA_Start_Date__c=date.newInstance(2018,06,02);
        gc26.ps.VG_MTA_End_Date__c=date.newInstance(2018,05,31);
        gc26.Next();
        gc26.MTAType=null;
        gc26.PSId=null;
        gc26.ps.Product__c = null;
        gc26.Next();
        gc26.MTAType='Revision of Cover';
        gc26.ps.Product__c = 'Fleet';
        gc26.Next();
        gc26.PSId=ps.Id;
        gc26.psaList = psaList;
        VG_ReInsurance__c ri=new VG_ReInsurance__c();
        ri.Name='Test/PS/0';
        ri.VG_Brokerage_Amount__c=25256;
        ri.VG_MGA_Commission_Override__c='';
        ri.VG_UMR__c=umr.id;
        gc26.RIListDup.add(ri);
        gc26.Previous();
        gc26.Cancel();
        gc26.addAsset();
        
    }
    public static testmethod void TesMethod5(){ 
        VG_Tu.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Gentium',acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test/PS/0');
        ps.Policy__c=pol.id;
        ps.Product__c='Fleet';
        ps.VG_MTA_Type__c='Declaration';
        List<Policy_Schedule__c> psList=new List<Policy_Schedule__c>();
        psList.add(ps);
        Insert psList;
        List<VG_Policy_Schedule_Asset__c> psaList=new List<VG_Policy_Schedule_Asset__c>();
        VG_Policy_Schedule_Asset__c psa=new VG_Policy_Schedule_Asset__c();
        psa.name='Test1';
        psa.RecordTypeId=Schema.SObjectType.VG_Policy_Schedule_Asset__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();
        psa.VG_Policy_Schedule__c=ps.id;
        psa.VG_Rate_Per_Vehicle__c=20;
        psa.VG_Number_of_Vehicles__c=10;
        psa.VG_Coverage__c='M3 - Fully Comprehensive';
        psa.VG_Vehicle_Type__c='Cars';
        psa.VG_Use__c='Public Hire';
        psa.VG_Technical_UW_Rate_Annual__c=10000;
        psaList.add(psa);
        VG_UMR__c umr=VG_TU.createUMR(acc.id,'Gentium');
        ApexPages.currentPage().getParameters().put('PSID', ps.id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Declaration');
        List<Policy__c> lstps =new List<Policy__c>();
        lstps.add(pol);
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(lstps);
        VG_GentiumStep2a_Controller gc26=new VG_GentiumStep2a_Controller(stdSetController);
        gc26.pseList=new List<VG_Policy_Schedule_Endorsement__c>();
        gc26.pseListDup=new List<VG_Policy_Schedule_Endorsement__c>();
        VG_GentiumStep2a_Controller.WrapperAsset wa = new VG_GentiumStep2a_Controller.WrapperAsset();
        wa.Counter='0';
        wa.psa=psa;
        wa.techPremium=2000;
        gc26.Index='0';
        gc26.Next();
        gc26.PSId=null;
        gc26.Next();
        gc26.MTAType='Declaration';
        gc26.PSId=null;
        gc26.Next();
        gc26.MTAType='Declaration';
        gc26.PSId=null;
        gc26.ps.VG_MTA_Start_Date__c=null;
        gc26.Next();
        gc26.MTAType='Declaration';
        gc26.PSId=null;
        gc26.ps.VG_MTA_Start_Date__c=date.newInstance(2018,06,02);
        gc26.ps.VG_MTA_End_Date__c=date.newInstance(2018,05,31);
        gc26.Next();
        gc26.MTAType=null;
        gc26.PSId=null;
        gc26.ps.Product__c = null;
        gc26.Next();
        gc26.MTAType='Declaration';
        gc26.ps.Product__c = 'Fleet';
        gc26.Next();
        gc26.PSId=ps.Id;
        gc26.psaList = psaList;
        VG_ReInsurance__c ri=new VG_ReInsurance__c();
        ri.Name='Test/PS/0';
        ri.VG_Brokerage_Amount__c=25256;
        ri.VG_MGA_Commission_Override__c='';
        ri.VG_UMR__c=umr.id;
        gc26.RIListDup.add(ri);
        gc26.Previous();
        gc26.Cancel();
        gc26.addAsset();
    }
}