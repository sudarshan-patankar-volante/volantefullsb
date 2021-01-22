/*

 *Created By : Anusuya
 
 *Created On : 7-4-2018
 
*/

trigger ClaimTrigger on Claim__c (Before Insert, After Insert, Before Update, After Update, Before Delete, After Delete) {
     ClaimTriggerFunction.Handler(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap, Trigger.IsBefore, Trigger.IsAfter, Trigger.IsInsert, Trigger.IsUpdate, Trigger.IsDelete);
}