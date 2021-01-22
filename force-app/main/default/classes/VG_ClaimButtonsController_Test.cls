@IsTest(SeeAllData=False)
public class VG_ClaimButtonsController_Test {
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
        claim__c cl=VG_TU.createClaim(acc.id,pol.id);
        VG_ClaimButtonsController.getPolicyId(cl.id);    
    }
}