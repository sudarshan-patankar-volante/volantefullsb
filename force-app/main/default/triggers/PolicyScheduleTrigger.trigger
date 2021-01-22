/*

 *Created By : Siddik
 
 *Created On : 24-11-2017
 
 *JIRA.No    : VG-11
 
 *Test Class : PolicyScheduleTriggerFunctionTest
 
*/

trigger PolicyScheduleTrigger on Policy_Schedule__c (Before Insert, After Insert, Before Update, After Update, Before Delete, After Delete) {
     PolicyScheduleTriggerFunction.Handler(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap, Trigger.IsBefore, Trigger.IsAfter, Trigger.IsInsert, Trigger.IsUpdate, Trigger.IsDelete);
}