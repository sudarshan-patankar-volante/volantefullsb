public class VG_NordicsAssetsUploadController{
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
    public List<Asset__c> NordicsAssetsupload;
    public List < SelectOption > statusOptions {get;set;}
    public String sObjectType {get; set;}
    public String attType {get; set;}
    public Boolean isAttTypeGiven {get; set;}
    public Document templateFile {get; set;}
    Public Account AccName {get; set;}
    
    public VG_NordicsAssetsUploadController(){
        obj = new VG_Attachment__c();
        NordicsAssetsupload=new List<Asset__c>();
        id = apexpages.currentpage().getparameters().get('id');
        sObjectType = apexpages.currentpage().getparameters().get('sObjectType');
        attType = apexpages.currentpage().getparameters().get('attType');       
        templateFile = [Select Id from Document where Name = 'Bridge Asset Upload Template'];        
        if(sObjectType=='Account')
            AccName=[Select Id,Name From Account where Id=:id];
        if(attType == null){
            isAttTypeGiven = False;
        }else{
            isAttTypeGiven = True;
            obj.VG_Attachment_Type__c = attType;
        }
        Id attRecordTypeId = Schema.SObjectType.VG_Attachment__c.getRecordTypeInfosByName().get('Account').getRecordTypeId();
        obj.RecordTypeId = attRecordTypeId;
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
   }
   
   
   public Database.SaveResult saveCustomAttachment(){
            obj.Id = null;
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
            /*if(AttName !=null && AttName != ''){
                System.debug('AttName.length:'+AttName.length()+AttName.left(80));
                if(AttName.length() > 80){
                    System.debug('Hi:'+AttName.left(80));
                    AttName=AttName.left(80);
                }
                String ext =this.fileName.substringAfter('.');
                customAttachment.Name = AttName+'.'+ext;
            }
            else{
                if(fileName.length() > 80){
                    String ext =this.fileName.substringAfter('.');
                    fileName=AttName.left(75)+'.'+ext;
                }
               customAttachment.name = this.fileName;
            }*/
            
            customAttachment.VG_Attachment__c = attachmentResult.getId();
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
            Id NordicsRecordTypeId = Schema.SObjectType.Asset__c.getRecordTypeInfosByName().get('Nordics Property').getRecordTypeId();
            ass.RecordTypeId=NordicsRecordTypeId;
            System.debug('recordtype::'+NordicsRecordTypeId);
          if(headervalues[0]=='Company'){          
            if(inputvalues[0] != '' && inputvalues[0] !=null)
               ass.VG_Company_Division__c=inputvalues[0].trim(); 
            if(inputvalues[1] != '')
                ass.VG_Street__c = inputvalues[1].trim();                
            if(inputvalues[2] != '')   
                ass.VG_Street_Number__c = inputvalues[2].trim();
            if(inputvalues[3] != '')     
                ass.VG_Postal_Code__c = inputvalues[3].trim();
            if(inputvalues[4] != '')
                ass.VG_City__c = inputvalues[4].trim();
            if(inputvalues[5] != '')
                ass.VG_Country__c = inputvalues[5].trim();
            if(inputvalues[6] != '')
                ass.VG_Block_ID__c = inputvalues[6].trim();
            if(inputvalues[7] != '')
                ass.CurrencyIsoCode = inputvalues[7].trim();
            if(inputvalues[8] != '')
                ass.VG_Full_Value_Building_P__c = inputvalues[8].trim();
            if(inputvalues[9] != '')
                ass.VG_Building_SI__c = Decimal.valueOf(inputvalues[9].trim());
            if(inputvalues[10] != '')
                ass.VG_Machinery_SI__c = Decimal.valueOf(inputvalues[10].trim());
            if(inputvalues[11] != '')
                ass.VG_Goods_SI__c = Decimal.valueOf(inputvalues[11].trim());
            if(inputvalues[12] != '')
                ass.VG_Contents_SI__c = Decimal.valueOf(inputvalues[12].trim());
            if(inputvalues[13] != '')
                ass.VG_Customer_Property_SI__c = Decimal.valueOf(inputvalues[13].trim());
            if(inputvalues[14] != '')
                ass.VG_Other_SI__c = Decimal.valueOf(inputvalues[14].trim());
            if(inputvalues[15] != '')
                ass.VG_Total_Business_Interruption_SI__c = Decimal.valueOf(inputvalues[15].trim());
            if(inputvalues[16] != '')
                ass.VG_Total_BISI_for_the_indemnity_period__c = Decimal.valueOf(inputvalues[16].trim());
            if(inputvalues[17] != '')   
                ass.VG_Coverage__c=inputvalues[17].trim();
            if(inputvalues[18] != '')   
                ass.VG_Comment__c=inputvalues[18].trim();
            if(inputvalues[19] != '')
                ass.VG_EML_PD__c=Decimal.valueOf(inputvalues[19].trim());
                if(ass.VG_EML_PD__c==null){
                    ass.VG_EML_PD__c=ass.VG_Customer_Property_SI__c;
                }
            if(inputvalues[20] != '')
                ass.VG_EML_BI__c=Decimal.valueOf(inputvalues[20].trim());
                if(ass.VG_EML_BI__c==null){
                    ass.VG_EML_BI__c=ass.VG_Building_SI__c;
                }
            if(inputvalues[21] != '')
                ass.VG_PD_Deductible__c=Decimal.valueOf(inputvalues[21].trim());
            if(inputvalues[22] != '')
                ass.VG_Waiting_Period__c=inputvalues[22].trim();
            if(inputvalues[23] != '')
                ass.VG_BI_Indemnity_Period__c=inputvalues[23].trim();
            if(inputvalues[24] != '')
                ass.VG_Total_MBBISI_for_the_indemnity_period__c = Decimal.valueOf(inputvalues[24].trim());
                if(inputvalues[25] != '')   
                ass.VG_MB_PD_Deductible__c=Decimal.valueOf(inputvalues[25].trim());
            if(inputvalues[26] != '')   
                ass.VG_MB_Waiting_Period__c=inputvalues[26].trim();
            if(inputvalues[27] != '')
                ass.VG_MB_BI_Indemnity_Period__c=inputvalues[27].trim();
            if(inputvalues[28] != '')
                ass.VG_Automatic_Fire_alarm__c = inputvalues[28].trim();
            if(inputvalues[29] != '')
                ass.VG_Water_sprinklers__c = inputvalues[29].trim();
            if(inputvalues[30] != '')
                ass.VG_Foam_supression_system__c = inputvalues[30].trim();
            if(inputvalues[31] != '')
                ass.VG_Smoke_and_heat_venting_system__c = inputvalues[31].trim();
            if(inputvalues[32] != '')
                ass.VG_Full_time_public_Fire_Brigade_staff__c = inputvalues[32].trim(); if(ass_rt_Map.get(ass.RecordTypeId).getName()=='Nordics Property'){                   
                System.debug('assName::'+ass.RecordType.Name+':'+ass_rt_Map.get(ass.RecordTypeId).getName()+ass.RecordTypeId);               
                ass.Name=ass.VG_Street__c+','+ass.VG_Street_Number__c+','+ass.VG_City__c;
                System.debug('assName::'+ass.Name);
            }
        }else if(headervalues[0]=='SFDC Record Id'){
            if(inputvalues[0] != '')
                ass.id = inputvalues[0].trim();
            if(inputvalues[1] != '' && inputvalues[1] !=null)
               ass.VG_Company_Division__c=inputvalues[1].trim(); 
            if(inputvalues[2] != '')
                ass.VG_Street__c = inputvalues[2].trim();                
            if(inputvalues[3] != '')   
                ass.VG_Street_Number__c = inputvalues[3].trim();
            if(inputvalues[4] != '')     
                ass.VG_Postal_Code__c = inputvalues[4].trim();
            if(inputvalues[5] != '')
                ass.VG_City__c = inputvalues[5].trim();
            if(inputvalues[6] != '')
                ass.VG_Country__c = inputvalues[6].trim();
            if(inputvalues[7] != '')
                ass.VG_Block_ID__c = inputvalues[7].trim();
            if(inputvalues[8] != '')
                ass.CurrencyIsoCode = inputvalues[8].trim();
            if(inputvalues[9] != '')
                ass.VG_Full_Value_Building_P__c = inputvalues[9].trim();
            if(inputvalues[10] != '')
                ass.VG_Building_SI__c = Decimal.valueOf(inputvalues[10].trim());
            if(inputvalues[11] != '')
                ass.VG_Machinery_SI__c = Decimal.valueOf(inputvalues[11].trim());
            if(inputvalues[12] != '')
                ass.VG_Goods_SI__c = Decimal.valueOf(inputvalues[12].trim());
            if(inputvalues[13] != '')
                ass.VG_Contents_SI__c = Decimal.valueOf(inputvalues[13].trim());
            if(inputvalues[14] != '')
                ass.VG_Customer_Property_SI__c = Decimal.valueOf(inputvalues[14].trim());
            if(inputvalues[15] != '')
                ass.VG_Other_SI__c = Decimal.valueOf(inputvalues[15].trim());
            if(inputvalues[16] != '')
                ass.VG_Total_Business_Interruption_SI__c = Decimal.valueOf(inputvalues[16].trim());
            if(inputvalues[17] != '')
                ass.VG_Total_BISI_for_the_indemnity_period__c = Decimal.valueOf(inputvalues[17].trim());
            if(inputvalues[18] != '')   
                ass.VG_Coverage__c=inputvalues[18].trim();
            if(inputvalues[19] != '')   
                ass.VG_Comment__c=inputvalues[19].trim();
            if(inputvalues[20] != '')
                ass.VG_EML_PD__c=Decimal.valueOf(inputvalues[20].trim());
                if(ass.VG_EML_PD__c==null){
                    ass.VG_EML_PD__c=ass.VG_Customer_Property_SI__c;
                }
            if(inputvalues[21] != '')
                ass.VG_EML_BI__c=Decimal.valueOf(inputvalues[21].trim());
                if(ass.VG_EML_BI__c==null){
                    ass.VG_EML_BI__c=ass.VG_Building_SI__c;
                }
            if(inputvalues[22] != '')
                ass.VG_PD_Deductible__c=Decimal.valueOf(inputvalues[22].trim());
            if(inputvalues[23] != '')
                ass.VG_Waiting_Period__c=inputvalues[23].trim();
            if(inputvalues[24] != '')
                ass.VG_BI_Indemnity_Period__c=inputvalues[24].trim();
            if(inputvalues[25] != '')
                ass.VG_Total_MBBISI_for_the_indemnity_period__c = Decimal.valueOf(inputvalues[25].trim());
                if(inputvalues[26] != '')   
                ass.VG_MB_PD_Deductible__c=Decimal.valueOf(inputvalues[26].trim());
            if(inputvalues[27] != '')   
                ass.VG_MB_Waiting_Period__c=inputvalues[27].trim();
            if(inputvalues[28] != '')
                ass.VG_MB_BI_Indemnity_Period__c=inputvalues[28].trim();
            if(inputvalues[29] != '')
                ass.VG_Automatic_Fire_alarm__c = inputvalues[29].trim();
            if(inputvalues[30] != '')
                ass.VG_Water_sprinklers__c = inputvalues[30].trim();
            if(inputvalues[31] != '')
                ass.VG_Foam_supression_system__c = inputvalues[31].trim();
            if(inputvalues[32] != '')
                ass.VG_Smoke_and_heat_venting_system__c = inputvalues[32].trim();
            if(inputvalues[33] != '')
                ass.VG_Full_time_public_Fire_Brigade_staff__c = inputvalues[33].trim(); if(ass_rt_Map.get(ass.RecordTypeId).getName()=='Nordics Property'){                   
                System.debug('assName::'+ass.RecordType.Name+':'+ass_rt_Map.get(ass.RecordTypeId).getName()+ass.RecordTypeId);               
                ass.Name=ass.VG_Street__c+','+ass.VG_Street_Number__c+','+ass.VG_City__c;
                System.debug('assName::'+ass.Name);
            } 
            
        }
        if(ass.VG_Street__c !=null && ass.VG_Street_Number__c!=null && ass.VG_City__c !=null)
        //if(ass.VG_Street__c !=null || ass.VG_Street_Number__c!=null || ass.VG_Postal_Code__c !=null || ass.VG_City__c !=null || ass.VG_Country__c !=null || ass.VG_Block_ID__c != null || ass.CurrencyIsoCode !=null || ass.VG_Building_SI__c !=null || ass.VG_Machinery_SI__c !=null || ass.VG_Contents_SI__c !=null || ass.VG_Customer_Property_SI__c !=null || ass.VG_Other_SI__c !=null || ass.VG_Total_Business_Interruption_SI__c !=null || ass.VG_Full_Value_Building__c !=null || ass.VG_Automatic_Fire_alarm__c !=null || ass.VG_Foam_supression_system__c !=null || ass.VG_Smoke_and_heat_venting_system__c!=null || ass.VG_Full_time_public_Fire_Brigade_staff__c !=null)          
             NordicsAssetsupload.add(ass);
        }
        updatedFileBody = 'SFDC Record Id,Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\n';        
        List<Asset__c> insAss=new List<Asset__c>();
        List<Asset__c> updAss=new List<Asset__c>();
        try{
        for(Asset__c ass:NordicsAssetsupload){
            if(ass.id==null){
                System.debug(':if:');
                ass.VG_Acc_Name_with_St_City__c=AccName.Name+'_'+ass.VG_Street__c+','+ass.VG_Street_Number__c+','+ass.VG_City__c;     
                insAss.add(ass);
            }else{
                System.debug(':else:');
                updAss.add(ass);
            }
        }
        
        if(!insAss.IsEmpty()){
            upsert insAss VG_Acc_Name_with_St_City__c;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Assets created successfully...'));                  
        
        }
        }catch(Exception e){
            AssetAttachment=false;
            if(e.getMessage().contains('Duplicate external id specified')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please check the file ....the combination of Street,Street Number and City already available.'));
                return null;
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error::'+e.getMessage()));
                return null;
            }    
            
        }
        if(!updAss.IsEmpty()){
            try{
                update updAss;
            }catch(Exception e){
                System.debug('Exp::'+e);
            }
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Assets Updated successfully...'));                  
       
        }
        for(Asset__c a : NordicsAssetsupload){ 
            updatedFileBody = updatedFileBody + a.Id;
            updatedFileBody = updatedFileBody + ',' + a.VG_Company_Division__c;                                              
            updatedFileBody = updatedFileBody + ',' + a.VG_Street__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Street_Number__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Postal_Code__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_City__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Country__c;                  
            updatedFileBody = updatedFileBody + ',' + a.VG_Block_ID__c;
            updatedFileBody = updatedFileBody + ',' + a.CurrencyIsoCode;
            updatedFileBody = updatedFileBody + ',' + a.VG_Full_Value_Building_P__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Building_SI__c;                                  
            updatedFileBody = updatedFileBody + ',' + a.VG_Machinery_SI__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Goods_SI__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Contents_SI__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Customer_Property_SI__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Other_SI__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Total_Business_Interruption_SI__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Total_BISI_for_the_indemnity_period__c ;
            updatedFileBody = updatedFileBody + ',' + a.VG_Coverage__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Comment__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_EML_PD__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_EML_BI__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_PD_Deductible__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Waiting_Period__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_BI_Indemnity_Period__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_MB_PD_Deductible__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_MB_Waiting_Period__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_MB_BI_Indemnity_Period__c;          
            updatedFileBody = updatedFileBody + ',' + a.VG_Automatic_Fire_alarm__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Water_sprinklers__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Foam_supression_system__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Smoke_and_heat_venting_system__c;
            updatedFileBody = updatedFileBody + ',' + a.VG_Full_time_public_Fire_Brigade_staff__c+'\n';
            
        }
        fileBody = Blob.valueOf(updatedFileBody);                
        AssetAttachment=True;
        return null;
    }                  
}