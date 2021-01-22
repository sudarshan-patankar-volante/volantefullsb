/*

 *Created By : Anusuya
 
 *Created On : 4-3-2019
 
*/

trigger TaxTrigger on VG_Taxes__c (Before Insert, After Insert, Before Update, After Update, Before Delete, After Delete) {
     TaxTriggerFunction.Handler(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap, Trigger.IsBefore, Trigger.IsAfter, Trigger.IsInsert, Trigger.IsUpdate, Trigger.IsDelete);
}