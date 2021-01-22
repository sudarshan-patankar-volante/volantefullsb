@IsTest(SeeAllData=False)
public class VG_ReviseAesirStepsController_Test {
    public static testMethod void TestMethod1(){
        VG_TU.policyCustomSetting();
        Test.startTest();
        Account acc=VG_TU.createAccount('Customer');
        Utilities.SkipMethods('Bridge Context');        
        Policy__c pol=VG_TU.createPolicy('Aesir',acc.id);
        List<Policy_Schedule__c> psList2=new List<Policy_Schedule__c>();
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
        ps.Gross_Written_Premium__c=5000;
        ps.Technical_UW_Premium__c=5487;
        ps.Premium_Adjustment_2__c=48752;
        ps.Gross_or_Net_Premium__c='Gross';
        ps.Actual_GWP__c=1540;
        ps.VG_Brokerage_Amount__c=450;
        ps.IPT_Percent__c=45;
        ps.VG_Fee_Income__c=4500;
        ps.Levies__c=4500;
        ps.VG_VAT__c=20;        
        update ps;
        ps.VG_MTA_Start_Date__c=Date.newInstance(2017, 12, 15);
        ps.VG_Brokerage_Amount__c = 4000;
        ps.Share__c=20;
        update ps;
        Policy_Schedule__c ps1=VG_Tu.createPolicySchedule(pol.id);
        psList2.add(ps);
        psList2.add(ps1);
        Risk_Capture__c rc=new Risk_Capture__c();
        rc.Name='Test';
        rc.Policy_Schedule__c=ps.id;  
        //rc.VG_Additional_Information__c='Notice of Event Limit :2000<br>Proof of Loss Limit :2000<br>Payment after POL limit :2000<br>Sunset Clause :2000<br>Salvage Provisions :2000<br>CTL Provisions :2000<br>Loss Minimisation :2000<br>Power Margin :2000<br>Propellant Margin :2000<br>Loss Formula :2000<br>AVN 41/21:2000<br>';
        Insert rc;
        Asset__c ass=VG_TU.createAsset(acc.id); 
        ass.LS_AccName_with_Ass_Name__c='Test1';
        update ass;
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);     
        rr.Asset__c=ass.id;
        update rr;
        ApexPages.currentPage().getParameters().put('Id', ps.id);   
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.valueOf(Date.newInstance(2019, 7, 17)));                
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');                
        VG_ReviseAesirStepsController aes=new VG_ReviseAesirStepsController();        
        aes.gotostep1();
        aes.gotostep2a();
        aes.fileName='test';
        aes.fileBody=blob.valueOf('Asset External id,Risk Start Date,Risk End Date,Coverage,Coverage Type,Limit,Attachment,AVG SI,Rate(%),Signed Shared(%),Annual Premium,Sum Insured\n Test1,14-08-19,31-08-19,Marine Cargo Treaty,Full cover,5000,5520,2900,25,15,0,0\n');       
        VG_ReviseAesirStepsController.RRWrapper RRW =new VG_ReviseAesirStepsController.RRWrapper();
        RRW.psa=rr;
        RRW.techPremium=4500;
        RRW.sumInsured=470;
        RRW.assName=ass.LS_AccName_with_Ass_Name__c;
        aes.addedRRList.add(RRW);           
        aes.RRCalc();
        aes.gotostep2b();                
        aes.gotostep5();
        aes.Cancel();
        aes.gotostep2();
        aes.SummaryCalc();
        aes.finish();
        Utilities.clearMethods();
        Test.stopTest();
    }
    public static testMethod void TestMethod2() {
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Aesir',acc.id);
        Policy_Schedule__c ps=VG_Tu.createPolicySchedule(pol.id);
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
        rr.VG_Sum_Insured__c=8000;
        insert rr;
        Risk_Capture__c rc=new Risk_Capture__c();
        rc.Name='Test';
        rc.Policy_Schedule__c=ps.id;  
        rc.VG_Additional_Information__c=+'RDInfo :'+'aa'+'<br>'
        +'Notice of Event Limit :'+'2000'+'<br>'
        +'Proof of Loss Limit :'+'2000'+'<br>'
        +'Payment after POL limit :'+'2000'+'<br>'
        +'Sunset Clause :'+'2000'+'<br>'
        +'Salvage Provisions :'+'2000'+'<br>'
        +'CTL Provisions :'+'2000'+'<br>'
        +'Loss Minimisation :'+'2000'+'<br>'
        +'Power Margin :'+'2000'+'<br>'
        +'Propellant Margin :'+'2000'+'<br>'
        +'Loss Formula :'+'2000'+'<br>'
        +'AVN 41/21:'+'2000'+'<br>';
        Insert rc; 
        ApexPages.currentPage().getParameters().put('Id', ps.id);   
        ApexPages.currentPage().getParameters().put('MTAStartDate', String.valueOf(Date.newInstance(2019, 7, 17)));                
        ApexPages.currentPage().getParameters().put('MTAType', 'Revision of Cover');    
        ApexPages.currentPage().getParameters().put('Currency', pol.CurrencyIsoCode);        
        VG_ReviseAesirStepsController asr=new VG_ReviseAesirStepsController();
        asr.gotostep1();
        asr.rc.VG_Additional_Information__c='';
        asr.gotostep2a(); 
        asr.fileName='test';
        asr.fileBody=blob.valueOf('Asset External id,Risk Start Date,Risk End Date,Coverage,Coverage Type,Limit,Attachment,AVG SI,Rate(%),Signed Shared(%),Annual Premium\nTest456,31-08-2018,31-08-2019,CAT,Full cover,1500,5000,1300,25,25,1200\nTest456,,01-08-2019,,,,,,,,190\n');               
        asr.gotostep2b();          
        //asr.Index='1';
        asr.gotostep2a();
        VG_ReviseAesirStepsController.RRWrapper RRW =new VG_ReviseAesirStepsController.RRWrapper();
        RRW.techPremium=4500;
        RRW.sumInsured=470;
        RRW.assName=ass.LS_AccName_with_Ass_Name__c;
        asr.addedRRList.add(RRW);
        asr.RRCalc();       
        asr.finish();
    }
}