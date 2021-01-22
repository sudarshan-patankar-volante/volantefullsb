public class VG_AesirAssetsUploadController{
    
    Public Id id {get;set;}
    
    public String description {get;set;} 
    public String AttName {get;set;}
    public String fileName {get;set;}
    public String updatedFileBody {get;set;}
    public string nameFile{get;set;}
    public String sObjectType {get; set;}
    public String attType {get; set;}
    Public String Message{get; set;}
    
    public String[] filelines = new String[]{};
    
    public Boolean isAttTypeGiven {get; set;}
    Public Static Boolean AssetAttachment = True;
    Public Static Boolean coverCatchBlocks = False;
    
    public Blob fileBody {get;set;}
    
    Public VG_Attachment__c obj {get; set;}
    Public Account acc {get; set;}
    public Document templateFile {get; set;}
    
    public List<Asset__c> BulkAssetsupload;
    
    public VG_AesirAssetsUploadController(){
        obj = new VG_Attachment__c();
        id = apexpages.currentpage().getparameters().get('id');
        sObjectType = apexpages.currentpage().getparameters().get('sObjectType');
        attType = apexpages.currentpage().getparameters().get('attType');
        if(sObjectType=='Account')
            acc=[Select Id,Name From Account where Id=:id];
        templateFile = [Select Id from Document where Name = 'Aesir Asset Upload Template'];
        if(attType == null){
            isAttTypeGiven = False;
        }else{
            isAttTypeGiven = True;
            obj.VG_Attachment_Type__c = attType;
        }
        Id attRecordTypeId = Schema.SObjectType.VG_Attachment__c.getRecordTypeInfosByName().get('Account').getRecordTypeId();
        obj.RecordTypeId = attRecordTypeId;
        BulkAssetsupload =new List<Asset__c>();
    }
    public PageReference back(){
        return new PageReference('/'+id);
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
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'File Successfully Attached..','File Successfully Attached..'));
            description = '';
            return null;
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
        }else{
            return null;
        }
    }
    public Database.SaveResult saveStandardAttachment(Id parentId){  
        if(coverCatchBlocks){
            Database.SaveResult result=null;
            return result;
        }else{
            Database.SaveResult result;
            Attachment attachment = new Attachment();
            attachment.body = this.fileBody;
            attachment.Name =this.fileName;
            /*if(AttName !=null && AttName != ''){
                String ext =this.fileName.substringAfterLast('.');
                if(AttName.length() > 75){
                    AttName=AttName.left(75);
                }
                attachment.Name = AttName+'.'+ext;
            }else{
                String ext =this.fileName.substringAfterLast('.');
                this.fileName=this.fileName.removeEndIgnoreCase('.'+ext);
                if(this.fileName.length() > 75){
                    AttName=this.fileName.left(75);
                }
                attachment.Name = AttName+'.'+ext;
            }*/
            attachment.parentId = parentId;
            System.debug('attachment.body::'+attachment.body+'::Name::'+attachment.Name+'::'+AttName);
            result = Database.insert(attachment);
            fileBody = Blob.valueOf(' ');
            return result;
        }
    }  
    public Pagereference ReadFile(){ 
        Message='';
        Boolean msg=false;    
        try{  
            nameFile=fileBody.toString();
        }catch(Exception e){                                  
           AssetAttachment=false;
           ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'CSV File Format only Accepted. Please check your file format.'));
           return null;
        }
        Set<String> regNum=new Set<String>();
        filelines = nameFile.split('\n');          
        System.debug('Filelines::'+filelines+'Filelines::'+filelines.size()+'nameFile::'+nameFile);        
        updatedFileBody = '';
        for (Integer i=1;i<filelines.size();i++){
            String[] inputvalues = new String[]{};
            String[] headervalues = new String[]{};
            inputvalues = filelines[i].split(',');
            headervalues = filelines[0].split(',');
            System.debug('header::'+headervalues[0]);
            Asset__c ass = new Asset__c();
            ass.VG_Account__c = id;
             if(headervalues[0]=='Satellite'){ 
                System.debug('i::'+i);    
                if(inputvalues[0]  !=  '')
                    ass.Name = ass.VG_Satellite__c = inputvalues[0].trim();
                if(inputvalues[1]  !=  '')
                    ass.VG_Satellite_Family__c = inputvalues[1].trim();
                if(inputvalues[2]  !=  '')
                    ass.VG_Manufacturer__c = inputvalues[2].trim();
                if(inputvalues[3]  !=  '')
                    ass.VG_Payload__c = inputvalues[3].trim();
                if(inputvalues[4]  !=  '')
                    ass.VG_Platform_Manufacturer__c = inputvalues[4].trim();
                if(inputvalues[5]  !=  '')
                    ass.VG_Operator__c = inputvalues[5].trim();
                if(inputvalues[6]  !=  '')
                    ass.VG_Payload_Power__c = Decimal.valueOf(inputvalues[6].trim());
                if(inputvalues[7]  !=  '')
                    ass.VG_Satellite_EOL_Power__c = Decimal.valueOf(inputvalues[7].trim());
                if(inputvalues[8]  !=  '')
                    ass.VG_Dry_Mass__c = Decimal.valueOf(inputvalues[8].trim());
                if(inputvalues[9]  !=  '')
                    ass.VG_Wet_Mass__c = Decimal.valueOf(inputvalues[9].trim());
                if(inputvalues[10]  !=  '')
                    ass.VG_Mission__c = inputvalues[10].trim();
                if(inputvalues[11]  !=  '')
                    ass.VG_Missions__c = inputvalues[11].trim();
                if(inputvalues[12]  !=  '')
                    ass.VG_Payload__c = inputvalues[12].trim();
                if(inputvalues[13]  !=  '')
                    ass.VG_Platform_Propulsion__c = inputvalues[13].trim();
                if(inputvalues[14]  !=  '')
                    ass.VG_Platform_Power__c = inputvalues[14].trim();
                if(inputvalues[15]  !=  '')
                    ass.VG_Platform_AOCS__c = inputvalues[15].trim();
                if(inputvalues[16]  !=  '')
                    ass.VG_Platform_Thermal__c = inputvalues[16].trim();
                if(inputvalues[17]  !=  '')
                    ass.VG_Platform_C_and_C__c = inputvalues[17].trim();
                if(inputvalues[18]  !=  '')
                    ass.VG_Equipments__c = inputvalues[18].trim();
                if(inputvalues[19]  !=  '')
                    ass.VG_Heritage__c = inputvalues[19].trim();
                if(inputvalues[20]  !=  '')
                    ass.VG_Design_Life__c = Decimal.valueOf(inputvalues[20].trim());
                if(inputvalues[21]  !=  '')
                    ass.VG_OML__c = Decimal.valueOf(inputvalues[21].trim());
                if(inputvalues[22]  !=  '')
                    ass.VG_EOL_Power_Margin__c = Decimal.valueOf(inputvalues[22].trim());
                if(inputvalues[23]  !=  '')
                    ass.VG_Technical_Summary__c = inputvalues[23].trim();
                if(inputvalues[24]  !=  '')
                    ass.VG_Rate_Loading__c = Decimal.valueOf(inputvalues[24].trim());
                if(inputvalues[25]  !=  '')
                    ass.VG_Rate_Adjustment__c = Decimal.valueOf(inputvalues[25].trim());
                if(inputvalues[26]  !=  '')
                    ass.VG_LaunchID__c = Decimal.valueOf(inputvalues[26].trim());
                if(inputvalues[27]  !=  '' && inputvalues[27]  !=  null)
                    ass.VG_RDSFamily__c = inputvalues[27].trim();    
                if(inputvalues[28]  !=  '')
                    ass.VG_Satellite_Status__c = inputvalues[28].trim();
                if(inputvalues[29]  !=  '')
                    ass.VG_Orbital_Position__c = Decimal.valueOf(inputvalues[29].trim());
                if(inputvalues[30]  !=  '')
                    ass.VG_Orbit__c = inputvalues[30].trim();
                if(inputvalues[31]  !=  '')
                    ass.VG_Int_ID__c = inputvalues[31].trim();
                if(inputvalues[32]  !=  '' && (inputvalues[32].trim() =='Satellite' || inputvalues[32].trim() =='Launcher')){
                    ass.VG_Asset_Type__c = inputvalues[32].trim();
                }else{
                    AssetAttachment = False;
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'Asset type must be either Satellite or Lanuncher.Please Check File.'));
                    return null;
                }
                if(inputvalues[33]  !=  '')
                    ass.VG_Launcher__c = ass.Name = inputvalues[33].trim();
                if(inputvalues[34]  !=  '')
                    ass.VG_Launcher_family__c = inputvalues[34].trim();
                if(inputvalues[35]  !=  '')
                    ass.VG_Description__c = inputvalues[35].trim();
                if(inputvalues[36]  !=  '')
                    ass.VG_Prime_Manufacturer__c = inputvalues[36].trim();
                if(inputvalues[37]  !=  '')
                    ass.VG_Launch_Operator__c = inputvalues[37].trim();
            }else if(headervalues[0]=='SFDC Record Id'){
                System.debug('19.6.2019::');
                if(inputvalues[0]  !=  '' && inputvalues[0]  !=  null)
                    ass.id = inputvalues[0].trim();
                if(inputvalues[1]  !=  '' && inputvalues[1]  !=  null)
                    ass.Name = ass.VG_Satellite__c = inputvalues[1].trim();
                if(inputvalues[2]  !=  '' && inputvalues[2]  !=  null)
                    ass.VG_Satellite_Family__c = inputvalues[2].trim();
                if(inputvalues[3]  !=  '' && inputvalues[3]  !=  null)
                    ass.VG_Manufacturer__c = inputvalues[3].trim();
                if(inputvalues[4]  !=  '' && inputvalues[4]  !=  null)
                    ass.VG_Payload__c = inputvalues[4].trim();
                if(inputvalues[5]  !=  '' && inputvalues[5]  !=  null)
                    ass.VG_Platform_Manufacturer__c = inputvalues[5].trim();
                if(inputvalues[6]  !=  '' && inputvalues[6]  !=  null)
                    ass.VG_Operator__c = inputvalues[6].trim();
                if(inputvalues[7]  !=  '' && inputvalues[7]  !=  null)
                    ass.VG_Payload_Power__c = Decimal.valueOf(inputvalues[7].trim());
                if(inputvalues[8]  !=  '' && inputvalues[8]  !=  null)
                    ass.VG_Satellite_EOL_Power__c = Decimal.valueOf(inputvalues[8].trim());
                if(inputvalues[9]  !=  '' && inputvalues[9]  !=  null)
                    ass.VG_Dry_Mass__c = Decimal.valueOf(inputvalues[9].trim());
                if(inputvalues[10]  !=  '' && inputvalues[10]  !=  null)
                    ass.VG_Wet_Mass__c = Decimal.valueOf(inputvalues[10].trim());
                if(inputvalues[11]  !=  '' && inputvalues[11]  !=  null)
                    ass.VG_Mission__c = inputvalues[11].trim();
                if(inputvalues[12]  !=  '' && inputvalues[12]  !=  null)
                    ass.VG_Missions__c = inputvalues[12].trim();
                if(inputvalues[13]  !=  '' && inputvalues[13]  !=  null){
                    String payLoad = inputvalues[13].trim();
                    System.debug('19.6.2019::'+payLoad);
                    ass.VG_Payload__c = payLoad;
                }
                if(inputvalues[14]  !=  '' && inputvalues[14]  !=  null)
                    ass.VG_Platform_Propulsion__c = inputvalues[14].trim();
                if(inputvalues[15]  !=  '' && inputvalues[15]  !=  null)
                    ass.VG_Platform_Power__c = inputvalues[15].trim();
                if(inputvalues[16]  !=  '' && inputvalues[16]  !=  null)
                    ass.VG_Platform_AOCS__c = inputvalues[16].trim();
                if(inputvalues[17]  !=  '' && inputvalues[17]  !=  null)
                    ass.VG_Platform_Thermal__c = inputvalues[17].trim();
                if(inputvalues[18]  !=  '' && inputvalues[18]  !=  null)
                    ass.VG_Platform_C_and_C__c = inputvalues[18].trim();
                if(inputvalues[19]  !=  '' && inputvalues[19]  !=  null)
                    ass.VG_Equipments__c = inputvalues[19].trim();
                if(inputvalues[20]  !=  '' && inputvalues[20]  !=  null)
                    ass.VG_Heritage__c = inputvalues[20].trim();
                if(inputvalues[21]  !=  '' && inputvalues[21]  !=  null)
                    ass.VG_Design_Life__c = Decimal.valueOf(inputvalues[21].trim());
                if(inputvalues[22]  !=  '' && inputvalues[22]  !=  null)
                    ass.VG_OML__c = Decimal.valueOf(inputvalues[22].trim());
                if(inputvalues[23]  !=  '' && inputvalues[23]  !=  null)
                    ass.VG_EOL_Power_Margin__c = Decimal.valueOf(inputvalues[23].trim());
                if(inputvalues[24]  !=  '' && inputvalues[24]  !=  null)
                    ass.VG_Technical_Summary__c = inputvalues[24].trim();
                if(inputvalues[25]  !=  '' && inputvalues[25]  !=  null)
                    ass.VG_Rate_Loading__c = Decimal.valueOf(inputvalues[25].trim());
                if(inputvalues[26]  !=  '' && inputvalues[26]  !=  null)
                    ass.VG_Rate_Adjustment__c = Decimal.valueOf(inputvalues[26].trim());
                if(inputvalues[27]  !=  '' && inputvalues[27]  !=  null)
                    ass.VG_LaunchID__c = Decimal.valueOf(inputvalues[27].trim());
                if(inputvalues[28]  !=  '' && inputvalues[28]  !=  null)
                    ass.VG_RDSFamily__c = inputvalues[28].trim();    
                if(inputvalues[29]  !=  '' && inputvalues[29]  !=  null)
                    ass.VG_Satellite_Status__c = inputvalues[29].trim();
                if(inputvalues[30]  !=  '' && inputvalues[30]  !=  null)
                    ass.VG_Orbital_Position__c = Decimal.valueOf(inputvalues[30].trim());
                if(inputvalues[31]  !=  '' && inputvalues[31]  !=  null)
                    ass.VG_Orbit__c = inputvalues[31].trim();
                if(inputvalues[32]  !=  '' && inputvalues[32]  !=  null)
                    ass.VG_Int_ID__c = inputvalues[32].trim();
                if(inputvalues[33]  !=  '' && inputvalues[33]  !=  null && (inputvalues[33].trim() =='Satellite' || inputvalues[33].trim() =='Launcher')){
                    ass.VG_Asset_Type__c = inputvalues[33].trim();
                }else{
                    AssetAttachment = False;
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'Asset type must be either Satellite or Lanuncher.Please Check File.'));
                    return null;
                }
                if(inputvalues[34]  !=  '' && inputvalues[33]  !=  null)
                    ass.VG_Launcher__c = ass.Name = inputvalues[34].trim();
                if(inputvalues[35]  !=  '' && inputvalues[35]  !=  null)
                    ass.VG_Launcher_family__c = inputvalues[35].trim();
                if(inputvalues[36]  !=  '' && inputvalues[36]  !=  null)
                    ass.VG_Description__c = inputvalues[36].trim();
                if(inputvalues[37]  !=  '' && inputvalues[37]  !=  null)
                    ass.VG_Prime_Manufacturer__c = inputvalues[37].trim();
                if(inputvalues[38]  !=  '' && inputvalues[38]  !=  null)
                    ass.VG_Launch_Operator__c = inputvalues[38].trim();
            }          
            BulkAssetsupload.add(ass);                                          
        }
        updatedFileBody = 'SFDC Record Id,Satellite,Satellite Family,Manufacturer,Payload Manufacturer,Platform Manufacturer,Operator,Payload Power,Satellite EOL Power,Dry Mass,Wet Mass,Mission,Missions,Payload,Platform_Propulsion,Platform_Power,Platform_AOCS,Platform_Thermal,Platform_C and C,Equipments,Heritage,Design Life,OML,EOL Power Margin,Technical Summary,Rate Loading,Rate Adjustment,LaunchID,RDSFamily,Satellite Status,Orbital Position,Orbit,Int. ID,Asset Type,Launcher,Launcher family,Description,Prime Manufacturer,Launch Operator \n';
        if(!BulkAssetsupload.IsEmpty()){
            upsert BulkAssetsupload;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Assets saved successfully...'));                  
        }               
        for(Asset__c a : BulkAssetsupload){ 
            updatedFileBody = updatedFileBody + a.Id;
            updatedFileBody = updatedFileBody + ',' + a.VG_Satellite__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Satellite_Family__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Manufacturer__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Payload__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Platform_Manufacturer__c;                  
            updatedFileBody = updatedFileBody + ',' + a.VG_Operator__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Payload_Power__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Satellite_EOL_Power__c;                                  
            updatedFileBody = updatedFileBody + ',' + a.VG_Dry_Mass__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Wet_Mass__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Mission__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Missions__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Payload__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Platform_Propulsion__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Platform_Power__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Platform_AOCS__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Platform_Thermal__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Platform_C_and_C__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Equipments__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Heritage__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Design_Life__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_OML__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_EOL_Power_Margin__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Technical_Summary__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Rate_Loading__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Rate_Adjustment__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_LaunchID__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_RDSFamily__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Satellite_Status__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Orbital_Position__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Orbit__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Int_ID__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Asset_Type__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Launcher__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Launcher_family__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Description__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Prime_Manufacturer__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Launch_Operator__c+'\n';
        }
        fileBody = Blob.valueOf(updatedFileBody);                
        AssetAttachment=True;
        return null;
    }
}