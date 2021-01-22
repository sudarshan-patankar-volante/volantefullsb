@isTest(SeeAllData = False)
public class VG_GentiumStep4_Controller_Test {
	public static testmethod void TesMethod1(){ 
        VG_TU.policyCustomSetting();        
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
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
        VG_GentiumStep4_Controller gen=new VG_GentiumStep4_Controller();
        gen.Nexta();
        gen.Previousa();
        VG_Policy_Schedule_Endorsement__c PSE1=new VG_Policy_Schedule_Endorsement__c();
        PSE1.VG_Endorsement_Details__c=EL.Text__c;
        PSE1.VG_Endorsement_Library_Id__c=EL.Id;
        PSE1.VG_Policy_Schedule__c=ps.Id;
        PSE1.VG_Title__c=EL.Endorsement_Title__c;
        PSE1.VG_Premium__c=0;
        Insert PSE1;
        gen.existingEndorsements.add(PSE1);
        gen.MTAType=null;
        gen.Previousa();        
    }
    public static testmethod void TesMethod2(){
        VG_TU.policyCustomSetting();        
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
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
        VG_GentiumStep4_Controller gen=new VG_GentiumStep4_Controller();
        gen.Nexta();        
    }
    public static testmethod void TesMethod3(){ 
        VG_TU.policyCustomSetting();        
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        Endorsement_Library__c EL=new Endorsement_Library__c();
        EL.Name='Test EL';
        El.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();        
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
        VG_GentiumStep4_Controller gen=new VG_GentiumStep4_Controller();
        gen.Nexta();
        gen.Previousa();
        VG_Policy_Schedule_Endorsement__c PSE1=new VG_Policy_Schedule_Endorsement__c();
        PSE1.VG_Endorsement_Details__c=EL.Text__c;
        PSE1.VG_Endorsement_Library_Id__c=EL.Id;
        PSE1.VG_Policy_Schedule__c=ps.Id;
        PSE1.VG_Title__c=EL.Endorsement_Title__c;
        PSE1.VG_Premium__c=0;
        Insert PSE1;
        gen.existingEndorsements.add(PSE1);
        gen.MTAType=null;
        gen.Previousa(); 
        gen.Cancel();
    }
    public static testmethod void TesMethod4(){
        VG_TU.policyCustomSetting();        
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Risk_Capture__c rc=VG_TU.createRiskCapture(ps.id);
        Endorsement_Library__c EL=new Endorsement_Library__c();
        EL.Name='Test EL';
        El.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();                
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
        ApexPages.currentPage().getParameters().put('MTAType', 'Declaration');
        VG_GentiumStep4_Controller gen=new VG_GentiumStep4_Controller();
        gen.Nexta();   
        gen.LibraryWrapperList[0].IsSelected=True;
        
    }
    public static testmethod void TesMethod5(){
        VG_TU.policyCustomSetting();        
        Account acc=VG_TU.createAccount('Customer');        
        Policy__c pol=VG_TU.createPolicy('Gentium', acc.id);
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
        ApexPages.currentPage().getParameters().put('MTAType', null);
        VG_GentiumStep4_Controller gen=new VG_GentiumStep4_Controller();
        gen.Nexta();        
    }
}