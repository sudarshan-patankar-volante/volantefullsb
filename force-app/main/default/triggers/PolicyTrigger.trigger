/*

 *Created By : Siddik
 
 *Created On : 24-11-2017
 
 *JIRA.No    : VG-10
 
 *Test Class : PolicyTriggerFunctionTest
 
*/

trigger PolicyTrigger on Policy__c (Before Insert, After Insert, Before Update, After Update, Before Delete, After Delete) {
     PolicyTriggerFunction.Handler(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap, Trigger.IsBefore, Trigger.IsAfter, Trigger.IsInsert, Trigger.IsUpdate, Trigger.IsDelete);
}