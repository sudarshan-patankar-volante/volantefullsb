public with sharing class VG_PolicyDocumentController {
    @AuraEnabled
    public static List<String> getUserDocRepoList(){
        User usr = [Select Id,Name,Document_Repository_Access__c from User WHERE username=:UserInfo.getUsername()];
        String docRepo = usr.Document_Repository_Access__c;
        String[] docRepolist = docRepo.split(';');
        System.debug('doc::'+docRepolist);
        return docRepolist;        
    }
    
    @AuraEnabled
    public static List<VG_Attachment__c> getPolicyAttachments(String fName, Id polid){        
        Policy__c pol = [select id, Name, Insured__c from Policy__c where id = :polid limit 1];
        String ProName = [select id, Name from Profile where id = :UserInfo.getProfileId() limit 1].Name;
        List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([select id, Name from Policy_Schedule__c where Policy__c = :polid]);
        Set<ID> psIds = new Set<ID>();
        for(Policy_Schedule__c ps:psList){
            psIds.add(ps.id);  
        } 
        if(fName == 'Policy Documentation'){
            return[select id, Name, VG_Folder__c, VG_Policy__c, VG_Portal_Name__c,VG_Attachment__c,VG_Attachment_URL__c, CreatedDate, VG_Description__c from VG_Attachment__c where (VG_Folder__c = :fName OR VG_Folder__c = :null) AND (VG_Policy_Schedule__c IN:psIds OR VG_Policy__c = :polid) ORDER BY CreatedDate desc];    
        }else if(fName == 'Pricing Spreadsheet'){
            return[select id, Name, VG_Folder__c, VG_Policy__c, VG_Portal_Name__c,VG_Attachment__c,VG_Attachment_URL__c, CreatedDate, VG_Description__c from VG_Attachment__c where VG_Folder__c = :'Pricing Spreadsheet' AND (VG_Policy_Schedule__c IN:psIds OR VG_Policy__c = :polid) ORDER BY CreatedDate desc];   
        }else{
            return[select id, Name, VG_Folder__c, VG_Policy__c, VG_Portal_Name__c,VG_Attachment__c,VG_Attachment_URL__c, CreatedDate, VG_Description__c from VG_Attachment__c where VG_Folder__c = :fName AND (VG_Policy_Schedule__c IN:psIds OR VG_Policy__c = :polid) ORDER BY CreatedDate desc];   
        }              
    }
    
    @AuraEnabled
    public static Attachment getAttachment(Id attid){
        Attachment att = [select id, Name, Body from Attachment where id = :attid limit 1];
        System.debug('Attachment:'+att);        
        return att;
    }
    
    @AuraEnabled
    public static String insertAttachment(Id polId,String fileStr,String folderName, String attId){
        try{
            List<VG_Attachment__c> customAttachmentList=new List<VG_Attachment__c>();
            system.debug('check::'+fileStr);  
            String[] fileNames = fileStr.split(';');
            String[] attamentIds = attId.split(';');
            List<contentversion> filelist= new List<contentversion>([select id,title,ContentDocumentId from contentversion where ContentDocumentId IN: attamentIds]);                
            Map<Id, ContentDocumentLink> docsList = new Map<Id, ContentDocumentLink>([SELECT ContentDocumentID, ContentDocument.Title, LinkedEntity.type, LinkedEntityId FROM ContentDocumentLink where ContentDocumentID IN: attamentIds]);
            System.debug('filelist::'+filelist.size());
            for(contentversion cv: filelist) {                               
                VG_Attachment__c customAttachment;
                customAttachment = new VG_Attachment__c();
                customAttachment.VG_Attachment__c = cv.Id;
                System.debug('test::'+customAttachment.VG_Attachment__c);
                //customAttachment.Name = fileStr;
                String fileNameFull = cv.title;
                if(fileNameFull.length() > 75){
                    fileNameFull = fileNameFull.substring(0, 74) + '...';
                }
                customAttachment.Name = fileNameFull;
                customAttachment.VG_Folder__c = folderName;
                customAttachment.VG_Policy__c = polId;
                customAttachmentList.add(customAttachment);
                System.debug('customAttachmentList::'+customAttachmentList.size());                
            }
            Insert customAttachmentList;            
            for(ContentDocumentLink CDL : docsList.values()){
                CDL.ShareType = 'I';
                CDL.Visibility = 'AllUsers';
            }
            Update docsList.values();
            return 'Success';
        }catch(exception ex){
            return 'Failed';
        }
    }     
  }