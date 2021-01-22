Public Class MTAStepsController{
    
    Public String seletedType {get; set;}
    Public String seletedProrateoption {get; set;}    
    Public String RecordType {get; set;}    
    
    Public Id PSID {get; set;}
    Public Id PID {get; set;}
    
    Public Boolean IsCancellation {get; set;}
    Public Boolean IsReduction {get; set;}
    Public Boolean IsExtension {get; set;}
    Public Boolean IsRevision {get; set;}
    Public Boolean IsDeclaration {get; set;}
    Public Boolean IsProRated {get; set;}
    Public Boolean IsPremiumAdjustmentOverride {get;set;}
    Public Boolean IsCommercialAdjustmentOverride {get;set;}

    Public Decimal sumGWP {get;set;}
    
    Public List<SelectOption> MTATypes {get; set;}
    Public List<VG_Policy_Schedule_Asset__c> psaList{get; set;}
    Public List<VG_Policy_Schedule_Endorsement__c> pseList {get; set;}
    Public List<VG_Policy_Schedule_Endorsement__c> sbpseList {get; set;}
    Public List<Risk_Capture__c> rcList {get; set;}
    Public List<VG_Policy_Schedule_Asset__c> finalpsaList{get; set;}
    Public List<VG_Policy_Schedule_Endorsement__c> finalpseList {get; set;}
    Public List<Risk_Capture__c> finalrcList {get; set;}
    Public list<SelectOption> Prorateoption {get; set;}    
    
    Public Map<Id, Policy_Schedule__c> psMap {get; set;}
    Public Map<Id, PSWrapper> PSWrapperMap {get; set;}
    Public Map<String, Policy_Schedule__c> finalpsMap {get; set;}
    
    Public Set<ID> psWrapKeys{get;set;}
    
    Public Policy__c policy{get;set;}
    Public Policy_Schedule__c ps{get;set;} 
    
    Public Date MTAcancellationDate{get;set;}
    
    Public MTAStepsController(){
        PSID = apexpages.currentpage().getparameters().get('PSId');
        PID = apexpages.currentpage().getparameters().get('PId');
        RecordType = apexpages.currentpage().getparameters().get('RecordType');
        
        PSWrapperMap = new Map<Id, PSWrapper>();
        MTATypes = new List<SelectOption>();
        Prorateoption = new List<SelectOption>();
        psaList = new List<VG_Policy_Schedule_Asset__c>();
        pseList = new List<VG_Policy_Schedule_Endorsement__c>();
        sbpseList = new List<VG_Policy_Schedule_Endorsement__c>();
        rcList = new List<Risk_Capture__c>();
        ps = new Policy_Schedule__c();
        
        MTATypes.add(new SelectOption('--Select--', '--Select--'));
        Prorateoption.add(new SelectOption('--Select--', '--Select--'));
        
        IsExtension = IsCancellation = IsReduction = IsRevision = IsDeclaration = False;
        if(PId != null){
            MTATypes.add(new SelectOption('Extension', 'Extension'));
            MTATypes.add(new SelectOption('Cancellation', 'Cancellation'));
            MTATypes.add(new SelectOption('Reduction', 'Reduction'));
            MTATypes.add(new SelectOption('Change Broker', 'Change Broker'));
            
            Prorateoption.add(new SelectOption('Flat', 'Flat'));
            Prorateoption.add(new SelectOption('Prorated', 'Prorated'));
            
            policy = [select id, Name, CurrencyIsoCode, RecordTypeId, RecordType.Name, CreatedDate, Type_of_Insurance__c, Description__c, VG_Fee_Income__c, Policy_Status__c, Line_Of_Business__c, Adjustment_Reason__c, Deductible_or_Excess_Basis__c, Policy_Basis__c, Payment_Frequency__c, Actual_GWP__c, Lead_insurer_Policy_No__c, MTA_Cancel_List__c, VG_Inception_Date__c, Underwriter__c, Broker_Name__c, Risk_Assessor__c, Levies__c, VG_Quoted_Time__c, Deductible_or_Excess_Amount__c, VG_Bound_Time__c, Endorsement_GWP__c, VG_Booked_Time__c, VG_Quoted_Bound__c, VG_Bound_Booked__c, Total_Sum_Insured__c, Sum_Insured_Share__c, AP_TP__c, Formula_Sum_Insured_Share__c, VG_MGA_Commission_Amount__c, Technical_UW_Premium__c, VG_Brokerage_Amount__c, Declaration_Type__c, Insured__c, IPT__c, Transaction_GWP__c, VG_Plan_Rate__c, VG_Is_Renewal__c, Total_claims_reserve__c, Total_claims_paid__c, VG_Sub_Broker__c, VG_Current_Insurer__c, VG_Aggregate_Limit__c, VG_Prospect_Premium__c, Total_claims_o_s__c, Paid_Aggregate_Balance__c, Total_Aggregate_Balance__c, VG_Expiry_Date__c, Earned_Aggregate_Balance__c, VG_Brokerage_Percent__c, Am_I_Underwriter__c, VG_Sub_Status__c, Loss_Ratio__c, VG_IsApproved__c, Inception_Expiry_Time__c, IsApproved_External__c, VG_Renewal_Policy_Id__c, Retroactive_Date__c, Extended_Reporting__c, VG_Lead_or_Follow__c, Lead_Insurer__c, Risk_Premium__c, Technical_Model_Premium__c, Premium_Adjustment__c, VG_Continuous_Cover_Date__c, VG_Local_Policies__c, Commercial_Adjustment__c, Gross_Written_Premium__c, Gross_Written_Premium_Rollup__c, VG_Additional_Insureds__c, VG_Territorial_Limits__c, VG_Wording__c, Jurisdiction__c, VG_Governance_Compliance__c, VG_Lloyds_Products__c, VG_Policy_Currency__c from Policy__c where Id = : PID limit 1];
            psMap = new Map<Id, Policy_Schedule__c>([select id, Name, VG_Volante_Entities__c,Split_Type__c, VG_Entity_Split_Required__c, VG_Entity_Share__c, VG_Gross_Written_Premium_100__c, VG_D_O_Product__c, VG_MTA_Reduction_Date__c,Policy__r.RecordType.Name, Premium_Adjustment__c , CurrencyIsoCode, RecordTypeId, Policy__c, MID_Check_Box__c, Base_Creation_End_Date__c, Base_Creation_Start_Date__c, Declaration_Date__c, IPT_Percent__c, VG_Technical_Loss_Ratio__c, Levies__c, MTA_Reason_for_Cancellation__c, Product__c, VG_Capacity_Paper__c, VG_Adjustment_Reason__c, VG_Base_Policy__c, VG_Witholding_Tax_Amount__c, VG_Brokerage_Percent__c, VG_Declaration_Type__c, VG_Declaration_Type_percent__c, VG_Fee_Income__c, VG_Is_MTA__c, VG_MGA_Commission_Amount__c, VG_MTA_Cancellation_Date__c, VG_MTA_End_Date__c, VG_MTA_Start_Date__c, VG_MTA_Status__c, VG_MTA_Type__c, VG_Pre_MTA_Expiry_Date__c, VG_Status__c, Gross_Written_Premium__c, VG_VAT__c, Account_Id__c, VG_IsTempDelete__c, VG_IsTemp__c, Technical_UW_Premium__c, VG_Technical_Model_Premium__c, Endorsement_Premium_Pro__c, Risk_Premium_Pro__c, VG_VAT_Amount__c, Insured_Id__c, VG_Booked_Time__c, Endorsement_GWP__c, VG_Risk_Premium__c, VG_Coverages__c, VG_Number_Of_vehicle__c, IPT__c, Actual_GWP__c, Transaction_GWP__c, VG_Brokerage_Amount__c, Attachment__c, Commission__c, Gross_Base_Premium__c, Gross_or_Net_Premium__c, ILF_Factor__c, ILF_Layer__c, ILF_Premium__c, Limit__c, Net_Premium__c, ORC_Amount__c, ORC__c, Premium_Adjustment_2__c, Rate_On_Line__c, Rate_Per_Mil__c, Share__c, Sum_Insured__c, Technical_Layer_Premium__c, Underwriting_Premium__c, VG_Adjusted_BI_Base_Rate__c, VG_Adjusted_PD_Base_Rate__c, VG_Adjustment_Factor__c, VG_Auto_acquisition_Threshold__c, VG_BI_Base_Rate__c, VG_CREDIT_Augur_SCORE__c, VG_Current_Plan_Rate__c, VG_Deductible__c, VG_Experience_Premium__c, VG_Exposure_Premium__c, VG_Extended_Reporting_Period_AP__c, VG_Extended_Reporting_Period__c, VG_Financials_Created__c, VG_Lloyds_Product__c, VG_Machinery_Breakdown_BI_Cover__c, VG_Machinery_Breakdown_Cover__c, VG_Net_Base_Premium__c, VG_Occupancy__c, VG_Overider_Amount__c, VG_Overider_Percent__c, VG_PD_Base_Rate__c, VG_Plan_Rate__c, VG_Retired_Directors_Additional_Premium__c, VG_Retired_Directors_Year__c, VG_Selected_Weight__c, VG_Total_Layer_Premium__c, VG_Turn_Over__c, VG_Type_Of_Operation__c, Written_share__c, VG_Payment_Due_Date__c, VG_Reinsurance_Type__c, VG_Structure__c, VG_Sub_Structure__c from Policy_Schedule__c where Policy__c = : PID]);
            psaList = [select id, Name, IsDeleted, CurrencyIsoCode,Annual_Rate_100__c, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, VG_Policy_Schedule__c, VG_Coverage__c, VG_Deductible__c, VG_Number_of_Vehicles__c, VG_Premium__c, VG_Rate_Per_Vehicle__c, VG_Use__c, VG_Vehicle_Type__c, VG_IsTempDelete__c, VG_IsTemp__c, VG_Technical_UW_Rate_Annual__c, Technical_UW_Premium__c, VG_Territorial_Limits__c, VG_Brokerage__c, Asset__c, Asset__r.Name, VG_AAD__c, VG_Adjusted_BI_Premium__c, VG_Adjusted_PD_Premium__c, VG_Aggregate_Precent__c, VG_BI_Indemnity_Period__c, VG_Building_Discount_Loading__c, VG_Deductible_Precent__c, VG_Deposit_Premium_Formula__c, VG_Deposit_Premium__c, VG_GNPI__c, VG_Gross_Written_Premium__c, VG_Information__c, VG_Limit_Precent__c, VG_Limit__c, VG_MB_BI_Indemnity_Period__c, VG_MB_PD_Deductible__c, VG_MB_Waiting_Period__c, VG_Max_Rate__c, VG_Min_Rate__c, VG_Minimum_Premium_Formula__c, VG_Minimum_Premium__c, VG_Net_BI_Premium__c, VG_Net_MB_Premium__c, VG_Net_PD_Premium__c, VG_Net_Risk_Premium__c, VG_No_Claims_Bonus_Value__c, VG_No_Claims_Bonus__c, VG_PD_Deductible__c, VG_Payment_Terms__c, VG_Provisional_Rate__c, VG_Rate_on_Income__c, VG_Return_Period_Entry__c, VG_Return_Period_Exit__c, VG_Risk_Premium__c, VG_Share__c, VG_Sub_Aggregation__c, VG_Sub_limit__c, VG_Swing_Load__c, VG_Vehicle_Make__c, VG_Vehicle_Model__c, VG_Waiting_Period__c, VG_Aggregate__c, VG_Base_Premium__c, VG_Tax_on_Premium__c, VG_Base_Premium_Rate__c, VG_Country__c, VG_Fee_Amounts__c, VG_Profession__c, VG_Coverage_Type__c, VG_Ceding_Commission__c, VG_Cession__c, VG_Event_Limit__c, VG_Expected_Ceding_Commission__c, VG_Expected_Loss_Ratio__c, VG_Expected_Premium_Income__c, VG_Expected_Profit_Commission__c, VG_Loss_Ratio_for_Max__c, VG_Loss_Ratio_for_Min__c, VG_Max_Ceding_Commission__c, VG_Min_Ceding_Commission__c, VG_No_of_Surplus_Lines__c, VG_Retention_Line__c, VG_Retention__c, VG_Treaty_Limit__c, VG_Address2__c, VG_Address3__c, VG_Address__c, VG_Attachment__c, VG_Binder_Ref__c, VG_Bordereax_Date__c, VG_CH_Commission__c, VG_Date_of_Birth__c, VG_Insured_Name__c, VG_Payment_Ref__c, VG_Policy_Cover_End_Date__c, VG_Policy_Cover_Start_Date__c, VG_Policy_No__c, VG_Postcode__c, VG_Registration_Plate__c, VG_Retroactive_Date__c, VG_Scheme_Name__c, VG_Sub_broker__c, VG_Sum_Insured__c, VG_Transaction_Effective_date__c, VG_Avg_SI__c, VG_CC_Information__c, VG_Declared_Value__c, VG_Max_SI__c, VG_Perils_Text__c, VG_Perils__c, VG_Policy_Basis__c, VG_Risk_End__c, VG_Risk_start__c, VG_Signed_Share__c, VG_Written_Share__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psMap.keySet()];
            pseList = [select id, Name, IsDeleted, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, VG_Policy_Schedule__c, VG_Endorsement_Details__c, VG_Endorsement_Library_Id__c, VG_Endorsement_Number__c, VG_Premium__c, VG_Title__c, VG_IsTempDelete__c, VG_IsTemp__c, VG_Sub_limit__c, VG_Type__c from VG_Policy_Schedule_Endorsement__c where VG_Type__c = 'Endorsements' AND VG_Policy_Schedule__c IN: psMap.keySet()];
            sbpseList = [select id, Name, IsDeleted, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, VG_Policy_Schedule__c, VG_Endorsement_Details__c, VG_Endorsement_Library_Id__c, VG_Endorsement_Number__c, VG_Premium__c, VG_Title__c, VG_IsTempDelete__c, VG_IsTemp__c, VG_Sub_limit__c, VG_Type__c from VG_Policy_Schedule_Endorsement__c where VG_Type__c = 'Sub-limits' AND VG_Policy_Schedule__c IN: psMap.keySet()];            
            rcList = [select id, Name, IsDeleted, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, Policy_Schedule__c, Drivers_Claims__c, Drivers_Convictions__c, Drivers_DOB__c, Drivers_License_Ban_Details__c, Drivers_Medical_Conditions__c, Drivers_Name__c, Drivers_Conviction_Points__c, VG_IsTempDelete__c, VG_IsTemp__c, VG_Plan_Loss_Ratio__c, VG_Rate_Type__c, VG_Share__c, VG_Territorial_Limits__c, VG_Total_Assets__c, VG_Layer__c, VG_No_of_Reinstatements__c, VG_Territorial_Scope__c, VG_Class_1_Employees__c, VG_Company_Domicile__c, VG_Company_Type__c, VG_Dispute_Clause__c, VG_Fees_Current_Year__c, VG_Fees_Year_1__c, VG_Fees_Year_2__c, VG_Fees_Year_3__c, VG_Headcount__c, VG_Industry__c, VG_Market_Cap__c, VG_Net_Equity__c, VG_Net_Profit__c, VG_Profession__c, VG_Revenue__c, VG_Additional_Information__c, VG_Cash_Loss_Limit__c, VG_Ceding_Commission_Type__c, VG_Claims_Notification_Threshold__c, VG_First_Premium_Payment_Date__c, VG_Income_Basis__c, VG_Policy_Details__c, VG_Risk_End__c, VG_Risk_start__c from Risk_Capture__c where Policy_Schedule__c IN: psMap.keySet()];
            String RecordTypeId = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Aesir').getRecordTypeId(); 
            IsPremiumAdjustmentOverride = false;
            IsCommercialAdjustmentOverride = false;
            for(Policy_Schedule__c ps : psMap.values()){
                PSWrapper psw = new PSWrapper();
                psw.ps = ps;
                psw.ps.Levies__c = (psw.ps.Levies__c!= null?ps.Levies__c:0);
                psw.ps.VG_Fee_Income__c = (psw.ps.VG_Fee_Income__c!= null?psw.ps.VG_Fee_Income__c:0);
                if(ps.Share__c != null && ps.Share__c != 0 && ps.Gross_Written_Premium__c != 0 && RecordTypeId!= RecordType)
                    psw.GWP = ps.Gross_Written_Premium__c / (ps.Share__c / 100);
                PSW.PremiumAdjustment = PSW.ps.Premium_Adjustment__c;
                PSW.CommercialAdjustment = PSW.ps.Premium_Adjustment_2__c;
                PSW.RIPro = PSW.Ps.Risk_Premium_Pro__c;
                PSW.endPro = PSW.ps.Endorsement_Premium_Pro__c;
                PSW.techUWPre = PSW.ps.Technical_UW_Premium__c;
                for(VG_Policy_Schedule_Asset__c rr:PSW.wrappsaList){  
                    If(rr.VG_Sum_Insured__c!= null)
                        PSW.TSI = PSW.TSI+rr.VG_Sum_Insured__c;
                }
                PSWrapperMap.put(psw.ps.id, psw);
            }
            for(VG_Policy_Schedule_Asset__c psa : psaList){
                PSWrapperMap.get(psa.VG_Policy_Schedule__c).wrappsaList.add(psa);
            }
            for(VG_Policy_Schedule_Endorsement__c pse : pseList){
                PSWrapperMap.get(pse.VG_Policy_Schedule__c).wrappseList.add(pse);
            }
            for(VG_Policy_Schedule_Endorsement__c pse : sbpseList){
                PSWrapperMap.get(pse.VG_Policy_Schedule__c).wrapsbpseList.add(pse);
            }
            for(Risk_Capture__c rc : rcList){
                PSWrapperMap.get(rc.Policy_Schedule__c).wraprcList.add(rc);
            }
            psWrapKeys = new Set<ID>();
            psWrapKeys = PSWrapperMap.keySet();
        }
        if(PSID != null){
            ps = [select id, Name, CurrencyIsoCode, RecordTypeId, VG_MTA_Reduction_Date__c, VG_D_O_Product__c, Policy__r.VG_Inception_Date__c, Policy__r.VG_Expiry_Date__c, RecordType.Name, CreatedDate, VG_Financials_Created__c, VG_Risk_Premium__c, Insured_Id__c, Declaration_Date__c, Product__c, Policy__c, VG_Plan_Rate__c, IPT_Percent__c, Premium_Adjustment__c, Endorsement_GWP__c, Levies__c, VG_Transaction_Type__c, VG_Risk_Transaction_Type__c, VG_Is_MTA__c, VG_MTA_Type__c, VG_MTA_Status__c, VG_MTA_Start_Date__c, VG_MTA_End_Date__c, VG_Current_Plan_Rate__c, VG_MTA_Cancellation_Date__c, MTA_Reason_for_Cancellation__c, VG_Declaration_Type__c, VG_Status__c, Net_Premium__c, VG_Declaration_Type_percent__c, VG_Fee_Income__c, VG_Adjustment_Reason__c, VG_Brokerage_Percent__c, VG_Net_Premium_Due__c, VG_Pre_MTA_Expiry_Date__c, VG_Base_Policy__c, Base_Creation_Start_Date__c, Base_Creation_End_Date__c, Commission__c, Gross_Base_Premium__c, VG_MGA_Commission_Amount__c, VG_Technical_Model_Premium__c, Technical_UW_Premium__c, Risk_Premium_Pro__c, Endorsement_Premium_Pro__c, Limit__c, Attachment__c, Sum_Insured__c, ILF_Factor__c, ILF_Premium__c, Rate_On_Line__c, Rate_Per_Mil__c, Share__c, Underwriting_Premium__c, Premium_Adjustment_2__c, ORC__c, ORC_Amount__c, Account_Id__c, VG_VAT__c, VG_VAT_Amount__c, VG_Lloyds_Product__c, VG_Net_Premium_Receivable__c, VG_Auto_acquisition_Threshold__c, VG_Extended_Reporting_Period_AP__c, ILF_Layer__c, VG_Retired_Directors_Additional_Premium__c, VG_Retired_Directors_Year__c, VG_Extended_Reporting_Period__c, Technical_Layer_Premium__c, Written_share__c, Gross_Written_Premium__c, Gross_or_Net_Premium__c, VG_Overider_Amount__c, VG_Overider_Percent__c, VG_Total_Layer_Premium__c, Transaction_GWP__c, Actual_GWP__c, IPT__c, VG_Brokerage_Amount__c, VG_Deductible__c, VG_Booked_Time__c, VG_Coverages__c, VG_Number_Of_vehicle__c, VG_Turn_Over__c, VG_Type_Of_Operation__c, VG_CREDIT_Augur_SCORE__c, VG_Exposure_Premium__c, VG_Experience_Premium__c, VG_Selected_Weight__c, VG_Net_Base_Premium__c, VG_Occupancy__c, VG_PD_Base_Rate__c, VG_BI_Base_Rate__c, VG_Machinery_Breakdown_Cover__c, VG_Machinery_Breakdown_BI_Cover__c, VG_Adjustment_Factor__c, VG_Adjusted_PD_Base_Rate__c, VG_Adjusted_BI_Base_Rate__c, VG_Witholding_Tax_Amount__c, VG_Net_Premium_Received__c, VG_Reinsurance_Type__c, VG_Structure__c, VG_Sub_Structure__c, VG_Technical_Loss_Ratio__c, MID_Check_Box__c, VG_Capacity_Paper__c, VG_Payment_Due_Date__c, VG_Wording__c, VG_Reporting_Date__c, VG_Rate_Change__c from Policy_Schedule__c where id = :PSID];
            MTATypes.add(new SelectOption('Revision of Cover', 'Revision of Cover'));
            If(RecordType == 'VFP')
                MTATypes.add(new SelectOption('Run-off', 'Run-off'));
            Prorateoption.add(new SelectOption('Flat', 'Flat'));
            Prorateoption.add(new SelectOption('Prorated', 'Prorated'));
        }
        IsProRated = false;
        if(RecordType == 'Bridge'){
            seletedType = 'Revision of Cover';
            ps.VG_MTA_End_Date__c = ps.Policy__r.VG_Expiry_Date__c;
            IsRevision = true;
        }
    }
    
    Public PageReference Cancel(){
        if(PId != null){
            return new PageReference('/'+PID);
        }else if(PSID != null){
            return new PageReference('/'+PSID);
        }else{
            return null;
        }
    }
    
    Public PageReference gotostep1(){
        return new PageReference('/apex/VG_MTA_Step1');        
    }
    
    Public PageReference finish(){
        finalpsaList = new List<VG_Policy_Schedule_Asset__c>();
        finalpseList = new List<VG_Policy_Schedule_Endorsement__c>();
        finalrcList = new List<Risk_Capture__c>();
        finalpsMap = new Map<String, Policy_Schedule__c>();
        if(IsCancellation){
            If(ps.MTA_Reason_for_Cancellation__c == '--None--' || ps.MTA_Reason_for_Cancellation__c == null){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'You must choose any reason for cancellation'));    
                return null; 
            }        
            if(ps.VG_Pre_MTA_Expiry_Date__c<ps.VG_MTA_Cancellation_Date__c){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Cancellation Date Can\'t be greater than Current Expiry date..'));    
                return null;  
            }else if(ps.VG_MTA_Cancellation_Date__c < policy.VG_Inception_Date__c){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Cancellation Date Can\'t be less than policy inception date'));    
                return null;  
            }else if(ps.VG_MTA_Cancellation_Date__c == null){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please fill Cancellation Date..'));    
                return null;               
            }                       
        }if(IsReduction){ 
            if(ps.VG_Pre_MTA_Expiry_Date__c<ps.VG_MTA_Reduction_Date__c){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Reduction Date Can\'t be greater than Current Expiry date..'));    
                return null;  
            }else if(ps.VG_MTA_Reduction_Date__c == null){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please fill Reduction Date..'));    
                return null;               
            }                       
        }if(IsExtension){
            if(ps.VG_MTA_End_Date__c == null || ps.VG_MTA_End_Date__c < ps.VG_MTA_Start_Date__c){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please check extention date Date..'));    
                return null;
            }
        }  
        Set<String> baseNames = new Set<String>();
        for(PSWrapper bps : PSWrapperMap.values()){
            baseNames.add(bps.ps.Name.remove('/NonEEA').remove('/EEA'));
        }
        Integer countPS = baseNames.size();     
        Map<String, String> mtaNameMap = new Map<String, String>();
               
        for(PSWrapper psw: PSWrapperMap.values()){
            psw.ps.VG_Is_MTA__c = True;
            psw.ps.VG_MTA_Type__c = seletedType;
            psw.ps.VG_Base_Policy__c = false;
            psw.ps.MTA_Parent_Policy_Schedule__c=psw.ps.id;
            String MTAParentBaseName = psw.ps.Name.remove('/NonEEA').remove('/EEA');
            String MTAPairBaseName = mtaNameMap.containsKey(MTAParentBaseName) ? mtaNameMap.get(MTAParentBaseName) : '';
            if(psw.ps.Split_Type__c == 'EEA'){
                if(MTAPairBaseName == ''){
                    psw.ps.Name =  policy.Name + '/MTA/'+countPS+'/EEA';
                    countPS++;  
                }else{
                    psw.ps.Name = MTAPairBaseName + '/EEA';
                }
            }else if(psw.ps.Split_Type__c == 'Non EEA'){
                if(MTAPairBaseName == ''){
                    psw.ps.Name =  policy.Name + '/MTA/'+countPS+'/NonEEA';
                    countPS++;  
                }else{
                    psw.ps.Name = MTAPairBaseName + '/NonEEA';
                }
            }else{
                psw.ps.Name =  policy.Name + '/MTA/'+countPS;
                countPS++;  
            }    
            mtaNameMap.put(MTAParentBaseName, psw.ps.Name.remove('/NonEEA').remove('/EEA'));       
            PSW.ps.VG_Status__c='Draft'; 
            PSW.ps.IPT__c = null;
            PSW.ps.IPT_Percent__c = null;               
            psw.ps.id = null;             
            if(IsExtension){
                policy.VG_Expiry_Date__c = ps.VG_MTA_End_Date__c;
                psw.ps.VG_MTA_Start_Date__c = ps.VG_MTA_Start_Date__c;
                psw.ps.VG_MTA_End_Date__c = ps.VG_MTA_End_Date__c;
                PSW.ps.Base_Creation_End_Date__c = ps.VG_MTA_End_Date__c;
                PSW.ps.Premium_Adjustment__c = PSW.PremiumAdjustment;
                PSW.ps.Premium_Adjustment_2__c = PSW.CommercialAdjustment;
                PSW.ps.Risk_Premium_Pro__c = PSW.RIPro;
                PSW.ps.Endorsement_Premium_Pro__c = PSW.endPro;
                If(policy.RecordType.Name == 'Gentium')
                    PSW.ps.Technical_UW_Premium__c = PSW.techUWPre;
            }
            if(IsCancellation || IsReduction){
                psw.ps.MTA_Reason_for_Cancellation__c = ps.MTA_Reason_for_Cancellation__c;
                psw.ps.VG_Pre_MTA_Expiry_Date__c = ps.VG_Pre_MTA_Expiry_Date__c;
                If(IsCancellation){
                    psw.ps.VG_MTA_Cancellation_Date__c = ps.VG_MTA_Cancellation_Date__c;  
                    policy.VG_Expiry_Date__c = ps.VG_MTA_Cancellation_Date__c; 
                    policy.VG_Sub_Status__c = 'Cancelled';  
                    psw.ps.VG_MTA_Start_Date__c = ps.VG_MTA_Cancellation_Date__c;
                    psw.ps.VG_MTA_End_Date__c = ps.VG_Pre_MTA_Expiry_Date__c;             
                }else If(IsReduction){
                    PSW.ps.Base_Creation_End_Date__c = ps.VG_MTA_Reduction_Date__c;
                    psw.ps.VG_MTA_Reduction_Date__c=ps.VG_MTA_Reduction_Date__c;  
                    policy.VG_Expiry_Date__c = ps.VG_MTA_Reduction_Date__c-1;
                    psw.ps.VG_MTA_Start_Date__c = ps.VG_MTA_Reduction_Date__c;
                    psw.ps.VG_MTA_End_Date__c = ps.VG_Pre_MTA_Expiry_Date__c;                                   
                }                
                PSW.ps.Premium_Adjustment__c = PSW.PremiumAdjustment;
                PSW.ps.Premium_Adjustment_2__c = PSW.CommercialAdjustment;
                PSW.ps.Risk_Premium_Pro__c = PSW.RIPro;
                PSW.ps.Endorsement_Premium_Pro__c = PSW.endPro;
                If(policy.RecordType.Name == 'Gentium')
                    PSW.ps.Technical_UW_Premium__c = PSW.techUWPre;               
            }
            Integer cnt = 0;
            for(VG_Policy_Schedule_Asset__c psa:psw.wrappsaList){
                VG_Policy_Schedule_Asset__c tmp = psa.clone(false, true, false, false);
                tmp.id = null;
                tmp.VG_Policy_Schedule__c = null;
                tmp.Name = psw.ps.Name;
                finalpsaList.add(tmp);
            }
            cnt = 0;
            for(VG_Policy_Schedule_Endorsement__c pse:psw.wrappseList){
                VG_Policy_Schedule_Endorsement__c tmp = pse.clone(false, true, false, false);
                tmp.id = null;
                tmp.VG_Policy_Schedule__c = null;
                tmp.Name = psw.ps.Name;
                finalpseList.add(tmp);
            }
            cnt = 0;
            for(VG_Policy_Schedule_Endorsement__c sbpse:psw.wrapsbpseList){
                VG_Policy_Schedule_Endorsement__c tmp = sbpse.clone(false, true, false, false);
                tmp.id = null;
                tmp.VG_Policy_Schedule__c = null;
                tmp.Name = psw.ps.Name;
                finalpseList.add(tmp);
            }
            cnt = 0;
            for(Risk_Capture__c rc: psw.wraprcList){
                Risk_Capture__c tmp = rc.clone(false, true, false, false);
                tmp.id = null;
                tmp.Policy_Schedule__c = null;
                tmp.Name = psw.ps.Name;
                finalrcList.add(tmp);
            }
            finalpsMap.put(psw.ps.Name, psw.ps);         
        }
        update policy;
        if(finalpsMap.size()>0){
            insert finalpsMap.values();
            PolicyScheduleTriggerFunction.allowInsertRI = True;
            PolicyScheduleTriggerFunction.createRIRecords(finalpsMap.values());
        }
        integer psacount = 1;
        for(VG_Policy_Schedule_Asset__c psa:finalpsaList){
            psa.VG_Policy_Schedule__c = finalpsMap.get(psa.Name).id;
            psa.Name = psa.Name+'/RR/'+psacount;
            psacount++;
        }
        integer psecount = 1;
        for(VG_Policy_Schedule_Endorsement__c pse:finalpseList){
            pse.VG_Policy_Schedule__c = finalpsMap.get(pse.Name).id;
            pse.Name = pse.Name+'/PE/'+psecount;
            psecount++;
        }
        integer rccount = 1;
        for(Risk_Capture__c rc: finalrcList){
            rc.Policy_Schedule__c = finalpsMap.get(rc.Name).id;
            rc.Name = rc.Name+'/RD/'+rccount;
            rccount++;
        }
        if(!finalpsaList.isEmpty())
            Insert finalpsaList;
        if(!finalpseList.isEmpty())
            Insert finalpseList;
        if(!finalrcList.isEmpty())
            Insert finalrcList;
        return new PageReference('/'+policy.id);
    }
    
    Public PageReference gotostep2(){
        PageReference reference;
        if(seletedType == '--Select--'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select MTA type.')); 
            return null;
        }
        if(seletedType == 'Extension'){
            IsExtension = True;
            IsCancellation = IsReduction = IsRevision = IsDeclaration = False;
            ps.VG_MTA_Start_Date__c = policy.VG_Expiry_Date__c.addDays(1);
            return new PageReference('/apex/VG_MTA_Step2');
        }else if(seletedType == 'Cancellation'){
            IsCancellation = True;
            IsExtension = IsReduction = IsRevision = IsDeclaration = False;
            ps.VG_Pre_MTA_Expiry_Date__c = policy.VG_Expiry_Date__c;
            ps.Base_Creation_End_Date__c = policy.VG_Expiry_Date__c;
            ps.Base_Creation_Start_Date__c = policy.VG_Inception_Date__c;
            return new PageReference('/apex/VG_MTA_Step2');
        }else if(seletedType == 'Reduction'){
            IsReduction = True;
            IsExtension = IsCancellation = IsRevision = IsDeclaration = False;
            ps.VG_Pre_MTA_Expiry_Date__c = policy.VG_Expiry_Date__c;
            ps.Base_Creation_End_Date__c = policy.VG_Expiry_Date__c;
            ps.Base_Creation_Start_Date__c = policy.VG_Inception_Date__c;
            return new PageReference('/apex/VG_MTA_Step2');
        }else if(seletedType == 'Run-off' && RecordType == 'VFP'){ 
            System.debug('seletedType::'+seletedType);          
            IsRevision = True;
            IsCancellation = IsReduction = IsExtension = IsDeclaration = False;
            ps.VG_MTA_Start_Date__c = ps.Base_Creation_End_Date__c;            
            return new PageReference('/apex/VG_MTA_Step3?Id = '+PSID+'&MTAType='+seletedType);            
        }else if(seletedType == 'Revision of Cover'){ 
            System.debug('seletedType::'+seletedType+ps.Policy__r.VG_Expiry_Date__c);          
            IsRevision = True;
            IsCancellation = IsReduction = IsExtension = IsDeclaration = False;
            ps.VG_MTA_End_Date__c = ps.Policy__r.VG_Expiry_Date__c;
            System.debug('Date::'+ps.VG_MTA_End_Date__c+'::'+ps.Policy__r.VG_Expiry_Date__c); 
            return new PageReference('/apex/VG_MTA_Step3');
        }else if(seletedType == 'Change Broker'){ 
            return new PageReference('/apex/ChangeBroker?id='+PID);
        }else{
            IsExtension = IsReduction = IsCancellation = IsRevision = IsDeclaration = False;
            return null; 
        } 
    }
    
    Public PageReference gotoStep4(){
        if(ps.VG_MTA_Start_Date__c < ps.Policy__r.VG_Inception_Date__c) {
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date Must be Greater than or equal to Risk Inception Date'));    
            return null; 
        }
        if(ps.VG_MTA_Start_Date__c > ps.VG_MTA_End_Date__c){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Start Date Must be within End Date.')); 
            return null;
        }
        If(seletedType=='Run-off'){
            If(ps.VG_MTA_End_Date__c==null){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Enter the End Date.')); 
                return null;
            }
            If(ps.VG_MTA_Start_Date__c==null){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Enter the Start Date.')); 
                return null;
            }
        }
        if(RecordType=='Imara'){
            return new PageReference('/apex/VG_Revise_Alpha_Step1?id='+PSID+'&MTAType='+seletedType+'&seletedProrateoption='+seletedProrateoption+'&MTAStartDate='+ps.VG_MTA_Start_Date__c);
        }else if(RecordType=='Aesir'){
            return new PageReference('/apex/VG_Revise_Aesir_Step1?id='+PSID+'&MTAType='+seletedType+'&MTAStartDate='+ps.VG_MTA_Start_Date__c);
        }else if(RecordType=='Horizon'){
            return new PageReference('/apex/VG_Revise_Horizon_Step1?id='+PSID+'&MTAType='+seletedType+'&seletedProrateoption='+seletedProrateoption+'&MTAStartDate='+ps.VG_MTA_Start_Date__c);
        }else if(RecordType=='Affinity'){
            return new PageReference('/apex/VG_Revise_LS_Step_1?id='+PSID+'&MTAType='+seletedType+'&seletedProrateoption='+seletedProrateoption+'&MTAStartDate='+ps.VG_MTA_Start_Date__c);
        }else if(RecordType=='VCL'){
            return new PageReference('/apex/VG_Revise_VCL_Step_1?id='+PSID+'&MTAType='+seletedType+'&seletedProrateoption='+seletedProrateoption+'&MTAStartDate='+ps.VG_MTA_Start_Date__c);
        }else if(RecordType=='VFP'){        
            If(seletedType == 'Revision of Cover')
                return new PageReference('/apex/VG_Revise_FIDO_Step1?id='+PSID+'&MTAType='+seletedType+'&seletedProrateoption='+seletedProrateoption+'&MTAStartDate='+ps.VG_MTA_Start_Date__c);
            else
                return new PageReference('/apex/VG_Revise_FIDO_Step5?id='+PSID+'&MTAType='+seletedType+'&seletedProrateoption='+seletedProrateoption+'&MTAStartDate='+ps.VG_MTA_Start_Date__c+'&MTAEndDate='+ps.VG_MTA_End_Date__c);        
        }else if(RecordType=='GentiumScheme'){
            return new PageReference('/apex/VG_Revise_Gentium_Edit5?PSID='+PSID+'&MTAType='+seletedType+'&seletedProrateoption='+seletedProrateoption+'&MTAStartDate='+ps.VG_MTA_Start_Date__c);
        }else if(RecordType=='GentiumFleet'){
            return new PageReference('/apex/VG_Revise_Gentium_Edit1?PSID='+PSID+'&MTAType='+seletedType+'&seletedProrateoption='+seletedProrateoption+'&MTAStartDate='+ps.VG_MTA_Start_Date__c);
        }else if(RecordType=='Bridge'){
            if(ps.Product__c !='Commercial Combined')
                return new PageReference('/apex/VG_Revise_Nordics_Step2?PSID='+PSID+'&MTAType='+seletedType+'&seletedProrateoption='+seletedProrateoption+'&MTAStartDate='+ps.VG_MTA_Start_Date__c);
            else
                return new PageReference('/apex/VG_CC_Revise_Nordics_Step2?PSID='+PSID+'&MTAType='+seletedType+'&seletedProrateoption='+seletedProrateoption+'&MTAStartDate='+ps.VG_MTA_Start_Date__c);
        }else{
            return null;
        }
    }
    
    Public void UpdateAdjustmentvalues(){
        IsPremiumAdjustmentOverride = True;
        IsCommercialAdjustmentOverride = True;
        FIDOSummaryCalc();
    }
    
    Public void AesirSummaryCalc(){   
        for(PSWrapper PSW: PSWrapperMap.values()){
            PSW.ps.VG_Gross_Written_Premium_100__c = PSW.ps.Technical_UW_Premium__c +PSW.ps.Premium_Adjustment_2__c;
            PSW.Ps.Risk_Premium_Pro__c = PSW.GWP = 0;
            for(VG_Policy_Schedule_Asset__c rr:PSW.wrappsaList){
                PSW.GWP = PSW.GWP + rr.Annual_Rate_100__c;
                PSW.Ps.Risk_Premium_Pro__c = (PSW.Ps.Risk_Premium_Pro__c!= null?PSW.Ps.Risk_Premium_Pro__c:0)+ rr.VG_Premium__c;                
            }
            PSW.ps.Gross_Written_Premium__c = PSW.GWP;
            PSW.ps.Share__c = (PSW.ps.Gross_Written_Premium__c/PSW.ps.VG_Gross_Written_Premium_100__c)*100;
            PSW.ps.VG_Technical_Model_Premium__c = PSW.ps.Net_Premium__c*(PSW.ps.Share__c/100);
            PSW.ps.Technical_UW_Premium__c = PSW.ps.VG_Technical_Model_Premium__c + PSW.ps.Premium_Adjustment__c;
            if(PSW.ps.VG_Brokerage_Percent__c != 0)
                PSW.ps.VG_Brokerage_Amount__c = psw.ps.Gross_Written_Premium__c *(PSW.ps.VG_Brokerage_Percent__c/100);           
            PSW.ps.Actual_GWP__c = psw.ps.Gross_Written_Premium__c - PSW.ps.VG_Brokerage_Amount__c;
            if(PSW.ps.Gross_or_Net_Premium__c == 'Gross')
                PSW.ps.Transaction_GWP__c = PSW.ps.Gross_Written_Premium__c;
            else if(PSW.ps.Gross_or_Net_Premium__c == 'Net')
                PSW.ps.Transaction_GWP__c = psw.ps.Gross_Written_Premium__c - PSW.ps.VG_Brokerage_Amount__c;           
        }        
    }
    
    Public PageReference FIDOSummaryCalc(){
        Decimal proratingfator = 1;  
        If(seletedProrateoption == 'Flat'){
            proratingfator = 1;
        }else{
            if(seletedType == 'Extension'){
                if(ps.VG_MTA_End_Date__c == null){
                    proratingfator = -99;
                }else{
                    if(Math.mod(policy.VG_Inception_Date__c.year(), 4) != 0){
                        if(Math.mod(policy.VG_Expiry_Date__c.year(), 4) == 0){
                            if(policy.VG_Expiry_Date__c <= date.newInstance(policy.VG_Expiry_Date__c.year(), 02, 28)){
                                proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                            }else{
                                proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                            }
                        }else{
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                        }
                    }else{
                        if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                        }else{
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                        }
                    }
                }
            }
            if(seletedType == 'Cancellation'  || seletedType == 'Reduction'){
                if(MTAcancellationDate == null){
                    proratingfator = -99;
                }else{
                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(ps.VG_Pre_MTA_Expiry_Date__c)+1)/365);
                }
            }
        }                
        for(PSWrapper PSW: PSWrapperMap.values()){
            if(seletedType == 'Extension'){
                If(seletedProrateoption == 'Flat'){     
                    PSW.RIPro = 0;
                    PSW.endPro = 0;
                }    
            }
            if(seletedType == 'Cancellation' || seletedType == 'Reduction' ){
                If(seletedType == 'Cancellation'){
                    MTAcancellationDate = ps.VG_MTA_Cancellation_Date__c; 
                    PSW.cancellationdate = ps.VG_MTA_Cancellation_Date__c; 
                }If(seletedType == 'Reduction' ){
                    MTAcancellationDate = ps.VG_MTA_Reduction_Date__c;
                    PSW.cancellationdate = ps.VG_MTA_Reduction_Date__c;
                }                             
                if(PSW.ps.VG_Is_MTA__c && (PSW.ps.VG_MTA_Type__c == 'Revision of Cover' || PSW.ps.VG_MTA_Type__c == 'Extension')){
                    if(PSW.cancellationdate > PSW.ps.VG_MTA_End_Date__c){
                        proratingfator = 0;
                    }else if(MTAcancellationDate < = PSW.ps.VG_MTA_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays+1));
                    }else if(MTAcancellationDate > PSW.ps.VG_MTA_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                        Decimal numDays2 = Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));                        
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays2+1));
                    }
                }else if(!PSW.ps.VG_Is_MTA__c){
                    if(PSW.cancellationdate > PSW.ps.Base_Creation_End_Date__c){
                        proratingfator = 0;
                    }else if(MTAcancellationDate < = PSW.ps.Base_Creation_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c));
                        System.debug('numDays1::'+numDays+'::'+PSW.ps.Base_Creation_Start_Date__c+PSW.ps.Base_Creation_End_Date__c);
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays+1));
                    }else if(MTAcancellationDate > PSW.ps.Base_Creation_Start_Date__c){
                        if(Math.mod(PSW.ps.Base_Creation_End_Date__c.year(), 4) != 0){
                            if(Math.mod(PSW.ps.Base_Creation_End_Date__c.year(), 4) == 0){
                                if(PSW.ps.Base_Creation_End_Date__c <= date.newInstance(PSW.ps.Base_Creation_End_Date__c.year(), 02, 28)){
                                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                                }else{
                                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)));
                                }
                            }else{
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                            }
                        }else{
                            if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)));
                            }else{
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                            }
                        }          
                    }                   
                }else {
                    Decimal numDays = Decimal.valueOf(MTAcancellationDate.daysBetween(ps.VG_Pre_MTA_Expiry_Date__c));
                    Decimal n2 = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                    if(numDays < = 0)
                        proratingfator = 0;
                    else
                        proratingfator = -1*((numDays+1)/(n2+1));                                   
                }
            }
            If(seletedProrateoption == 'Prorated'){                             
                if(!IsProRated){                
                    if(PSW.Ps.Risk_Premium_Pro__c != null){
                        PSW.RIPro = 0;
                        PSW.RIPro = (PSW.ps.Risk_Premium_Pro__c*proratingfator).setscale(2);
                    }else{
                        PSW.Ps.Risk_Premium_Pro__c = 0;
                    }
                    if(PSW.ps.Endorsement_Premium_Pro__c != null){
                        PSW.endPro = 0;
                        PSW.endpro = (PSW.ps.Endorsement_Premium_Pro__c*proratingfator).setscale(2);
                    }else{
                        PSW.ps.Endorsement_Premium_Pro__c = 0;  
                    }  
                }                              
                PSW.ps.Net_Premium__c = PSW.RIPro + PSW.endPro;
                If(!IsPremiumAdjustmentOverride){
                    PSW.PremiumAdjustment = (PSW.ps.Premium_Adjustment__c*proratingfator).setscale(2);  
                }   
                
                PSW.ps.Technical_UW_Premium__c = PSW.PremiumAdjustment+PSW.ps.Net_Premium__c;
                If(!IsCommercialAdjustmentOverride){
                    PSW.CommercialAdjustment = (PSW.ps.Premium_Adjustment_2__c*proratingfator).setscale(2);                    
                }         
            }
            If(seletedProrateoption == 'Flat'){     
                If(seletedType == 'Cancellation' || seletedType == '' ){           
                    if(PSW.Ps.Risk_Premium_Pro__c != null){
                        PSW.RIPro = 0;
                        PSW.RIPro = PSW.ps.Risk_Premium_Pro__c;                     
                    }else{
                        PSW.Ps.Risk_Premium_Pro__c = 0;
                    }
                    if(PSW.ps.Endorsement_Premium_Pro__c != null){
                        PSW.endPro = 0;
                        PSW.endpro = PSW.ps.Endorsement_Premium_Pro__c;                     
                    }else{
                        PSW.ps.Endorsement_Premium_Pro__c = 0;  
                    }  
                }else if(seletedType == 'Reduction' ){
                    PSW.RIPro = 0;
                    PSW.endPro = 0;
                }                  
                PSW.ps.Net_Premium__c = PSW.RIPro + PSW.endPro;
                
                If(!IsPremiumAdjustmentOverride){
                    PSW.PremiumAdjustment = (PSW.ps.Premium_Adjustment__c).setscale(2);                      
                }   
                
                PSW.ps.Technical_UW_Premium__c = PSW.PremiumAdjustment+PSW.ps.Net_Premium__c;
                If(!IsCommercialAdjustmentOverride){
                    PSW.CommercialAdjustment = (PSW.ps.Premium_Adjustment_2__c).setscale(2);                    
                }            
            }                                   
            PSW.ps.VG_Gross_Written_Premium_100__c = PSW.ps.Technical_UW_Premium__c+PSW.CommercialAdjustment;
            PSW.ps.VG_VAT_Amount__c = (PSW.ps.VG_VAT__c/100)*PSW.ps.VG_Fee_Income__c;            
            If(PSW.ps.Product__c == 'W&I'){
                PSW.ps.VG_Technical_Model_Premium__c = PSW.RIPro + PSW.endPro;
                PSW.ps.Gross_Written_Premium__c = PSW.ps.VG_Gross_Written_Premium_100__c;
                PSW.ps.Sum_Insured__c = PSW.ps.Limit__c;
            }else{
                PSW.ps.VG_Technical_Model_Premium__c = ((PSW.ps.Share__c!=null?PSW.ps.Share__c:0)/100)*(PSW.ps.Net_Premium__c!=null?PSW.ps.Net_Premium__c:0);                          
                if(PSW.ps.Share__c != null && PSW.ps.Share__c != 0 && PSW.GWP != 0)
                    PSW.ps.Gross_Written_Premium__c = PSW.ps.VG_Gross_Written_Premium_100__c * (PSW.ps.Share__c / 100);            
                PSW.ps.Sum_Insured__c = PSW.ps.Limit__c*((PSW.ps.Share__c!=null?PSW.ps.Share__c:0)/100);                                 
            }
            If(PSW.ps.Gross_or_Net_Premium__c == 'Gross'){
                PSW.ps.Transaction_GWP__c = PSW.ps.Gross_Written_Premium__c+PSW.ps.Gross_Written_Premium__c+PSW.ps.VG_Fee_Income__c;
            }else{
                PSW.ps.Transaction_GWP__c = PSW.ps.Actual_GWP__c+PSW.ps.Gross_Written_Premium__c+PSW.ps.VG_Fee_Income__c;
            }
            
            PSW.ps.VG_Brokerage_Amount__c = psw.ps.Gross_Written_Premium__c*(PSW.ps.VG_Brokerage_Percent__c /100);
            PSW.ps.Actual_GWP__c = psw.ps.Gross_Written_Premium__c-PSW.ps.VG_Brokerage_Amount__c;            
        }
        IsProRated = True;
        IsPremiumAdjustmentOverride = True;
        IsCommercialAdjustmentOverride = True;
        return null;
    }
    
    Public PageReference AlphaHorizonSummaryCalc(){
        Decimal proratingfator = 1;
        If(seletedProrateoption == 'Flat'){
            proratingfator = 1;
        }else{
            if(seletedType == 'Extension'){
                if(ps.VG_MTA_End_Date__c == null){
                    proratingfator = -99;
                }else{
                    if(Math.mod(policy.VG_Inception_Date__c.year(), 4) != 0){
                        if(Math.mod(policy.VG_Expiry_Date__c.year(), 4) == 0){
                            if(policy.VG_Expiry_Date__c <= date.newInstance(policy.VG_Expiry_Date__c.year(), 02, 28)){
                                proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                            }else{
                                proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                            }
                        }else{
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                        }
                    }else{
                        if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                        }else{
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                        }
                    }
                }
            }
            if(seletedType == 'Cancellation'  || seletedType == 'Reduction'){
                if(MTAcancellationDate == null){
                    proratingfator = -99;
                }else{
                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(ps.VG_Pre_MTA_Expiry_Date__c)+1)/365);
                }
            }
        }                
        for(PSWrapper PSW: PSWrapperMap.values()){
            if(seletedType == 'Extension'){
                If(seletedProrateoption == 'Flat'){     
                    PSW.RIPro = 0;
                    PSW.endPro = 0;
                }    
            }
            if(seletedType == 'Cancellation' || seletedType == 'Reduction' ){
                If(seletedType == 'Cancellation'){
                    MTAcancellationDate = ps.VG_MTA_Cancellation_Date__c; 
                    PSW.cancellationdate = ps.VG_MTA_Cancellation_Date__c; 
                }If(seletedType == 'Reduction' ){
                    MTAcancellationDate = ps.VG_MTA_Reduction_Date__c;
                    PSW.cancellationdate = ps.VG_MTA_Reduction_Date__c;
                }                                 
                if(PSW.ps.VG_Is_MTA__c && (PSW.ps.VG_MTA_Type__c == 'Revision of Cover' || PSW.ps.VG_MTA_Type__c == 'Extension')){
                    if(PSW.cancellationdate > PSW.ps.VG_MTA_End_Date__c){
                        proratingfator = 0;
                    }else if(MTAcancellationDate < = PSW.ps.VG_MTA_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays+1));
                    }else if(MTAcancellationDate > PSW.ps.VG_MTA_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                        Decimal numDays2 = Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));                        
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays2+1));
                    }
                }else if(!PSW.ps.VG_Is_MTA__c){
                    if(PSW.cancellationdate > PSW.ps.Base_Creation_End_Date__c){
                        proratingfator = 0;
                    }else if(MTAcancellationDate < = PSW.ps.Base_Creation_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c));
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays+1));     
                    }else if(MTAcancellationDate > PSW.ps.Base_Creation_Start_Date__c){
                       if(Math.mod(PSW.ps.Base_Creation_End_Date__c.year(), 4) != 0){
                            if(Math.mod(PSW.ps.Base_Creation_End_Date__c.year(), 4) == 0){
                                if(PSW.ps.Base_Creation_End_Date__c <= date.newInstance(PSW.ps.Base_Creation_End_Date__c.year(), 02, 28)){
                                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                                }else{
                                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)));
                                }
                            }else{
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                            }
                        }else{
                            if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)));
                            }else{
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                            }
                        }           
                    }                   
                }else {
                    Decimal numDays = Decimal.valueOf(MTAcancellationDate.daysBetween(ps.VG_Pre_MTA_Expiry_Date__c));
                    Decimal n2 = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                    if(numDays < = 0)
                        proratingfator = 0;
                    else
                        proratingfator = -1*((numDays+1)/(n2+1));                                      
                }
            }
            If(seletedProrateoption == 'Prorated'){
                if(!IsProRated){
                    if(PSW.Ps.Risk_Premium_Pro__c != null){
                        PSW.RIPro = 0;
                        PSW.RIPro = PSW.Ps.Risk_Premium_Pro__c*proratingfator;                    
                    }else{
                        PSW.Ps.Risk_Premium_Pro__c = 0;
                    }
                    if(PSW.ps.Endorsement_Premium_Pro__c != null){
                        PSW.endPro = 0;
                        PSW.endPro = PSW.ps.Endorsement_Premium_Pro__c*proratingfator;                       
                    }else{
                        PSW.ps.Endorsement_Premium_Pro__c = 0;  
                    }
                }          
                If(!IsCommercialAdjustmentOverride){
                    PSW.CommercialAdjustment = (PSW.ps.Premium_Adjustment_2__c*proratingfator).setscale(2);                    
                } 
            }else If(seletedProrateoption == 'Flat'){
                if(!IsProRated){
                    If(seletedType == 'Cancellation' || seletedType == '' ){           
                        if(PSW.Ps.Risk_Premium_Pro__c != null){
                            PSW.RIPro = 0;
                            PSW.RIPro = PSW.ps.Risk_Premium_Pro__c;                     
                        }else{
                            PSW.Ps.Risk_Premium_Pro__c = 0;
                        }
                        if(PSW.ps.Endorsement_Premium_Pro__c != null){
                            PSW.endPro = 0;
                            PSW.endpro = PSW.ps.Endorsement_Premium_Pro__c;                     
                        }else{
                            PSW.ps.Endorsement_Premium_Pro__c = 0;  
                        }  
                    }else if(seletedType == 'Reduction' ){
                        PSW.RIPro = 0;
                        PSW.endPro = 0;
                    }    
                }          
                If(!IsCommercialAdjustmentOverride){
                    PSW.CommercialAdjustment = (PSW.ps.Premium_Adjustment_2__c).setscale(2);                    
                }                 
            }
            
            PSW.ps.VG_Gross_Written_Premium_100__c = PSW.CommercialAdjustment + PSW.RIPro + PSW.endPro;                        
            PSW.ps.Gross_Written_Premium__c = (PSW.CommercialAdjustment+PSW.RIPro + PSW.endPro)*(PSW.ps.Share__c/100);
            PSW.ps.Net_Premium__c = PSW.RIPro + PSW.endPro;
            PSW.ps.VG_Technical_Model_Premium__c = (PSW.ps.Share__c/100)*PSW.ps.Net_Premium__c;
            if(PSW.ps.VG_Technical_Loss_Ratio__c != null && PSW.ps.VG_Technical_Loss_Ratio__c > 0)
                PSW.ps.Technical_UW_Premium__c = PSW.ps.Gross_Written_Premium__c * (PSW.ps.VG_Technical_Loss_Ratio__c/100);
            
            PSW.ps.VG_Brokerage_Amount__c = PSW.ps.Gross_Written_Premium__c*(PSW.ps.VG_Brokerage_Percent__c/100);
            PSW.ps.Transaction_GWP__c = PSW.ps.Gross_Written_Premium__c+PSW.ps.VG_Fee_Income__c-PSW.ps.VG_Brokerage_Amount__c-(PSW.ps.Gross_Written_Premium__c*(PSW.ps.VG_Overider_Percent__c/100));
            
            for(VG_Policy_Schedule_Asset__c rr:PSW.wrappsaList){
                if(PSW.ps.Product__c == 'AGG Stop Loss'){
                    if((PSW.ps.Premium_Adjustment_2__c+PSW.RIPro + PSW.endPro) > 0  && rr.VG_Limit_Precent__c != null && rr.VG_GNPI__c!= null && rr.VG_Limit_Precent__c > 0){
                        PSW.ps.Rate_On_Line__c = (PSW.CommercialAdjustment+PSW.RIPro + PSW.endPro)/((rr.VG_Limit_Precent__c/100)*rr.VG_GNPI__c);
                    }
                }else{
                    if((PSW.ps.Premium_Adjustment_2__c+PSW.RIPro + PSW.endPro) > 0  && rr.VG_Limit__c != null && rr.VG_Limit__c > 0 && rr.VG_Deductible__c != null)
                        PSW.ps.Rate_On_Line__c = (PSW.CommercialAdjustment+PSW.RIPro + PSW.endPro)/(rr.VG_Limit__c/100);        
                }
            }
            PSW.ps.Actual_GWP__c = PSW.ps.Gross_Written_Premium__c - PSW.ps.VG_Brokerage_Amount__c - (PSW.ps.Gross_Written_Premium__c*(PSW.ps.VG_Overider_Percent__c/100));
        }
        IsProRated = True;
        IsCommercialAdjustmentOverride = True;
        return null;
    }
    
    Public PageReference LSSummaryCalc(){
        Decimal proratingfator = 1;
        If(seletedProrateoption == 'Flat'){
            proratingfator = 1;
        }else{
            if(seletedType == 'Extension'){
                if(ps.VG_MTA_End_Date__c == null){
                    proratingfator = -99;
                }else{
                    if(Math.mod(policy.VG_Inception_Date__c.year(), 4) != 0){
                        if(Math.mod(policy.VG_Expiry_Date__c.year(), 4) == 0){
                            if(policy.VG_Expiry_Date__c <= date.newInstance(policy.VG_Expiry_Date__c.year(), 02, 28)){
                                proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                            }else{
                                proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                            }
                        }else{
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                        }
                    }else{
                        if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                        }else{
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                        }
                    }
                }
            }
            if(seletedType == 'Cancellation'  || seletedType == 'Reduction'){
                if(MTAcancellationDate == null){
                    proratingfator = -99;
                }else{
                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(ps.VG_Pre_MTA_Expiry_Date__c)+1)/365);
                }
            }
        }                   
        for(PSWrapper PSW: PSWrapperMap.values()){
            if(seletedType == 'Extension'){
                If(seletedProrateoption == 'Flat'){     
                    PSW.RIPro = 0;
                    PSW.endPro = 0;
                }    
            }
            if(seletedType == 'Cancellation' || seletedType == 'Reduction' ){
                If(seletedType == 'Cancellation'){
                    MTAcancellationDate = ps.VG_MTA_Cancellation_Date__c; 
                    PSW.cancellationdate = ps.VG_MTA_Cancellation_Date__c; 
                }If(seletedType == 'Reduction' ){
                    MTAcancellationDate = ps.VG_MTA_Reduction_Date__c;
                    PSW.cancellationdate = ps.VG_MTA_Reduction_Date__c;
                }                                 
                if(PSW.ps.VG_Is_MTA__c && (PSW.ps.VG_MTA_Type__c == 'Revision of Cover' || PSW.ps.VG_MTA_Type__c == 'Extension')){
                    if(PSW.cancellationdate > PSW.ps.VG_MTA_End_Date__c){
                        proratingfator = 0;
                    }else if(MTAcancellationDate < = PSW.ps.VG_MTA_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays+1));
                    }else if(MTAcancellationDate > PSW.ps.VG_MTA_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                        Decimal numDays2 = Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));                                                
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays2+1));
                    }
                }else if(!PSW.ps.VG_Is_MTA__c){
                    if(PSW.cancellationdate > PSW.ps.Base_Creation_End_Date__c){
                        proratingfator = 0;
                    }else if(MTAcancellationDate < = PSW.ps.Base_Creation_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c));
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays+1));     
                    }else if(MTAcancellationDate > PSW.ps.Base_Creation_Start_Date__c){
                        if(Math.mod(PSW.ps.Base_Creation_End_Date__c.year(), 4) != 0){
                            if(Math.mod(PSW.ps.Base_Creation_End_Date__c.year(), 4) == 0){
                                if(PSW.ps.Base_Creation_End_Date__c <= date.newInstance(PSW.ps.Base_Creation_End_Date__c.year(), 02, 28)){
                                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                                }else{
                                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)));
                                }
                            }else{
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                            }
                        }else{
                            if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)));
                            }else{
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                            }
                        }           
                    }                   
                }else {
                    Decimal numDays = Decimal.valueOf(MTAcancellationDate.daysBetween(ps.VG_Pre_MTA_Expiry_Date__c));
                    Decimal n2 = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                    if(numDays < = 0)
                        proratingfator = 0;
                    else
                        proratingfator = -1*((numDays+1)/(n2+1));                                      
                }
            }
            If(seletedProrateoption == 'Prorated'){
                if(!IsProRated){
                    if(PSW.Ps.Risk_Premium_Pro__c != null){
                        PSW.RIPro = 0;
                        PSW.RIPro = PSW.Ps.Risk_Premium_Pro__c*proratingfator;                    
                    }else{
                        PSW.Ps.Risk_Premium_Pro__c = 0;
                    }
                    if(PSW.ps.Endorsement_Premium_Pro__c != null){
                        PSW.endPro = 0;
                        PSW.endPro = PSW.ps.Endorsement_Premium_Pro__c*proratingfator;                   
                    }else{
                        PSW.ps.Endorsement_Premium_Pro__c = 0;  
                    }  
                }
                If(!IsPremiumAdjustmentOverride){
                    PSW.PremiumAdjustment = (PSW.ps.Premium_Adjustment__c*proratingfator).setscale(2);  
                }   
                If(!IsCommercialAdjustmentOverride){
                    PSW.CommercialAdjustment = (PSW.ps.Premium_Adjustment_2__c*proratingfator).setscale(2);                    
                } 
            }else If(seletedProrateoption == 'Flat'){
                if(!IsProRated){
                    If(seletedType == 'Cancellation' || seletedType == '' ){           
                        if(PSW.Ps.Risk_Premium_Pro__c != null){
                            PSW.RIPro = 0;
                            PSW.RIPro = PSW.ps.Risk_Premium_Pro__c;                     
                        }else{
                            PSW.Ps.Risk_Premium_Pro__c = 0;
                        }
                        if(PSW.ps.Endorsement_Premium_Pro__c != null){
                            PSW.endPro = 0;
                            PSW.endpro = PSW.ps.Endorsement_Premium_Pro__c;                     
                        }else{
                            PSW.ps.Endorsement_Premium_Pro__c = 0;  
                        }  
                    }else if(seletedType == 'Reduction' ){
                        PSW.RIPro = 0;
                        PSW.endPro = 0;
                    }    
                }
                If(!IsPremiumAdjustmentOverride){
                    PSW.PremiumAdjustment = (PSW.ps.Premium_Adjustment__c).setscale(2);                     
                }   
                
                If(!IsCommercialAdjustmentOverride){
                    PSW.CommercialAdjustment = (PSW.ps.Premium_Adjustment_2__c).setscale(2);                    
                } 
            }
            PSW.ps.Net_Premium__c = PSW.RIPro + PSW.endPro;
            PSW.TSI = 0;            
            for(VG_Policy_Schedule_Asset__c rr:PSW.wrappsaList){  
                If(rr.VG_Sum_Insured__c!= null)
                    PSW.TSI = PSW.TSI+rr.VG_Sum_Insured__c;
            }
            PSW.ps.Sum_Insured__c = PSW.TSI*(PSW.ps.Share__c/100)  ;
            PSW.ps.Technical_UW_Premium__c = PSW.RIPro + PSW.endPro + PSW.PremiumAdjustment;               
            PSW.GWP = PSW.ps.Technical_UW_Premium__c+PSW.CommercialAdjustment ;
            PSW.ps.VG_Gross_Written_Premium_100__c = PSW.GWP;
            if(PSW.ps.Share__c != null && PSW.ps.Share__c != 0)
                PSW.ps.Gross_Written_Premium__c = PSW.GWP * (PSW.ps.Share__c / 100);            
            PSW.ps.VG_Brokerage_Amount__c = psw.ps.Gross_Written_Premium__c*(PSW.ps.VG_Brokerage_Percent__c/100);
            PSW.ps.Actual_GWP__c = psw.ps.Gross_Written_Premium__c - PSW.ps.VG_Brokerage_Amount__c;
            PSW.ps.VG_Technical_Model_Premium__c = (PSW.ps.Share__c/100)*PSW.ps.Net_Premium__c;
            PSW.ps.VG_VAT_Amount__c = (PSW.ps.VG_VAT__c/100)*PSW.ps.VG_Fee_Income__c;
            
            If(PSW.ps.Gross_or_Net_Premium__c == 'Gross'){
                PSW.ps.Transaction_GWP__c = PSW.ps.Gross_Written_Premium__c +PSW.ps.Gross_Written_Premium__c +PSW.ps.VG_Fee_Income__c;
                
            }else{
                PSW.ps.Transaction_GWP__c = PSW.ps.Actual_GWP__c+PSW.ps.Gross_Written_Premium__c +PSW.ps.VG_Fee_Income__c;
            }           
        }
        IsProrated = True;
        IsPremiumAdjustmentOverride = True;
        IsCommercialAdjustmentOverride = True;
        return null;
    }
    
    Public PageReference GentiumSummaryCalc(){
        Decimal proratingfator = 1;
        If(seletedProrateoption == 'Flat'){
            proratingfator = 1;
        }else{
            if(seletedType == 'Extension'){
                if(ps.VG_MTA_End_Date__c == null){
                    proratingfator = -99;
                }else{
                    if(Math.mod(policy.VG_Inception_Date__c.year(), 4) != 0){
                        if(Math.mod(policy.VG_Expiry_Date__c.year(), 4) == 0){
                            if(policy.VG_Expiry_Date__c <= date.newInstance(policy.VG_Expiry_Date__c.year(), 02, 28)){
                                proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                            }else{
                                proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                            }
                        }else{
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                        }
                    }else{
                        if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                        }else{
                            proratingfator = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1);
                        }
                    }
                }
            }
            if(seletedType == 'Cancellation'  || seletedType == 'Reduction'){
                if(MTAcancellationDate == null){
                    proratingfator = -99;
                }else{
                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(ps.VG_Pre_MTA_Expiry_Date__c)+1)/365);
                }
            }
        }               
        for(PSWrapper PSW: PSWrapperMap.values()){
            if(seletedType == 'Extension'){
                If(seletedProrateoption == 'Flat'){     
                    PSW.RIPro = 0;
                    PSW.endPro = 0;
                }    
            }
            if(seletedType == 'Cancellation' || seletedType == 'Reduction' ){
                If(seletedType == 'Cancellation'){
                    MTAcancellationDate = ps.VG_MTA_Cancellation_Date__c; 
                    PSW.cancellationdate = ps.VG_MTA_Cancellation_Date__c; 
                }If(seletedType == 'Reduction' ){
                    MTAcancellationDate = ps.VG_MTA_Reduction_Date__c;
                    PSW.cancellationdate = ps.VG_MTA_Reduction_Date__c;
                }                    
                if(PSW.ps.VG_Is_MTA__c && (PSW.ps.VG_MTA_Type__c == 'Revision of Cover' || PSW.ps.VG_MTA_Type__c == 'Extension')){
                    if(PSW.cancellationdate > PSW.ps.VG_MTA_End_Date__c){
                        proratingfator = 0;
                    }else if(MTAcancellationDate < = PSW.ps.VG_MTA_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays+1));
                    }else if(MTAcancellationDate > PSW.ps.VG_MTA_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                        Decimal numDays2 = Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));  
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays2+1));
                    }
                }else if(!PSW.ps.VG_Is_MTA__c){
                    if(PSW.cancellationdate > PSW.ps.Base_Creation_End_Date__c){
                        proratingfator = 0;
                    }else if(MTAcancellationDate < = PSW.ps.Base_Creation_Start_Date__c){
                        Decimal numDays = Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c));
                        if(numDays < = 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays+1)/(numDays+1));     
                    }else if(MTAcancellationDate > PSW.ps.Base_Creation_Start_Date__c){
                        if(Math.mod(PSW.ps.Base_Creation_End_Date__c.year(), 4) != 0){
                            if(Math.mod(PSW.ps.Base_Creation_End_Date__c.year(), 4) == 0){
                                if(PSW.ps.Base_Creation_End_Date__c <= date.newInstance(PSW.ps.Base_Creation_End_Date__c.year(), 02, 28)){
                                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                                }else{
                                    proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)));
                                }
                            }else{
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                            }
                        }else{
                            if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)));
                            }else{
                                proratingfator = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                            }
                        }           
                    }                   
                }else {
                    Decimal numDays = Decimal.valueOf(MTAcancellationDate.daysBetween(ps.VG_Pre_MTA_Expiry_Date__c));
                    Decimal n2 = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c));
                    if(numDays < = 0)
                        proratingfator = 0;
                    else
                        proratingfator = -1*((numDays+1)/(n2+1));                                    
                }
            }
            if(PSW.ps.Product__c == 'Schemes'){               
                PSW.CCAmount = 0;
                for(VG_Policy_Schedule_Asset__c rr:PSW.wrappsaList){
                    PSW.CCAmount = PSW.CCAmount+rr.VG_CH_Commission__c;
                }
                for(VG_Policy_Schedule_Asset__c rrw:PSW.wrappsaList){
                    if(sumGWP != null && rrw.VG_Gross_Written_Premium__c != null){
                        sumGWP = rrw.VG_Gross_Written_Premium__c+sumGWP;
                    }
                }
                
                PSW.ps.VG_Gross_Written_Premium_100__c = sumGWP;
                PSW.ps.Gross_Written_Premium__c = sumGWP;       
                
                if(PSW.ps.VG_Brokerage_Percent__c != 0 && PSW.ps.Gross_Written_Premium__c != null)
                    PSW.ps.VG_Brokerage_Amount__c = (PSW.ps.VG_Brokerage_Percent__c/100) * PSW.ps.Gross_Written_Premium__c  ;
                else
                    PSW.ps.VG_Brokerage_Amount__c = 0;
                
                if(PSW.CCAmount != 0 && PSW.ps.Gross_Written_Premium__c  != 0 && PSW.CCPrecent != 0){
                    PSW.CCPrecent = (PSW.CCAmount / PSW.ps.Gross_Written_Premium__c );
                }
                PSW.ps.Actual_GWP__c = (PSW.ps.Gross_Written_Premium__c != null ? PSW.ps.Gross_Written_Premium__c :0)  - PSW.ps.VG_Brokerage_Amount__c - PSW.CCAmount;
                PSW.ps.Transaction_GWP__c = PSW.ps.Actual_GWP__c + PSW.ps.VG_Fee_Income__c ;
            }else{
                If(seletedProrateoption == 'Prorated'){
                    if(!IsProRated){
                        if(PSW.Ps.Risk_Premium_Pro__c != null){
                            PSW.RIPro = 0;
                            PSW.RIPro = PSW.Ps.Risk_Premium_Pro__c*proratingfator;                    
                        }else{
                            PSW.Ps.Risk_Premium_Pro__c = 0;
                        }
                        if(PSW.ps.Endorsement_Premium_Pro__c != null){
                            PSW.endPro = 0;
                            PSW.endPro = PSW.ps.Endorsement_Premium_Pro__c*proratingfator;                           
                        }else{
                            PSW.ps.Endorsement_Premium_Pro__c = 0;  
                        }  
                        if(PSW.ps.Technical_UW_Premium__c != null){
                            PSW.techUWPre = 0;
                            PSW.techUWPre = PSW.ps.Technical_UW_Premium__c*proratingfator;
                        }else{
                            PSW.ps.Technical_UW_Premium__c = 0;
                        }                    
                    }
                    If(!IsPremiumAdjustmentOverride){
                        PSW.PremiumAdjustment = (PSW.ps.Premium_Adjustment__c*proratingfator).setscale(2);  
                    } 
                }else If(seletedProrateoption == 'Flat'){
                    if(!IsProRated){
                        If(seletedType == 'Cancellation' || seletedType == '' ){           
                            if(PSW.Ps.Risk_Premium_Pro__c != null){
                                PSW.RIPro = 0;
                                PSW.RIPro = PSW.ps.Risk_Premium_Pro__c;                     
                            }else{
                                PSW.Ps.Risk_Premium_Pro__c = 0;
                            }
                            if(PSW.ps.Endorsement_Premium_Pro__c != null){
                                PSW.endPro = 0;
                                PSW.endpro = PSW.ps.Endorsement_Premium_Pro__c;                     
                            }else{
                                PSW.ps.Endorsement_Premium_Pro__c = 0;  
                            }                                
                        }else if(seletedType == 'Reduction' ){
                            PSW.RIPro = 0;
                            PSW.endPro = 0;                           
                        }
                        if(PSW.ps.Technical_UW_Premium__c != null){
                            PSW.techUWPre = 0;
                            PSW.techUWPre = PSW.ps.Technical_UW_Premium__c;                                
                        }else{
                            PSW.ps.Technical_UW_Premium__c = 0;
                        }                                           
                    }
                    If(!IsPremiumAdjustmentOverride){
                        PSW.PremiumAdjustment = (PSW.ps.Premium_Adjustment__c).setscale(2);                         
                    } 
                }                
                if(PSW.ps.VG_Fee_Income__c>0){
                    PSW.ps.VG_VAT__c = 20;
                }else{
                    PSW.ps.VG_VAT__c = 0;
                    PSW.ps.VG_VAT_Amount__c = 0;
                }
                
                if(PSW.PremiumAdjustment != null)
                    PSW.ps.Gross_Written_Premium__c = (PSW.RIPro+PSW.endPro)+ PSW.PremiumAdjustment;
                else
                    PSW.ps.Gross_Written_Premium__c = 0;
                PSW.ps.VG_Gross_Written_Premium_100__c = PSW.ps.Gross_Written_Premium__c;       
                if(PSW.ps.VG_Brokerage_Percent__c != null){
                    PSW.ps.VG_Brokerage_Amount__c = PSW.ps.Gross_Written_Premium__c  * (PSW.ps.VG_Brokerage_Percent__c/100);
                }else{
                    PSW.ps.VG_Brokerage_Amount__c = 0;
                }
                PSW.ps.Actual_GWP__c = PSW.ps.Gross_Written_Premium__c  - PSW.ps.VG_Brokerage_Amount__c;
                if(PSW.ps.VG_Fee_Income__c != null){
                    PSW.transactPremium = PSW.ps.Gross_Written_Premium__c  +PSW.ps.VG_Fee_Income__c-PSW.ps.VG_Brokerage_Amount__c ;
                }else{
                    PSW.transactPremium = PSW.ps.Gross_Written_Premium__c -PSW.ps.VG_Brokerage_Amount__c ;
                }
                if(PSW.ps.VG_VAT__c != null && PSW.ps.VG_Fee_Income__c != null){
                    PSW.ps.VG_VAT_Amount__c = PSW.ps.VG_Fee_Income__c * (PSW.ps.VG_VAT__c/100);
                }else{
                    PSW.ps.VG_VAT_Amount__c = 0;
                }    
            }
        }
        IsProRated = True;
        IsPremiumAdjustmentOverride = True;
        return null;
    }
    
    Public void calcJunction(){
        IsProrated = false;
        IsPremiumAdjustmentOverride = false;
        IsCommercialAdjustmentOverride = false;             
        if(IsExtension && ps.VG_MTA_Start_Date__c > ps.VG_MTA_End_Date__c){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'MTA End Date must come after MTA Start Date..'));
        }else if((IsCancellation || IsReduction) && ps.VG_Pre_MTA_Expiry_Date__c < ps.VG_MTA_Cancellation_Date__c){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Cancellation Date must come before Current Expiry Date..'));
        }else{
            if(policy.RecordType.Name == 'Aesir')
                AesirSummaryCalc();
            if(policy.RecordType.Name == 'VFP')
                FIDOSummaryCalc();
            if(policy.RecordType.Name == 'Imara' || policy.RecordType.Name == 'Horizon')
                AlphaHorizonSummaryCalc();
            if(policy.RecordType.Name == 'Affinity')
                LSSummaryCalc();
            if(policy.RecordType.Name == 'Gentium')
                GentiumSummaryCalc();
        }
    }
    
    Public Class PSWrapper{
        Public Policy_Schedule__c ps {get; set;}
        Public List<VG_Policy_Schedule_Asset__c> wrappsaList{get; set;}
        Public List<VG_Policy_Schedule_Endorsement__c> wrappseList {get; set;}
        Public List<VG_Policy_Schedule_Endorsement__c> wrapsbpseList {get; set;}
        
        Public List<Risk_Capture__c> wraprcList {get; set;}
        Public Decimal technicalPremium {get; set;}
        Public Decimal actualPremium {get; set;}
        Public Decimal transactionalPremium {get; set;}
        Public Decimal brokerageAmount {get; set;}
        Public Decimal RIPro {get; set;}
        Public Decimal endPro {get; set;}
        Public Decimal techUWPre{get;set;}
        Public Decimal TSI {get; set;}
        Public Decimal CCAmount{get; set;}
        Public Decimal CCPrecent{get; set;}
        Public Decimal transactPremium {get; set;}
        Public Decimal GWP{get;set;}
        Public Decimal PremiumAdjustment{get;set;}
        Public Decimal CommercialAdjustment{get;set;}
        Public Date cancellationdate {get;set;}
        
        Public PSWrapper(){
            ps = new Policy_Schedule__c();
            wrappsaList = new List<VG_Policy_Schedule_Asset__c>();
            wrappseList = new List<VG_Policy_Schedule_Endorsement__c>();
            wrapsbpseList = new List<VG_Policy_Schedule_Endorsement__c>();
            wraprcList = new List<Risk_Capture__c>();
            endPro = 0;
            TSI = 0;
            CCAmount = 0;
            CCPrecent = 0;
            transactPremium = 0;
            RIPro = 0;
            GWP = 0;
            technicalPremium = 0;
            actualPremium = 0;
            transactionalPremium = 0;
            brokerageAmount = 0;
            techUWPre = 0;
            CommercialAdjustment = 0;
            PremiumAdjustment = 0;
        }
    } 
}