public class VG_Nordics_PS_Button_Controller{
    
    @AuraEnabled
    public static Policy_Schedule__c getPolicySchedule(Id psId){
        System.debug('Stat::'+psId);
        Policy_Schedule__c ps = [select id, Name, Policy__c, CurrencyIsoCode,VG_Co_Insurance_type__c,VG_Is_Co_Insurance__c, Product__c, Policy__r.MTA_Cancel_List__c, Policy__r.Policy_Status__c, Policy__r.VG_Sub_Status__c, VG_Status__c, VG_MTA_Type__c, VG_MTA_Start_Date__c, VG_Is_MTA__c from Policy_Schedule__c where id=:psId limit 1];
        System.debug('Stat::'+ps);
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
    public static Date getMTAStartdate(Id psId){
        Policy_Schedule__c ps = [select id, Name, Policy__c, CurrencyIsoCode, Product__c, Policy__r.MTA_Cancel_List__c, Policy__r.Policy_Status__c, Policy__r.VG_Sub_Status__c, VG_Status__c, VG_MTA_Type__c, VG_MTA_Start_Date__c, VG_Is_MTA__c from Policy_Schedule__c where id=:psId limit 1];       
        Date MTAStartdate = Date.valueOf(ps.VG_MTA_Start_Date__c);
        return MTAStartdate;
    }
    
    @AuraEnabled
    public static String deletePolicySchedule(Id psId){
        Policy_Schedule__c ps = [select id, Policy__c from Policy_Schedule__c where id=:psId limit 1];
        String policyId = ps.Policy__c;   
        delete ps;
        return policyId;
    }
    
    @AuraEnabled
    Public Static Void createBridgeEnglishQuoteAttachment(Id psId){
        Policy_Schedule__c ps = [select id, Name, Policy__c, Product__c, Policy__r.Policy_Status__c from Policy_Schedule__c where id=:psId limit 1];
        System.debug('Stat2::'+ps); 
        //If(ps.Product__c! = 'Commercial Combined'){   
        VG_Attachment__c customAttachment;
        Attachment attachment = new Attachment();
        PageReference policyPDF;
        policyPDF = Page.VG_English_Quotation_For_Bridge;
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
            attachment.name ='Bridge English Quote Summary'+System.today().format()+'.doc';
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
        //}
    }
    
    @AuraEnabled
    Public Static Void createBridgeSwedishQuoteAttachment(Id psId){
        Policy_Schedule__c ps = [select id, Name, Policy__c, Product__c, Policy__r.Policy_Status__c from Policy_Schedule__c where id=:psId limit 1];
        System.debug('Stat2::'+ps);   
        //If(ps.Product__c != 'Commercial Combined'){
        VG_Attachment__c customAttachment;
        Attachment attachment = new Attachment();
        PageReference policyPDF;
        policyPDF = Page.VG_Swedish_Quotation_For_Bridge;
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
            attachment.name ='Bridge Swedish Quote Summary'+System.today().format()+'.doc';
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
        //}
    }
    
    @AuraEnabled
    Public Static Void createBS_Quote_SheetAttachment(Id psId){
        Policy_Schedule__c ps = [select id, Name, VG_Status__c from Policy_Schedule__c where id=:psId limit 1];
        System.debug('Stat2::'+ps);    
        VG_Attachment__c customAttachment;
        Attachment attachment = new Attachment();
        PageReference policyPDF;
        policyPDF = Page.BS_Quote_Sheet_for_L_FL;
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
            attachment.name ='BS English Quote Sheet  '+System.today().format()+'.doc';
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
    
    @AuraEnabled
    Public Static Void createBS_Swedish_Quote_SheetAttachment(Id psId){
        Policy_Schedule__c ps = [select id, Name, VG_Status__c from Policy_Schedule__c where id=:psId limit 1];
        System.debug('Stat2::'+ps);    
        VG_Attachment__c customAttachment;
        Attachment attachment = new Attachment();
        PageReference policyPDF;
        policyPDF = Page.BS_Quote_Sheet_for_Swedish;
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
            attachment.name ='BS Swedish Quote Sheet  '+System.today().format()+'.doc';
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
    @AuraEnabled
    Public Static Void createBS_Quote_Sheet_P_CC_Attachment(Id psId){
        Policy_Schedule__c ps = [select id, Name, VG_Status__c from Policy_Schedule__c where id=:psId limit 1];
        System.debug('Stat2::'+ps);    
        VG_Attachment__c customAttachment;
        Attachment attachment = new Attachment();
        PageReference policyPDF;
        policyPDF = Page.BS_Quote_Sheet_P_CC;
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
            attachment.name ='BS English Policy Schedule '+System.today().format()+'.doc';
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
    
    @AuraEnabled
    Public Static Void createBS_Swedish_Policy_Schedule_Attachment(Id psId){
        Policy_Schedule__c ps = [select id, Name, VG_Status__c from Policy_Schedule__c where id=:psId limit 1];
        System.debug('Stat2::'+ps);    
        VG_Attachment__c customAttachment;
        Attachment attachment = new Attachment();
        PageReference policyPDF;
        policyPDF = Page.BS_Policy_Schedule_for_Swedish;
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
            attachment.name ='BS Swedish Policy Schedule '+System.today().format()+'.doc';
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
    
    @AuraEnabled
    Public Static Void createBridge_Swedish_InvoiceAttachment(Id psId){
        Policy_Schedule__c ps = [select id, Name, VG_Status__c from Policy_Schedule__c where id=:psId limit 1];
        List<VG_Payment_Frequency__c > InsertedpfList = new List<VG_Payment_Frequency__c >([select id, Name, VG_Comment__c, VG_Is_Temp_Delete__c, VG_GWP_This_Time__c, CurrencyIsoCode, VG_Payment_Percent__c, VG_Due_Date__c, VG_Outstanding_taxes__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.Policy__r.Policy_Status__c from VG_Payment_Frequency__c where VG_Policy_Schedule__c =: psId ORDER BY VG_Due_Date__c ASC ]);                    
        for(VG_Payment_Frequency__c pf:InsertedpfList){  
            VG_Attachment__c customAttachment;
            Attachment attachment = new Attachment();
            PageReference policyPDF;
            policyPDF = Page.VG_Bridge_Swedish_Invoice;
            policyPDF.getParameters().put('Id',psId);
            policyPDF.getParameters().put('PFId',pf.Id);
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
                attachment.name ='Bridge Swedish Invoice '+pf.Name+'-'+System.today().format()+'.doc';
                attachment.parentId = psId;
                Insert attachment;
                System.debug('attachment::'+attachment);
                customAttachment = new VG_Attachment__c();
                customAttachment.VG_Attachment__c = attachment.Id;
                customAttachment.VG_Folder__c = 'Finance';
                customAttachment.VG_Policy_Schedule__c = attachment.parentId;
                customAttachment.Name = attachment.Name;
                Insert customAttachment;
                System.debug('customAttachment::'+customAttachment);
            }
        }
    }
    
    @AuraEnabled
    Public Static Void createBridge_English_InvoiceAttachment(Id psId){
        Policy_Schedule__c ps = [select id, Name, VG_Status__c from Policy_Schedule__c where id=:psId limit 1];
        List<VG_Payment_Frequency__c > InsertedpfList = new List<VG_Payment_Frequency__c >([select id, Name, VG_Comment__c, VG_Is_Temp_Delete__c, VG_GWP_This_Time__c, CurrencyIsoCode, VG_Payment_Percent__c, VG_Due_Date__c, VG_Outstanding_taxes__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.Policy__r.Policy_Status__c from VG_Payment_Frequency__c where VG_Policy_Schedule__c =: psId ORDER BY VG_Due_Date__c ASC ]);        
        for(VG_Payment_Frequency__c pf:InsertedpfList){                       
            VG_Attachment__c customAttachment;
            Attachment attachment = new Attachment();
            PageReference policyPDF;
            policyPDF = Page.VG_Bridge_English_Invoice;
            policyPDF.getParameters().put('Id',psId);
            policyPDF.getParameters().put('PFId',pf.Id);
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
                attachment.name ='Bridge English Invoice '+pf.Name+'-'+System.today().format()+'.doc';
                attachment.parentId = psId;
                Insert attachment;
                System.debug('attachment::'+attachment);
                customAttachment = new VG_Attachment__c();
                customAttachment.VG_Attachment__c = attachment.Id;
                customAttachment.VG_Folder__c = 'Finance';
                customAttachment.VG_Policy_Schedule__c = attachment.parentId;
                customAttachment.Name = attachment.Name;
                Insert customAttachment;
                System.debug('customAttachment::'+customAttachment);
            }
        }
    }
}