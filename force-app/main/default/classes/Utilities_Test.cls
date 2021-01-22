@IsTest(SeeAllData = False)
public class Utilities_Test {
    public static testMethod void TestMethod1(){
        Utilities.avoidRecursionCheck('Test');
        Utilities.avoidRecursionCheck('Test');
        
    }   
}