@IsTest(SeeAllData=False)
public class VG_NordicsProductSteps_Test {

    public static testmethod void testmethod1(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        List<Policy_Schedule__c> psList=new List<Policy_Schedule__c>();
        psList.add(ps);
        Insert psList; 
        List<VG_Policy_Schedule_Asset__c> psaList=new List<VG_Policy_Schedule_Asset__c>();
        VG_Policy_Schedule_Asset__c psa=new VG_Policy_Schedule_Asset__c();
        psa.name='Test';
        psa.VG_Policy_Schedule__c=ps.id;
        psa.VG_Rate_Per_Vehicle__c=20;
        psa.VG_Number_of_Vehicles__c=10;
        psa.VG_Coverage__c='M3 - Fully Comprehensive';
        psa.VG_Vehicle_Type__c='Plant';
        psaList.add(psa);
        VG_Policy_Schedule_Asset__c psa1=new VG_Policy_Schedule_Asset__c();
        psa1.name='Test';
        psa1.VG_Policy_Schedule__c=ps.id;
        psa1.VG_Rate_Per_Vehicle__c=20;
        psa1.VG_Number_of_Vehicles__c=10;
        psa1.VG_Coverage__c='M3 - Fully Comprehensive';
        psa1.VG_Vehicle_Type__c='Cars';        
        psa1.VG_Technical_UW_Rate_Annual__c=5000;       
        Insert psa1;
        System.debug('psaList::'+psaList);
        
        PageReference pageRef = Page.VG_Nordics_Step1;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', pol.id);
        VG_NordicsProductSteps cntr = new VG_NordicsProductSteps();
        cntr.assetList=new List<VG_NordicsProductSteps.AssetWrapper>();        
        VG_NordicsProductSteps.AssetWrapper ass=new VG_NordicsProductSteps.AssetWrapper();                
        ass.asset=psaList[0];
        ass.AdjustedBIPremium=100;
        ass.counter='0';
        cntr.assetList.add(ass);
        System.debug('assetList1::'+cntr.assetList);
        VG_NordicsProductSteps.PricingWrapper pw=new VG_NordicsProductSteps.PricingWrapper();
        pw.price='0';
        cntr.otherFactors.add(pw);
        cntr.gotostep4();
        cntr.addRR();        
        cntr.RemoveRR();
        cntr.AddAsset();              
        cntr.CancelAsset();
        cntr.EditAsset();             
    }
    
    public static testmethod void testmethod2(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        Policy_Schedule__c ps=new Policy_Schedule__c(Name='Test');
        ps.Policy__c=pol.id;
        List<Policy_Schedule__c> psList=new List<Policy_Schedule__c>();
        psList.add(ps);
        Insert psList; 
        List<VG_Policy_Schedule_Asset__c> psaList=new List<VG_Policy_Schedule_Asset__c>();
        VG_Policy_Schedule_Asset__c psa=new VG_Policy_Schedule_Asset__c();
        psa.name='Test';
        psa.VG_Policy_Schedule__c=ps.id;
        psa.VG_Rate_Per_Vehicle__c=20;
        psa.VG_Number_of_Vehicles__c=10;
        psa.VG_Coverage__c='M3 - Fully Comprehensive';
        psa.VG_Vehicle_Type__c='Plant';
        psaList.add(psa);
        VG_Policy_Schedule_Asset__c psa1=new VG_Policy_Schedule_Asset__c();
        psa1.name='Test';
        psa1.VG_Policy_Schedule__c=ps.id;
        psa1.VG_Rate_Per_Vehicle__c=20;
        psa1.VG_Number_of_Vehicles__c=10;
        psa1.VG_Coverage__c='M3 - Fully Comprehensive';
        psa1.VG_Vehicle_Type__c='Cars';        
        psa1.VG_Technical_UW_Rate_Annual__c=5000;
        psaList.add(psa1);
        Insert psaList;        
        PageReference pageRef = Page.VG_Nordics_Step1;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', pol.id);
        VG_NordicsProductSteps cntr = new VG_NordicsProductSteps();  
        VG_NordicsProductSteps.RRWrapper rr=new VG_NordicsProductSteps.RRWrapper();
        rr.psa=psaList[0];
        rr.share=10;
        System.debug('share::'+rr.share);
        rr.Counter='0';
        rr.techPremium=1000;
        cntr.riskRatingList.add(rr);
        VG_NordicsProductSteps.RRWrapper rr1=new VG_NordicsProductSteps.RRWrapper();
        rr1.psa=psaList[1];
        rr1.share=100;
        rr1.Counter='1';
        rr1.techPremium=1100;
        cntr.riskRatingList.add(rr1);
        cntr.price.VG_Product__c='Property';
        List<VG_Pricing__c> priceList=new List<VG_Pricing__c>();
        VG_Pricing__c pr=new VG_Pricing__c();
        pr.Name='prTest1';
        pr.VG_Product__c='Property';
        pr.VG_Level__c = 'Risk Detail';
        pr.VG_Rate__c=1000;
        pr.VG_Rating_Factor__c='Agentur';
        pr.VG_Category__c = 'BI Base Rate';
        pr.VG_Order__c=1;
        priceList.add(pr);
        VG_Pricing__c pr1=new VG_Pricing__c();
        pr1.Name='prTest2';
        pr1.VG_Product__c='Property';
        pr1.VG_Level__c = 'Risk Detail';
        pr1.VG_Rate__c=1000;
        pr1.VG_Rating_Factor__c='Agentur';
        pr1.VG_Category__c = 'PD Base Rate';
        pr1.VG_Order__c=1;
        priceList.add(pr1);
        VG_Pricing__c pr2=new VG_Pricing__c();
        pr2.Name='prTest2';
        pr2.VG_Product__c='Property';
        pr2.VG_Level__c = 'Risk Detail';
        pr2.VG_Rate__c=1000;
        pr2.VG_Rating_Factor__c='Agentur';
        pr2.VG_Category__c = 'Pressure over 200 bar and/or temperature over 500 ºC';
        pr2.VG_Order__c=1;
        priceList.add(pr2);
        VG_Pricing__c pr4=pr1.clone(false,true,false,false);
        priceList.add(pr4);
        Insert priceList;
        System.debug('price::'+priceList);                
        cntr.AddCustom();
        cntr.gotostep1A();
        cntr.gotostep2();
        cntr.gotostep3();
        cntr.gotostep4();
        cntr.gotostep4b();
        cntr.gotostep5();
        cntr.cancel();
    }
    
    public static testmethod void testmethod3(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        List<VG_Policy_Schedule_Asset__c> psaList=new List<VG_Policy_Schedule_Asset__c>();
        VG_Policy_Schedule_Asset__c psa=new VG_Policy_Schedule_Asset__c();
        psa.name='Test1';
        psa.VG_Policy_Schedule__c=ps.id;
        psa.VG_Rate_Per_Vehicle__c=20;
        psa.VG_Number_of_Vehicles__c=10;
        psa.VG_Coverage__c='M3 - Fully Comprehensive';
        psa.VG_Vehicle_Type__c='Plant';
        psaList.add(psa);
        VG_Policy_Schedule_Asset__c psa1=new VG_Policy_Schedule_Asset__c();
        psa1.name='Test2';
        psa1.VG_Policy_Schedule__c=ps.id;
        psa1.VG_Rate_Per_Vehicle__c=20;
        psa1.VG_Number_of_Vehicles__c=10;
        psa1.VG_Coverage__c='M3 - Fully Comprehensive';
        psa1.VG_Vehicle_Type__c='Cars';        
        psa1.VG_Technical_UW_Rate_Annual__c=5000;
        psaList.add(psa1);
        Insert psaList;        
        PageReference pageRef = Page.VG_Nordics_Step1;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', pol.id);
        VG_NordicsProductSteps cntr = new VG_NordicsProductSteps();
        cntr.price.VG_Product__c='GLPL';
        List<VG_Pricing__c> priceList=new List<VG_Pricing__c>();
        VG_Pricing__c pr=new VG_Pricing__c();
        pr.Name='prTest1';
        pr.VG_Product__c='GLPL';
        pr.VG_Level__c = 'Risk Detail';
        pr.VG_Rate__c=1000;
        pr.VG_Rating_Factor__c='Agentur';
        pr.VG_Category__c = 'Type of operation';
        pr.VG_Order__c=1;
        priceList.add(pr);
        VG_Pricing__c pr3=pr.clone(false,true,false,false);
        priceList.add(pr3);
        VG_Pricing__c pr1=new VG_Pricing__c();
        pr1.Name='prTest2';
        pr1.VG_Product__c='GLPL';
        pr1.VG_Level__c = 'Risk Detail';
        pr1.VG_Rate__c=1000;
        pr1.VG_Rating_Factor__c='Agentur';
        pr1.VG_Category__c = 'Deductible Adjustment';
        pr1.VG_Order__c=1;
        priceList.add(pr1);
        VG_Pricing__c pr2=new VG_Pricing__c();
        pr2.Name='prTest3';
        pr2.VG_Product__c='Property';
        pr2.VG_Level__c = 'Risk Detail';
        pr2.VG_Rate__c=1000;
        pr2.VG_Rating_Factor__c='Agentur';
        pr2.VG_Category__c = 'Deductible Adjustment';
        pr2.VG_Order__c=1;
        priceList.add(pr2);
        Insert priceList;
        cntr.gotostep2();
        cntr.updateExposure();
        //below code cover sub classes 
        VG_NordicsProductSteps.LibraryWrapper lw=new VG_NordicsProductSteps.LibraryWrapper();
        VG_NordicsProductSteps.AssetWrapper aw=new VG_NordicsProductSteps.AssetWrapper();
        VG_NordicsProductSteps.RRWrapper rrw=new VG_NordicsProductSteps.RRWrapper();
        VG_NordicsProductSteps.OtherFactors ofa=new VG_NordicsProductSteps.OtherFactors();
        VG_NordicsProductSteps.PricingWrapper pw=new VG_NordicsProductSteps.PricingWrapper();
        // above code cover sub classes 
    }
    
    public static testmethod void testmethod4(){
        VG_TU.policyCustomSetting();
        Account acc=VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        pol.CurrencyIsoCode='SEK';
        Update pol;
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        List<VG_Pricing__c> priceList=new List<VG_Pricing__c>();
        VG_Pricing__c pr=new VG_Pricing__c();
        pr.Name='prTest1';
        pr.VG_Product__c='GLPL';
        pr.VG_Level__c = 'Risk Detail';
        pr.VG_Rate__c=1000;
        pr.VG_Rating_Factor__c='Agentur';
        pr.VG_Category__c = 'Type of operation';
        pr.VG_Order__c=1;
        priceList.add(pr);
        VG_Pricing__c pr3=pr.clone(false,true,false,false);
        priceList.add(pr3);
        VG_Pricing__c pr1=new VG_Pricing__c();
        pr1.Name='prTest2';
        pr1.VG_Product__c='GLPL';
        pr1.VG_Level__c = 'Risk Detail';
        pr1.VG_Rate__c=1000;
        pr1.VG_Rating_Factor__c='Agentur';
        pr1.VG_Category__c = 'Deductible Adjustment';
        pr1.VG_Order__c=1;
        priceList.add(pr1);
        VG_Pricing__c pr2=new VG_Pricing__c();
        pr2.Name='prTest3';
        pr2.VG_Product__c='Property';
        pr2.VG_Level__c = 'Risk Detail';
        pr2.VG_Rate__c=1000;
        pr2.VG_Rating_Factor__c='Agentur';
        pr2.VG_Category__c = 'Deductible Adjustment';
        pr2.VG_Order__c=1;
        priceList.add(pr2);
        Insert priceList;
        Endorsement_Library__c el=VG_TU.createEndorsementLibrary();
        el.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
        el.Type__c='Endorsements';
        el.VG_Product__c='Commercial';
        Update el;
        Endorsement_Library__c el1=el.clone(false,true,false,false);
        el1.Type__c='Sub-limits'; 
        Insert el1;
        VG_Policy_Schedule_Asset__c psa=VG_TU.createPolicyScheduleAsset(ps.id);
        ApexPages.currentPage().getParameters().put('Id', pol.id);
        ApexPages.currentPage().getParameters().put('Currency', pol.CurrencyIsoCode);
        VG_NordicsProductSteps cntr = new VG_NordicsProductSteps();
        VG_NordicsProductSteps.RRWrapper rrw=new VG_NordicsProductSteps.RRWrapper();
        VG_NordicsProductSteps.LibraryWrapper lw=new VG_NordicsProductSteps.LibraryWrapper();
        RRW.psa = psa;
        RRW.counter = '0';
        RRW.share=0;
        cntr.cancel();//completed
        //cntr.updateDeductibleRate();//completed
        cntr.gotostep1A();//completed
        cntr.gotostep2();
        cntr.price=pr2;
        cntr.gotostep2();
        cntr.gotostep3();//completed 
        el.VG_Product__c=cntr.price.VG_Product__c;
        update el;
        el1.VG_Product__c=cntr.price.VG_Product__c;
        update el1;
        cntr.gotostep4();
        cntr.gotostep6();
        System.debug('19.3.2019::'+cntr.LibraryWrapperList1);
        cntr.LibraryWrapperList[0].IsSelected=false;
        cntr.LibraryWrapperList1[0].IsSelected=false;
        cntr.gotostep4b();
        cntr.gotostep6b();
        cntr.AddCustom();
        VG_Policy_Schedule_Endorsement__c tempEndsmt = new VG_Policy_Schedule_Endorsement__c();
        tempEndsmt.CurrencyISOCode = 'USD';
        tempEndsmt.VG_Endorsement_Library_Id__c=el.id;
        //tempEndsmt.VG_Policy_Schedule__c = PSId;
        tempEndsmt.VG_Premium__c = 1000;
        tempEndsmt.VG_Sub_limit__c=1000;
        //counterEnd++;
        //tempEndsmt.Name = PSName + '/PE/'+counterEnd;
        cntr.existingEndorsements1.add(tempEndsmt);
        cntr.existingEndorsements[0].VG_Premium__c =1000;
        cntr.existingEndorsements[0].VG_Sub_limit__c =1000;
        cntr.LibraryWrapperList[0].IsSelected=True;
        cntr.LibraryWrapperList1[0].IsSelected=True;
        cntr.gotostep4b();
        cntr.gotostep6b();
        cntr.gotostep5();//completed
        cntr.addRR();//completed
        cntr.AddCustom();//completed
        cntr.Index='0';
        cntr.counter=0;
        cntr.RemoveRR();//completed
        cntr.RemoveRR();//completed
        cntr.AddAsset();//completed
        cntr.SaveAsset();//completed
        cntr.AddAsset();//completed
        cntr.SaveAsset();//completed
        cntr.AddAsset();//completed
        cntr.SaveAsset();//completed
        cntr.RemoveAsset();//completed
        cntr.CancelAsset();//completed
        cntr.EditAsset();//completed
        cntr.setLPList();
        cntr.price.VG_Product__c='Commercial';
        cntr.setLPList();
        cntr.gotostep4();
        cntr.gotostep6();
        cntr.riskRatingList.add(RRW);
        cntr.IsProperty=false;
        cntr.gotostep4();
        cntr.gotostep6();
        cntr.price.VG_Product__c='GLPL';
        cntr.setLPList();
        cntr.price.VG_Product__c='Life Sciences';
        cntr.setLPList();
        cntr.price.VG_Product__c='D&O';
        cntr.setLPList();
        cntr.price.VG_Product__c='Clinical Trials';
        cntr.setLPList();
        cntr.price.VG_Product__c='Crime';
        cntr.setLPList();
        cntr.price.VG_Product__c='FIPI';
        cntr.setLPList();
        cntr.price.VG_Product__c='PI';
        cntr.setLPList();//completed
        cntr.getFLRates(50000000, 'IPO');
        cntr.getFLRates(100000000, 'IPO');
        cntr.getFLRates(250000000, 'IPO');
        cntr.getFLRates(500000000, 'IPO');
        cntr.getFLRates(750000000, 'IPO');
        cntr.getFLRates(1000000000, 'IPO');
        cntr.getFLRates(1500000000, 'IPO');
        cntr.getFLRates(2500000000L, 'IPO');
        cntr.getFLRates(5000000000L, 'IPO');
        cntr.getFLRates(10000000000L, 'IPO');
        cntr.getFLRates(25000000000L, 'IPO');
        cntr.getFLRates(50000000000L, 'IPO');
        cntr.getFLRates(100000000000L, 'IPO');
        cntr.getFLRates(500000000000L, 'IPO');
        cntr.getFLRates(50000000, 'Crime');
        cntr.getFLRates(100000000, 'Crime');
        cntr.getFLRates(250000000, 'Crime');
        cntr.getFLRates(500000000, 'Crime');
        cntr.getFLRates(750000000, 'Crime');
        cntr.getFLRates(1000000000, 'Crime');
        cntr.getFLRates(1500000000, 'Crime');
        cntr.getFLRates(2500000000L, 'Crime');
        cntr.getFLRates(5000000000L, 'Crime');
        cntr.getFLRates(10000000000L, 'Crime');
        cntr.getFLRates(25000000000L, 'Crime');
        cntr.getFLRates(50000000000L, 'Crime');
        cntr.getFLRates(100000000000L, 'Crime');
        cntr.getFLRates(500000000000L, 'Crime');
        cntr.getFLRates(50000000, 'D&O');
        cntr.getFLRates(100000000, 'D&O');
        cntr.getFLRates(250000000, 'D&O');
        cntr.getFLRates(500000000, 'D&O');
        cntr.getFLRates(750000000, 'D&O');
        cntr.getFLRates(1000000000, 'D&O');
        cntr.getFLRates(1500000000, 'D&O');
        cntr.getFLRates(2500000000L, 'D&O');
        cntr.getFLRates(5000000000L, 'D&O');
        cntr.getFLRates(10000000000L, 'D&O');
        cntr.getFLRates(25000000000L, 'D&O');
        cntr.getFLRates(50000000000L, 'D&O');
        cntr.getFLRates(100000000000L, 'D&O');
        cntr.getFLRates(500000000000L, 'D&O');
        cntr.getFLRates(500000000000L, 'GLPL');//Completed
        //cntr.finish();
    }
}