@isTest(SeeAllData = false)
Public Class VG_BulkAssetsUploadController_Test{
    public static testMethod void TestMethod7() {
        Document d=new Document();
        d.Name='Asset Upload Template';
        d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test \nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test2 \n');      
        d.FolderId='0050O0000078Mug';
        Insert d;
        Account acc=VG_TU.createAccount('Customer');          
        ApexPages.currentPage().getParameters().put('attType', 'Assets File');
        ApexPages.currentPage().getParameters().put('id', acc.Id);
        ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
        ApexPages.currentPage().getParameters().put('ParentId', acc.id);     
        VG_BulkAssetsUploadController bac=new VG_BulkAssetsUploadController();
        bac.fileBody=d.Body;
        bac.fileName='Unit Test Attachment.this is attachment';
        
        VG_BulkAssetsUploadController.coverCatchBlocks=true;
        bac.processUpload();
        //below code cover savecustomattachment() else part
        bac.sObjectType=null;
        bac.saveCustomAttachment();
        //above  code cover savecustomattachment() else part
    }
    public static testMethod void TestMethod8() {
        Document d=new Document();
        d.Name='Asset Upload Template';
        d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test\n,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test2 \n');      
        d.FolderId='0050O0000078Mug';
        Insert d;
        Account acc=VG_TU.createAccount('Customer');          
        ApexPages.currentPage().getParameters().put('attType', 'Assets File');
        ApexPages.currentPage().getParameters().put('id', acc.Id);
        ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
        ApexPages.currentPage().getParameters().put('ParentId', acc.id);     
        VG_BulkAssetsUploadController bac=new VG_BulkAssetsUploadController();
        bac.fileBody=d.Body;
        bac.fileName='Unit Test Attachment';
        VG_BulkAssetsUploadController.coverCatchBlocks=true;
        bac.processUpload();
    }
    
    public static testMethod void TestMethod1() {
        VG_BulkAssetsUploadController controller;        
        PageReference pageRef = Page.VG_BulkAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Asset Upload Template';
            d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test \n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_BulkAssetsUploadController();
            controller.fileName='Unit Test Attachment.jps';
            controller.description='Test description';
            controller.fileName='Unit Test Attachmentthis is attachmenttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
        	controller.AttName='Unit Test Attachmentthis is attachmenttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
            controller.fileBody = Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number \nRM 1234,Honda,Accord,2000,0.5,5,,,20/11/2017,,Active,Test\n');      
            controller.processUpload();
            controller.back();
        }catch(Exception e){
            System.debug('Error::'+e);
        }
    }
   public static testMethod void TestMethod21() {
        VG_BulkAssetsUploadController controller;        
        PageReference pageRef = Page.VG_BulkAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Asset Upload Template';
            d.Body=Blob.valueOf('Registration Number \n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');              
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_BulkAssetsUploadController();  
            controller.nameFile='TestAtt.xlsx';
            controller.ReadFile();
            controller.back();
        }catch(Exception e){
            System.debug('Error::'+e);           
        }
    }
    public static testMethod void TestMethod2() {
        VG_BulkAssetsUploadController controller;        
        PageReference pageRef = Page.VG_BulkAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Asset Upload Template';
            d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('attType', 'TOBA');
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_BulkAssetsUploadController();
            
            controller.fileName='Unit Test Attachment';
            controller.fileBody = Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test \n');               
            controller.processUpload();
            controller.back();
        }catch(Exception e){
            System.debug(e);
        }
    }
    
    
    public static testMethod void TestMethod3() {
        VG_BulkAssetsUploadController controller;        
        PageReference pageRef = Page.VG_BulkAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Asset Upload Template';
            d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc = VG_TU.createAccount('Customer');
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
            Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
            ApexPages.currentPage().getParameters().put('id', pol.Id);
            ApexPages.currentPage().getParameters().put('attType', 'null');
            ApexPages.currentPage().getParameters().put('sObjectType', 'Policy__c');           
            ApexPages.currentPage().getParameters().put('ParentId', pol.id);
            controller = new VG_BulkAssetsUploadController();
            controller.fileName='Unit Test Attachment.jps';
            Controller.AttName='Unit Test Attachmentthis is attachmenttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt.jpg';
            controller.description='Test description';
            controller.fileBody = Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test \n');                   
            controller.processUpload();
            controller.back();
        }catch(Exception e){
            System.debug(e);
        }
    }
    public static testMethod void TestMethod4() {
        VG_BulkAssetsUploadController controller;        
        PageReference pageRef = Page.VG_BulkAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{   
            Document d=new Document();
            d.Name='Asset Upload Template';
            d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;            
            controller = new VG_BulkAssetsUploadController();
            controller.processUpload();
            controller.back();
        }catch(Exception e){
            System.debug(e);
        }
    }
    public static testMethod void TestMethod5() {
        VG_BulkAssetsUploadController controller;        
        PageReference pageRef = Page.VG_BulkAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{    
            Document d=new Document();
            d.Name='Asset Upload Template';
            d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);           
            controller = new VG_BulkAssetsUploadController();
            VG_BulkAssetsUploadController.coverCatchBlocks=true;
            controller.fileName='Unit Test Attachment.jps';
            controller.fileBody = Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\n RM 1234,Honda,Accord,Vehicle CC,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test \n RM 1234,Honda,Accord,3000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test2\n');                   
            
            controller.processUpload();
            controller.back();
        }catch(Exception e){
            System.debug(e);
        }
    }
    public static testMethod void TestMethod6() {
        VG_BulkAssetsUploadController controller;        
        PageReference pageRef = Page.VG_BulkAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Asset Upload Template';
            d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('attType', 'Assets File');
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_BulkAssetsUploadController();
            controller.fileName='Unit Test Attachment';
            controller.fileBody = Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test\n');               
            controller.processUpload();
            controller.back();
            Attachment att=[select id,Name,body from Attachment where ParentId=:acc.id limit 1];
            controller.fileBody =att.Body;
            controller.processUpload();
        }catch(Exception e){
            System.debug(e);
        }
    }
    public static testMethod void TestMethod9() {
        VG_BulkAssetsUploadController controller;        
        PageReference pageRef = Page.VG_BulkAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Asset Upload Template';
            d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test \n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('attType', 'Assets File');
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_BulkAssetsUploadController();
            controller.fileName='Unit Test Attachmentthis is attachmenttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt';
            controller.fileBody = Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test \n');               
            controller.processUpload();
            controller.back();
            Asset__c ass=[select id,Name from Asset__c where VG_Account__c=:acc.id limit 1];
            String body='SFDC Record Id,Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number \n'+ass.id+',RM 1234,Honda,Accord,2200,0.5,5,Business Use – Class 2,M6 - Third Party Only,,,Active,Test \n';
            controller.BulkAssetsupload.clear();
            controller.fileBody =blob.valueOf(body);
            controller.processUpload();
        }catch(Exception e){
            System.debug(e);
        }
    }
    public static testMethod void TestMethod10() {
        VG_BulkAssetsUploadController controller;        
        PageReference pageRef = Page.VG_BulkAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Asset Upload Template';
            d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('attType', 'Assets File');
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_BulkAssetsUploadController();
            controller.fileName='Unit Test Attachment';
            controller.fileBody = Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,CC,GVW,Seats,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test\n');               
            controller.processUpload();
            controller.back();
            Attachment att=[select id,Name,body from Attachment where ParentId=:acc.id limit 1];
            controller.fileBody =att.Body;
            controller.processUpload();
        }catch(Exception e){
            System.debug(e);
        }
    }
    public static testMethod void TestMethod11() {
        VG_BulkAssetsUploadController controller;        
        PageReference pageRef = Page.VG_BulkAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Asset Upload Template';
            d.Body=Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test \n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('attType', 'Assets File');
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_BulkAssetsUploadController();
            controller.fileName='Unit Test Attachment';
            controller.fileBody = Blob.valueOf('Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number\nRM 1234,Honda,Accord,2000,0.5,5,Business Use – Class 2,M6 - Third Party Only,20/11/2017,20/11/2018,Active,Test \n');               
            controller.processUpload();
            controller.back();
            Asset__c ass=[select id,Name from Asset__c where VG_Account__c=:acc.id limit 1];
            String body='SFDC Record Id,Registration Number,Make,Model,CC,GVW,Seats,Use,Cover,Date Added,Date Deleted,Status,Policy Number \n'+ass.id+',RM 1234,Honda,Accord,CC,GVW,Seats,Business Use – Class 2,M6 - Third Party Only,,,Active,Test \n';
            controller.BulkAssetsupload.clear();
            controller.fileBody =blob.valueOf(body);
            controller.processUpload();
        }catch(Exception e){
            System.debug(e);
        }
    }
}