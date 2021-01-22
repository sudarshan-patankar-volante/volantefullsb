/*

 *Created By : Venkat
 
 *Created On : 19-12-2017
 
 *JIRA.No    : 
 
 *Test Class : 
*/

trigger ReInsuranceTrigger on VG_ReInsurance__c (Before Insert, After Insert, Before Update, After Update, Before Delete, After Delete, After UnDelete) {
    ReInsuranceTriggerFunction.Handler(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap, Trigger.IsBefore, Trigger.IsAfter, Trigger.IsInsert, Trigger.IsUpdate, Trigger.IsDelete,Trigger.IsUnDelete);
}