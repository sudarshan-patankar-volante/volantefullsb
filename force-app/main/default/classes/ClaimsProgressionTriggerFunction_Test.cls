@IsTest(SeeAllData=False)
public class ClaimsProgressionTriggerFunction_Test {
    Public Static TestMethod Void testMethod1(){
        Account acc=VG_TU.createAccount('Customer');
        VG_TU.policyCustomSetting(); 
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        Insert ps;
        claim__c c=new Claim__c();
        c.Name='test';
        c.Account__c=acc.id;
        c.Policy_Number__c=pol.id;
        Insert c;  
        Test.startTest();
        VG_UMR__c u=VG_TU.createUMR(acc.id);      
        System.debug('paper::'+u.VG_Capacity_Paper__c);
        claim__c cl=VG_TU.createClaim(acc.id,pol.id);
        Claims_Schedule__c cs1=VG_TU.createClaimSchedule(acc.id,ps.id,cl.id);
        Claims_Progression__c cp=new Claims_Progression__c();
        cp.RecordTypeId=Schema.SObjectType.Claims_Progression__c.getRecordTypeInfosByName().get('Claim Financial').getRecordTypeId();        
        cp.Name='Test';
        cp.VG_Claims_Schedule__c=cs1.id;
        Insert cp;        
        Claims_Progression__c cp1=VG_TU.createClaimProgression('Claim Recovery',cs1.id);        
        Claims_Progression__c cp2=VG_TU.createClaimProgression('Claim Financial',cs1.id);        
   	    Test.stopTest();
    }
}