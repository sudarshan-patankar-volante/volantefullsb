/*

 *Created By : Siddik
 
 *Created On : 16-11-2017
 
 *JIRA.No    : VG-5
 
 *Test Class : AccountTriggerFunctionTest
 
*/

trigger AccountTrigger on Account (Before Insert, After Insert, Before Update, After Update, Before Delete, After Delete) {
     AccountTriggerFunction.Handler(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap, Trigger.IsBefore, Trigger.IsAfter, Trigger.IsInsert, Trigger.IsUpdate, Trigger.IsDelete);
}