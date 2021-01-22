@IsTest(SeeAllData=False)
public class VG_AesirAssetsUploadController_Test {
    public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        ApexPages.currentPage().getParameters().put('Id', acc.id);
        /*Document d=new Document();
        d.Name='Aesir Asset Upload Template';
        Folder folder = [select id from Folder LIMIT 1];
		d.folderId = folder.id;
        Insert d;*/
        Document d1=new Document();
        d1.Name='Aesir Asset Upload Template';
        d1.Body=blob.valueOf('Hai');
        d1.FolderId='00l0O000002n3zY';
        insert d1;
        //Cover Constructor
        ApexPages.currentPage().getParameters().put('Id', acc.id);
        ApexPages.currentPage().getParameters().put('sObjectType', 'Account');
        ApexPages.currentPage().getParameters().put('attType', null);
        VG_AesirAssetsUploadController aauc=new VG_AesirAssetsUploadController();
        //Cover Back()
        aauc.back();
        //Cover processUpload
        aauc.processUpload();
        aauc.fileBody=blob.valueOf('Hai');
        aauc.fileName='test';
        aauc.description='Test';
        aauc.processUpload();
        VG_AesirAssetsUploadController.coverCatchBlocks=True;
        aauc.processUpload();
        VG_AesirAssetsUploadController.coverCatchBlocks=false;
        aauc.sObjectType=null;
        aauc.processUpload();
        aauc.sObjectType='Account';
        aauc.AttName='Test';
        aauc.processUpload();
        aauc.AttName='pppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppppp';
        aauc.processUpload();
        aauc.attType='Assets File';
        aauc.AttName='Test';
        aauc.fileBody=blob.valueOf('Satellite,Satellite Family,Manufacturer,Payload Manufacturer,Platform Manufacturer,Operator,Payload Power,Satellite EOL Power,Dry Mass,Wet Mass,Mission,Missions,Payload,Platform_Propulsion,Platform_Power,Platform_AOCS,Platform_Thermal,Platform_C and C,Equipments,Heritage,Design Life,OML,EOL Power Margin,Technical Summary,Rate Loading,Rate Adjustment,LaunchID,RDSFamily,Satellite Status,Orbital Position,Orbit,Int. ID,Asset Type,Launcher,Launcher family,Description,Prime Manufacturer,Launch Operator\nTest123,TBA,TBA,TBA,TBA,TBA,200000,2000000,200000,200000,Test Mission,ADS-B;Cargo,Testing,Testing,Testing,Testing,Testing,Testing,Testing,Testing,5555,5222,2000.2,testing,20,20.35,543,testing,Future Launch,255586.25,GTO,Testing,Satellite,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Launcher,Test456,TBA,Testing,TBA,TBA');
        aauc.processUpload();
        Asset__c ass=[select id,Name from Asset__c limit 1];
        aauc.BulkAssetsupload.clear();
		aauc.fileBody=blob.valueOf('SFDC Record Id,Satellite,Satellite Family,Manufacturer,Payload Manufacturer,Platform Manufacturer,Operator,Payload Power,Satellite EOL Power,Dry Mass,Wet Mass,Mission,Missions,Payload,Platform_Propulsion,Platform_Power,Platform_AOCS,Platform_Thermal,Platform_C and C,Equipments,Heritage,Design Life,OML,EOL Power Margin,Technical Summary,Rate Loading,Rate Adjustment,LaunchID,RDSFamily,Satellite Status,Orbital Position,Orbit,Int. ID,Asset Type,Launcher,Launcher family,Description,Prime Manufacturer,Launch Operator\n'+ass.id+',Test123,TBA,TBA,TBA,TBA,TBA,200000,2000000,200000,200000,Test Mission,ADS-B;Cargo,Testing,Testing,Testing,Testing,Testing,Testing,Testing,Testing,5555,5222,2000.2,testing,20,20.35,543,testing,Future Launch,255586.25,GTO,Testing,Satellite,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Launcher,Test456,TBA,Testing,TBA,TBA');
        aauc.processUpload(); 
        aauc.BulkAssetsupload.clear();
        aauc.fileBody=blob.valueOf('Satellite,Satellite Family,Manufacturer,Payload Manufacturer,Platform Manufacturer,Operator,Payload Power,Satellite EOL Power,Dry Mass,Wet Mass,Mission,Missions,Payload,Platform_Propulsion,Platform_Power,Platform_AOCS,Platform_Thermal,Platform_C and C,Equipments,Heritage,Design Life,OML,EOL Power Margin,Technical Summary,Rate Loading,Rate Adjustment,LaunchID,RDSFamily,Satellite Status,Orbital Position,Orbit,Int. ID,Asset Type,Launcher,Launcher family,Description,Prime Manufacturer,Launch Operator\nTest123,TBA,TBA,TBA,TBA,TBA,200000,2000000,200000,200000,Test Mission,ADS-B;Cargo,Testing,Testing,Testing,Testing,Testing,Testing,Testing,Testing,5555,5222,2000.2,testing,20,20.35,543,testing,Future Launch,255586.25,GTO,Testing,Satellite,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Launcher,Test456,TBA,Testing,TBA,TBA');
        aauc.processUpload(); 
        aauc.BulkAssetsupload.clear();
		aauc.fileBody=blob.valueOf('SFDC Record Id,Satellite,Satellite Family,Manufacturer,Payload Manufacturer,Platform Manufacturer,Operator,Payload Power,Satellite EOL Power,Dry Mass,Wet Mass,Mission,Missions,Payload,Platform_Propulsion,Platform_Power,Platform_AOCS,Platform_Thermal,Platform_C and C,Equipments,Heritage,Design Life,OML,EOL Power Margin,Technical Summary,Rate Loading,Rate Adjustment,LaunchID,RDSFamily,Satellite Status,Orbital Position,Orbit,Int. ID,Asset Type,Launcher,Launcher family,Description,Prime Manufacturer,Launch Operator\n'+ass.id+',Test123,TBA,TBA,TBA,TBA,TBA,200000,2000000,200000,200000,Test Mission,ADS-B;Cargo,Testing,Testing,Testing,Testing,Testing,Testing,Testing,Testing,5555,5222,2000.2,testing,20,20.35,543,testing,Future Launch,255586.25,GTO,Testing,Satellite,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Launcher,Test456,TBA,Testing,TBA,TBA');
        aauc.processUpload(); 
        aauc.fileBody=null;
        aauc.ReadFile();
        ApexPages.currentPage().getParameters().put('attType', 'TOBA');
        VG_AesirAssetsUploadController aauc1=new VG_AesirAssetsUploadController();
    }
}