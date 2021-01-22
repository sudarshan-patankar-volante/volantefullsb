@IsTest(SeeAllData=False)
public class VG_AesirStepsController_Test {
    public static testMethod void TestMethod1() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Aesir',acc.id);
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        Asset__c ass=new Asset__c();
        ass.VG_Asset_Type__c='Satellite';
        ass.Name='test';
        ass.VG_Account__c=acc.id;
        ass.LS_AccName_with_Ass_Name__c='Test';
        Insert ass;
        VG_Policy_Schedule_Asset__c psa = VG_TU.createPolicyScheduleAsset(ps.id);
        psa.Asset__c=ass.id;
        psa.Annual_Rate_100__c=500;
        update psa; 
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        ApexPages.currentPage().getParameters().put('Currency', pol.CurrencyIsoCode);        
        VG_AesirStepsController asr=new VG_AesirStepsController();
        asr.gotostep1();
        asr.rc.VG_Additional_Information__c='';
        asr.gotostep2a(); 
        asr.fileName='test';
        asr.fileBody=blob.valueOf('Selected Asset,Risk Start Date,Risk End Date,Coverage,Coverage Type,Limit,Attachment,AVG SI	Rate(%),Signed Shared(%),Annual Premium,Sum Insured\n Test1,14-08-19,31-08-19,Marine Cargo Treaty,Full cover,5000,5520,2900,25,15,0,0\n');               
        asr.gotostep2b();      
        asr.Index='1';
        VG_AesirStepsController.RRWrapper RRW =new VG_AesirStepsController.RRWrapper();
        RRW.psa = psa;
        RRW.techPremium=4500;
        RRW.sumInsured=470;
        RRW.assName=ass.LS_AccName_with_Ass_Name__c;
        asr.addedRRList.add(RRW);
        asr.RRCalc();
        asr.gotostep5();
        asr.gotostep2();
        asr.Cancel();
        asr.SummaryCalc();
        //asr.finish();
    }
    public static testMethod void TestMethod2() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Aesir',acc.id);
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Split_Type__c= 'EEA';
        ps.Name=ps.Name+'/EEA';
        update ps;
		Asset__c ass=new Asset__c();
        ass.VG_Asset_Type__c='Launcher';
        ass.Name='Test456';
        ass.LS_AccName_with_Ass_Name__c='Test456';
        ass.VG_Account__c=acc.id;
        Insert ass;
        VG_Policy_Schedule_Asset__c rr=new VG_Policy_Schedule_Asset__c();   
        rr.VG_Policy_Schedule__c=ps.id;
        rr.Asset__c=ass.Id;
        rr.Annual_Rate_100__c=4500;
        rr.VG_Premium__c=780;
        insert rr;
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        ApexPages.currentPage().getParameters().put('Currency', pol.CurrencyIsoCode);        
        VG_AesirStepsController asr=new VG_AesirStepsController();
        asr.gotostep1();
        asr.rc.VG_Additional_Information__c='';
        asr.gotostep2a(); 
        asr.fileName='test';
        asr.fileBody=blob.valueOf('Asset External id,Risk Start Date,Risk End Date,Coverage,Coverage Type,Limit,Attachment,AVG SI,Rate(%),Signed Shared(%),Annual Premium\nTest456,31-08-2018,31-08-2019,CAT,Full cover,1500,5000,1300,25,25,1200\nTest456,,01-08-2019,,,,,,,,190\n');               
        asr.gotostep2b();          
        asr.Index='1';
        asr.gotostep2a();   
        asr.RRCalc();
        asr.SummaryCalc();
        asr.finish();
        
    }
}