public class VG_Horizon_PS_Button_Controller {
    @AuraEnabled
    public static Policy_Schedule__c getPolicySchedule(Id psId){
        Policy_Schedule__c ps = [select id, Name, CreatedBy.Name, CurrencyIsoCode,VG_Capacity_Paper__c, Policy__c,Policy__r.VG_Is_Renewal__c, Policy__r.MTA_Cancel_List__c, Policy__r.Policy_Status__c, Policy__r.VG_Sub_Status__c, VG_Status__c, VG_MTA_Type__c, VG_Is_MTA__c, Product__c from Policy_Schedule__c where id=:psId limit 1];
        return ps;
    }
    
    @AuraEnabled
    public static String getCurrentUser(){
        String user = UserInfo.getName();
        return user;
    }
    
    @AuraEnabled
    public static void bookPolicySchedule(Id psId){
        Policy_Schedule__c ps = new Policy_Schedule__c();
        ps.id = psId;
        ps.VG_Status__c = 'Booked';
        update ps;
    }
    
    @AuraEnabled
    public static String deletePolicySchedule(Id psId){
        Policy_Schedule__c ps = [select id, Policy__c from Policy_Schedule__c where id=:psId limit 1];
        String policyId = ps.Policy__c;   
        delete ps;
        return policyId;
    }
    
    @AuraEnabled
    Public Static Void createHorizonQuoteAttachment(Id psId){
        Policy_Schedule__c ps = [select id, Name, VG_Status__c from Policy_Schedule__c where id=:psId limit 1];
        System.debug('Stat2::'+ps);    
        VG_Attachment__c customAttachment;
        Attachment attachment = new Attachment();
        PageReference policyPDF;
        policyPDF = Page.VG_Horizon_Quote;
        policyPDF.getParameters().put('Id',psId);
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
            attachment.name = 'Horizon Quote '+System.today().format()+'.doc';
            attachment.parentId = psId;
            Insert attachment;
            System.debug('attachment::'+attachment);
            customAttachment = new VG_Attachment__c();
            customAttachment.VG_Attachment__c = attachment.Id;
            customAttachment.VG_Folder__c = 'Policy Documentation';
            customAttachment.VG_Policy_Schedule__c = attachment.parentId;
            customAttachment.Name = attachment.Name;
            Insert customAttachment;
            System.debug('customAttachment::'+customAttachment);
        }
    }
}