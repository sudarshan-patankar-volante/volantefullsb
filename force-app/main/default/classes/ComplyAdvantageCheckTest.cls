@IsTest(SeeAllData=False)
public class ComplyAdvantageCheckTest {
	Public Static TestMethod Void testMethod1(){
        Test.startTest();
        Account a = VG_TU.createAccount('Customer');
        Test.setMock(HttpCalloutMock.class, new ComplyAdvantageCheckMock()); 
        ComplyAdvantageCheck.check(new Set<ID>{a.id});
        Test.stopTest();
    }
}