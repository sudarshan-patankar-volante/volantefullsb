@isTest(SeeAllData = True)
public class VG_CC_Nordics_StepController_Test {
    public static testMethod void TestMethod1(){
        //VG_TU.policyCustomSetting();
        Test.setMock(HttpCalloutMock.class, new ComplyAdvantageCheckMock()); 
        Account acc=VG_TU.createAccount('Customer');
        Asset__c ass=VG_TU.createAsset(acc.id);
        ass.VG_Machinery_SI__c=2000;
        ass.VG_Other_SI__c=200;
        ass.VG_Goods_SI__c=2000;
        ass.VG_Customer_Property_SI__c=2000;
        ass.VG_Contents_SI__c=2000;
        ass.VG_BI_Indemnity_Period__c='36 Months';
        ass.VG_MB_BI_Indemnity_Period__c='36 Months';
        ass.VG_Waiting_Period__c='168 Hours';
        ass.VG_MB_Waiting_Period__c='168 Hours';
        ass.VG_Total_MBBISI_for_the_indemnity_period__c=2000;
        ass.VG_Total_BISI_for_the_indemnity_period__c=2000;
        ass.VG_PD_Deductible__c=2000;
        ass.VG_MB_PD_Deductible__c=2000;
        ass.VG_Comment__c='test';
        update ass;
        Test.startTest();
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        //Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.Id);
        ApexPages.currentPage().getParameters().put('policyId', pol.id);
        VG_CC_Nordics_StepController cc=new VG_CC_Nordics_StepController();
        cc.addRiskRating();
        cc.selectedOccupancy = 'Administrativa tjänster till finansmarknaden - 6611001';
        String[] s=new String[]{'Fire','Burglary','Water','All Risk','Machinery Breakdown','CAR/EAR','Escaping Liquid','Cistern','Freeze & Refrigerator','Robbery','Special Objects','Business Interruption','Machinery BI','Personal Accident (visitor)','Crisis','Crime','Legal Aid','Liability GL/PL','Epidemic Disease','Loss of Rent','Extra Costs','Business Interruption due to Health Problems','Professional Indemnity','Business Sample','Forklift','Lift','Tools','Assault'};
        for(integer i=0;i<s.size();i++){
            cc.currentCW = new VG_CC_Nordics_StepController.CoverageWrapper();
            cc.currentCW.selectedCoverage=s[i];
            cc.setCoverageContext();
            cc.setCoveragePricings();
        }
        cc.gotostep2();
        cc.gotostep3(); 
        VG_Policy_Schedule_Endorsement__c pse=new VG_Policy_Schedule_Endorsement__c();
        pse.VG_Premium__c = 100;
        cc.existingEndorsements.add(pse);
        cc.gotostep4();
        cc.gotostep4b();
        cc.gotostep5();
        cc.gotostep5b();
        cc.gotostep6();
        cc.finish();
        Policy_Schedule__c ps= [Select Id from Policy_Schedule__c LIMIT 1];
        ps.Limit__c = 10000;
        ps.Attachment__c = 500000;
        ps.Sum_Insured__c = 1500000;
        ps.Written_share__c = 50;
        ps.VG_Rate_Change__c = 0;
        ps.VG_Deductible__c = 2000;
        ps.Technical_Layer_Premium__c = 2000;
        ps.Gross_Written_Premium__c = 2500;
        ps.VG_Gross_Written_Premium_100__c = 5000;
        ps.Gross_or_Net_Premium__c  = 'Net';
        ps.Rate_On_Line__c = 3400; 
        //VG_Auto_acquisition_Threshold__c
        ps.VG_Retired_Directors_Additional_Premium__c = 200;
        ps.VG_Retired_Directors_Year__c = 1989;
        //VG_Extended_Reporting_Period_AP__c
        ps.Rate_Per_Mil__c  = 1300;
        ps.Share__c = 50;
        ps.Technical_UW_Premium__c = 3000;
        ps.Premium_Adjustment__c = 2000;
        ps.Underwriting_Premium__c = 5000;
        ps.Premium_Adjustment_2__c = 1000;
        ps.VG_Technical_Model_Premium__c = 4500;
        //ORC__c = 2000;
        //ORC_Amount__c 
        ps.VG_Brokerage_Percent__c = 10;
        ps.Actual_GWP__c = 5000;
        ps.VG_Brokerage_Amount__c = 500;
        ps.IPT__c = 100;
        ps.Levies__c = 250;
        ps.VG_Fee_Income__c = 100; 
        //VG_CREDIT_Augur_SCORE__c 
        ps.VG_Exposure_Premium__c = 4500;
        ps.VG_Experience_Premium__c = 5000;
        ps.VG_Selected_Weight__c = 0.2; 
        ps.VG_Net_Base_Premium__c = 4000;
        Update ps;
        Test.stopTest();
        /*ApexPages.currentPage().getParameters().put('PSId', ps.id);
        ApexPages.currentPage().getParameters().put('policyId', pol.id);
        ApexPages.currentPage().getParameters().put('policyCurrency', 'SEK');
        VG_CC_Revise_Nordics_StepController ccRevise = new VG_CC_Revise_Nordics_StepController();
        ccRevise.selectedOccupancy = 'Administrativa tjänster till finansmarknaden - 6611001';
        ccRevise.gotostep2();
        ccRevise.gotostep3(); 
        VG_Policy_Schedule_Endorsement__c pse2=new VG_Policy_Schedule_Endorsement__c();
        pse2.VG_Premium__c = 200;
        ccRevise.existingEndorsements.add(pse2);
        ccRevise.gotostep4();
        ccRevise.gotostep4b();
        ccRevise.gotostep5();
        ccRevise.gotostep5b();
        ccRevise.gotostep6();
        ccRevise.finish();*/
    }
    
    
    public static testMethod void TestMethod2(){
        //VG_TU.policyCustomSetting();
        Test.setMock(HttpCalloutMock.class, new ComplyAdvantageCheckMock()); 
        Account acc=VG_TU.createAccount('Customer');
        Asset__c ass=VG_TU.createAsset(acc.id);
        ass.VG_Machinery_SI__c=2000;
        ass.VG_Other_SI__c=200;
        ass.VG_Goods_SI__c=2000;
        ass.VG_Customer_Property_SI__c=2000;
        ass.VG_Contents_SI__c=2000;
        ass.VG_BI_Indemnity_Period__c='36 Months';
        ass.VG_MB_BI_Indemnity_Period__c='36 Months';
        ass.VG_Waiting_Period__c='168 Hours';
        ass.VG_MB_Waiting_Period__c='168 Hours';
        ass.VG_Total_MBBISI_for_the_indemnity_period__c=2000;
        ass.VG_Total_BISI_for_the_indemnity_period__c=2000;
        ass.VG_PD_Deductible__c=2000;
        ass.VG_MB_PD_Deductible__c=2000;
        ass.VG_Comment__c='test';
        update ass;
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);
        //Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.Id);
        ApexPages.currentPage().getParameters().put('policyId', pol.id);
        VG_CC_Nordics_StepController cc=new VG_CC_Nordics_StepController();
        
        cc.gotostep2();
        cc.gotostep3(); 
        VG_Policy_Schedule_Endorsement__c pse=new VG_Policy_Schedule_Endorsement__c();
        pse.VG_Premium__c = 100;
        cc.existingEndorsements.add(pse);
        cc.gotostep4();
        cc.gotostep4b();
        cc.gotostep5();
        cc.gotostep5b();
        cc.gotostep6();
        cc.finish();
        Policy_Schedule__c ps= [Select Id from Policy_Schedule__c LIMIT 1];
        ps.Limit__c = 10000;
        ps.Attachment__c = 500000;
        ps.Sum_Insured__c = 1500000;
        ps.Written_share__c = 50;
        ps.VG_Rate_Change__c = 0;
        ps.VG_Deductible__c = 2000;
        ps.Technical_Layer_Premium__c = 2000;
        ps.Gross_Written_Premium__c = 2500;
        ps.VG_Gross_Written_Premium_100__c = 5000;
        ps.Gross_or_Net_Premium__c  = 'Net';
        ps.Rate_On_Line__c = 3400; 
        //VG_Auto_acquisition_Threshold__c
        ps.VG_Retired_Directors_Additional_Premium__c = 200;
        ps.VG_Retired_Directors_Year__c = 1989;
        //VG_Extended_Reporting_Period_AP__c
        ps.Rate_Per_Mil__c  = 1300;
        ps.Share__c = 50;
        ps.Technical_UW_Premium__c = 3000;
        ps.Premium_Adjustment__c = 2000;
        ps.Underwriting_Premium__c = 5000;
        ps.Premium_Adjustment_2__c = 1000;
        ps.VG_Technical_Model_Premium__c = 4500;
        //ORC__c = 2000;
        //ORC_Amount__c 
        ps.VG_Brokerage_Percent__c = 10;
        ps.Actual_GWP__c = 5000;
        ps.VG_Brokerage_Amount__c = 500;
        ps.IPT__c = 100;
        ps.Levies__c = 250;
        ps.VG_Fee_Income__c = 100; 
        //VG_CREDIT_Augur_SCORE__c 
        ps.VG_Exposure_Premium__c = 4500;
        ps.VG_Experience_Premium__c = 5000;
        ps.VG_Selected_Weight__c = 0.2; 
        ps.VG_Net_Base_Premium__c = 4000;
        Update ps;
        Test.startTest();
        ApexPages.currentPage().getParameters().put('PSId', ps.id);
        ApexPages.currentPage().getParameters().put('policyId', pol.id);
        ApexPages.currentPage().getParameters().put('policyCurrency', 'SEK');
        VG_CC_Revise_Nordics_StepController ccRevise = new VG_CC_Revise_Nordics_StepController();
        ccRevise.selectedOccupancy = 'Administrativa tjänster till finansmarknaden - 6611001';
        ccRevise.addRiskRating();
        String[] s=new String[]{'Fire','Burglary','Water','All Risk','Machinery Breakdown','CAR/EAR','Escaping Liquid','Cistern','Freeze & Refrigerator','Robbery','Special Objects','Business Interruption','Machinery BI','Personal Accident (visitor)','Crisis','Crime','Legal Aid','Liability GL/PL','Epidemic Disease','Loss of Rent','Extra Costs','Business Interruption due to Health Problems','Professional Indemnity','Business Sample','Forklift','Lift','Tools','Assault'};
        for(integer i=0;i<s.size();i++){
            System.debug('Coverage is: '+s);
            ccRevise.currentCW = new VG_CC_Revise_Nordics_StepController.CoverageWrapper();
            ccRevise.currentCW.selectedCoverage=s[i];
            ccRevise.setCoverageContext();
            ccRevise.setCoveragePricings();
        }
        ccRevise.gotostep2();
        ccRevise.gotostep3(); 
        VG_Policy_Schedule_Endorsement__c pse2=new VG_Policy_Schedule_Endorsement__c();
        pse2.VG_Premium__c = 200;
        ccRevise.existingEndorsements.add(pse2);
        ccRevise.gotostep4();
        ccRevise.gotostep4b();
        ccRevise.gotostep5();
        ccRevise.gotostep5b();
        ccRevise.gotostep6();
        ccRevise.finish();
        Test.stopTest();
    }
}