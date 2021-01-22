public with sharing class VG_PS_DocumentController {
    
    @AuraEnabled
    public static List<String> getUserDocRepoList(){
        User usr = [Select Id,Name,Document_Repository_Access__c from User WHERE username=:UserInfo.getUsername()];
        String docRepo = usr.Document_Repository_Access__c;
        String[] docRepolist = docRepo.split(';');
        System.debug('doc::'+docRepolist);
        return docRepolist;        
    }
    
    @AuraEnabled
    public static List<VG_Attachment__c> getPolicyAttachments(String fName,Id psid){   
        System.debug('PSID::'+psid+'::'+[select id, Name, Policy__c from Policy_Schedule__c]);
        Policy_Schedule__c ps = [select id, Name, Policy__c from Policy_Schedule__c where id=:psid limit 1];
        String ProName = [select id, Name from Profile where id=:UserInfo.getProfileId() limit 1].Name;
        System.debug('ProName::'+ProName);       
        if(fName == 'Policy Documentation'){
            return[select id, Name, VG_Folder__c, VG_Policy__c, VG_Portal_Name__c, VG_Attachment__c,VG_Attachment_URL__c, CreatedDate, VG_Description__c from VG_Attachment__c where (VG_Folder__c=:fName OR VG_Folder__c=:null) AND (VG_Policy_Schedule__c=:psid OR VG_Policy__c=:ps.Policy__c) ORDER BY CreatedDate desc];    
        }else if(fName == 'Pricing Spreadsheet'){
            return[select id, Name, VG_Folder__c, VG_Policy__c, VG_Portal_Name__c, VG_Attachment__c,VG_Attachment_URL__c, CreatedDate, VG_Description__c from VG_Attachment__c where VG_Folder__c=:'Pricing Spreadsheet' AND (VG_Policy_Schedule__c=:psid OR VG_Policy__c=:ps.Policy__c) ORDER BY CreatedDate desc];   
        }else{
            return[select id, Name, VG_Folder__c, VG_Policy__c, VG_Portal_Name__c, VG_Attachment__c,VG_Attachment_URL__c,CreatedDate, VG_Description__c from VG_Attachment__c where VG_Folder__c=:fName AND (VG_Policy_Schedule__c=:psid OR VG_Policy__c=:ps.Policy__c) ORDER BY CreatedDate desc];   
        }               
    }
    
    @AuraEnabled
    public static Attachment getAttachment(Id attid){
        Attachment att = [select id, Name, Body from Attachment where id=:attid limit 1];
        System.debug('Attachment:'+att);
        return att;
    }
    @AuraEnabled
    public static String insertAttachment(Id psid,String fileStr,String folderName, String attId){
        try{
            String fileNameFull;
            List<VG_Attachment__c> customAttachmentList=new List<VG_Attachment__c>();           
            String[] fileNames = fileStr.split(';');
            String[] attamentIds = attId.split(';');
            List<contentversion> filelist= new List<contentversion>([select id,Title,ContentDocumentId from contentversion where ContentDocumentId IN: attamentIds]);                
            Map<Id, ContentDocumentLink> docsList = new Map<Id, ContentDocumentLink>([SELECT ContentDocumentID, ContentDocument.Title, LinkedEntity.type, LinkedEntityId FROM ContentDocumentLink where ContentDocumentID IN: attamentIds]);
            System.debug('filelist::'+filelist.size());
            for(contentversion cv: filelist) {                                  
                VG_Attachment__c customAttachment;
                customAttachment = new VG_Attachment__c();
                customAttachment.VG_Attachment__c = cv.Id;
                System.debug('test::'+customAttachment.VG_Attachment__c);
                //customAttachment.Name = fileStr;
                System.debug('title::'+cv.title);
                fileNameFull = cv.title;
                if(fileNameFull.length() > 75){
                    fileNameFull = fileNameFull.substring(0, 74) + '...';
                }
                customAttachment.Name = fileNameFull;
                customAttachment.VG_Folder__c = folderName;
                customAttachment.VG_Policy_Schedule__c = psid;
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