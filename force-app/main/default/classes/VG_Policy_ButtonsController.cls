public with sharing class VG_Policy_ButtonsController {
    
    @AuraEnabled
    public static List<Policy__c> getPolicyStatus(Id polId){
        List<Policy__c> polList  =  new List<Policy__c>();
        Policy__c pol  =  [select id,  Name,  Policy_Status__c,  CurrencyIsoCode,  VG_Renewal_Policy_Id__c,  Insured__c,  VG_Is_Renewal__c,  MTA_Cancel_List__c from Policy__c where id = :polId limit 1];
        polList.add(pol);
        if(pol.VG_Renewal_Policy_Id__c!= null){
            Policy__c renewalPol  =  [select id ,  Name,  Policy_Status__c,  CurrencyIsoCode,  VG_Renewal_Policy_Id__c,  VG_Is_Renewal__c,  Insured__c,  MTA_Cancel_List__c from Policy__c where id = :pol.VG_Renewal_Policy_Id__c limit 1];
            polList.add(renewalPol);
        }
        return polList;
    }
    
    @AuraEnabled
    public static Id getBasePolicy(Id polId){
        Policy__c pol = [select id, Name, Policy_Status__c, CurrencyIsoCode, VG_Renewal_Policy_Id__c, Insured__c, VG_Is_Renewal__c, MTA_Cancel_List__c from Policy__c where VG_Renewal_Policy_Id__c=:polId limit 1];
        System.debug('polid:'+pol.id);
        return pol.id;
    }
    
    @AuraEnabled
    public static String createRenewalPolicy(Id policyId){
        Map<id, Policy_Schedule__c > psMap  =  new Map<Id, Policy_Schedule__c >();
        Map<id, Policy_Schedule__c > psROCMap  =  new Map<Id, Policy_Schedule__c >();
        Map<id, List<VG_Exposure_Premium__c>> expMap  =  new Map<id, List<VG_Exposure_Premium__c>>();
        Map<id, List<VG_Policy_Schedule_Asset__c>> psaMap  =  new Map<id, List<VG_Policy_Schedule_Asset__c>>();
        Map<id, List<VG_Policy_Schedule_Endorsement__c>> pseMap  =  new Map<id, List<VG_Policy_Schedule_Endorsement__c>>();
        Map<id, Risk_Capture__c> rcMap  =  new Map<id, Risk_Capture__c>();
        
        Policy__c policy  =  [select id,  Name,  CurrencyIsoCode, Description__c, VG_Programme_Reference_Number__c,VG_Programme_Reference_Number__r.Name, VG_LTA__c,  VG_NAIC_Code__c,  Terms_of_Trade_Days__c,  RecordTypeId,  CreatedDate,  CreatedById,  LastModifiedDate,  LastModifiedById,  Insured__c,  VG_US_Classification__c,  Broker_Contact__c,  AP_TP__c,  Adjustment_Reason__c,  Am_I_Underwriter__c,  Broker_Name__c,  Declaration_Type__c,  Deductible_or_Excess_Amount__c,  Deductible_or_Excess_Basis__c,  Formula_Sum_Insured_Share__c,  Inception_Expiry_Time__c,  IsApproved_External__c,  Line_Of_Business__c,  Payment_Frequency__c,  Policy_Basis__c,  Policy_Status__c,  Risk_Assessor__c,  Sum_Insured_Share__c,  Total_Sum_Insured__c,  Type_of_Insurance__c,  Underwriter__c,  VG_Aggregate_Limit__c,  VG_Brokerage_Percent__c,  VG_Current_Insurer__c,  VG_Expiry_Date__c,  VG_Inception_Date__c,  VG_IsApproved__c,  VG_Prospect_Premium__c,  VG_Sub_Broker__c,  VG_Sub_Status__c, IPT__c,  Gross_Written_Premium__c,  Gross_Written_Premium_Rollup__c,  VG_Brokerage_Amount__c,  Earned_Aggregate_Balance__c,  Extended_Reporting__c,  Lead_Insurer__c,  Loss_Ratio__c,  Retroactive_Date__c,  Total_Aggregate_Balance__c,  Actual_GWP__c,  Total_claims_o_s__c,  MTA_Cancel_List__c, Endorsement_GWP__c, Jurisdiction__c, Levies__c, Premium_Adjustment__c, Risk_Premium__c, Technical_Model_Premium__c, Technical_UW_Premium__c, Total_claims_paid__c, Paid_Aggregate_Balance__c, VG_Fee_Income__c, VG_MGA_Commission_Amount__c, VG_Lloyds_Products__c, Total_claims_reserve__c, VG_Additional_Insureds__c, VG_Continuous_Cover_Date__c, VG_Governance_Compliance__c, VG_Local_Policies__c, VG_Plan_Rate__c, VG_Territorial_Limits__c, VG_Wording__c, Commercial_Adjustment__c, Transaction_GWP__c, VG_Is_Renewal__c, VG_Renewal_Policy_Id__c from Policy__c where id = :policyid limit 1];
        Map<id, Policy_Schedule__c > allPSMap  =  new Map<Id, Policy_Schedule__c >([select id,  Name,Split_Type__c,VG_Volante_Entities__c, VG_Co_Insurance_Parent__c,VG_Co_Insurance_Parent__r.Name ,VG_Co_Insurance_type__c,VG_Is_Co_Insurance__c, IsDeleted,  CurrencyIsoCode,  RecordTypeId,  CreatedDate,  VG_Financials_Created__c,  VG_Risk_Premium__c, Insured_Id__c, Declaration_Date__c, Product__c, Policy__c, VG_Plan_Rate__c, IPT_Percent__c,  Premium_Adjustment__c,  Endorsement_GWP__c,  Levies__c,  VG_Transaction_Type__c,  VG_Risk_Transaction_Type__c, VG_Is_MTA__c,  VG_MTA_Type__c,  VG_MTA_Status__c,  VG_MTA_Start_Date__c,  VG_MTA_End_Date__c,  VG_Current_Plan_Rate__c,  VG_MTA_Cancellation_Date__c,  MTA_Reason_for_Cancellation__c,  VG_Declaration_Type__c,  VG_Status__c , Net_Premium__c,  VG_Declaration_Type_percent__c,  VG_Fee_Income__c,  VG_Adjustment_Reason__c,  VG_Brokerage_Percent__c,  VG_Net_Premium_Due__c,  VG_Pre_MTA_Expiry_Date__c,  VG_Base_Policy__c,  Base_Creation_Start_Date__c,  Base_Creation_End_Date__c,  Commission__c,  Gross_Base_Premium__c,  VG_MGA_Commission_Amount__c,  VG_Technical_Model_Premium__c,  Technical_UW_Premium__c,  Risk_Premium_Pro__c,  Endorsement_Premium_Pro__c,  Limit__c, Attachment__c,  Sum_Insured__c,  ILF_Factor__c,  ILF_Premium__c,  Rate_On_Line__c, Rate_Per_Mil__c, Share__c, Underwriting_Premium__c, Premium_Adjustment_2__c, ORC__c, ORC_Amount__c, Account_Id__c, VG_VAT__c, VG_VAT_Amount__c, VG_Lloyds_Product__c, VG_Net_Premium_Receivable__c, VG_Auto_acquisition_Threshold__c, VG_Extended_Reporting_Period_AP__c, ILF_Layer__c, VG_Retired_Directors_Additional_Premium__c, VG_Retired_Directors_Year__c, VG_Extended_Reporting_Period__c, Technical_Layer_Premium__c, Written_share__c, Gross_Written_Premium__c, Gross_or_Net_Premium__c, VG_Overider_Amount__c, VG_Overider_Percent__c, VG_Total_Layer_Premium__c, Transaction_GWP__c, Actual_GWP__c, IPT__c, VG_Brokerage_Amount__c, VG_Deductible__c, VG_Coverages__c, VG_Number_Of_vehicle__c, VG_Turn_Over__c, VG_Type_Of_Operation__c, VG_CREDIT_Augur_SCORE__c, VG_Exposure_Premium__c, VG_Experience_Premium__c, VG_Selected_Weight__c, VG_Net_Base_Premium__c, VG_Occupancy__c, VG_PD_Base_Rate__c, VG_BI_Base_Rate__c, VG_Machinery_Breakdown_Cover__c, VG_Machinery_Breakdown_BI_Cover__c, VG_Adjustment_Factor__c, VG_Adjusted_PD_Base_Rate__c, VG_Adjusted_BI_Base_Rate__c, VG_Witholding_Tax_Amount__c, VG_Net_Premium_Received__c, VG_Reinsurance_Type__c, VG_Structure__c, VG_Sub_Structure__c, VG_Technical_Loss_Ratio__c, MID_Check_Box__c, VG_Capacity_Paper__c, VG_Payment_Due_Date__c, VG_Wording__c, VG_Reporting_Date__c, VG_Rate_Change__c, VG_Municipality_Code__c, VG_Side_B_Rentention__c, VG_Side_C_Rentention__c, VG_D_O_Product__c, VG_Gross_Written_Premium_100__c, VG_Bridge_Selected_Asset__c, MTA_Parent_Policy_Schedule__c from Policy_Schedule__c where Policy__c  = : policy.id AND VG_MTA_Type__c != 'Cancellation' AND VG_MTA_Type__c != 'Reduction' AND VG_MTA_Type__c != 'Extension' Order By CreatedDate Asc]);
        Map<Id, Policy_Schedule__c  > haveROCMap  =  new Map<Id, Policy_Schedule__c>();
        
        for(Policy_Schedule__c  ps: allPSMap.values()){
            if(!ps.VG_Is_MTA__c){
                psMap.put(ps.id, ps);
            }else{
                psROCMap.put(ps.id, ps);
                if(!haveROCMap.containsKey(ps.MTA_Parent_Policy_Schedule__c)){
                    haveROCMap.put(ps.MTA_Parent_Policy_Schedule__c, ps);
                }else{
                    if(haveROCMap.get(ps.MTA_Parent_Policy_Schedule__c).CreatedDate < ps.CreatedDate)
                        haveROCMap.put(ps.MTA_Parent_Policy_Schedule__c, ps);
                }
            }
        }
        List<VG_Policy_Schedule_Asset__c > psaList = new List<VG_Policy_Schedule_Asset__c>([select Annual_Rate_100__c,Asset__c,CreatedById,CreatedDate,CurrencyIsoCode,Id,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,RecordTypeId,SystemModstamp,Technical_UW_Premium__c,VG_AAD__c,VG_Address2__c,VG_Address3__c,VG_Address__c,VG_Adjusted_BI_Premium__c,VG_Adjusted_PD_Premium__c,VG_Aggregate_Precent__c,VG_Aggregate__c,VG_Attachment__c,VG_Avg_SI__c,VG_Base_Premium_Rate__c,VG_Base_Premium__c,VG_Binder_Ref__c,VG_BI_Indemnity_Period__c,VG_Bordereax_Date__c,VG_Brokerage__c,VG_Building_Discount_Loading__c,VG_CC_Information__c,VG_Ceding_Commission__c,VG_Cession__c,VG_CH_Commission__c,VG_Country__c,VG_Coverage_Type__c,VG_Coverage__c,VG_Date_of_Birth__c,VG_Declared_Value__c,VG_Deductible_Precent__c,VG_Deductible__c,VG_Deposit_Premium_Formula__c,VG_Deposit_Premium__c,VG_Event_Limit__c,VG_Expected_Ceding_Commission__c,VG_Expected_Loss_Ratio__c,VG_Expected_Premium_Income__c,VG_Expected_Profit_Commission__c,VG_Fee_Amounts__c,VG_GNPI__c,VG_Gross_Written_Premium__c,VG_Information__c,VG_Insured_Name__c,VG_IsTempDelete__c,VG_IsTemp__c,VG_Limit_Precent__c,VG_Limit__c,VG_Loss_Ratio_for_Max__c,VG_Loss_Ratio_for_Min__c,VG_Management_Expenses_for_PC__c,VG_Max_Ceding_Commission__c,VG_Max_Rate__c,VG_Max_SI__c,VG_MB_BI_Indemnity_Period__c,VG_MB_PD_Deductible__c,VG_MB_Waiting_Period__c,VG_Minimum_Premium_Formula__c,VG_Minimum_Premium__c,VG_Min_Ceding_Commission__c,VG_Min_Rate__c,VG_Net_BI_Premium__c,VG_Net_MB_Premium__c,VG_Net_PD_Premium__c,VG_Net_Risk_Premium__c,VG_No_Claims_Bonus_Value__c,VG_No_Claims_Bonus__c,VG_No_of_Surplus_Lines__c,VG_Number_of_Vehicles__c,VG_OtherRisk__c,VG_Payment_Ref__c,VG_Payment_Terms__c,VG_PD_Deductible__c,VG_Perils_Text__c,VG_Perils__c,VG_Policy_Basis__c,VG_Policy_Cover_End_Date__c,VG_Policy_Cover_Start_Date__c,VG_Policy_No__c,VG_Policy_Schedule__c,VG_Postcode__c,VG_Premium__c,VG_Profession__c,VG_Provisional_Rate__c,VG_Rate_on_Income__c,VG_Rate_Per_Vehicle__c,VG_Registration_Plate__c,VG_Retention_Line__c,VG_Retention__c,VG_Retroactive_Date__c,VG_Return_Period_Entry__c,VG_Return_Period_Exit__c,VG_Risk_End__c,VG_Risk_Premium__c,VG_Risk_start__c,VG_Scheme_Name__c,VG_Share__c,VG_Signed_Share__c,VG_Sub_Aggregation__c,VG_Sub_broker__c,VG_Sub_limit__c,VG_Sum_Insured__c,VG_Swing_Load__c,VG_Tax_on_Premium__c,VG_Technical_UW_Rate_Annual__c,VG_Territorial_Limits__c,VG_Transaction_Effective_date__c,VG_Transaction_Type__c,VG_Treaty_Limit__c,VG_Use__c,VG_Vehicle_Make__c,VG_Vehicle_Model__c,VG_Vehicle_Type__c,VG_Waiting_Period__c,VG_Written_Share__c from VG_Policy_Schedule_Asset__c where (VG_Policy_Schedule__c IN: psMap.keyset() OR VG_Policy_Schedule__c IN: psROCMap.keyset())  ORDER By Name DESC]);
        List<VG_Policy_Schedule_Endorsement__c > pseList = new List<VG_Policy_Schedule_Endorsement__c>([select id, Name, CurrencyIsoCode, CreatedDate, VG_Premium__c, VG_Policy_Schedule__c, VG_Title__c, VG_Endorsement_Details__c, VG_Endorsement_Library_Id__c, VG_Endorsement_Number__c, VG_IsTemp__c, VG_IsTempDelete__c, VG_Sub_limit__c, VG_Type__c, VG_Product__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c IN: psMap.keyset() OR VG_Policy_Schedule__c IN: psROCMap.keyset()  ORDER By Name DESC]);
        List<VG_Exposure_Premium__c> expList = new List<VG_Exposure_Premium__c>([select id, Name, CurrencyIsoCode, CreatedDate, VG_Factor_Name__c, VG_Rating_Factor__c, VG_Rate__c, VG_Other_Factor__c, VG_Policy_Schedule__c from VG_Exposure_Premium__c where VG_Policy_Schedule__c IN: psMap.keyset() OR VG_Policy_Schedule__c IN: psROCMap.keyset()]);
        List<Risk_Capture__c> rcList = new List<Risk_Capture__c>([select CreatedById,CreatedDate,CurrencyIsoCode,De_Minimis_description__c,Drivers_Claims__c,Drivers_Convictions__c,Drivers_Conviction_Points__c,Drivers_DOB__c,Drivers_License_Ban_Details__c,Drivers_Medical_Conditions__c,Drivers_Name__c,Id,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,Policy_Schedule__c,SystemModstamp,VG_Additional_Information__c,VG_Buyer__c,VG_Cash_Loss_Limit__c,VG_Ceding_Commission_Type__c,VG_Claims_Notification_Threshold__c,VG_Class_1_Employees__c,VG_Company_Domicile__c,VG_Company_Type__c,VG_Completion_Date__c,VG_De_Minimis_Amount__c,VG_De_Minimis_Applicable_to_all_risks__c,VG_De_Minimis_of_EV__c,VG_Dispute_Clause__c,VG_Endorsed__c,VG_Enterprise_Value__c,VG_Expense_Agreement_Amount__c,VG_Expense_Agreement_t_Amount_Tax__c,VG_Fees_Current_Year__c,VG_Fees_Year_1__c,VG_Fees_Year_2__c,VG_Fees_Year_3__c,VG_First_Premium_Payment_Date__c,VG_Governing_Law_of_Sale_Agreement__c,VG_Headcount__c,VG_Income_Basis__c,VG_Industry__c,VG_Layer__c,VG_Market_Cap__c,VG_Net_Equity__c,VG_Net_Profit__c,VG_No_of_Reinstatements__c,VG_Plan_Loss_Ratio__c,VG_Policy_Details__c,VG_Profession__c,VG_Rate_Type__c,VG_Reinstatement_Premium__c,VG_Retention_Amount__c,VG_Retention_Applicable_to_all_risks__c,VG_Retention_description__c,VG_Retention_Fixed_or_Tipping__c,VG_Retention_of_EV__c,VG_Revenue__c,VG_Risk_End__c,VG_Risk_start__c,VG_Sector__c,VG_Seller__c,VG_Share__c,VG_Target__c,VG_Territorial_Limits__c,VG_Territorial_Scope__c,VG_Total_Assets__c from Risk_Capture__c where Policy_Schedule__c IN: psMap.keyset() OR Policy_Schedule__c IN: psROCMap.keyset()]);
        
        for(Policy_Schedule__c  ps: allPSMap.values()){
            if(ps.VG_Is_MTA__c){
                if(ps.Product__c  ==  'Commercial Combined'){
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Limit__c = ps.Limit__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Brokerage_Percent__c = ps.VG_Brokerage_Percent__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Written_share__c = ps.Written_share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Share__c = ps.Share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_or_Net_Premium__c = ps.Gross_or_Net_Premium__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c : 0)+(ps.Risk_Premium_Pro__c !=  null ? ps.Risk_Premium_Pro__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  : 0)+(ps.Endorsement_Premium_Pro__c  !=  null ? ps.Endorsement_Premium_Pro__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c : 0)+(ps.Premium_Adjustment_2__c !=  null ? ps.Premium_Adjustment_2__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c : 0)+(ps.VG_Fee_Income__c !=  null ? ps.VG_Fee_Income__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c!=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c: 0)+(ps.Levies__c!=  null ? ps.Levies__c: 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c : 0)+(ps.Premium_Adjustment__c !=  null ? ps.Premium_Adjustment__c : 0);
                }else if(ps.Product__c !=  'Property'){
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Limit__c = ps.Limit__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Brokerage_Percent__c = ps.VG_Brokerage_Percent__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Written_share__c = ps.Written_share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Share__c = ps.Share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_or_Net_Premium__c = ps.Gross_or_Net_Premium__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Rate_On_Line__c = ps.Rate_On_Line__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Rate_Per_Mil__c = ps.Rate_Per_Mil__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).ILF_Factor__c = ps.ILF_Factor__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).ILF_Premium__c = ps.ILF_Premium__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).ILF_Layer__c = ps.ILF_Layer__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Attachment__c = ps.Attachment__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Technical_Layer_Premium__c = ps.Technical_Layer_Premium__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c : 0)+(ps.Risk_Premium_Pro__c !=  null ? ps.Risk_Premium_Pro__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  : 0)+(ps.Endorsement_Premium_Pro__c  !=  null ? ps.Endorsement_Premium_Pro__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c : 0)+(ps.Premium_Adjustment_2__c !=  null ? ps.Premium_Adjustment_2__c : 0);
                    System.debug(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c+'::'+ps.Levies__c);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c  = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c  !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c  : 0)+(ps.Levies__c  !=  null ? ps.Levies__c  : 0);
                    System.debug(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c  = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c  !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c  : 0)+(ps.VG_Fee_Income__c  !=  null ? ps.VG_Fee_Income__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c : 0)+(ps.Premium_Adjustment__c !=  null ? ps.Premium_Adjustment__c : 0);
                }else if(ps.Product__c  ==  'Property'){
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Written_share__c = ps.Written_share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Share__c = ps.Share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_or_Net_Premium__c = ps.Gross_or_Net_Premium__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Brokerage_Percent__c = ps.VG_Brokerage_Percent__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c : 0)+(ps.Risk_Premium_Pro__c !=  null ? ps.Risk_Premium_Pro__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  : 0)+(ps.Endorsement_Premium_Pro__c  !=  null ? ps.Endorsement_Premium_Pro__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c  = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c  !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c  : 0)+(ps.VG_Fee_Income__c  !=  null ? ps.VG_Fee_Income__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c  = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c  !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Levies__c  : 0)+(ps.Levies__c  !=  null ? ps.Levies__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c : 0)+(ps.Premium_Adjustment__c !=  null ? ps.Premium_Adjustment__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c = (allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c !=  null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c : 0)+(ps.Premium_Adjustment_2__c !=  null ? ps.Premium_Adjustment_2__c : 0);
                }
            } 
        }
        for(Policy_Schedule__c  ps: allPSMap.values()){
            if(!ps.VG_Is_MTA__c){
                if(ps.Product__c  ==  'Commercial Combined'){
                    ps.Net_Premium__c  = ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c ;
                    ps.VG_Technical_Model_Premium__c  = ps.Net_Premium__c*(ps.Share__c/100);
                    ps.Technical_UW_Premium__c = ps.Underwriting_Premium__c = ps.VG_Technical_Model_Premium__c +ps.Premium_Adjustment__c ;
                    ps.Actual_GWP__c =  ps.Underwriting_Premium__c + ps.Premium_Adjustment_2__c ;
                    ps.Gross_Written_Premium__c = ps.Actual_GWP__c/(1-(ps.VG_Brokerage_Percent__c/100));
                    ps.VG_Brokerage_Amount__c = ps.Gross_Written_Premium__c - ps.Actual_GWP__c;
                }else if(ps.Product__c !=  'Property'){
                    ps.Net_Premium__c  = ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c ;
                    ps.VG_Technical_Model_Premium__c = ps.Technical_Layer_Premium__c * (ps.Share__c/100);
                    ps.Technical_UW_Premium__c = ps.Underwriting_Premium__c = ps.VG_Technical_Model_Premium__c+ps.Premium_Adjustment__c;
                    ps.Sum_Insured__c = ps.Limit__c* (ps.Share__c/100);
                    ps.Actual_GWP__c =  ps.Underwriting_Premium__c + ps.Premium_Adjustment_2__c ;
                    ps.Gross_Written_Premium__c = ps.Actual_GWP__c/(1-(ps.VG_Brokerage_Percent__c/100));
                    ps.VG_Brokerage_Amount__c = ps.Gross_Written_Premium__c * (ps.VG_Brokerage_Percent__c/100);
                    ps.VG_Gross_Written_Premium_100__c = ps.Actual_GWP__c/(ps.Share__c/100);
                }else if(ps.Product__c  ==  'Property'){
                    ps.Net_Premium__c  = ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c ;
                    ps.VG_Technical_Model_Premium__c = ps.Net_Premium__c * (ps.Share__c/100);
                    ps.Technical_UW_Premium__c = ps.Underwriting_Premium__c = ps.VG_Technical_Model_Premium__c+ps.Premium_Adjustment__c;
                    ps.Actual_GWP__c =  ps.Underwriting_Premium__c + ps.Premium_Adjustment_2__c ; 
                    ps.VG_Gross_Written_Premium_100__c = ps.Actual_GWP__c/(ps.Share__c/100);
                    ps.Gross_Written_Premium__c = ps.Actual_GWP__c/(1-(ps.VG_Brokerage_Percent__c/100));
                    ps.VG_Brokerage_Amount__c = ps.Gross_Written_Premium__c * (ps.VG_Brokerage_Percent__c/100);
                    
                }
            }
        }
        
        
        for(Risk_Capture__c  rc: rcList){
            if(!allPSMap.get(rc.Policy_Schedule__c).VG_Is_MTA__c) {
                rcMap.put(rc.Policy_Schedule__c, rc);
            }else{
                if(rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c).CreatedDate < rc.CreatedDate){
                    rcMap.put(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c, rc);
                }
            }
        }
        System.debug(rcMap.size()+'::'+rcMap);
        for(VG_Policy_Schedule_Endorsement__c pse: pseList){
            if(!allPSMap.get(pse.VG_Policy_Schedule__c).VG_Is_MTA__c){
                if(pseMap.containsKey(pse.VG_Policy_Schedule__c)) {
                    List<VG_Policy_Schedule_Endorsement__c> tempPSEList  =  pseMap.get(pse.VG_Policy_Schedule__c);
                    tempPSEList.add(pse);
                    pseMap.put(pse.VG_Policy_Schedule__c,  tempPSEList );
                } else {
                    pseMap.put(pse.VG_Policy_Schedule__c,  new List<VG_Policy_Schedule_Endorsement__c> { pse });
                }
            }else{
                if(pseMap.containsKey(allPSMap.get(pse.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)) {
                    List<VG_Policy_Schedule_Endorsement__c> tempPSEList  =  pseMap.get(allPSMap.get(pse.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c);
                    tempPSEList.add(pse);
                    pseMap.put(allPSMap.get(pse.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c,  tempPSEList );
                } else {
                    pseMap.put(allPSMap.get(pse.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c,  new List<VG_Policy_Schedule_Endorsement__c> { pse });
                }
            }
        }
        System.debug(pseMap.size());
        Set<ID> psIds = new Set<ID>();
        psIds.addAll(pseMap.keyset());
        for(String psid: psIds){
            List<VG_Policy_Schedule_Endorsement__c > newPSEList = new List<VG_Policy_Schedule_Endorsement__c>();
            Map<String, VG_Policy_Schedule_Endorsement__c > edmMap = new Map<String, VG_Policy_Schedule_Endorsement__c>();
            for(VG_Policy_Schedule_Endorsement__c pse: pseMap.get(psid)){
                if(pse.VG_Endorsement_Library_Id__c !=  null){
                    if(edmMap.containsKey(pse.VG_Endorsement_Library_Id__c)){
                        if(pse.CreatedDate > edmMap.get(pse.VG_Endorsement_Library_Id__c).createdDate){
                            edmMap.remove(pse.VG_Endorsement_Library_Id__c);
                            edmMap.put(pse.VG_Endorsement_Library_Id__c, pse);
                        }
                    }else{
                        edmMap.put(pse.VG_Endorsement_Library_Id__c, pse);
                    }
                }else{
                    edmMap.put(pse.id, pse);
                }
            }
            newPSEList.addAll(edmMap.values());
            pseMap.remove(psid);
            pseMap.put(psId, newPSEList);
        }
        for(VG_Policy_Schedule_Asset__c  psa: psaList){
            if(!allPSMap.get(psa.VG_Policy_Schedule__c).VG_Is_MTA__c){
                if(psaMap.containsKey(psa.VG_Policy_Schedule__c)) {
                    List<VG_Policy_Schedule_Asset__c > tempPSAList  =  psaMap.get(psa.VG_Policy_Schedule__c);
                    tempPSAList.add(psa);
                    psaMap.put(psa.VG_Policy_Schedule__c,  tempPSAList );
                } else {
                    psaMap.put(psa.VG_Policy_Schedule__c,  new List<VG_Policy_Schedule_Asset__c > { psa });
                }
            }else{
                if(psaMap.containsKey(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)) {
                    List<VG_Policy_Schedule_Asset__c > tempPSAList  =  psaMap.get(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c);
                    tempPSAList.add(psa);
                    psaMap.put(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c,  tempPSAList );
                } else {
                    psaMap.put(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c,  new List<VG_Policy_Schedule_Asset__c > { psa });
                }
            }
        }
        for(VG_Exposure_Premium__c  exp: expList){
            if(expMap.containsKey(exp.VG_Policy_Schedule__c)) {
                List<VG_Exposure_Premium__c > tempEXPList  =  expMap.get(exp.VG_Policy_Schedule__c);
                tempEXPList.add(exp);
                expMap.put(exp.VG_Policy_Schedule__c,  tempEXPList);
            } else {
                expMap.put(exp.VG_Policy_Schedule__c,  new List<VG_Exposure_Premium__c > { exp });
            }
        }
        for(ID psid: haveROCMap.keyset()){
            expMap.put(psid, expMap.get(haveROCMap.get(psid).id));
        }
        Policy__c renewalPolicy = new Policy__c();
        renewalPolicy = policy.clone(false, true, false, false);
        renewalPolicy.VG_Governance_Compliance__c = null;
        renewalPolicy.VG_Sub_Status__c = null;
        renewalPolicy.VG_Is_Renewal__c = true;
        renewalPolicy.VG_Inception_Date__c = policy.VG_Expiry_Date__c.addDays(1);
        renewalPolicy.VG_Expiry_Date__c = renewalPolicy.VG_Inception_Date__c.addDays(364);
        if(Math.mod(renewalPolicy.VG_Inception_Date__c.year(), 4) !=  0){
            if(Math.mod(renewalPolicy.VG_Expiry_Date__c.year(), 4)  ==  0){
                if(renewalPolicy.VG_Expiry_Date__c < =  date.newInstance(renewalPolicy.VG_Expiry_Date__c.year(), 02, 28)){
                    renewalPolicy.VG_Expiry_Date__c = renewalPolicy.VG_Expiry_Date__c.addDays(0);
                }else{
                    renewalPolicy.VG_Expiry_Date__c = renewalPolicy.VG_Expiry_Date__c.addDays(1);
                }
            }
        }else{
            if(renewalPolicy.VG_Inception_Date__c < date.newInstance(renewalPolicy.VG_Inception_Date__c.year(), 03, 01)){
                renewalPolicy.VG_Expiry_Date__c = renewalPolicy.VG_Expiry_Date__c.addDays(1);
            }else{
                renewalPolicy.VG_Expiry_Date__c = renewalPolicy.VG_Expiry_Date__c.addDays(0);
            }
        }
        List<VG_Policy_Schedule_Asset__c > psaInsertList = new List<VG_Policy_Schedule_Asset__c>();
        List<VG_Policy_Schedule_Endorsement__c > pseInsertList = new List<VG_Policy_Schedule_Endorsement__c>();
        List<VG_Exposure_Premium__c> expInsertList = new List<VG_Exposure_Premium__c>();
        List<Risk_Capture__c> rcInsertList = new List<Risk_Capture__c>();
        
        Map<String, Policy_Schedule__c> insertedPSMap = new Map<String, Policy_Schedule__c>();
        Map<String, List<VG_Policy_Schedule_Asset__c>> insertedPSAMap = new Map<String, List<VG_Policy_Schedule_Asset__c>>();
        Map<String, List<VG_Policy_Schedule_Endorsement__c>> insertedPSEMap = new Map<String, List<VG_Policy_Schedule_Endorsement__c>>();
        Map<String, List<VG_Exposure_Premium__c>> insertedExpMap = new Map<String, List<VG_Exposure_Premium__c>>();
        Map<String, Risk_Capture__c> insertedRCMap = new Map<String, Risk_Capture__c>();
        
        renewalPolicy.Policy_Status__c = 'Prospect';
        renewalPolicy.CurrencyIsoCode = policy.CurrencyIsoCode;
        renewalPolicy.Broker_Contact__c = policy.Broker_Contact__c;
        renewalPolicy.VG_US_Classification__c = policy.VG_US_Classification__c;
        try{
            //Generating ProgramReferenceNumber
            VG_Programme__c pgm;
            if(policy.VG_Programme_Reference_Number__c != null){
                String[] pgName = policy.VG_Programme_Reference_Number__r.Name.split('/');
                String newPGName = pgName[0]+'/'+pgName[1]+'/'+pgName[2]+'/'+pgName[3]+'/'+(Integer.valueOf(pgName[4])+1);
                List<VG_Programme__c> renewPG = [Select Id from VG_Programme__c where Name =: newPGName];
                if(!renewPG.IsEmpty()){
                    pgm = renewPG[0];
                }else{
                    pgm = new VG_Programme__c();
                    pgm.Name = newPGName;
                    Insert pgm;
                } 
                renewalPolicy.VG_Programme_Reference_Number__c = pgm.id;
            }
            //Generating ProgramReferenceNumber
            Insert renewalPolicy;
            System.debug('renewalPolicy::'+renewalPolicy.id);
            policy.VG_Renewal_Policy_Id__c = renewalPolicy.id;
            Utilities.SkipMethods('Trigger Context');
            Utilities.SkipMethods('Trigger Context2');
            update policy;
            Utilities.clearMethods();
            /*if(Test.isRunningTest())
            {
                throw new MyException();
            }*/                    
        }Catch(Exception e){
            if(renewalPolicy.id !=  null)
                delete renewalPolicy;
            String errMsg;
            System.debug('e.getMessage()::'+e.getMessage()+renewalPolicy.Policy_Status__c);
            if(e.getMessage().contains('is required in')){
                errMsg = 'Fill Required Fields \n';
                System.debug(errMsg);
                System.debug(e.getMessage());
                String[] errors = e.getMessage().split(',');
                String error = errors[1].replace(': []', '');
                error = error.replace('<br/>', ',').replace('is required in', ':');
                error = error.removeEnd(',');
                errors = error.split(',');
                System.debug(errors);
                System.debug(error);
                Map<String, List<String>> errorMap =  new Map<String, List<String>>();
                for(integer i = 0;i<errors.size();i++){
                    String[] temp = errors[i].split(':');
                    System.debug(temp);
                    if(errorMap.containsKey(temp[0])){
                        List<String> tmpList = errorMap.get(temp[0]);
                        if(temp[0].contains('Policy Field'))
                            tmpList.add(temp[1]);
                        else
                            tmpList.add(temp[1]+'-'+temp[2]);
                        errorMap.put(temp[0], tmpList);
                    }else{
                        if(temp[0].contains('Policy Field'))
                            errorMap.put(temp[0] , new List<String>{temp[1]});
                        else
                            errorMap.put(temp[0] , new List<String>{temp[1]+'-'+temp[2]});
                    }                  
                }
                System.debug(errorMap);
                for(String s: errorMap.keySet()){
                    errMsg = errMsg+s+':';
                    for(String str: errorMap.get(s)){
                        errMsg = errMsg+str+', ';
                    }
                    errMsg = errMsg.removeEnd(', ');
                    errMsg = errMsg+'\n';
                }
                System.debug(errMsg);
            }else{
                errMsg = 'Something wrong contact Admin...';
            }
            return errMsg;
        }
        
        renewalPolicy = [select id, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, Insured__c, AP_TP__c, Adjustment_Reason__c, Am_I_Underwriter__c, Broker_Name__c, Declaration_Type__c, Deductible_or_Excess_Amount__c, Deductible_or_Excess_Basis__c, Formula_Sum_Insured_Share__c, Inception_Expiry_Time__c, IsApproved_External__c, Line_Of_Business__c, Payment_Frequency__c, Policy_Basis__c, Policy_Status__c, Risk_Assessor__c, Sum_Insured_Share__c, Total_Sum_Insured__c, Type_of_Insurance__c, Underwriter__c, VG_Aggregate_Limit__c, VG_Booked_Time__c, VG_Brokerage_Percent__c, VG_Current_Insurer__c, VG_Expiry_Date__c, VG_Inception_Date__c, VG_IsApproved__c, VG_Prospect_Premium__c, VG_Sub_Broker__c, VG_Sub_Status__c, IPT__c, Gross_Written_Premium__c, Gross_Written_Premium_Rollup__c, VG_Brokerage_Amount__c, Earned_Aggregate_Balance__c, Extended_Reporting__c, Lead_Insurer__c, Loss_Ratio__c, Retroactive_Date__c, Total_Aggregate_Balance__c, Actual_GWP__c, Total_claims_o_s__c, MTA_Cancel_List__c, Endorsement_GWP__c, Jurisdiction__c, Levies__c, Premium_Adjustment__c, Risk_Premium__c, Technical_Model_Premium__c, Technical_UW_Premium__c, Total_claims_paid__c, Paid_Aggregate_Balance__c, VG_Fee_Income__c, VG_MGA_Commission_Amount__c, VG_Lloyds_Products__c, Total_claims_reserve__c, VG_Additional_Insureds__c, VG_Continuous_Cover_Date__c, VG_Governance_Compliance__c, VG_Local_Policies__c, VG_Plan_Rate__c, VG_Territorial_Limits__c, VG_Wording__c, Commercial_Adjustment__c, Transaction_GWP__c, VG_Is_Renewal__c, VG_Renewal_Policy_Id__c from Policy__c where id = :renewalPolicy.id limit 1];
        
        Map<String, String> coinsuranceNameMap = new Map<String, String>();
        Integer psCount = 0;
        for(Policy_Schedule__c temp: allPSMap.values()){
            
            if(!temp.VG_Is_MTA__c){
                System.debug('coiparentname::'+temp.VG_Co_Insurance_Parent__r.Name);
                System.debug('ps.Name::'+temp.Name);
                Policy_Schedule__c ps = new Policy_Schedule__c ();
                System.debug('PS::'+ps);
                ps = temp.clone(false, true, false, false);
                ps.VG_Status__c = 'Draft';
                ps.IPT__c = 0;
                ps.Base_Creation_Start_Date__c = renewalPolicy.VG_Inception_Date__c;
                ps.Base_Creation_End_Date__c = renewalPolicy.VG_Expiry_Date__c;
                System.debug('PS::'+ps.Product__c+renewalPolicy.Policy_Status__c);
                ps.id = null;
                ps.Policy__c = renewalPolicy.id;
                ps.Name = renewalPolicy.Name+'/PS/'+psCount;
                if(ps.VG_Co_Insurance_type__c == 'Child'){
                    String[] parentname = ps.VG_Co_Insurance_Parent__r.Name.split('/PS/');
                    System.debug('ps.Name::'+parentname+parentname[0]+parentname[1]); 
                    String coiparentname =  renewalPolicy.Name+'/PS/'+ parentname[1]; 
                    coinsuranceNameMap.put(ps.Name, coiparentname);
                    //ps.VG_Co_Insurance_Parent__c =  coiname.id;                                
                }  
                    
                psCount++;
                ps.CurrencyIsoCode = renewalPolicy.CurrencyIsoCode;
                insertedPSMap.put(ps.Name, ps);
                if(rcMap.get(temp.id) !=  null){
                    insertedRCMap.put(ps.Name, rcMap.get(temp.id));
                }
                System.debug(rcMap.get(temp.id)+'::'+rcMap+'::'+temp.id+'::'+insertedRCMap);
                if(pseMap.get(temp.id) !=  null){
                    for(VG_Policy_Schedule_Endorsement__c pse: pseMap.get(temp.id)){
                        if(insertedPSEMap.containsKey(ps.Name)) {
                            List<VG_Policy_Schedule_Endorsement__c> tempPSEList  =  insertedPSEMap.get(ps.Name);
                            tempPSEList.add(pse);
                            insertedPSEMap.put(ps.Name,  tempPSEList);
                        } else {
                            insertedPSEMap.put(ps.Name,  new List<VG_Policy_Schedule_Endorsement__c> { pse });
                        }
                    }
                }
                if(psaMap.get(temp.id) !=  null){
                    for(VG_Policy_Schedule_Asset__c  psa: psaMap.get(temp.id)){
                        if(insertedpsaMap.containsKey(ps.Name)) {
                            List<VG_Policy_Schedule_Asset__c > tempPSAList =  insertedpsaMap.get(ps.Name);
                            tempPSAList.add(psa);
                            insertedpsaMap.put(ps.Name,  tempPSAList);
                        } else {
                            insertedpsaMap.put(ps.Name,  new List<VG_Policy_Schedule_Asset__c > { psa });
                        }
                    }
                }
                if(expMap.get(temp.id) !=  null){
                    for(VG_Exposure_Premium__c  exp: expMap.get(temp.id)){
                        if(insertedEXPMap.containsKey(ps.Name)) {
                            List<VG_Exposure_Premium__c > tempEXPList =  insertedEXPMap.get(ps.Name);
                            tempEXPList.add(exp);
                            insertedEXPMap.put(ps.Name,  tempEXPList);
                        } else {
                            insertedEXPMap.put(ps.Name,  new List<VG_Exposure_Premium__c > { exp });
                        }
                    }
                }
            }
        }
        
       
        if(insertedPSMap !=  null){
            try{
                Utilities.SkipMethods('Bridge Child Context');
                insert insertedPSMap.values();
                List<Policy_Schedule__c> coinameList = new  List<Policy_Schedule__c>();
                for(Policy_Schedule__c ps:insertedPSMap.values()){
                    String name ;
                    if(ps.VG_Co_Insurance_type__c=='Child'){
                        System.debug('coinsuranceNameMap::'+coinsuranceNameMap);                        
                        System.debug('coinsuranceNameMap::'+coinsuranceNameMap.get(ps.Name));
                        if(coinsuranceNameMap.get(ps.Name).contains('/EEA')){
                            name = coinsuranceNameMap.get(ps.Name).remove('/EEA');                        
                        }else{
                            name = coinsuranceNameMap.get(ps.Name);
                        }
                        ps.VG_Co_Insurance_Parent__c = insertedPSMap.get(name).Id;    
                        coinameList.add(ps);                         
                    }                    
                }  
                Utilities.SkipMethods('Trigger Context');
                Utilities.SkipMethods('Trigger Context2');  
                if(!coinameList.IsEmpty())
                    update coinameList;  
                Utilities.ClearMethods(); 
            }Catch(Exception e){
                if(renewalPolicy.id !=  null)
                    delete renewalPolicy;
                String errMsg;
                System.debug('e.getMessage()::'+e.getMessage());
                if(e.getMessage().contains('is required in')){
                    errMsg  =  'Fill Required Fields \n';
                    System.debug(errMsg);
                    System.debug(e.getMessage());
                    String[] errors  =  e.getMessage().split(',');
                    String error  =  errors[1].replace(': []', '');
                    error  =  error.replace('<br/>', ', ').replace('is required in', ':');
                    error  =  error.removeEnd(', ');
                    errors  =  error.split(',');
                    System.debug(errors);
                    System.debug(error);
                    Map<String, List<String>> errorMap  =  new Map<String, List<String>>();
                    for(integer i  =  0;i<errors.size();i++){
                        String[] temp  =  errors[i].split(':');
                        System.debug(temp);
                        if(errorMap.containsKey(temp[0])){
                            List<String> tmpList  =  errorMap.get(temp[0]);
                            if(temp[0].contains('Policy Field'))
                                tmpList.add(temp[1]);
                            else
                                tmpList.add(temp[1]+'-'+temp[2]);
                            errorMap.put(temp[0], tmpList);
                        }else{
                            if(temp[0].contains('Policy Field'))
                                errorMap.put(temp[0] , new List<String>{temp[1]});
                            else
                                errorMap.put(temp[0] , new List<String>{temp[1]+'-'+temp[2]});
                        }                  
                    }
                    System.debug(errorMap);
                    for(String s: errorMap.keySet()){
                        errMsg  =  errMsg+s+':';
                        for(String str: errorMap.get(s)){
                            errMsg  =  errMsg+str+', ';
                        }
                        errMsg  =  errMsg.removeEnd(', ');
                        errMsg  =  errMsg+'\n';
                    }
                    System.debug(errMsg);
                }else{
                    errMsg  =  'Something wrong contact Admin...';
                }
                return errMsg;
            }
        }
        
        for(String psName: insertedPSMap.keyset()){
            Integer pseCount  =  1;
            Integer sbCount  =  1;
            if(insertedPSEMap.get(psName) !=  null){
                for(VG_Policy_Schedule_Endorsement__c pse: insertedPSEMap.get(psName)){
                    VG_Policy_Schedule_Endorsement__c tmp  =  new VG_Policy_Schedule_Endorsement__c();
                    tmp = pse.clone(false, true, false, false);
                    tmp.id = null;
                    if(tmp.VG_Type__c  ==  'Endorsements'){
                        tmp.Name  =  psName+'/PE/'+pseCount;
                        pseCount++;
                    }else{
                        tmp.Name  =  psName+'/PESB/'+sbCount;
                        sbCount++;
                    }
                    tmp.VG_Policy_Schedule__c  =  insertedPSMap.get(psName).id;
                    pseInsertList.add(tmp);
                    
                }
            }
            Integer psaCount = 1;
            if(insertedPSAMap.get(psName) !=  null){
                for(VG_Policy_Schedule_Asset__c  psa: insertedPSAMap.get(psName)){
                    VG_Policy_Schedule_Asset__c  tmp  =  new VG_Policy_Schedule_Asset__c ();
                    tmp  =  psa.clone(false, true, false, false);
                    tmp.id  =  null;
                    tmp.Name  =  psName+'/RR/'+psaCount;
                    psaCount++;
                    tmp.VG_Policy_Schedule__c  =  insertedPSMap.get(psName).id;
                    psaInsertList.add(tmp);
                }
            }
            if(insertedRCMap.get(psName) !=  null){
                Risk_Capture__c  tmp  =  new Risk_Capture__c ();
                tmp  =  insertedRCMap.get(psName).clone(false, true, false, false);
                tmp.id  =  null;
                tmp.Name  =  psName+'/RD/1';
                tmp.Policy_Schedule__c  =  insertedPSMap.get(psName).id;
                rcInsertList.add(tmp);
            }
            System.debug(insertedRCMap.get(psName)+'::'+rcInsertList+'::'+psName+'::'+insertedRCMap);
            if(insertedEXPMap.get(psName) !=  null){
                for(VG_Exposure_Premium__c  exp: insertedEXPMap.get(psName)){
                    VG_Exposure_Premium__c tmp  =  new VG_Exposure_Premium__c();
                    tmp = exp.clone(false, true, false, false);
                    tmp.VG_Policy_Schedule__c  =  insertedPSMap.get(psName).id;
                    tmp.id  =  null;
                    expInsertList.add(tmp);
                    
                }
            }
        }
       
        Utilities.SkipMethods('Trigger Context');
        Utilities.SkipMethods('Trigger Context2');
        System.debug(rcInsertList.size()+'::'+rcInsertList);
        if(!expInsertList.IsEmpty())
            insert expInsertList;
        if(!pseInsertList.IsEmpty())
            insert pseInsertList;
        if(!rcInsertList.IsEmpty())
            insert rcInsertList;
        if(!psaInsertList.IsEmpty())
            insert psaInsertList;
        Utilities.clearMethods();
        
        return renewalPolicy.id;
    }
}