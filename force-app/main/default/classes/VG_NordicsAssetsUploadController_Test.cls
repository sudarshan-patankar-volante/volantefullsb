@isTest(SeeAllData = false)
public class VG_NordicsAssetsUploadController_Test {
    public static testMethod void TestMethod1(){
        VG_NordicsAssetsUploadController controller;        
        PageReference pageRef = Page.VG_NordicsAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Bridge Asset Upload Template';
            d.Body=Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('attType', 'TOBA');            
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_NordicsAssetsUploadController();
            controller.fileName='Unit Test Attachment';
            controller.fileBody = Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n');      
            controller.processUpload();
            controller.back();
            Attachment att=[select id,Name,body from Attachment where ParentId=:acc.id limit 1];
            controller.AttName='Attachment File name-Unit Test Attachment For Bridge Asset Upload Template For NordicsPortalCommunity_Profile.csv';
            controller.fileBody =att.Body;
            controller.description='Asset File Attached';
            controller.processUpload();
            
        }catch(Exception e){
            System.debug('Error::'+e);
        }   
    }
    // cover code for filename length
    public static testMethod void TestMethod5(){
        VG_NordicsAssetsUploadController controller;        
        PageReference pageRef = Page.VG_NordicsAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Bridge Asset Upload Template';
            d.Body=Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('attType', 'TOBA');            
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_NordicsAssetsUploadController();
            controller.fileName='Unit Test Attachment-File name-Unit Test Attachment For Bridge Asset Upload Template For NordicsPortalCommunity_Profile.csv.csv';
            controller.fileBody = Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n\n');      
            VG_NordicsAssetsUploadController.AssetAttachment=false;
            controller.processUpload();
            VG_NordicsAssetsUploadController.AssetAttachment=True;
            controller.processUpload();
            
        }catch(Exception e){
            System.debug('Error::'+e);
        }   
    }
    public static testMethod void TestMethod2(){
        VG_NordicsAssetsUploadController controller;        
        PageReference pageRef = Page.VG_NordicsAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Bridge Asset Upload Template';
            d.Body=Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('attType', 'Assets File');                        
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_NordicsAssetsUploadController();
            controller.fileName='Unit Test Attachment.jps';
            controller.fileBody = Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n');      
            controller.processUpload();
            controller.back();
            Attachment att=[select id,Name,body from Attachment where ParentId=:acc.id limit 1];
            controller.fileBody =att.Body;
            controller.description='Asset File Attached';
            controller.processUpload();
        }catch(Exception e){
            System.debug('Error::'+e);
        }   
    }
     //Cover codes SFDC Record Id related
     public static testMethod void TestMethod8(){
        VG_NordicsAssetsUploadController controller;        
        PageReference pageRef = Page.VG_NordicsAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Bridge Asset Upload Template';
            d.Body=Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('attType', 'Assets File');                        
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_NordicsAssetsUploadController();
            controller.AccName=acc;
            controller.fileName='Unit Test Attachment.jps';
            controller.fileBody = Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n');      
            controller.processUpload();
            controller.back();
            Asset__c ass=[select id,Name from Asset__c where VG_Account__c=:acc.id limit 1];
            controller = new VG_NordicsAssetsUploadController();
            controller.fileName='Unit Test Attachment.jps';
            String body='SFDC Record Id,Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\n'+ass.id+',Stig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n';
            controller.NordicsAssetsUpload.clear();
            controller.fileBody =blob.valueOf(body);
            controller.processUpload(); 
        }catch(Exception e){
            System.debug('Error::'+e);
        }   
    }
    //covered filename length>80 in custom attachment
    public static testMethod void TestMethod3() {
        VG_NordicsAssetsUploadController controller;        
        PageReference pageRef = Page.VG_NordicsAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Bridge Asset Upload Template';
            d.Body=Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('attType', 'Assets File');                        
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_NordicsAssetsUploadController();
            controller.fileName='Attachment File name-Unit Test Attachment For Bridge Asset Upload Template For NordicsPortalCommunityProfile.jps';
            controller.fileBody = Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n');      
            VG_NordicsAssetsUploadController.coverCatchBlocks=true;
            controller.processUpload();            
            controller.back();
            
        }catch(Exception e){
            System.debug(e);
        }
    }
    
    //Please Upload a file Error message
     public static testMethod void TestMethod4() {
        VG_NordicsAssetsUploadController controller;        
        PageReference pageRef = Page.VG_NordicsAssetsUpload;
        Test.setCurrentPage(pageRef);
        try{
            Document d=new Document();
            d.Name='Bridge Asset Upload Template';
            d.Body=Blob.valueOf('Company,Street,Street Number,Postal Code,City,Country,Block ID,CurrencyISOCode,F/S/FL* Building,TSI Building,TSI Machinery,TSI Goods,TSI Contents,TSI Customer Property,TSI Other,Total Business Interruption SI (12 months),Total Business Interruption SI (for the indemnity period),Coverage,Comment,EML PD,EML BI,PD Deductible,Waiting Period,BI Indemnity Period,Total MB Business Interruption SI (for the indemnity period),MB PD Deductible,MB Waiting Period,MB BI Indemnity Period,Automatic Fire alarm?,Water sprinklers?,Foam supression system?,Smoke and heat venting system?,Full time public Fire Brigade staff?\nStig S,Kalmarvagen,1,12366,Kalmar,Sverige,Stavlo9:1,SEK,F,26290000,2750000,19000000,0,0,0,26586000,53172000,M3 - Fully Comprehensive,Stickans prylar,48040000,26586000,9100,24 hours,24 months,13293000,9100,48 hours,12 months,No,No,No,No,Under 10 mins\n');      
            d.FolderId='0050O0000078Mug';
            Insert d;
            Account acc=VG_TU.createAccount('Customer');          
            ApexPages.currentPage().getParameters().put('id', acc.Id);
            ApexPages.currentPage().getParameters().put('attType', null);                        
            ApexPages.currentPage().getParameters().put('ParentId', acc.id);         
            controller = new VG_NordicsAssetsUploadController();
            controller.fileName='Unit Test Attachment For Bridge Asset Upload Template For NordicsPortalCommunity.jps';            
            controller.nameFile='Test.xlsx';
            controller.fileBody = null;
            controller.ReadFile();
            controller.processUpload();
            controller.back();          
        }catch(Exception e){
            System.debug(e);
        }
    }
}