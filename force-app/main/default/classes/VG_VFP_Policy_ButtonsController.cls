public with sharing class VG_VFP_Policy_ButtonsController {
    @AuraEnabled
    public static List<Policy__c> getPolicyStatus(Id polId){
        List<Policy__c> polList=new List<Policy__c>();
        Policy__c pol=[select id,Name,Policy_Status__c,VG_Sub_Status__c,VG_Is_Renewal__c,CurrencyIsoCode,VG_Renewal_Policy_Id__c,Insured__c,MTA_Cancel_List__c from Policy__c where id=:polId limit 1];
        polList.add(pol);
        if(pol.VG_Renewal_Policy_Id__c!=null){
            Policy__c renewalPol=[select id,Name,Policy_Status__c,VG_Is_Renewal__c,CurrencyIsoCode,VG_Renewal_Policy_Id__c,Insured__c,MTA_Cancel_List__c from Policy__c where id=:pol.VG_Renewal_Policy_Id__c limit 1];
            polList.add(renewalPol);
        }
        return polList;
    }
    
    @AuraEnabled
    public static String createRenewalPolicy(Id policyId){
        return VG_RenewalController.createRenewalPolicy(policyId,'VFP');
        
    }
    
    @AuraEnabled
    public static Id getBasePolicy(Id polId){
        Policy__c pol = [select id, Name, Policy_Status__c, CurrencyIsoCode, VG_Renewal_Policy_Id__c, Insured__c, VG_Is_Renewal__c, MTA_Cancel_List__c from Policy__c where VG_Renewal_Policy_Id__c=:polId limit 1];
        System.debug('polid:'+pol.id);
        return pol.id;
    }
    
    @AuraEnabled
    Public Static Void createVSR_Quote_SheetAttachment(Id polId){
        Policy__c pol = [select id, Name, Policy_Status__c, CurrencyIsoCode, VG_Renewal_Policy_Id__c, Insured__c, VG_Is_Renewal__c, MTA_Cancel_List__c from Policy__c where Id=:polId limit 1];
        VG_Attachment__c customAttachment;
        Attachment attachment = new Attachment();
        PageReference policyPDF;
        policyPDF = Page.VG_VFP_VSR_Quote;
        policyPDF.getParameters().put('Id',polId);
        policyPDF.setRedirect(true);
        if(policyPDF != null){
            Blob body;
            if(!test.isRunningTest()){
                body = policyPDF.getContent();//policyPDF.getContentAsPDF();
            }else{
                body = blob.valueof('TEST');
            }
            //body = policyPDF.getContentAsPDF();
            System.debug('Body is:'+body);
            attachment.body = body;
            attachment.name ='VFP VSR Quote'+System.today().format()+'.doc';                   
            attachment.parentId = polId;
            Insert attachment;
            System.debug('attachment::'+attachment);
            
            //Get attachment
            Attachment attach = [SELECT Id, OwnerId, Name, Body, ContentType, ParentId From Attachment WHERE ID=:attachment.id LIMIT 1];
            
            //Insert ContentVersion
            ContentVersion cVersion = new ContentVersion();
            cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
            cVersion.PathOnClient = attach.Name;//File name with extention
            cVersion.Origin = 'C';//C-Content Origin. H-Chatter Origin.
            cVersion.OwnerId = attach.OwnerId;//Owner of the file
            cVersion.Title = attach.Name;//Name of the file
            cVersion.VersionData = attach.Body;//File content
            Insert cVersion;
            
            //After saved the Content Verison, get the ContentDocumentId
            Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
            
            //Insert ContentDocumentLink
            ContentDocumentLink cDocLink = new ContentDocumentLink();
            cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
            cDocLink.LinkedEntityId = attach.ParentId;//Add attachment parentId
            cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
            cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
            Insert cDocLink;
            
            customAttachment = new VG_Attachment__c();
            customAttachment.VG_Attachment__c = cVersion.Id;
            customAttachment.VG_Folder__c = 'Policy Documentation';
            customAttachment.VG_Policy__c= attachment.parentId;
            customAttachment.Name = attachment.Name;
            Insert customAttachment;
            delete attach;
        }
    }
    
    @AuraEnabled
    Public Static Void createVSR_Schedule_SheetAttachment(Id polId){
        Policy__c pol = [select id, Name, Policy_Status__c, CurrencyIsoCode, VG_Renewal_Policy_Id__c, Insured__c, VG_Is_Renewal__c, MTA_Cancel_List__c from Policy__c where Id=:polId limit 1];
        VG_Attachment__c customAttachment;
        Attachment attachment = new Attachment();
        PageReference policyPDF;
        policyPDF = Page.VG_VFP_VSR_Schedule;
        policyPDF.getParameters().put('Id',polId);
        policyPDF.setRedirect(true);
        if(policyPDF != null){
            Blob body;
            if(!test.isRunningTest()){
                body = policyPDF.getContent();//policyPDF.getContentAsPDF();
            }else{
                body = blob.valueof('TEST');
            }
            //body = policyPDF.getContentAsPDF();
            System.debug('Body is:'+body);
            attachment.body = body;
            attachment.name ='VFP VSR Schedule'+System.today().format()+'.doc';                   
            attachment.parentId = polId;
            Insert attachment;
            System.debug('attachment::'+attachment);
            
            //Get attachment
            Attachment attach = [SELECT Id, OwnerId, Name, Body, ContentType, ParentId From Attachment WHERE ID=:attachment.id LIMIT 1];
            
            //Insert ContentVersion
            ContentVersion cVersion = new ContentVersion();
            cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
            cVersion.PathOnClient = attach.Name;//File name with extention
            cVersion.Origin = 'C';//C-Content Origin. H-Chatter Origin.
            cVersion.OwnerId = attach.OwnerId;//Owner of the file
            cVersion.Title = attach.Name;//Name of the file
            cVersion.VersionData = attach.Body;//File content
            Insert cVersion;
            
            //After saved the Content Verison, get the ContentDocumentId
            Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
            
            //Insert ContentDocumentLink
            ContentDocumentLink cDocLink = new ContentDocumentLink();
            cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
            cDocLink.LinkedEntityId = attach.ParentId;//Add attachment parentId
            cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
            cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
            Insert cDocLink;
            
            customAttachment = new VG_Attachment__c();
            customAttachment.VG_Attachment__c = cVersion.Id;
            customAttachment.VG_Folder__c = 'Policy Documentation';
            customAttachment.VG_Policy__c= attachment.parentId;
            customAttachment.Name = attachment.Name;
            Insert customAttachment;
            delete attach;
        }
    }
}