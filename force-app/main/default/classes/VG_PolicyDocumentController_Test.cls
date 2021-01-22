@IsTest(SeeAllData=false)
public class VG_PolicyDocumentController_Test {
    public Static Testmethod Void method1(){
        SystemConstants__c cs = new SystemConstants__c();
        cs.Name='Latest Policy Name';
        cs.DocumentId__c = 'Reset';
        Insert cs;
        Policy_Record_Type__c prt = new Policy_Record_Type__c ();
        prt.Name='Edison Motor';
        prt.Code__c = 'EM';
        Insert prt;
        Policy_LOB__c lob = new Policy_LOB__c();
        lob.Name='Motor';
        lob.Code__c = 'MTR';
        Insert lob;
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        ps.VG_Current_Plan_Rate__c='USD';
        ps.CurrencyIsoCode='GBP';
        ps.VG_Status__c='Draft';
        Insert ps;
        Attachment att=new Attachment();
        att.Name='Test';
        att.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Date Added,Date Deleted,Status \nRM 1234,Honda,Accord,200.05,0.5,5,20/11/2017,22/11/2017,Active \n');      
        att.ParentId=pol.id;
        Insert att;
        VG_Attachment__c cusAtt=new VG_Attachment__c();
        cusAtt.Name='Test';
        cusAtt.VG_Folder__c='Underwriting';
        cusAtt.VG_Policy__c=pol.id;
        cusAtt.VG_Attachment__c=att.id;
        Insert cusAtt;
        VG_PolicyDocumentController.getPolicyAttachments('Underwriting',pol.id);
        VG_PolicyDocumentController.getAttachment(att.id);
        VG_PolicyDocumentController.getUserDocRepoList();
    }
    
    public Static Testmethod Void method2(){
        SystemConstants__c cs = new SystemConstants__c();
        cs.Name='Latest Policy Name';
        cs.DocumentId__c = 'Reset';
        Insert cs;
        Policy_Record_Type__c prt = new Policy_Record_Type__c ();
        prt.Name='Edison Motor';
        prt.Code__c = 'EM';
        Insert prt;
        Policy_LOB__c lob = new Policy_LOB__c();
        lob.Name='Motor';
        lob.Code__c = 'MTR';
        Insert lob;
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        ps.VG_Current_Plan_Rate__c='USD';
        ps.CurrencyIsoCode='GBP';
        ps.VG_Status__c='Draft';
        Insert ps;
        Attachment att=new Attachment();
        att.Name='Test';
        att.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Date Added,Date Deleted,Status \nRM 1234,Honda,Accord,200.05,0.5,5,20/11/2017,22/11/2017,Active \n');      
        att.ParentId=pol.id;
        Insert att;
        VG_Attachment__c cusAtt=new VG_Attachment__c();
        cusAtt.Name='Test';
        cusAtt.VG_Folder__c='Underwriting';
        cusAtt.VG_Policy__c=pol.id;
        cusAtt.VG_Attachment__c=att.id;
        Insert cusAtt;
        VG_PolicyDocumentController.getPolicyAttachments('Policy Documentation',pol.id);
        VG_PolicyDocumentController.getPolicyAttachments('Pricing Spreadsheet',pol.id);
        VG_PolicyDocumentController.getAttachment(att.id);
        VG_PolicyDocumentController.insertAttachment(pol.id, 'Test;', 'Policy Documentation', att.Id);
        
    }
    /*public Static Testmethod Void method3(){
        Account acc1=new Account();
        acc1.Name='Test ACC';
        acc1.RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Volante Team').getRecordTypeId();
        acc1.Industry='Energy';
        acc1.ShippingStreet='Test Street';
        acc1.ShippingCity='Test City';
        acc1.ShippingCountry='TC';
        acc1.Phone='9876543210';
        Insert acc1;
        Contact con=VG_TU.createContact(acc1);
        Id p = [select id from profile where name='UMR Partner Community'].id;
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                timezonesidkey='America/Los_Angeles', username='UMRPartneruser@noemail.com');
       
        insert user;
        
        system.runAs(user) {
        }
            SystemConstants__c cs = new SystemConstants__c();
            cs.Name='Latest Policy Name';
            cs.DocumentId__c = 'Reset';
            Insert cs;
            Policy_Record_Type__c prt = new Policy_Record_Type__c ();
            prt.Name='Edison Motor';
            prt.Code__c = 'EM';
            Insert prt;
            Policy_LOB__c lob = new Policy_LOB__c();
            lob.Name='Motor';
            lob.Code__c = 'MTR';
            Insert lob;
            Account acc=VG_TU.createAccount('Customer');
            Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
            Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
            ps.Policy__c=pol.id;
            ps.VG_Current_Plan_Rate__c='USD';
            ps.CurrencyIsoCode='GBP';
            ps.VG_Status__c='Draft';
            Insert ps;
            Attachment att=new Attachment();
            att.Name='Test';
            att.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Date Added,Date Deleted,Status \nRM 1234,Honda,Accord,200.05,0.5,5,20/11/2017,22/11/2017,Active \n');      
            att.ParentId=pol.id;
            Insert att;
            VG_Attachment__c cusAtt=new VG_Attachment__c();
            cusAtt.Name='Test';
            cusAtt.VG_Folder__c='Underwriting';
            cusAtt.VG_Policy__c=pol.id;
            cusAtt.VG_Attachment__c=att.id;
            Insert cusAtt;
            VG_PolicyDocumentController.getPolicyAttachments('Policy Documentation',pol.id);
            VG_PolicyDocumentController.getPolicyAttachments('Pricing spreashsheet',pol.id);
            VG_PolicyDocumentController.getPolicyAttachments('Finance',pol.id);
            VG_PolicyDocumentController.getAttachment(att.id);
    }*/
}