public class VG_LS_Policy_ButtonsController {
    
    @AuraEnabled
    public static List<Policy__c> getPolicyStatus(Id polId){
        List<Policy__c> polList=new List<Policy__c>();
        Policy__c pol=[select id,Name,Policy_Status__c,VG_Is_Renewal__c,CurrencyIsoCode,VG_Renewal_Policy_Id__c,Insured__c,MTA_Cancel_List__c from Policy__c where id=:polId limit 1];
        polList.add(pol);
        if(pol.VG_Renewal_Policy_Id__c!=null){
            Policy__c renewalPol=[select id,Name,Policy_Status__c,VG_Is_Renewal__c,CurrencyIsoCode,VG_Renewal_Policy_Id__c,Insured__c,MTA_Cancel_List__c from Policy__c where id=:pol.VG_Renewal_Policy_Id__c limit 1];
            polList.add(renewalPol);
        }
        return polList;
    }
    
    @AuraEnabled
    Public Static Void createLSScheduleAttachment(Id polId){
        Policy__c pol=[select id,Name,Policy_Status__c from Policy__c where id=:polId limit 1];
        System.debug('Stat2::'+pol);    
        VG_Attachment__c customAttachment;
        Attachment attachment= new Attachment();
        PageReference policyPDF;
        policyPDF = Page.VG_LS_Schedule;
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
            attachment.name ='LS Schedule '+System.today().format()+'.doc';
            attachment.parentId = polId;
            Insert attachment;
            System.debug('attachment::'+attachment);
            customAttachment = new VG_Attachment__c();
            customAttachment.VG_Attachment__c = attachment.Id;
            customAttachment.VG_Folder__c='Policy Documentation';
            customAttachment.VG_Policy__c=attachment.parentId;
            customAttachment.Name = attachment.Name;
            Insert customAttachment;
            System.debug('customAttachment::'+customAttachment);
        }
    }
    
    @AuraEnabled
    Public Static Void createLSQuoteAttachment(Id polId){
        Policy__c pol=[select id,Name,Policy_Status__c from Policy__c where id=:polId limit 1];
        System.debug('Stat2::'+pol);    
        VG_Attachment__c customAttachment;
        Attachment attachment= new Attachment();
        PageReference policyPDF;
        policyPDF = Page.VG_LS_Quote;
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
            attachment.name ='LS Quote '+System.today().format()+'.doc';
            attachment.parentId = polId;
            Insert attachment;
            System.debug('attachment::'+attachment);
            customAttachment = new VG_Attachment__c();
            customAttachment.VG_Attachment__c = attachment.Id;
            customAttachment.VG_Folder__c='Policy Documentation';
            customAttachment.VG_Policy__c=attachment.parentId;
            customAttachment.Name = attachment.Name;
            Insert customAttachment;
            System.debug('customAttachment::'+customAttachment);
        }
    }
    
    @AuraEnabled
    Public Static Void createLSStatementAttachment(Id polId){
        Policy__c pol=[select id,Name,Policy_Status__c from Policy__c where id=:polId limit 1];
        System.debug('Stat2::'+pol);    
        VG_Attachment__c customAttachment;
        Attachment attachment= new Attachment();
        PageReference policyPDF;
        policyPDF = Page.VG_LS_Statement_of_Fact;
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
            attachment.name ='LS Statement '+System.today().format()+'.doc';
            attachment.parentId = polId;
            Insert attachment;
            System.debug('attachment::'+attachment);
            customAttachment = new VG_Attachment__c();
            customAttachment.VG_Attachment__c = attachment.Id;
            customAttachment.VG_Folder__c='Policy Documentation';
            customAttachment.VG_Policy__c=attachment.parentId;
            customAttachment.Name = attachment.Name;
            Insert customAttachment;
            System.debug('customAttachment::'+customAttachment);
        }
    }
    
    @AuraEnabled
    public static String createRenewalPolicy(Id policyId){
        return  VG_RenewalController.createRenewalPolicy(policyId,'Affinity');
    }
    
    @AuraEnabled
    public static Id getBasePolicy(Id polId){
        Policy__c pol = [select id, Name, Policy_Status__c, CurrencyIsoCode, VG_Renewal_Policy_Id__c, Insured__c, VG_Is_Renewal__c, MTA_Cancel_List__c from Policy__c where VG_Renewal_Policy_Id__c=:polId limit 1];
        System.debug('polid:'+pol.id);
        return pol.id;
    }
}