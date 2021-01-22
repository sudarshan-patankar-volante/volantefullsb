public class VG_BulkAssetsUploadController{
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
    public List<Asset__c> BulkAssetsupload;
    public List < SelectOption > statusOptions {get;set;}
    public String sObjectType {get; set;}
    public String attType {get; set;}
    public Boolean isAttTypeGiven {get; set;}
    public Document templateFile {get; set;}
    public Boolean policyPageBlockSection {get;set;}
    public List < SelectOption > policyFolderOptions {get;set;}
    Public Account AccName {get; set;}
    Public String Message{get; set;}
    public String contentType { get; set; }
    public VG_BulkAssetsUploadController(){
        obj = new VG_Attachment__c();
        id = apexpages.currentpage().getparameters().get('id');
        sObjectType = apexpages.currentpage().getparameters().get('sObjectType');
        attType = apexpages.currentpage().getparameters().get('attType');
        if(sObjectType=='Account')
            AccName=[Select Id,Name From Account where Id=:id];
        if(sObjectType == 'Policy__c'){
            policyPageBlockSection = True;
        }
        templateFile = [Select Id from Document where Name = 'Asset Upload Template'];
        if(attType == null){
            isAttTypeGiven = False;
        }else{
            isAttTypeGiven = True;
            obj.VG_Attachment_Type__c = attType;
        }
        Id attRecordTypeId = Schema.SObjectType.VG_Attachment__c.getRecordTypeInfosByName().get('Account').getRecordTypeId();
        obj.RecordTypeId = attRecordTypeId;
        BulkAssetsupload =new List<Asset__c>();
        
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
            //Code added finished  on 26.2.2018
            if(Description !=null && Description!='' )
                obj.VG_Description__c=Description;
            //Code added finished  on 26.2.2018
            if(attType == 'Assets File')
                ReadFile();
            if(AssetAttachment){
                return Database.insert(obj);
            }else{
                return null;   
            }
            
        }else if(sObjectType == 'Policy__c'){
            obj.VG_Policy__c=id;
            //Code added by siddik on 26.2.2018 
            if(Description !=null && Description!='' )
                obj.VG_Description__c=Description; 
            //Code added finished  on 26.2.2018 
            return Database.insert(obj);
        }else{
            return null;
        }
        
        
    }
    
    
    public Database.SaveResult saveStandardAttachment(Id parentId){       
        System.debug('coverCatchBlocks:'+coverCatchBlocks);
        if(coverCatchBlocks){
            Database.SaveResult result=null;
            return result;
        }else{
            Database.SaveResult result;
            Attachment attachment = new Attachment();
            attachment.body = this.fileBody;
            if(AttName !=null && AttName != ''){
                String ext =this.fileName.substringAfterLast('.');
                //Code Added by siddik on 12.3.2018
                if(AttName.length() > 75){
                    AttName=AttName.left(75);
                }
                //Code Added End by siddik on 12.3.2018
                attachment.Name = AttName+'.'+ext;
            }else{
                //Code Added by siddik on 12.3.2018
                String ext =this.fileName.substringAfterLast('.');
                this.fileName=this.fileName.removeEndIgnoreCase('.'+ext);
                if(this.fileName.length() > 75){
                    AttName=this.fileName.left(75);
                }
                //Code Added End by siddik on 12.3.2018
                attachment.Name = AttName+'.'+ext;
            }
            attachment.parentId = parentId;
            // insert the attahcment
            System.debug('attachment.body::'+attachment.body+'::Name::'+attachment.Name+'::'+AttName);
            result = Database.insert(attachment);
            // reset the file for the view state
            fileBody = Blob.valueOf(' ');
            return result;
        }
    }
    
    
    public PageReference processUpload(){
        
        // code added by siddik on 19.2.2018
        if(fileBody == null){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please Upload a file'));
            return null;
        }
        //end added ...19.2.2018
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
            // update the custom attachment record with some attachment info
            VG_Attachment__c customAttachment = [select id from VG_Attachment__c where id = :customAttachmentResult.getId()];
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
        Message='';
        Boolean msg=false;    
        //System.debug('10.5.2019::'+EncodingUtil.base64Encode(fileBody));
        try{  
            nameFile=PaymentDetailsController.decode(fileBody,'ISO-8859-1');
            filelines = nameFile.split('\n');
            System.debug('nameFile::'+nameFile); 
        }
        catch(Exception e){                                  
           AssetAttachment=false;
           System.debug('error::'+e);
           ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'CSV File Format only Accepted. Please check your file format.'));
           return null;
        }
        Set<String> regNum=new Set<String>();
                  
        System.debug('Filelines::'+filelines.size()+'\nFilelines::'+filelines+'\nnameFile::'+nameFile);        
        updatedFileBody = '';
        for (Integer i=1;i<filelines.size();i++){
            String[] inputvalues = new String[]{};
            String[] headervalues = new String[]{};
            inputvalues = filelines[i].split(',');
            headervalues = filelines[0].split(',');
            System.debug('header::'+headervalues[0]+headervalues.size()+headervalues[0].trim().equalsIgnoreCase('Registration Number'));
            Asset__c ass = new Asset__c();
            ass.VG_Account__c = id;
            System.debug(inputvalues);
            for(Integer w=0;w<inputvalues.size();w++){
                System.debug('5.7.2019::'+inputvalues[w]+'::'+inputvalues[w].length()+'::'+inputvalues[w].replace(' ,',',').trim()+'::'+inputvalues[w].replace(' ,',',').trim().length());
            }
            if(headervalues[0].trim()=='Registration Number'){             
                System.debug(':i1:'+i);
                if(inputvalues[0] !=null && inputvalues[0] !='' ){
                    if(!regNum.contains(inputvalues[0])){
                        System.debug(':i2:'+i+inputvalues[0]+'regNum:'+regNum);
                        regNum.add(inputvalues[0]);
                    }else{
                        System.debug(':i3:'+i+inputvalues[0]);
                        AssetAttachment=False;
                        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Repeated Registration Numbers do not allowed.Please Check File on the line number '+i+' with name of '+inputvalues[0]));
                        return null;
                    }
                }else{
                    AssetAttachment=False;
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Registration Numbers can\'t empty.Please Check File.'));
                    return null;
                }
                if(inputvalues[0] != '')
                    ass.Name = ass.Vehicle_Registration_No__c = inputvalues[0].replace(' ,',',').trim();
                if(inputvalues[1] != '')
                    ass.Vehicle_Make__c = inputvalues[1].replace(' ,',',').trim();
                if(inputvalues[2] != '')      
                    ass.Vehicle_Model__c = inputvalues[2].replace(' ,',',').trim(); 
                 //Add Validation Code By Anu 20.3.2018                 
                if(inputvalues[3] != ''){                    
                    try{
                        ass.Vehcicle_CC__c = Decimal.valueOf(inputvalues[3].replace(' ,',',').trim());
                    }
                    catch(TypeException e){                       
                       AssetAttachment=False;
                       msg=True;
                       Message+='Vehicle CC Value Must be in Number<br>';
                    }
                }                                             
                if(inputvalues[4] != ''){                    
                    try{
                       ass.Vehcile_GVW__c = Decimal.valueOf(inputvalues[4].replace(' ,',',').trim());
                    }
                    catch(TypeException e){                       
                       AssetAttachment=False;
                       msg=True;
                       Message+='Vehicle GVW Value Must be in Number'+'<br>';
                    }
                    
                }                                                                    
                if(inputvalues[5] != ''){                   
                    try{
                        ass.Vehicle_Number_of_Seats__c = Decimal.valueOf(inputvalues[5].replace(' ,',',').trim());
                    }
                    catch(TypeException e){                      
                       AssetAttachment=False;
                       msg=True;
                       Message+='Vehicle NO.OF.Seats Value Must be in Number<br>';
                    }
                } 
                if(msg){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Message));    
                    return null;
                }
                // End Validation Code By Anu 20.3.2018                                    
                if(inputvalues[6] != '') 
                    ass.VG_Use__c = inputvalues[6].replace(' ,',',').trim();
                if(inputvalues[7] != '') 
                    ass.VG_Coverage__c = inputvalues[7].replace(' ,',',').trim();                                 
                if(inputvalues[8] != '') 
                    ass.VG_Date_Added__c = Date.parse(inputvalues[8].replace(' ,',',').replace('-','/').trim());
                if(inputvalues[9] != '') 
                    ass.VG_Date_Removed__c = Date.parse(inputvalues[9].replace(' ,',',').replace('-','/').trim());
                if(inputvalues[10] != '') 
                    ass.VG_Status__c = inputvalues[10].replace(' ,',',').trim();
                if(inputvalues[11] != '') 
                    ass.VG_Policy_Number__c = inputvalues[11].replace(' ,',',').trim();
               
            }else if(headervalues[0]=='SFDC Record Id'){
                System.debug(':else if:');
                if(inputvalues[0] != '')
                    ass.id = inputvalues[0].trim();
                if(inputvalues[1] != '')
                    ass.Name = ass.Vehicle_Registration_No__c = inputvalues[1].trim();                      
                if(inputvalues[2] != '')
                    ass.Vehicle_Make__c = inputvalues[2].trim();
                if(inputvalues[3] != '')      
                    ass.Vehicle_Model__c = inputvalues[3].trim();  
                //Add Validation Code By Anu 20.3.2018                 
                if(inputvalues[4] != ''){                    
                    try{
                        ass.Vehcicle_CC__c = Decimal.valueOf(inputvalues[4].trim()); 
                    }
                    catch(TypeException e){
                       AssetAttachment=False;
                       msg=True;
                       Message+='Vehicle CC Value Must be in Number<br>';
                    }
                }                                          
                if(inputvalues[5] != ''){                   
                    try{
                       ass.Vehcile_GVW__c = Decimal.valueOf(inputvalues[5].trim());
                    }
                    catch(TypeException e){
                       AssetAttachment=False;
                       msg=True;
                       Message+='Vehicle GVW Value Must be in Number<br>';
                    }
                    
                }    
                                                                                                        
                if(inputvalues[6] != ''){                    
                    try{
                        ass.Vehicle_Number_of_Seats__c = Decimal.valueOf(inputvalues[6].trim());
                    }
                    catch(TypeException e){
                       AssetAttachment=False;
                       msg=True;
                       Message+='Vehicle NO.OF.Seats Value Must be in Number<br>';
                    }
                } 
                if(msg){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Message));    
                    return null;
                }
                // End Validation Code By Anu 20.3.2018                     
                if(inputvalues[7] != '') 
                    ass.VG_Use__c = inputvalues[7].trim();
                if(inputvalues[8] != '') 
                    ass.VG_Coverage__c = inputvalues[8].trim();                 
                
                if(inputvalues[9] != '' && inputvalues[9] != null && inputvalues[9] != 'null'){ 
                    ass.VG_Date_Added__c = Date.valueOf(inputvalues[9].left(10));                    
                    String dateval =String.valueOf(ass.VG_Date_Added__c);                    
                    List<String> dateParts = dateval.split('-');                    
                    Datetime dateWithTime = Datetime.newInstance(Integer.valueOf(dateParts[0]), Integer.valueOf(dateParts[1]), Integer.valueOf(dateParts[2]));
                    dateval= dateWithTime.format('dd/MM/yyyy');
                    Date assDate=Date.parse(dateval);                   
                    ass.VG_Date_Added__c=assDate;
                }
                if(inputvalues[10] != '' && inputvalues[10] != null && inputvalues[10] != 'null'){                     
                    ass.VG_Date_Removed__c = Date.valueOf(inputvalues[10].left(10));
                    String dateval2 =String.valueOf(ass.VG_Date_Added__c);
                    List<String> dateRemove = dateval2.split('-');
                    Datetime dateWithTime2 = Datetime.newInstance(Integer.valueOf(dateRemove[0]), Integer.valueOf(dateRemove[1]), Integer.valueOf(dateRemove[2]));
                    dateval2= dateWithTime2.format('dd/MM/yyyy');
                    Date assDate2=Date.parse(dateval2);
                    ass.VG_Date_Removed__c=assDate2;
                }
                if(inputvalues[11] != '') 
                    ass.VG_Status__c = inputvalues[11].trim();
                if(inputvalues[12] != '') 
                    ass.VG_Policy_Number__c = inputvalues[12].trim();
            }else{
                System.debug('Encoding issue please select EnCoding in UTF-8...'+headervalues[0].trim()+'::'+headervalues[0].trim().length());
            }                                                                             
            System.debug('Asset::'+ass);          
            BulkAssetsupload.add(ass);                                          
        }
        updatedFileBody = 'SFDC Record Id,Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number \n';
        List<Asset__c> insAss=new List<Asset__c>();
        List<Asset__c> updAss=new List<Asset__c>();
        for(Asset__c ass:BulkAssetsupload){
            if(ass.id==null){
                ass.VG_REG_NO_Account_Name__c=AccName.Name+'_'+ass.Vehicle_Registration_No__c; 
                System.debug(':if:'+ass.VG_REG_NO_Account_Name__c);               
                insAss.add(ass);
            }else{
                System.debug(':else:');
                updAss.add(ass);
            }
        }
        System.debug('BulkAssetsupload:'+BulkAssetsupload.size()+':'+BulkAssetsupload);
        System.debug('insAss:'+insAss.size()+':'+insAss);
        System.debug('updAss:'+updAss.size()+':'+updAss);
        if(!insAss.IsEmpty()){
            upsert insAss VG_REG_NO_Account_Name__c;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Assets created successfully...'));                  
        
        }
        if(!updAss.IsEmpty()){
            update updAss;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Assets Updated successfully...'));                  
       
        }
                         
        for(Asset__c a : BulkAssetsupload){ 
            updatedFileBody = updatedFileBody + a.Id;                                              
            updatedFileBody = updatedFileBody + ',' + a.Vehicle_Registration_No__c;
            updatedFileBody = updatedFileBody + ',' + a.Vehicle_Make__c;
            updatedFileBody = updatedFileBody + ',' + a.Vehicle_Model__c;
            updatedFileBody = updatedFileBody + ',' + a.Vehcicle_CC__c;
            updatedFileBody = updatedFileBody + ',' + a.Vehcile_GVW__c;                  
            updatedFileBody = updatedFileBody + ',' + a.Vehicle_Number_of_Seats__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Use__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Coverage__c;                                  
            updatedFileBody = updatedFileBody + ',' + a.VG_Date_Added__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Date_Removed__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Status__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Policy_Number__c+'\n';
              
        }
        fileBody = Blob.valueOf(updatedFileBody);                
        AssetAttachment=True;
        return null;
    }
}