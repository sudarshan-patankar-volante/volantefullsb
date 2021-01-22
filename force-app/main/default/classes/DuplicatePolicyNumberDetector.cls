global class DuplicatePolicyNumberDetector implements Database.Batchable<sObject> , Schedulable, Database.Stateful {
    
    Public String PolicyDuplicates = '';
    
    global List<Policy__c> start(Database.BatchableContext BC){
        return new List<Policy__c>([select id,Name from Policy__c]);
    }
 
    global void execute(Database.BatchableContext BC, List<Policy__c> policyList){
         Set<String> uniqueNameSet = new Set<String>();
         Set<String> dupCheck = new Set<String>();
         for(Policy__c pol: policyList){
            uniqueNameSet.add(pol.Name);
         }
         List<Policy__c> polCheck = [select id,Name from Policy__c where Name IN: uniqueNameSet];
         for(Policy__c pol : polCheck){
             if(!dupCheck.contains(pol.Name)){
                 dupCheck.add(pol.Name);
             }else{
                 PolicyDuplicates = PolicyDuplicates + pol.Name + ',\n';
             }
         }
    }  
    
    global void finish(Database.BatchableContext BC){
        List<messaging.Email> emailsList = new List<messaging.Email>();
        string[]toAdd=new string[]{Label.EmailID_DuplicatePolicyNumberDetector};
        string []ccAdd=new string[]{Label.EmailID2_DuplicatePolicyNumberDetector};
        messaging.SingleEmailMessage email1=new messaging.SingleEmailMessage();
        if(PolicyDuplicates != ''){ 
            email1.setToAddresses(toAdd);
            email1.setCcAddresses(ccAdd);
            email1.setSubject('Duplicates Detected');
            email1.setPlainTextBody(PolicyDuplicates );
            email1.setSenderDisplayName('Developer Team');
            emailsList.add(email1);
            messaging.sendEmail(emailsList);
        }
    }
    global void execute(SchedulableContext ctx) {
        DuplicatePolicyNumberDetector duplicateDetector= new DuplicatePolicyNumberDetector();
        database.executebatch(duplicateDetector ,500);
    }
}