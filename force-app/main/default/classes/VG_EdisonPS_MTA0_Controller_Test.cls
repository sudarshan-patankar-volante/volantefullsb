@IsTest(SeeAllData=False)
public class VG_EdisonPS_MTA0_Controller_Test {
    public static testmethod void method1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ApexPages.currentPage().getParameters().put('PSID', ps.id);
        ApexPages.currentPage().getParameters().put('PId', pol.id);
        VG_EdisonPS_MTA0_Controller emc=new VG_EdisonPS_MTA0_Controller();
        emc.Cancel();
        emc.Next();
        emc.seletedType='--Select--';
        emc.Next();
        emc.psListDup=new List<Policy_Schedule__c>();
        emc.psaListDup=new List<VG_Policy_Schedule_Asset__c>();
        emc.pseListDup=new List<VG_Policy_Schedule_Endorsement__c>();
        emc.rcListDup=new List<Risk_Capture__c>();
        emc.RIListDup=new List<VG_ReInsurance__c>();
        emc.psList=new Map<Id, Policy_Schedule__c>();
        emc.psaList=new List<VG_Policy_Schedule_Asset__c> ();
        emc.pseList =new List<VG_Policy_Schedule_Endorsement__c> ();
        emc.RIList =new List<VG_ReInsurance__c> ();
        emc.rcList =new List<Risk_Capture__c> ();
        emc.oldPSIdDupPSRecMap =new Map<Id, Policy_Schedule__c> ();
        emc.oldPSIdDupPSAMap =new Map<Id, List<VG_Policy_Schedule_Asset__c>> ();
        emc.oldPSIdDupPSEMap=new Map<Id, List<VG_Policy_Schedule_Endorsement__c>> ();
        emc.oldPSIdDupRIMap =new Map<Id, List<VG_ReInsurance__c>> ();
        emc.oldPSIdDupRCMap =new Map<Id, List<Risk_Capture__c>> ();
        emc.PID=null;
        emc.cancel();
    }
}