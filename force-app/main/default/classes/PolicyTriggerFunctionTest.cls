@IsTest(SeeAllData=False)
Public Class PolicyTriggerFunctionTest{ 
    Public Static TestMethod Void unitTestMethod1(){  
        VG_TU.policyCustomSetting();
        Test.startTest();
        Utilities.SkipMethods('Bridge Context');
        Account acc = VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createPolicy('Edison Motor',acc.id);  
        pol.VG_Inception_Date__c=Date.newInstance(2019, 12, 18);
        pol.VG_Expiry_Date__c=Date.newInstance(2020, 12, 18);
        pol.Policy_Status__c='Working';
        update pol; 
        pol.Policy_Status__c='Quoted';
        update pol;
        pol.VG_Sub_Status__c  = 'Approved';
        pol.VG_IsApproved__c = True;
        pol.Policy_Status__c='Bound';
        update pol;
        pol.Policy_Status__c='Booked';
        update pol;
        List<Policy__c> polList=new List<Policy__c>();
        Policy__c pol1=pol.clone(false,true,false,false);
        pol1.Policy_Status__c='Quoted';
        Policy__c pol2=pol.clone(false,true,false,false);
        pol2.VG_Quoted_Time__c=system.today();
        pol2.Policy_Status__c='Bound';
        pol2.VG_Sub_Status__c='Approved';
        polList.add(pol1);
        polList.add(pol2);
        Insert polList;
        Policy__c pol3=pol2.clone(false,true,false,false);
        pol3.VG_Bound_Time__c=system.today();
        pol3.Line_Of_Business__c='Motor';
        pol3.Policy_Status__c='Booked';
        Insert pol3;
        Test.stopTest();
    }
    Public Static TestMethod Void unitTestMethod2(){    
        VG_TU.policyCustomSetting();
        Account acc = VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createCustomPolicy('Gentium',acc.id);  
        pol.Policy_Status__c='Working';
        update pol;
        pol.Policy_Status__c='Quoted';
        update pol;
    }   
    
    Public Static TestMethod Void unitTestMethod3(){    
        VG_TU.policyCustomSetting();
        VG_TU.ValidationCustomSetting();
        Account acc = VG_TU.createAccount('Customer');
        Utilities.SkipMethods('Bridge Context');
        Policy__c pol=VG_TU.createCustomPolicy('Bridge',acc.id); 
        Test.startTest();
        List<Policy_Schedule__c> pslist = new List<Policy_Schedule__c>();
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Policy_Schedule__c ps1=VG_TU.createPolicySchedule(pol.id);
        ps.Product__c = 'GLPL';
        ps.VG_Lloyds_Product__c='NA-GL/ PL excl Claims Made excl USA';
        ps.Sum_Insured__c=50000;
        ps1.Product__c='Property';
        ps1.VG_Lloyds_Product__c='P3-PD Primary Layer Property excl USA';
        ps1.Sum_Insured__c=500000;
        Policy_Schedule__c ps2=VG_TU.createPolicySchedule(pol.id);
        Policy_Schedule__c ps3=VG_TU.createPolicySchedule(pol.id);
        ps2.Product__c = 'Life Sciences';
        ps2.VG_Lloyds_Product__c='PB-Product Recall';
        ps2.Sum_Insured__c=20000;
        ps3.Product__c='D&O';
        ps3.VG_Lloyds_Product__c='D2-D&O excl FI incl USA';
        ps2.Sum_Insured__c=350000000;
        Policy_Schedule__c ps4=VG_TU.createPolicySchedule(pol.id);
        Policy_Schedule__c ps5=VG_TU.createPolicySchedule(pol.id);
        ps4.Product__c = 'PI';
        ps4.VG_Lloyds_Product__c='E8-PI excl Legal/ Acc / Arch/ Eng/ FI incl USA';
        ps4.Sum_Insured__c=70000;
        ps5.Product__c='FIPI';
        ps5.VG_Lloyds_Product__c='F2-PI FI incl USA';
        ps5.Sum_Insured__c=150000;
        pslist.add(ps);
        pslist.add(ps1);
        pslist.add(ps2);
        pslist.add(ps3);
        pslist.add(ps4);
        pslist.add(ps5);        
        update pslist;        
        
        VG_UMR__c umr = VG_TU.createUMR(acc.id);        
        List<VG_ReInsurance__c> riList = new List<VG_ReInsurance__c>();
        for(Policy_Schedule__c psh: pslist){
            VG_ReInsurance__c ri=new VG_ReInsurance__c();
            ri.Name='Test';
            ri.VG_Brokerage_Amount__c=25256;
            ri.VG_MGA_Commission_Override__c='';
            ri.VG_UMR__c=umr.id;
            ri.VG_Policy_Schedule__c=psh.Id;
            riList.add(ri);
        }
        Insert riList;       
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);       
        Risk_Capture__c rc = VG_TU.createRiskCapture(ps.id);
        VG_Payment_Frequency__c pf=VG_TU.createPaymentFrequency(ps.id);  
        VG_Governance_Compliance__c gc = new VG_Governance_Compliance__c();
        gc.VG_UW_Consideration__c = 'UW Consideration';
        gc.Name = pol.Name+'gc';
        insert gc;
        pol.Policy_Status__c='Working';
        update pol;
        pol.Policy_Status__c='Quoted';
        update pol;
        Utilities.clearMethods();
        Test.stopTest();
    }   
    
    Public Static TestMethod Void unitTestMenthod5(){    
        VG_TU.policyCustomSetting();
        //VG_TU.ValidationCustomSetting();
        Test.startTest();       
        Utilities.SkipMethods('Trigger Context2'); 
        
        Account acc = VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createCustomPolicy('Bridge',acc.id);
        pol.Policy_Status__c='Working';
        update pol;        
        pol.Policy_Status__c='Quoted';
        update pol;
        pol.Policy_Status__c = 'Bound';
        update pol;        
        List<Policy_Schedule__c> pslist = new List<Policy_Schedule__c>();
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        Policy_Schedule__c ps1=VG_TU.createPolicySchedule(pol.id);
        ps.Product__c = 'GLPL';
        ps.VG_Lloyds_Product__c='NA-GL/ PL excl Claims Made excl USA';
        ps.Sum_Insured__c=50000000;
        ps1.Product__c='Property';
        ps1.VG_Lloyds_Product__c='P3-PD Primary Layer Property excl USA';
        ps1.Sum_Insured__c=50000000;
        Policy_Schedule__c ps2=VG_TU.createPolicySchedule(pol.id);
        Policy_Schedule__c ps3=VG_TU.createPolicySchedule(pol.id);
        ps2.Product__c = 'Life Sciences';
        ps2.VG_Lloyds_Product__c='PB-Product Recall';
        ps2.Sum_Insured__c=20000000;
        ps3.Product__c='D&O';
        ps3.VG_Lloyds_Product__c='D2-D&O excl FI incl USA';
        ps2.Sum_Insured__c=350000000;
        Policy_Schedule__c ps4=VG_TU.createPolicySchedule(pol.id);
        Policy_Schedule__c ps5=VG_TU.createPolicySchedule(pol.id);
        ps4.Product__c = 'PI';
        ps4.VG_Lloyds_Product__c='E8-PI excl Legal/ Acc / Arch/ Eng/ FI incl USA';
        ps4.Sum_Insured__c=70000000;
        ps5.Product__c='FIPI';
        ps5.VG_Lloyds_Product__c='F2-PI FI incl USA';
        ps5.Sum_Insured__c=150000;
        pslist.add(ps);
        pslist.add(ps1);
        pslist.add(ps2);
        pslist.add(ps3);
        pslist.add(ps4);
        pslist.add(ps5);        
        update pslist;        
        PolicyTriggerFunction.avoidRecursion=false;
        VG_UMR__c umr = VG_TU.createUMR(acc.id);        
        List<VG_ReInsurance__c> riList = new List<VG_ReInsurance__c>();
        for(Policy_Schedule__c psh: pslist){
            VG_ReInsurance__c ri=new VG_ReInsurance__c();
            ri.Name='Test';
            ri.VG_Brokerage_Amount__c=25256;
            ri.VG_MGA_Commission_Override__c='';
            ri.VG_UMR__c=umr.id;
            ri.VG_Policy_Schedule__c=psh.Id;
            riList.add(ri);
        }
        Insert riList;       
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);       
        Risk_Capture__c rc = VG_TU.createRiskCapture(ps.id);
        VG_Payment_Frequency__c pf=VG_TU.createPaymentFrequency(ps.id);  
        VG_Governance_Compliance__c gc = new VG_Governance_Compliance__c();
        gc.VG_UW_Consideration__c = 'UW Consideration';
        gc.Name = pol.Name+'gc';
        insert gc;
        pol.VG_Sub_Status__c='Awaiting Approval';        
        pol.Policy_Status__c = 'Booked';
        update pol;
        Test.stopTest();
    }   
    
    Public Static TestMethod Void unitTestMenthod4(){    
        VG_TU.policyCustomSetting();
        VG_TU.ValidationCustomSetting();
        Account acc = VG_TU.createAccount('Customer');
        Policy__c pol=VG_TU.createCustomPolicy('VFP',acc.id); 
        Test.startTest();
        List<Policy_Schedule__c> pslist = new List<Policy_Schedule__c>();
        Policy_Schedule__c ps=VG_TU.createPolicySchedule(pol.id);
        //Policy_Schedule__c ps1=VG_TU.createPolicySchedule(pol.id);        
        pslist.add(ps);
        //pslist.add(ps1);        
        update pslist;                
        VG_UMR__c umr = VG_TU.createUMR(acc.id);        
        List<VG_ReInsurance__c> riList = new List<VG_ReInsurance__c>();
        VG_ReInsurance__c ri=new VG_ReInsurance__c();
        ri.Name='Test';
        ri.VG_Brokerage_Amount__c=25256;
        ri.VG_MGA_Commission_Override__c='';
        ri.VG_UMR__c=umr.id;
        ri.VG_Policy_Schedule__c=ps.Id;
        riList.add(ri);
        Insert riList;       
        VG_Policy_Schedule_Asset__c rr=VG_TU.createPolicyScheduleAsset(ps.id);       
        Risk_Capture__c rc = VG_TU.createRiskCapture(ps.id);
        VG_Payment_Frequency__c pf=VG_TU.createPaymentFrequency(ps.id);  
        VG_Governance_Compliance__c gc = new VG_Governance_Compliance__c();
        gc.VG_UW_Consideration__c = 'UW Consideration';
        gc.Name = pol.Name+'gc';
        insert gc;        
        Test.stopTest();
    }       
}