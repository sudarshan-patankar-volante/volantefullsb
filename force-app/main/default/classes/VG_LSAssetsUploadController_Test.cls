@IsTest(SeeAllData=False)
public class VG_LSAssetsUploadController_Test {
       public static testMethod void TestMethod6() {
        VG_LSAssetsUploadController controller;        
        PageReference pageRef = Page.VG_LSAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='LS Asset Upload Template';
            d.Body=Blob.valueOf('Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no\n14,4500.00,KK St,627811,IN,567\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('attType', 'Assets File');
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_LSAssetsUploadController();
            controller.fileName='Unit Test Attachment';
            controller.fileBody = Blob.valueOf('Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no\n15,4500,KC St,567895,US,567\n');               
            controller.processUpload();
            controller.back();
            Attachment att=[select id,Name,body from Attachment where ParentId=:acc.id limit 1];
            controller.fileBody =att.Body;
            controller.processUpload();
        }catch(Exception e){
            System.debug(e);
        }
    }   
    public static testMethod void TestMethod1() {
        VG_LSAssetsUploadController controller;        
        PageReference pageRef = Page.VG_LSAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='LS Asset Upload Template';
            d.Body=Blob.valueOf('Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no\n14,4500.00,KK St,627811,IN,567\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('attType', 'Assets File');
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_LSAssetsUploadController();
            controller.ReadFile();
            controller.fileName='Unit Test Attachment';
            controller.fileBody = Blob.valueOf('Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no\n14,4500.00,KK St,627811,IN,567\n');               
            controller.processUpload();
            controller.back();
            Asset__c ass=[select id,Name from Asset__c where VG_Account__c=:acc.id limit 1];
            String body='SFDC Record Id,Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no\n'+ass.id+',14,4580.40,KK St,627811,IN,567\n';
            controller.LSAssetsupload.clear();
            controller.fileBody =blob.valueOf(body);
            controller.processUpload();
        }catch(Exception e){
            System.debug(e);
        }
    }
    
    public static testMethod void TestMethod7() {
        Document d=new Document();
        d.Name='LS Asset Upload Template';
        d.Body=Blob.valueOf('Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no \n');      
        d.FolderId='0050O0000078Mug';
        Insert d;
        Account acc=VG_TU.createAccount('Customer');          
        ApexPages.currentPage().getParameters().put('attType', 'Assets File');
        ApexPages.currentPage().getParameters().put('id', acc.Id);
        ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
        ApexPages.currentPage().getParameters().put('ParentId', acc.id);     
        VG_LSAssetsUploadController lsa=new VG_LSAssetsUploadController();
        lsa.fileBody=d.Body;
        lsa.fileName='Unit Test Attachment.this is attachment';
        
        VG_LSAssetsUploadController.coverCatchBlocks=true;
        lsa.processUpload();
        //below code cover savecustomattachment() else part
        lsa.sObjectType=null;
        lsa.saveCustomAttachment();
        //above  code cover savecustomattachment() else part
    }
    public static testMethod void TestMethod8() {
        Document d=new Document();
        d.Name='LS Asset Upload Template';
        d.Body=Blob.valueOf('Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no\n');      
        d.FolderId='0050O0000078Mug';
        Insert d;
        Account acc=VG_TU.createAccount('Customer');          
        ApexPages.currentPage().getParameters().put('attType', 'Assets File');
        ApexPages.currentPage().getParameters().put('id', acc.Id);
        ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
        ApexPages.currentPage().getParameters().put('ParentId', acc.id);     
        VG_LSAssetsUploadController lsa=new VG_LSAssetsUploadController();
        lsa.fileBody=d.Body;
        lsa.fileName='Unit Test Attachment';
        VG_LSAssetsUploadController.coverCatchBlocks=true;
        lsa.processUpload();
        lsa.ReadFile();
    } 
  
  public static testMethod void TestMethod3() {
        VG_LSAssetsUploadController controller;        
        PageReference pageRef = Page.VG_LSAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='LS Asset Upload Template';
            d.Body=Blob.valueOf('Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no\n14,4500.00,KK St,627811,IN,567\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc = VG_TU.createAccount('Customer');
            SystemConstants__c cs = new SystemConstants__c();
            cs.Name='Latest Policy Name';
            cs.DocumentId__c = 'Reset';
            Insert cs;
            Policy_Record_Type__c prt = new Policy_Record_Type__c ();
            prt.Name='Affinity';
            prt.Code__c = 'EM';
            Insert prt;
            Policy_LOB__c lob = new Policy_LOB__c();
            lob.Name='Motor';
            lob.Code__c = 'MTR';
            Insert lob;
            Policy__c pol=VG_TU.createPolicy('Affinity', acc.id);
            ApexPages.currentPage().getParameters().put('id', pol.Id);
            ApexPages.currentPage().getParameters().put('attType', 'null');
            ApexPages.currentPage().getParameters().put('sObjectType', 'Policy__c');           
            ApexPages.currentPage().getParameters().put('ParentId', pol.id);
            controller = new VG_LSAssetsUploadController();
            controller.fileName='Unit Test Attachment.jps';
            Controller.AttName='Unit Test Attachmentthis is attachmenttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt.jpg';
            controller.description='Test description';
            controller.fileBody = Blob.valueOf('Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no\n14,4500.00,KK St,627811,IN,567\n');                   
            controller.processUpload();
            controller.back();
        }catch(Exception e){
            System.debug(e);
        }
    }
    public static testMethod void TestMethod2() {
        VG_LSAssetsUploadController controller;        
        PageReference pageRef = Page.VG_LSAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='LS Asset Upload Template';
            d.Body=Blob.valueOf('Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no\n14,4500.00,KK St,627811,IN,567\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('attType', 'TOBA');
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_LSAssetsUploadController();
            
            controller.fileName='Unit Test Attachment';
            controller.fileBody = Blob.valueOf('Total Material Damage,Total Business Interruption,Street,Postal Code,Country,Bulding no \n14,4500.00,KK St,627811,IN,567\n');               
            controller.processUpload();
            controller.back();
        }catch(Exception e){
            System.debug(e);
        }
    }
   
}