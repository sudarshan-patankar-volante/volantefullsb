/*

 *Created By : Siddik
 
 *Created On : 10-09-2018
 
 *JIRA.No    : -
 
 *Test Class : PolicyScheduleTriggerFunctionTest
 
*/

trigger PolicyScheduleAssetTrigger on VG_Policy_Schedule_Asset__c (Before Insert, After Insert, Before Update, After Update, Before Delete, After Delete) {
     PolicyScheduleAssetTriggerFunction.Handler(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap, Trigger.IsBefore, Trigger.IsAfter, Trigger.IsInsert, Trigger.IsUpdate, Trigger.IsDelete);
}