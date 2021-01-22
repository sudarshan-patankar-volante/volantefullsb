public class VG_LSAssetsUploadController{
    Public VG_Attachment__c obj {get; set;}
    Public Id id {get;set;}
    public String description {get;set;} 
    public String AttName {get;set;}
    public String fileName {get;set;}
    public String updatedFileBody {get;set;}
    public string nameFile{get;set;}
    String[] filelines = new String[]{};
    public Blob fileBody {get;set;}
    Public Static Boolean coverCatchBlocks = False;
    Public Static Boolean AssetAttachment = True;
    public List<Asset__c> LSAssetsupload;
    public List < SelectOption > statusOptions {get;set;}
    public String sObjectType {get; set;}
    public String attType {get; set;}
    public Boolean isAttTypeGiven {get; set;}
    public Boolean policyPageBlockSection {get;set;}
    public List < SelectOption > policyFolderOptions {get;set;}
    Public Account AccName {get; set;}
    public Document templateFile {get; set;}
     public VG_LSAssetsUploadController(){
        obj = new VG_Attachment__c();
        id = apexpages.currentpage().getparameters().get('id');
        sObjectType = apexpages.currentpage().getparameters().get('sObjectType');
        attType = apexpages.currentpage().getparameters().get('attType');
        if(sObjectType=='Account')
            AccName=[Select Id,Name From Account where Id=:id];
        if(sObjectType == 'Policy__c'){
            policyPageBlockSection = True;
        }
        templateFile = [Select Id from Document where Name = 'LS Asset Upload Template'];
        if(attType == null){
            isAttTypeGiven = False;
        }else{
            isAttTypeGiven = True;
            obj.VG_Attachment_Type__c = attType;
        }
        Id attRecordTypeId = Schema.SObjectType.VG_Attachment__c.getRecordTypeInfosByName().get('Account').getRecordTypeId();
        obj.RecordTypeId = attRecordTypeId;
        LSAssetsupload =new List<Asset__c>();
        
        statusOptions = new List <SelectOption>();
        Schema.DescribeFieldResult statusFieldDescription = Schema.VG_Attachment__c.VG_Attachment_Type__c.getDescribe();
        for (Schema.Picklistentry picklistEntry: statusFieldDescription.getPicklistValues()) {
            if(picklistEntry.getValue() != 'Assets File'){
                statusOptions.add(new SelectOption(pickListEntry.getValue(), pickListEntry.getLabel()));            
            
            }
            if (picklistEntry.isDefaultValue()) {
                obj.VG_Attachment_Type__c = picklistEntry.getValue();
            }
        }
         
        policyFolderOptions = new List <SelectOption>();
        Schema.DescribeFieldResult FolderFieldDescription = Schema.VG_Attachment__c.VG_Folder__c.getDescribe();
        for (Schema.Picklistentry picklistEntry: FolderFieldDescription.getPicklistValues()) {
            policyFolderOptions.add(new SelectOption(pickListEntry.getValue(), pickListEntry.getLabel()));            
            if (picklistEntry.isDefaultValue()) {
                obj.VG_Folder__c = picklistEntry.getValue();
            }
        }        
    }
    
     public Database.SaveResult saveCustomAttachment(){
        obj.Id = null;
        if(sObjectType == 'Account'){ 
            obj.VG_Account__c=id;
            obj.VG_Attachment_Type__c = attType;
            if(Description !=null && Description!='' )
                obj.VG_Description__c=Description;
            if(attType == 'Assets File')
                ReadFile();                
            if(AssetAttachment){
                return Database.insert(obj);
            }else{
                return null;   
            } 
        }else if(sObjectType == 'Policy__c'){
            obj.VG_Policy__c=id;
            if(Description !=null && Description!='' )
                obj.VG_Description__c=Description; 
                return Database.insert(obj);
        }else{
            return null;
        }      
    }
        
    public Database.SaveResult saveStandardAttachment(Id parentId){       
        System.debug('coverCatchBlocks:'+coverCatchBlocks+parentId);
        if(coverCatchBlocks){
            Database.SaveResult result=null;
            return result;
        }else{
            Database.SaveResult result;
            Attachment attachment = new Attachment();
            attachment.body = this.fileBody;
            if(AttName !=null && AttName != ''){
                String ext =this.fileName.substringAfter('.');
                if(AttName.length() > 80){
                    AttName=AttName.left(80);
                }
               attachment.Name = AttName+'.'+ext;
            }else{
                if(fileName.length() > 80){
                    String ext =this.fileName.substringAfter('.');
                    fileName=fileName.left(75)+'.'+ext;
                }
               
                attachment.Name = this.fileName;
            }
            
            attachment.parentId = parentId;
            System.debug('attachment.body::'+attachment.body);
            result = Database.insert(attachment);
            fileBody = Blob.valueOf(' ');
            return result;
        }
    }
    
    public PageReference processUpload(){
        if(fileBody == null){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please Upload a file'));
            return null;
        }
        Database.SaveResult customAttachmentResult = saveCustomAttachment();        
        if (customAttachmentResult == null || !customAttachmentResult.isSuccess()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Could not save attachment.'));
            return null;
        }       
        Database.SaveResult attachmentResult = saveStandardAttachment(id);        
        if (attachmentResult == null || !attachmentResult.isSuccess()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Could not save attachment.'));            
            return null;
        }else{
            VG_Attachment__c customAttachment = [select id from VG_Attachment__c where id = :customAttachmentResult.getId()];          
            customAttachment.VG_Attachment__c = attachmentResult.getId();
            if(AttName != null)
                customAttachment.Name = AttName ;
            else
                customAttachment.Name = this.fileName ;
            customAttachment.VG_Attachment__c = attachmentResult.getId();
            try{
                System.debug('customAttachment::'+customAttachment.Name);
                update customAttachment;
            }catch(Exception e){
               ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  e.getMessage()));
               return null;
            }
            update customAttachment;
            System.debug('Type::'+obj.VG_Attachment_Type__c);
            if(obj.VG_Attachment_Type__c == 'TOBA'){
                Account acc = new Account();
                acc.Id = id;
                acc.VG_TOBA_Uploaded__c = True;
                Update acc;
            }
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'File Successfully Attached..','File Successfully Attached..'));
            description = '';
            return null;
        }
    }  
    
    
    public PageReference back(){
        return new PageReference('/'+id);
    } 
    
     public Pagereference ReadFile(){ 
        try{  
            nameFile=fileBody.toString();
        }
        catch(Exception e){                                  
           AssetAttachment=false;
           ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'CSV File Format only Accepted. Please check your file format.'));
           return null;
        }
        String regNum;
        if(nameFile!=null)
        filelines = nameFile.split('\n');
        System.debug('Filelines1::'+filelines+'Filelines::'+filelines.size()+'nameFile::'+nameFile);        
        updatedFileBody = '';
        for (Integer i=1;i<filelines.size();i++){
                String[] inputvalues = new String[]{};
                String[] headervalues = new String[]{};                             
                inputvalues = filelines[i].split(',');                             
                headervalues = filelines[0].split(',');
                System.debug('header::'+headervalues[0]);            
            Asset__c ass = new Asset__c();
            ass.VG_Account__c = id;
            Map<ID,Schema.RecordTypeInfo> ass_rt_Map = Asset__c.sObjectType.getDescribe().getRecordTypeInfosById();        
            Id LSId = Schema.SObjectType.Asset__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
            ass.RecordTypeId=LSId;
            System.debug('recordtype::'+LSId);
             if(headervalues[0]=='Total Material Damage'){          
                if(inputvalues[0] != '' && inputvalues[0] !=null)
                   ass.Total_Material_Damage__c=Decimal.valueOf(inputvalues[0].trim()); 
                if(inputvalues[1] != '')
                    ass.VG_Total_Business_Interruption_SI__c = Decimal.valueOf(inputvalues[1].trim());
                if(inputvalues[2] != '')
                    ass.VG_Street__c = inputvalues[2].trim();                                
                if(inputvalues[3] != '')     
                    ass.VG_Postal_Code__c = inputvalues[3].trim(); 
                if(inputvalues[4] != '')
                    ass.VG_Country__c = inputvalues[4].trim();
                if(inputvalues[5] != ''){
                    ass.VG_Building_No__c = Decimal.valueOf(inputvalues[5].trim());
                    ass.Name=ass.VG_Street__c+','+ass.VG_Postal_Code__c+','+ass.VG_Country__c;
                    System.debug('assName::'+ass.Name);
                }   
             }else if(headervalues[0]=='SFDC Record Id'){
                if(inputvalues[0] != '')
                    ass.id = inputvalues[0].trim();
                    System.debug('ass::'+inputvalues[0].trim()+inputvalues[1]);
                if(inputvalues[1] != '' && inputvalues[1] !=null)
                   ass.Total_Material_Damage__c=Decimal.valueOf(inputvalues[1].trim()); 
                if(inputvalues[2] != '')
                    ass.VG_Total_Business_Interruption_SI__c = Decimal.valueOf(inputvalues[2].trim());
                if(inputvalues[3] != '')
                    ass.VG_Street__c = inputvalues[3].trim();
                if(inputvalues[4] != '')     
                    ass.VG_Postal_Code__c = inputvalues[4].trim(); 
                if(inputvalues[5] != '')
                    ass.VG_Country__c = inputvalues[5].trim();
                if(inputvalues[6] != '')
                    ass.VG_Building_No__c = Decimal.valueOf(inputvalues[6].trim());                              
            }
             if(ass.VG_Street__c !=null && ass.VG_Postal_Code__c!=null && ass.VG_Country__c!=null){
                  LSAssetsupload.add(ass);
             }
         }
        updatedFileBody = 'SFDC Record Id,Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no\n';        
        List<Asset__c> insAss=new List<Asset__c>();
        List<Asset__c> updAss=new List<Asset__c>();
        for(Asset__c ass:LSAssetsupload){
            if(ass.id==null){
                System.debug(':if:');
                ass.LS_AccName_with_Ass_Name__c=AccName.Name+'_'+ass.VG_Street__c+','+ass.VG_Postal_Code__c+','+ass.VG_Country__c;     
                insAss.add(ass);
            }else{
                System.debug(':else:');
                updAss.add(ass);
            }
        }
        
        if(!insAss.IsEmpty()){
            upsert insAss LS_AccName_with_Ass_Name__c;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Assets created successfully...'));                          
        }
        if(!updAss.IsEmpty()){
            try{
                update updAss;
            }catch(Exception e){
                System.debug('Exp::'+e);
            }            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Assets Updated successfully...'));                  
       
        }
        
        for(Asset__c a : LSAssetsupload){ 
            updatedFileBody = updatedFileBody + a.Id;
            updatedFileBody = updatedFileBody + ',' + a.Total_Material_Damage__c;                                              
            updatedFileBody = updatedFileBody + ',' + a.VG_Total_Business_Interruption_SI__c;            
            updatedFileBody = updatedFileBody + ',' + a.VG_Street__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Postal_Code__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Country__c;                  
            updatedFileBody = updatedFileBody + ',' + a.VG_Building_No__c+'\n';
       }
    
        fileBody = Blob.valueOf(updatedFileBody);                
        AssetAttachment=True;
        return null;
    }
 }