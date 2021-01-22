global class DeleteAllRMTestPolicies implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Account acc=[select id,Name from Account where Name=:'RM Test' limit 1];
        Map<id,Policy__c> polMap=new Map<id,Policy__c>([select id,name from Policy__c where Insured__c =: acc.id]);
        if(polMap.size()>0){
            Map<id,Policy_Schedule__c> psMap=new Map<id,Policy_Schedule__c>([select id,Name from Policy_Schedule__c where Policy__c IN: polMap.keyset()]);
            
            if(polMap != null)
                delete polMap.values();
        }
    }
}