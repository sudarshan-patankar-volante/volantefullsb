@isTest(SeeAllData = False)
public class VG_EdisonPS_Ins3_Controller_Test {
    public static testmethod void TesMethod1(){
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
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        Endorsement_Library__c EL=new Endorsement_Library__c();
        EL.Name='Test EL';
        EL.Text__c='Text';
        EL.Endorsement_Title__c='Title';
        Insert EL;
        VG_Policy_Schedule_Endorsement__c PSE=new VG_Policy_Schedule_Endorsement__c();
        PSE.VG_Endorsement_Details__c=EL.Text__c;
        PSE.VG_Endorsement_Library_Id__c=EL.Id;
        PSE.VG_Policy_Schedule__c=ps.Id;
        PSE.VG_Title__c=EL.Endorsement_Title__c;
        PSE.VG_Premium__c=0;
        Insert PSE;
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Cancellation');
        VG_EdisonPS_Ins3_Controller eps3=new VG_EdisonPS_Ins3_Controller();
        eps3.Nexta();
        eps3.Previousa();
        //Below Line covers previousa() 1st if
        VG_Policy_Schedule_Endorsement__c PSE1=new VG_Policy_Schedule_Endorsement__c();
        PSE1.VG_Endorsement_Details__c=EL.Text__c;
        PSE1.VG_Endorsement_Library_Id__c=EL.Id;
        PSE1.VG_Policy_Schedule__c=ps.Id;
        PSE1.VG_Title__c=EL.Endorsement_Title__c;
        PSE1.VG_Premium__c=0;
        Insert PSE1;
        eps3.existingEndorsements.add(PSE1);
        eps3.MTAType=null;
        eps3.Previousa();
        //above Line covers previousa() 1st if
    }
       
    public static testmethod void TesMethod2(){
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
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        Endorsement_Library__c EL=new Endorsement_Library__c();
        EL.Name='Test EL';
        EL.Text__c='Text';
        EL.Endorsement_Title__c='Title';
        Insert EL;
        VG_Policy_Schedule_Endorsement__c PSE=new VG_Policy_Schedule_Endorsement__c();
        PSE.VG_Endorsement_Details__c=EL.Text__c;
        PSE.VG_Endorsement_Library_Id__c=EL.Id;
        PSE.VG_Policy_Schedule__c=ps.Id;
        PSE.VG_Title__c=EL.Endorsement_Title__c;
        PSE.VG_Premium__c=0;
        Insert PSE;
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Extension');
        VG_EdisonPS_Ins3_Controller eps3=new VG_EdisonPS_Ins3_Controller();
        eps3.Nexta();       
       
    }
    
    public static testmethod void TesMethod3(){
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
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        Endorsement_Library__c EL=new Endorsement_Library__c();
        EL.Name='Test EL';
        EL.Text__c='Text';
        EL.Endorsement_Title__c='Title';
        Insert EL;
        VG_Policy_Schedule_Endorsement__c PSE=new VG_Policy_Schedule_Endorsement__c();
        PSE.VG_Endorsement_Details__c=EL.Text__c;
        PSE.VG_Endorsement_Library_Id__c=EL.Id;
        PSE.VG_Policy_Schedule__c=ps.Id;
        PSE.VG_Title__c=EL.Endorsement_Title__c;
        PSE.VG_Premium__c=0;
        Insert PSE;
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');
        VG_EdisonPS_Ins3_Controller eps3=new VG_EdisonPS_Ins3_Controller();
        eps3.Previousa();      
        eps3.Cancel();
        Policy_Schedule__c ps1=VG_TU.createPolicySchedule(pol.id);
        ApexPages.currentPage().getParameters().put('id', ps1.Id);
        VG_EdisonPS_Ins3_Controller eps4=new VG_EdisonPS_Ins3_Controller();
    }
    
    public static testmethod void TesMethod4(){
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
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        Endorsement_Library__c EL=new Endorsement_Library__c();
        EL.Name='Test EL';
        EL.Text__c='Text';
        EL.Endorsement_Title__c='Title';
        Insert EL;
        VG_Policy_Schedule_Endorsement__c PSE=new VG_Policy_Schedule_Endorsement__c();
        PSE.VG_Endorsement_Details__c=EL.Text__c;
        PSE.VG_Endorsement_Library_Id__c=EL.Id;
        PSE.VG_Policy_Schedule__c=ps.Id;
        PSE.VG_Title__c=EL.Endorsement_Title__c;
        PSE.VG_Premium__c=0;
        Insert PSE;
        VG_Policy_Schedule_Asset__c psa=new VG_Policy_Schedule_Asset__c();
        psa.Name='psaTest';
        psa.VG_Policy_Schedule__c=ps.Id;
        Insert psa;
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', 'Declaration');
        VG_EdisonPS_Ins3_Controller eps3=new VG_EdisonPS_Ins3_Controller();
        eps3.Nexta();
        eps3.Previousa();
        eps3.Cancel();
       
    }  
    
      public static testmethod void TesMethod5(){
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
        Policy__c pol=VG_TU.createPolicy('Edison Motor', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        Endorsement_Library__c EL=new Endorsement_Library__c();
        EL.Name='Test EL';
        EL.Text__c='Text';
        EL.Endorsement_Title__c='Title';
        Insert EL;          
        VG_Policy_Schedule_Endorsement__c PSE=new VG_Policy_Schedule_Endorsement__c();
        PSE.VG_Endorsement_Details__c=EL.Text__c;
        PSE.VG_Endorsement_Library_Id__c=EL.Id;
        PSE.VG_Policy_Schedule__c=ps.Id;
        PSE.VG_Title__c=EL.Endorsement_Title__c;
        PSE.VG_Premium__c=0;
        Insert PSE;
        VG_Policy_Schedule_Asset__c psa=new VG_Policy_Schedule_Asset__c();
        psa.Name='psaTest';
        psa.VG_Policy_Schedule__c=ps.Id;
        Insert psa;
        ApexPages.currentPage().getParameters().put('id', ps.Id);
        ApexPages.currentPage().getParameters().put('MTAType', null);
        VG_EdisonPS_Ins3_Controller eps3=new VG_EdisonPS_Ins3_Controller();
        eps3.Nexta();        
        eps3.Cancel();                
    }   
}