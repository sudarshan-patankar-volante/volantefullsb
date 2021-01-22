/*@Created By: Anusuya
*
*@Created On: 16-Nov-2017
*
*@JIRA Number: VG-6
*/

@IsTest(SeeAllData=False)
Public Class ContactTriggerFunction_Test{
    Public Static TestMethod Void InitialTestMethod(){
        Account acc = VG_TU.createAccount('Customer');
        Contact con =VG_TU.createContact(acc);
    }
}