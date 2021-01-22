@IsTest(SeeAllData=False)
public class VG_Governance_Compliance_Controller_Test {
    public static testmethod void testmethod1(){
	    VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Bridge',acc.id);
        VG_Governance_Compliance__c gcc=new VG_Governance_Compliance__c();
        gcc.VG_Question_1__c=True;
        insert gcc;
        pol.VG_Governance_Compliance__c=gcc.id;
        update pol;
        ApexPages.StandardController stdController = new ApexPages.StandardController(pol);
        VG_Governance_Compliance_Controller gc=new VG_Governance_Compliance_Controller(stdController);
    }   
}