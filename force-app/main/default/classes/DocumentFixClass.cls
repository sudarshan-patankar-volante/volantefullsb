global class DocumentFixClass implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        String query = 'Select Id, Name, VG_Attachment__c, VG_Policy__c from VG_Attachment__c';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<VG_Attachment__c> records){
        // process each batch of records
        Set<Id> docIds = new Set<Id>();
        Set<Id> attachmentIds = new Set<Id>();
        for(VG_Attachment__c att : records){
            if(att.VG_Attachment__c != null){
                if(att.VG_Attachment__c.substring(0,3) == '00P'){
                    //attachmentIds.add(att.VG_Attachment__c); 
                }else{
                    docIds.add(att.VG_Attachment__c);
                } 
            }
        }
        List<contentversion> versions = [select id,title,ContentDocument.ParentId, ContentDocumentId,FileExtension from contentversion where Id IN: docIds];
        System.debug('versions'+versions.size());
        Map<Id, Id> versionMap = new Map<Id, Id>();
        for(contentversion ver : versions){
            System.debug(ver.ContentDocumentId);
            versionMap.put(ver.Id, ver.ContentDocumentId);
        }
        Map<Id, String> docNames = new Map<Id, String>();
        Map<Id, ContentDocumentLink> docsList = versionMap.IsEmpty() ? new Map<Id, ContentDocumentLink>() : new Map<Id, ContentDocumentLink>([SELECT ContentDocumentID, ContentDocument.Title, LinkedEntity.type, LinkedEntityId FROM ContentDocumentLink where ContentDocumentID IN: versionMap.values()]);
        for(ContentDocumentLink CDL : docsList.values()){
            CDL.ShareType = 'I';
            CDL.Visibility = 'AllUsers';
        }
        Update docsList.values();
    }    
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}