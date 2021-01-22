global class BDXFixBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {

        String query = Label.BDX_Fix_Batch;
        return Database.getQueryLocator(query);

    }

   // Execute method
    global void execute(Database.BatchableContext BC, List<Policy_Schedule__c> scope) {
         Set<Id> setIds = new Set<Id>();
         for(Policy_Schedule__c ps : scope){
             setIds.add(ps.Id);
         }
         List<VG_ReInsurance__c> RIList = [Select Id, VG_UMR__c, VG_Policy_Schedule__c from VG_ReInsurance__c where VG_Policy_Schedule__c IN: setIds];

         Delete RIList;
         PolicyScheduleTriggerFunction.allowInsertRI = True;
         PolicyScheduleTriggerFunction.createRIRecords(scope);
    }   
    // Finish Method

    global void finish(Database.BatchableContext BC) {

    }
}