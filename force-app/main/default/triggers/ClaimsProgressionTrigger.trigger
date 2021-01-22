trigger ClaimsProgressionTrigger on Claims_Progression__c (Before Insert, After Insert, Before Update, After Update, Before Delete, After Delete) {
     ClaimsProgressionTriggerFunction.Handler(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap, Trigger.IsBefore, Trigger.IsAfter, Trigger.IsInsert, Trigger.IsUpdate, Trigger.IsDelete);
}