@IsTest(seeAllData =False)
public class VG_ShowPolicyAssets_Ext_Test {
    public static testmethod void method1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c();
        ps.Name='Test';
        ps.Policy__c=pol.id;  
        ps.VG_Is_MTA__c=False;
        ps.VG_Status__c='Booked';
        ps.Levies__c=14;
        ps.VG_Fee_Income__c=2000;
        Insert ps;
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        VG_Policy_Schedule_Asset__c psa2=VG_TU.createPolicyScheduleAsset(ps.id);
        apexpages.currentpage().getparameters().put('id',pol.id);
        VG_ShowPolicyAssets_Ext spe=new VG_ShowPolicyAssets_Ext();
    }
}