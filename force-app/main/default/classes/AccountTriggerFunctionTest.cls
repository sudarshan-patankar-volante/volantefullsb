/*

 *Created By : Siddik
 
 *Created On : 16-11-2017
 
 *JIRA.No    : VG-5
 
*/

@IsTest(SeeAllData=False)
Public Class AccountTriggerFunctionTest{
     Public Static TestMethod Void testMethod1(){
        Account a=VG_TU.createAccount('Customer');
     }
}