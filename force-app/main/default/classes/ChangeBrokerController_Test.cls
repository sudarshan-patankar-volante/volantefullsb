@IsTest(SeeAllData=False)
public class ChangeBrokerController_Test {
	public Static Testmethod Void method1(){
        VG_TU.policyCustomSetting();
        Account acc2=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc2.id);
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        ChangeBrokerController cbc = new ChangeBrokerController();
        cbc.save();
		cbc.cancel();        
    }
    public Static Testmethod Void method2(){
        VG_TU.policyCustomSetting();
        Account acc2=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Affinity',acc2.id);
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        Account ba=VG_TU.createChangeBrokerAccount('Broker');  
        Contact c = VG_TU.createContact(ba);
        System.debug('ba::'+ba);
        pol.Broker_Name__c = ba.id;
        pol.Broker_Contact__c= c.Id;
        update pol;
        ChangeBrokerController cbc = new ChangeBrokerController();
        cbc.policy=pol;
        cbc.PolicyId = pol.Id;
        cbc.save();
    	
    } 
}