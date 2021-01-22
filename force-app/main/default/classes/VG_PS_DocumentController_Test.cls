@IsTest(seeAllData =False)
public class VG_PS_DocumentController_Test {    
    public static testMethod void TestMethod2() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');                
        List<Document> dList=new List<Document>();
        Document d1=new Document();
        d1.Name='Motor Felt';
        d1.Body=blob.valueOf('Hai');
        d1.FolderId='0050O0000078Mug';
        dList.add(d1);
        Document d2=new Document();
        d2.Name='VG PI Logo';
        d2.Body=blob.valueOf('Hai');
        d2.FolderId='0050O0000078Mug';
        dList.add(d2);
        Document d3=new Document();
        d3.Name='VG_LS_Affnity_Logo';
        d3.Body=blob.valueOf('Hai');
        d3.FolderId='0050O0000078Mug';
        dList.add(d3);
        Document d4=new Document();
        d4.Name='David Sign';
        d4.Body=blob.valueOf('Hai');
        d4.FolderId='0050O0000078Mug';
        dList.add(d4);
        Document d5=new Document();
        d5.Name='LS EL_Image';
        d5.Body=blob.valueOf('Hai');
        d5.FolderId='0050O0000078Mug';
        dList.add(d5);
        Document d6=new Document();
        d6.Name='Talbir Bains';
        d6.Body=blob.valueOf('Hai');
        d6.FolderId='0050O0000078Mug';
        dList.add(d6);
        insert dList;
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
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
        /*ContentVersion contentVersion = new ContentVersion(
            Title = 'Penguins',
            PathOnClient = 'Penguins.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true           
        );
        insert contentVersion;    
		contentversion cv = [select id,ContentDocumentId from contentversion where ContentDocumentId =:att.Id];                                  
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = acc.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;*/
        VG_PS_DocumentController.getUserDocRepoList();
        VG_PS_DocumentController.getPolicyAttachments('Underwriting',ps.id);
        VG_PS_DocumentController.getAttachment(att.id);
        VG_PS_DocumentController.getPolicyAttachments('Policy Documentation',ps.id);
        VG_PS_DocumentController.getAttachment(att.id);
        VG_PS_DocumentController.getPolicyAttachments('Pricing Spreadsheet',ps.id);
        VG_PS_DocumentController.getAttachment(att.id);
        VG_PS_DocumentController.insertAttachment(ps.id, 'Test;', 'Policy Documentation', att.Id);
        VG_PS_DocumentController pdc=new VG_PS_DocumentController ();
        
    }
}