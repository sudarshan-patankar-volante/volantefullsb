public class VG_TU{
    Public Static Policy__c createPolicy(String RecordType,Id accid){
        Id p = [select id from profile where name='Partner Community User'].id;
       
        Contact con = new Contact(FirstName='Test',LastName ='testCon',Position__c='manager',AccountId = accId,MobilePhone='9000000000',Email='test@test.com');
        insert con;  
        //UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];         
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                VG_Underwriter__c=true,
                timezonesidkey='America/Los_Angeles', username='Partneruser@noemail.com');
       
        insert user;
        Policy__c pol=new Policy__c();
        system.runAs(user) {
            pol.RecordTypeId=Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get(RecordType).getRecordTypeId();
            pol.Insured__c=accid;
            pol.Policy_Status__c='Prospect';
            pol.Line_Of_Business__c='Motor';
            pol.VG_Inception_Date__c=Date.newInstance(2017, 12, 18);
            pol.VG_Expiry_Date__c=Date.newInstance(2018, 12, 18);
            pol.Inception_Expiry_Time__c='13:05';
            pol.CurrencyIsoCode='GBP';
            Account ba=VG_TU.createAccount('Broker');
            ba.VG_Volante_Entities__c='BUAB; HEAG; VCL; VEML; VIL; VSR LLC; VTSL';
            update ba;        
            pol.Broker_Name__c=ba.id;
            pol.Underwriter__c=user.Id;
            pol.VG_Ignore_Validation__c=True;
            pol.Type_of_Insurance__c='Direct';
            pol.Declaration_Type__c='Quarterly';
            pol.Deductible_or_Excess_Amount__c=5000;
            Insert pol;
            
        }
        return pol;
    }
    Public Static Policy__c createCustomPolicy(String RecordType,Id accid){
        Id p = [select id from profile where name='Partner Community User'].id;
       
        Contact con = new Contact(FirstName='Test',LastName ='testCon',Position__c='manager',AccountId = accId,MobilePhone='9000000000',Email='test@test.com');
        insert con;  
        
                  
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = p, country='United States',IsActive =true,
                ContactId = con.Id,
                VG_Underwriter__c=true,
                Approval_Limit__c =450,
                timezonesidkey='America/Los_Angeles', username='Partneruser2@noemail.com');
       
        insert user;
        system.runAs(user) {
            // statements to be executed by this test user.
        }
        Policy__c pol=new Policy__c();
        pol.RecordTypeId=Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get(RecordType).getRecordTypeId();
        //pol.Name='Test';
        pol.Insured__c=accid;
        pol.Policy_Status__c='Prospect';
        pol.Line_Of_Business__c='Motor';
        pol.VG_Inception_Date__c=Date.newInstance(2017, 12, 18);
        pol.VG_Expiry_Date__c=Date.newInstance(2018, 12, 18);
        pol.Inception_Expiry_Time__c='13:05';
        pol.CurrencyIsoCode='GBP';
        //Code added by siddik on 26.2.2018
        Account ba=VG_TU.createAccount('Broker');
        ba.VG_Volante_Entities__c='BUAB; HEAG; VCL; VEML; VIL; VSR LLC; VTSL';
        update ba;
        Authority_Approvals__c baa = new Authority_Approvals__c();
        baa.Name='Test';
        baa.VG_User_Name__c = user.id;
        baa.CurrencyIsoCode='GBP';
        insert baa;
        pol.Broker_Name__c=ba.id;
        pol.VG_Surplus_Broker__c=ba.id;       
        pol.Underwriter__c=User.Id;
        pol.Type_of_Insurance__c='Direct';
        pol.Declaration_Type__c='Quarterly';
        pol.Deductible_or_Excess_Amount__c=5000;
        pol.VG_Ignore_Validation__c=false;
        Insert pol;        
        //Code added finished on 26.2.2018
        return pol;
    }
    Public Static VG_Policy_Schedule_Endorsement__c createPolicyScheduleEndorsement(Id psid){
        VG_Policy_Schedule_Endorsement__c pse=new VG_Policy_Schedule_Endorsement__c();
        pse.VG_Policy_Schedule__c=psid;
        pse.Name='Test';
        pse.VG_Type__c='Endorsements';
        pse.VG_Title__c='Test';
        pse.VG_Premium__c=25000;
        pse.VG_Endorsement_Number__c='Test';
        insert pse;
        return pse;
    }
    //Code added by siddik on 26.2.2018 
    public static Contact createContact(Account acc){
        Contact con =new Contact();
        con.FirstName='Test';
        con.Position__c='manager';
        con.LastName='Contact';
        con.MobilePhone='9000000000';
        con.Email='test@test.com';
        con.Account=acc;
        con.AccountId=acc.id;
        Insert con;
        return con;
    }
    //Code added finished  on 26.2.2018 
    Public Static Endorsement_Library__c createEndorsementLibrary(){
        Endorsement_Library__c el=new Endorsement_Library__c();
        el.Endorsement_Title__c='Test title';
        el.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        el.Status__c='Endorsements';
        el.Text__c='this is test class text';
        Insert el;
        return el;
    }
    Public Static Endorsement_Library__c createEndorsementLibraryCustom(String RecordType,String Type){
        Endorsement_Library__c el=new Endorsement_Library__c();
        el.Endorsement_Title__c='Test title';
        el.RecordTypeId=Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get(RecordType).getRecordTypeId();
        el.Type__c=Type;
        el.Text__c='this is test Endroesment Record';
        Insert el;
        return el;
    }
    Public Static VG_Payment_Frequency__c createPaymentFrequency(Id psid){      
        VG_Payment_Frequency__c pf=new VG_Payment_Frequency__c();
        pf.Name='test';
        pf.VG_Policy_Schedule__c=psid;
        pf.VG_Due_Date__c=Date.newInstance(2019, 6, 6);
        pf.VG_GWP_This_Time__c=4500;
        pf.VG_Payment_Percent__c=50;
        Insert pf;
        return pf;
    }
    //Code added by Anu  on 13.4.2018 
    Public Static Claim__c createClaim(Id accid,Id polid){      
        claim__c c=new Claim__c();
        c.Name='test';
        c.Account__c=accid;
        c.Policy_Number__c=polid;
        c.Risk_Inception_Date__c=Date.newInstance(2017, 12, 18);
        Insert c;
        return c;
    }
    Public Static Claims_Schedule__c createClaimSchedule(Id accid,Id psid,Id cid){      
        Claims_Schedule__c csc=new Claims_Schedule__c();
        csc.Name='test';
        csc.Claimant_Name__c=accid;        
        csc.VG_Policy_Schedule__c=psid;
        csc.Claim__c=cid;
        Insert csc;
        System.debug('csc::'+csc);
        return csc;
    }
    Public Static Claims_Progression__c createClaimProgression(String RecordType,Id csid){      
        Claims_Progression__c cp=new Claims_Progression__c();
        cp.RecordTypeId=Schema.SObjectType.Claims_Progression__c.getRecordTypeInfosByName().get(RecordType).getRecordTypeId();        
        cp.Name='Test';
        cp.VG_Claims_Schedule__c=csid;
        Insert cp;
        return cp;
    }
    //Code added finished  on 13.4.2018 
    Public Static void policyCustomSetting(){
        List<SObject> insertPCS=new List<SObject>();
        Skip_Context__c sc = new Skip_Context__c();
        sc.Name = 'Bridge Context';
        sc.Methods__c = 'RollupFields;UMRRollupFields;checkvalidation;ValidateMandatoryFields';
        sc.Recursion_Name__c = 'Bridge Context';
        insertPCS.add(sc);
        Skip_Context__c sc1 = new Skip_Context__c();
        sc1.Name = 'Trigger Context2';
        sc1.Methods__c = 'updateSLAFields;PolicyNumberAutoGEN;InsertValidateMandatoryFields;checkHorizonPoliciesForApproval;ValidateMandatoryFields;clonePS;currencyUpdateOnChilds;updateRIRecords;sendApprovals;UpdateRollUpAccountFields;UMRRollupFields;deleteGovernancecompliance';
        sc1.Recursion_Name__c = 'Trigger Context2';
        insertPCS.add(sc1);
        Skip_Context__c sc2 = new Skip_Context__c();
        sc2.Name = 'Trigger Context';
        sc2.Methods__c = 'RollupFields;checkvalidation;setCOI_Ext_Cac_Reduc;createCOInsuranceChildsforMTAPS;UpdateRiskDateFields;updateSLAFields;InsertValidateMandatoryFields;PolicyNumberAutoGEN;setPolicyLloydsProducts;checkPaymentRecords';
        sc2.Recursion_Name__c = 'Trigger Context';
        insertPCS.add(sc2);
        Skip_Context__c sc3 = new Skip_Context__c();
        sc3.Name = 'ExpiryDate_Update_2';
        sc3.Methods__c = 'UpdateRollUpAccountFields;deleteGovernancecompliance;setExpiryDateforExtension';
        sc3.Recursion_Name__c = 'ExpiryDate_Update_2';
        insertPCS.add(sc3);
        Skip_Context__c sc4 = new Skip_Context__c();
        sc4.Name = 'ExpiryDate_Update_1';
        sc4.Methods__c = 'sendApprovals;updateSLAFields;InsertValidateMandatoryFields;PolicyNumberAutoGEN;setPolicyLloydsProducts;checkPaymentRecords;checkHorizonPoliciesForApproval;ValidateMandatoryFields;clonePS;currencyUpdateOnChilds;UMRRollupFields';
        sc4.Recursion_Name__c = 'ExpiryDate_Update_1';
        insertPCS.add(sc4);
        Skip_Context__c sc5 = new Skip_Context__c();
        sc5.Name = 'Payment Frequency Context';
        sc5.Methods__c = 'updateSLAFields;setPolicyLloydsProducts;checkEligibilityForApproval;UpdateRollUpAccountFields';
        sc5.Recursion_Name__c = 'Payment Frequency Context';
        insertPCS.add(sc5);
        SystemConstants__c cs = new SystemConstants__c();
        cs.Name='Latest Policy Name';
        cs.DocumentId__c = 'EDM/MTR/00039/2017/1';
        insertPCS.add(cs);
        SystemConstants__c cs1 = new SystemConstants__c();
        cs1.Name='Invoice Number';
        cs1.DocumentId__c = '1000';
        insertPCS.add(cs1);
        Policy_Record_Type__c prt = new Policy_Record_Type__c ();
        prt.Name='Edison Motor';
        prt.Code__c = 'EM';
        insertPCS.add(prt);
        Policy_Record_Type__c prt2 = new Policy_Record_Type__c ();
        prt2.Name='Bridge';
        prt2.Code__c = 'BDM';
        insertPCS.add(prt2);
        Policy_Record_Type__c prt9 = new Policy_Record_Type__c ();
        prt9.Name='VCL';
        prt9.Code__c = 'VCL';
        insertPCS.add(prt9);
        Policy_Record_Type__c prt3 = new Policy_Record_Type__c ();
        prt3.Name='Horizon';
        prt3.Code__c = 'HOZ';
        insertPCS.add(prt3);
        Policy_Record_Type__c prt4 = new Policy_Record_Type__c ();
        prt4.Name='VFP';
        prt4.Code__c = 'VFP';
        insertPCS.add(prt4);
        Policy_Record_Type__c prt5 = new Policy_Record_Type__c ();
        prt5.Name='Aesir';
        prt5.Code__c = 'Aesir';
        insertPCS.add(prt5);       
        Policy_Record_Type__c prt6 = new Policy_Record_Type__c ();
        prt6.Name='Gentium';
        prt6.Code__c = 'GEN';
        insertPCS.add(prt6);
        Policy_Record_Type__c prt7 = new Policy_Record_Type__c ();
        prt7.Name='Affinity';
        prt7.Code__c = 'AFS';
        insertPCS.add(prt7);
        Policy_Record_Type__c prt8 = new Policy_Record_Type__c ();
        prt8.Name='Imara';
        prt8.Code__c = 'IMR';
        insertPCS.add(prt8);
        Policy_LOB__c lob = new Policy_LOB__c();
        lob.Name='Motor';
        lob.Code__c = 'MTR';
        insertPCS.add(lob);
        Policy_LOB__c lob2 = new Policy_LOB__c();
        lob2.Name='Property';
        lob2.Code__c = 'PTY';
        insertPCS.add(lob2);
        Declaration_Rates__c dr =new Declaration_Rates__c();
        dr.Name='Edison_Motor';
        dr.Q1_Declaration_Rate__c=87.50;
        dr.Q2_Declaration_Rate__c=62.50;
        dr.Q3_Declaration_Rate__c=37.50;
        dr.Q4_Declaration_Rate__c=12.50;
        dr.Annual_Declaration_Rate__c=50;
        dr.Half_Yearly_Declaration_Rate__c=25;
        insertPCS.add(dr);       
        insert insertPCS;        
    }
    
    Public Static void ValidationCustomSetting(){
        List<VG_Validations__c> valList = new List<VG_Validations__c>();  
        VG_Validations__c val = new VG_Validations__c();
        val.Name = 'Policy_23_VFP';
        val.VG_Field_API__c ='CurrencyIsoCode';
        val.VG_Field_Label__c='CurrencyIsoCode';
        val.VG_Level__c='Policy';
        val.VG_Policy_Status__c='Prospect';
        val.VG_RecordTypeName__c='VFP';
        val.VG_Type__c='Null check';
        val.VG_Value__c='';
        valList.add(val);
        VG_Validations__c val2 = new VG_Validations__c();
        val2.Name = 'Account_EDM';
        val2.VG_Field_API__c ='ShippingStreet';
        val2.VG_Field_Label__c='Shipping Street';
        val2.VG_Level__c='Account';
        val2.VG_Policy_Status__c='Prospect';
        val2.VG_RecordTypeName__c='Edison Motor';
        val2.VG_Type__c='Null check';
        val2.VG_Value__c='';
        valList.add(val2);
        VG_Validations__c val1 = new VG_Validations__c();
        val1.Name = 'CBDX_HOZ1';
        val1.VG_Field_API__c ='VG_UMR__c';
        val1.VG_Field_Label__c='UMR';
        val1.VG_Level__c='Capacity Bordereaux';
        val1.VG_Policy_Status__c='Prospect';
        val1.VG_RecordTypeName__c='Affinity';
        val1.VG_Type__c='Null check';
        val1.VG_Value__c='';
        valList.add(val1);
        VG_Validations__c val3 = new VG_Validations__c();
        val3.Name = 'GC';
        val3.VG_Field_API__c ='VG_Referral_completed_By__c';
        val3.VG_Field_Label__c='Referral completed By';
        val3.VG_Level__c='Governance & Compliance';
        val3.VG_Policy_Status__c='Prospect';
        val3.VG_RecordTypeName__c='Gentium';
        val3.VG_Type__c='Null check';
        val3.VG_Value__c='';
        valList.add(val3);
        VG_Validations__c val4 = new VG_Validations__c();
        val4.Name = 'Payment Frequency_Aesir3';
        val4.VG_Field_API__c ='VG_Due_Date__c';
        val4.VG_Field_Label__c='Due Date';
        val4.VG_Level__c='Payment Frequency';
        val4.VG_Policy_Status__c='Prospect';
        val4.VG_RecordTypeName__c='Aesir';
        val4.VG_Type__c='Null check';
        val4.VG_Value__c='';
        valList.add(val4);
        VG_Validations__c val5 = new VG_Validations__c();
        val5.Name = 'Policy_23_Imara';
        val5.VG_Field_API__c ='VG_LTA_Start_Date__c';
        val5.VG_Field_Label__c='LTA Start Date';
        val5.VG_Level__c='Policy';
        val5.VG_Policy_Status__c='Prospect';
        val5.VG_RecordTypeName__c='Imara';
        val5.VG_Type__c='Null check';
        val5.VG_Value__c='';
        valList.add(val5);
         VG_Validations__c val6 = new VG_Validations__c();
        val6.Name = 'Policy_2';
        val6.VG_Field_API__c ='VG_Surplus_Lines_Broker_License_No__c';
        val6.VG_Field_Label__c='Surplus Lines Broker Licence No';
        val6.VG_Level__c='Broker';
        val6.VG_Policy_Status__c='Prospect';
        val6.VG_RecordTypeName__c='Horizon';
        val6.VG_Type__c='Null check';
        val6.VG_Value__c='';
        valList.add(val6);
        VG_Validations__c val7 = new VG_Validations__c();
        val7.Name = 'RR';
        val7.VG_Field_API__c ='VG_GNPI__c';
        val7.VG_Field_Label__c='GNPI';
        val7.VG_Level__c='Risk Rating';
        val7.VG_Policy_Status__c='Prospect';
        val7.VG_RecordTypeName__c='Bridge';
        val7.VG_Type__c='Null check';
        val7.VG_Value__c='';
        valList.add(val7);
        insert valList;
    }
    Public Static Account createAccount(String RecordType){
        Account acc=new Account();
        acc.Name='Test';
        acc.RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get(RecordType).getRecordTypeId();
        acc.Industry='Energy';
        acc.ShippingStreet='Test Street';
        acc.ShippingCity='Test City';
        acc.ShippingCountry='India';
        //Code added by siddik on 26.2.2018 
        acc.Phone='9876543210';
        if(RecordType=='Broker'){
            acc.Name='Broker Test';
            acc.Intermediary_Role__c='Local Brokers';
            acc.VG_Intermediary_Number__c='test123';
            acc.Broker_Type__c='Insurance';
            acc.Terms__c='90';
            acc.Broker_Distribution__c='Direct';
            acc.Regulatory_Check__c=true;
            acc.VG_TOBA_Uploaded__c=true;
        }
        //Code added finished  on 26.2.2018
        Insert acc;
        return acc;
    }
    
    Public Static Account createChangeBrokerAccount(String RecordType){
        Account acc=new Account();
        acc.RecordTypeId=Schema.SObjectType.Account.getRecordTypeInfosByName().get('Broker').getRecordTypeId();
        acc.Name='Broker Test2';
        acc.Intermediary_Role__c='Local Brokers';
        acc.VG_Intermediary_Number__c='test123';
        acc.Broker_Type__c='Insurance';
        acc.Terms__c='90';
        acc.Broker_Distribution__c='Direct';
        acc.Regulatory_Check__c=true;
        acc.VG_TOBA_Uploaded__c=true;
        Insert acc;
        return acc;
    }
    
    Public Static Policy_Schedule__c createPolicySchedule(Id polid){
        Policy_Schedule__c ps=new Policy_Schedule__c();
        ps.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        ps.Name='/PS/0';
        ps.Policy__c=polid; 
        //ps.MTA_Reason_for_Cancellation__c='Product unsuitable / misunderstood';
        ps.Base_Creation_Start_Date__c =Date.newInstance(2018, 12, 18);        
        ps.Base_Creation_End_Date__c=Date.newInstance(2019, 12, 19);
         
        ps.VG_Is_MTA__c=True;
        ps.VG_Status__c='Draft';
        ps.IPT__c=500;
        ps.Levies__c=14;
        ps.Premium_Adjustment__c=5000;
        ps.Endorsement_Premium_Pro__c=25000;
        ps.Risk_Premium_Pro__c=26000;
        ps.VG_Brokerage_Percent__c=12.5;
        ps.VG_MTA_Type__c='Cancellation';
        ps.Limit__c=2000;
        ps.Premium_Adjustment_2__c=2000;
        ps.VG_VAT__c=12;
        ps.Gross_or_Net_Premium__c='Gross';
        ps.VG_Overider_Percent__c=12;
        ps.Technical_UW_Premium__c=7000;
        ps.VG_Fee_Income__c=2000;
        ps.Gross_Written_Premium__c=500;
        ps.Share__c=20;
        Insert ps;
        return ps;
    }  
    
    Public Static Asset__c createAsset(Id accid){
        Asset__c ass=new Asset__c();
        ass.Name='RM 1234';
        ass.VG_Account__c=accid;
        ass.VG_Status__c='Active';
        Insert ass;
        return ass;
    }
    Public Static VG_Policy_Schedule_Asset__c createPolicyScheduleAsset(Id psid){
        VG_Policy_Schedule_Asset__c psa=new VG_Policy_Schedule_Asset__c();
        psa.name='Test';
        psa.VG_Coverage__c = 'CAR';
        psa.VG_Territorial_Limits__c = 'Nordic';
        psa.VG_Premium__c=15252;
        psa.VG_Policy_Schedule__c=psid;
        psa.VG_Rate_Per_Vehicle__c=20;
        psa.VG_Number_of_Vehicles__c=10;
        psa.VG_Technical_UW_Rate_Annual__c=30;
        psa.VG_Territorial_Limits__c='Nordic';
        psa.VG_Sub_limit__c=5000;
        psa.VG_Deductible__c=13000;
        psa.VG_Vehicle_Type__c='Cars';
        psa.VG_Fee_Amounts__c=10000;
        psa.VG_Base_Premium_Rate__c=12.3;
        psa.VG_Share__c = 100;
        Insert psa;
        return psa;
    }
    Public Static Risk_Capture__c createRiskCapture(Id psid){
        Risk_Capture__c rc=new Risk_Capture__c();
        rc.Name='Test';
        rc.Drivers_DOB__c=Date.newInstance(1956, 02, 16);
        rc.Drivers_Claims__c='nil';
        rc.Drivers_License_Ban_Details__c='Never';
        rc.Drivers_Name__c='Test Driver';
        rc.Drivers_Conviction_Points__c='25256';
        rc.Drivers_Medical_Conditions__c='fit';
        rc.Drivers_Convictions__c='AC10';
        rc.Policy_Schedule__c=psId;
        Insert rc;
        return rc;
    }
    Public Static VG_ReInsurance__c createReInsurance(Id psid,Id umrid){
        VG_ReInsurance__c ri=new VG_ReInsurance__c();
        ri.Name='Test';
        ri.VG_Brokerage_Amount__c=25256;
        ri.VG_MGA_Commission_Override__c='';
        ri.VG_UMR__c=umrid;
        ri.VG_Policy_Schedule__c=psid;
        Insert ri;
        return ri;
    }
    Public Static VG_UMR__c createUMR(Id accid){
        VG_UMR__c u=new VG_UMR__c();
        u.VG_Account__c=accid;
        u.Name='Test';
        u.RecordTypeId=Schema.SObjectType.VG_UMR__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        u.VG_RI_Product__c='Cyber';
        u.VG_RI_Coverage__c='M6 - Third Party Only';
        u.VG_RI_Type__c='Net';
        u.VG_RI_Share_Type__c='Proportional';
        u.VG_Capacity_Paper__c='Hazardous';
        u.VG_RI_Inception_Date__c=Date.newInstance(2017, 11, 18);
        u.VG_RI_Expiry_Date__c=Date.newInstance(2018, 12, 18);
        u.VG_RI_Binder_Broker__c=accId;
        u.VG_Currency__c='CAD';
        u.VG_RI_Share__c=52;
        u.VG_MGA_Commission__c=45;
        u.VG_RI_Binder_Commission__c=28;
        u.VG_RI_Referral_Limit_Sum_Insured__c=125685;
        u.VG_RI_Referral_Limit_Premium__c=1528;
        u.VG_RI_Sum_Insured_Limit__c=1258888;
        u.VG_Capacity_Manager__c=userinfo.getUserId();//This line added by siddik on 26.2.2018 
        Insert u;
        return u;
    }
    Public Static VG_UMR__c createUMR(Id accid,String RecordType){
        VG_UMR__c u=new VG_UMR__c();
        u.VG_Account__c=accid;
        u.Name='Test';
        u.RecordTypeId=Schema.SObjectType.VG_UMR__c.getRecordTypeInfosByName().get(RecordType).getRecordTypeId();      
        //u.RecordTypeId=Schema.SObjectType.VG_UMR__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        u.VG_RI_Product__c='Cyber';
        u.VG_RI_Coverage__c='M6 - Third Party Only';
        u.VG_RI_Type__c='Net';
        u.VG_RI_Share_Type__c='Proportional';
        u.VG_RI_Inception_Date__c=Date.newInstance(2017, 11, 18);
        u.VG_RI_Expiry_Date__c=Date.newInstance(2018, 12, 18);
        u.VG_RI_Binder_Broker__c=accId;
        u.VG_Currency__c='CAD';
        u.VG_RI_Share__c=52;
        u.VG_MGA_Commission__c=45;
        u.VG_RI_Binder_Commission__c=28;
        u.VG_RI_Referral_Limit_Sum_Insured__c=125685;
        u.VG_RI_Referral_Limit_Premium__c=1528;
        u.VG_RI_Sum_Insured_Limit__c=1258888;
        u.VG_Capacity_Manager__c=userinfo.getUserId();//This line added by siddik on 26.2.2018 
        Insert u;
        return u;
    }  
}