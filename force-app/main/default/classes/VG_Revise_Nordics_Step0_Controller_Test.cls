@IsTest(SeeAllData=False)
public class VG_Revise_Nordics_Step0_Controller_Test {
    public static testmethod void method1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Bridge',acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        ApexPages.currentPage().getParameters().put('PId', pol.id);
        VG_Revise_Nordics_Step0_Controller emc=new VG_Revise_Nordics_Step0_Controller();
        emc.Cancel();
        emc.Next();
        emc.seletedType='--Select--';
        emc.Next();
        emc.PID=null;
        emc.cancel();
    }
}