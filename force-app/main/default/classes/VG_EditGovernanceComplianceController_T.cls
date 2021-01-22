@IsTest(SeeAllData=False)
public class VG_EditGovernanceComplianceController_T {
    public static testmethod void testmethod1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        VG_Edit_Governance_Compliance_Controller egcc=new VG_Edit_Governance_Compliance_Controller();
        egcc.cancel();
        egcc.gc.VG_Peer_Review_1_Complete__c=true;
        egcc.gc.VG_Peer_Review_2_Complete__c=true;
        egcc.gc.VG_Contract_Certainty__c=true;
        egcc.createGC();
        VG_Governance_Compliance__c gcc=new VG_Governance_Compliance__c();
        gcc.Name='Test';
        Insert gcc;
        Policy__c pol1=pol.Clone(false,true,false,false);
        pol1.VG_Governance_Compliance__c=gcc.id;
        Insert pol1;
        ApexPages.currentPage().getParameters().put('Id', pol1.id);
        VG_Edit_Governance_Compliance_Controller egcc1=new VG_Edit_Governance_Compliance_Controller();
        egcc1.createGC();
        //Below lines cover VG_Governance_Compliance_Controller class
        ApexPages.StandardController stdController = new ApexPages.StandardController(pol1);
        VG_Governance_Compliance_Controller gandcc=new VG_Governance_Compliance_Controller(stdController);
    }
}