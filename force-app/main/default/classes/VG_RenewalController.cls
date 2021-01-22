Public with sharing Class VG_RenewalController{
    @AuraEnabled
    public static String createRenewalPolicy(Id policyId,String RecordType){
        System.debug('parameters :: '+ policyId+'::'+RecordType);
        
        Map<String,Policy_Schedule__c> insertedPSMap=new Map<String,Policy_Schedule__c>();
        Map<String,List<VG_Policy_Schedule_Asset__c>> insertedPSAMap=new Map<String,List<VG_Policy_Schedule_Asset__c>>();
        Map<String,List<VG_Policy_Schedule_Endorsement__c>> insertedPSEMap=new Map<String,List<VG_Policy_Schedule_Endorsement__c>>();
        Map<String,List<Risk_Capture__c>> insertedRCMap=new Map<String,List<Risk_Capture__c>>();
        Map<id,Policy_Schedule__c > psMap=new Map<Id,Policy_Schedule__c >();
        Map<id,Policy_Schedule__c > psROCMap=new Map<Id,Policy_Schedule__c >();
        Map<id,List<VG_Policy_Schedule_Asset__c>> psaMap=new Map<id,List<VG_Policy_Schedule_Asset__c>>();
        Map<id,List<VG_Policy_Schedule_Endorsement__c>> pseMap=new Map<id,List<VG_Policy_Schedule_Endorsement__c>>();
        Map<id,List<Risk_Capture__c>> rcMap=new Map<id,List<Risk_Capture__c>>();
        List<VG_Policy_Schedule_Asset__c > psaInsertList=new List<VG_Policy_Schedule_Asset__c>();
        List<VG_Policy_Schedule_Endorsement__c > pseInsertList=new List<VG_Policy_Schedule_Endorsement__c>();
        List<Risk_Capture__c> rcInsertList=new List<Risk_Capture__c>();
        
        Policy__c policy=[select id,Name,CurrencyIsoCode,VG_NAIC_Code__c, Description__c,VG_Programme_Reference_Number__c, VG_Programme_Reference_Number__r.Name , Underwriter__r.Name, Underwriter__r.ContactID,Underwriter__r.Email,VG_Surplus_Broker__c,VG_LTA__c,VG_LTA_Expiry_Date__c,VG_LTA_Start_Date__c,VG_LTA_Comments__c,Terms_of_Trade_Days__c,RecordTypeId,VG_US_Classification__c,CreatedDate,Broker_Contact__c,CreatedById,LastModifiedDate,LastModifiedById,Insured__c,AP_TP__c,Adjustment_Reason__c,Am_I_Underwriter__c,Broker_Name__c,Declaration_Type__c,Deductible_or_Excess_Amount__c,Deductible_or_Excess_Basis__c,Formula_Sum_Insured_Share__c,Inception_Expiry_Time__c,IsApproved_External__c,Line_Of_Business__c,Payment_Frequency__c,Policy_Basis__c,Policy_Status__c,Risk_Assessor__c,Sum_Insured_Share__c,Total_Sum_Insured__c,Type_of_Insurance__c,Underwriter__c,VG_Aggregate_Limit__c,VG_Brokerage_Percent__c,VG_Current_Insurer__c,VG_Expiry_Date__c,VG_Inception_Date__c,VG_IsApproved__c,VG_Prospect_Premium__c,VG_Sub_Broker__c,VG_Sub_Status__c,IPT__c,Gross_Written_Premium__c,Gross_Written_Premium_Rollup__c,VG_Brokerage_Amount__c,Earned_Aggregate_Balance__c,Extended_Reporting__c,Lead_Insurer__c,Loss_Ratio__c,Retroactive_Date__c,Total_Aggregate_Balance__c,Actual_GWP__c,Total_claims_o_s__c,MTA_Cancel_List__c,Endorsement_GWP__c,Jurisdiction__c,Levies__c,Premium_Adjustment__c,Risk_Premium__c,Technical_Model_Premium__c,Technical_UW_Premium__c,Total_claims_paid__c,Paid_Aggregate_Balance__c,VG_Fee_Income__c,VG_MGA_Commission_Amount__c,VG_Lloyds_Products__c,Total_claims_reserve__c,VG_Additional_Insureds__c,VG_Continuous_Cover_Date__c,VG_Governance_Compliance__c,VG_Local_Policies__c,VG_Plan_Rate__c,VG_Territorial_Limits__c,VG_Wording__c,Commercial_Adjustment__c,Transaction_GWP__c,VG_Is_Renewal__c,VG_Renewal_Policy_Id__c from Policy__c where id=:policyid limit 1];
        Map<id,Policy_Schedule__c > allPSMap=new Map<Id,Policy_Schedule__c >([select id,Name,IsDeleted,CurrencyIsoCode,RecordTypeId,CreatedDate,VG_Financials_Created__c,VG_Risk_Premium__c,Insured_Id__c,Declaration_Date__c,Product__c,Policy__c,VG_Plan_Rate__c,IPT_Percent__c,Premium_Adjustment__c,Endorsement_GWP__c,Levies__c,VG_Transaction_Type__c,VG_Risk_Transaction_Type__c,VG_Is_MTA__c,VG_MTA_Type__c,VG_MTA_Status__c,VG_MTA_Start_Date__c,VG_MTA_End_Date__c,VG_Current_Plan_Rate__c,VG_MTA_Cancellation_Date__c,MTA_Reason_for_Cancellation__c,VG_Declaration_Type__c,VG_Status__c,Net_Premium__c,VG_Declaration_Type_percent__c,VG_Fee_Income__c,VG_Adjustment_Reason__c,VG_Brokerage_Percent__c,VG_Net_Premium_Due__c,VG_Pre_MTA_Expiry_Date__c,VG_Base_Policy__c,Base_Creation_Start_Date__c,Base_Creation_End_Date__c,Commission__c,Gross_Base_Premium__c,VG_MGA_Commission_Amount__c,VG_Technical_Model_Premium__c,Technical_UW_Premium__c,Risk_Premium_Pro__c,Endorsement_Premium_Pro__c,Limit__c,Attachment__c,Sum_Insured__c,ILF_Factor__c,ILF_Premium__c,Rate_On_Line__c,Rate_Per_Mil__c,Share__c,Underwriting_Premium__c,Premium_Adjustment_2__c,ORC__c,ORC_Amount__c,Account_Id__c,VG_VAT__c,VG_VAT_Amount__c,VG_Lloyds_Product__c,VG_Net_Premium_Receivable__c,VG_Auto_acquisition_Threshold__c,VG_Extended_Reporting_Period_AP__c,ILF_Layer__c,VG_Retired_Directors_Additional_Premium__c,VG_Retired_Directors_Year__c,VG_Extended_Reporting_Period__c,Technical_Layer_Premium__c,Written_share__c,Gross_Written_Premium__c,Gross_or_Net_Premium__c,VG_Overider_Amount__c,VG_Overider_Percent__c,VG_Total_Layer_Premium__c,Transaction_GWP__c,Actual_GWP__c,IPT__c,VG_Brokerage_Amount__c,VG_Deductible__c,VG_Coverages__c,VG_Number_Of_vehicle__c,VG_Turn_Over__c,VG_Type_Of_Operation__c,VG_CREDIT_Augur_SCORE__c,VG_Exposure_Premium__c,VG_Experience_Premium__c,VG_Selected_Weight__c,VG_Net_Base_Premium__c,VG_Occupancy__c,VG_PD_Base_Rate__c,VG_BI_Base_Rate__c,VG_Machinery_Breakdown_Cover__c,VG_Machinery_Breakdown_BI_Cover__c,VG_Adjustment_Factor__c,VG_Adjusted_PD_Base_Rate__c,VG_Adjusted_BI_Base_Rate__c,VG_Witholding_Tax_Amount__c,VG_Net_Premium_Received__c,VG_Reinsurance_Type__c,VG_Structure__c,VG_Sub_Structure__c,VG_Technical_Loss_Ratio__c,MID_Check_Box__c,VG_Capacity_Paper__c,VG_Payment_Due_Date__c,VG_Wording__c,VG_Reporting_Date__c,VG_Rate_Change__c,VG_Municipality_Code__c,VG_Side_B_Rentention__c,VG_Side_C_Rentention__c,VG_D_O_Product__c,VG_Gross_Written_Premium_100__c,VG_Bridge_Selected_Asset__c,MTA_Parent_Policy_Schedule__c from Policy_Schedule__c where Policy__c =: policy.id AND (VG_MTA_Type__c != 'Cancellation' AND VG_MTA_Type__c !='Extension' AND VG_MTA_Type__c !='Reduction')]);
        
        
        for(Policy_Schedule__c  ps: allPSMap.values()){
            if(!ps.VG_Is_MTA__c)
                psMap.put(ps.id,ps);
            else
                psROCMap.put(ps.id,ps);
        }
        for(Policy_Schedule__c  ps: allPSMap.values()){
            if(ps.VG_Is_MTA__c){               
                if(RecordType=='Aesir'){
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Limit__c=ps.Limit__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Brokerage_Percent__c=ps.VG_Brokerage_Percent__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).ILF_Layer__c =ps.ILF_Layer__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Written_share__c=ps.Written_share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Share__c=ps.Share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Sum_Insured__c=ps.Sum_Insured__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Attachment__c=ps.Attachment__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_or_Net_Premium__c=ps.Gross_or_Net_Premium__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c : 0)+(ps.Risk_Premium_Pro__c != null ? ps.Risk_Premium_Pro__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  : 0)+(ps.Endorsement_Premium_Pro__c  != null ? ps.Endorsement_Premium_Pro__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c : 0)+(ps.Premium_Adjustment__c != null ? ps.Premium_Adjustment__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c : 0)+(ps.Premium_Adjustment_2__c != null ? ps.Premium_Adjustment_2__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_Written_Premium__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_Written_Premium__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_Written_Premium__c  : 0)+(ps.Gross_Written_Premium__c  != null ? ps.Gross_Written_Premium__c  : 0);
                }else if(RecordType=='Imara' || RecordType=='Horizon'){
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Written_share__c=ps.Written_share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Share__c=ps.Share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Sum_Insured__c=ps.Sum_Insured__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Brokerage_Percent__c=ps.VG_Brokerage_Percent__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Rate_On_Line__c=ps.Rate_On_Line__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Technical_Loss_Ratio__c   =ps.VG_Technical_Loss_Ratio__c  ;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Overider_Percent__c=ps.VG_Overider_Percent__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c  : 0)+(ps.Risk_Premium_Pro__c  != null ? ps.Risk_Premium_Pro__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  : 0)+(ps.Endorsement_Premium_Pro__c  != null ? ps.Endorsement_Premium_Pro__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c : 0)+(ps.Premium_Adjustment_2__c != null ? ps.Premium_Adjustment_2__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c : 0)+(ps.VG_Fee_Income__c != null ? ps.VG_Fee_Income__c : 0);
                }else if(RecordType=='Affinity'){
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Written_share__c=ps.Written_share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Share__c=ps.Share__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Sum_Insured__c=ps.Sum_Insured__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_or_Net_Premium__c=ps.Gross_or_Net_Premium__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Brokerage_Percent__c=ps.VG_Brokerage_Percent__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c  : 0)+(ps.Risk_Premium_Pro__c  != null ? ps.Risk_Premium_Pro__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  : 0)+(ps.Endorsement_Premium_Pro__c  != null ? ps.Endorsement_Premium_Pro__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c : 0)+(ps.Premium_Adjustment__c != null ? ps.Premium_Adjustment__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c : 0)+(ps.Premium_Adjustment_2__c != null ? ps.Premium_Adjustment_2__c : 0);
                }else if(RecordType=='Gentium'){
                    if(ps.Product__c == 'Fleet'){
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Brokerage_Percent__c=ps.VG_Brokerage_Percent__c;
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_VAT__c=ps.VG_VAT__c;
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c : 0)+(ps.Risk_Premium_Pro__c != null ? ps.Risk_Premium_Pro__c : 0);
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  : 0)+(ps.Endorsement_Premium_Pro__c  != null ? ps.Endorsement_Premium_Pro__c  : 0);
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Technical_UW_Premium__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Technical_UW_Premium__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Technical_UW_Premium__c  : 0)+(ps.Technical_UW_Premium__c  != null ? ps.Technical_UW_Premium__c  : 0);
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c : 0)+(ps.VG_Fee_Income__c != null ? ps.VG_Fee_Income__c : 0);
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Technical_Model_Premium__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Technical_Model_Premium__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Technical_Model_Premium__c  : 0)+(ps.VG_Technical_Model_Premium__c  != null ? ps.VG_Technical_Model_Premium__c  : 0);
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c : 0)+(ps.Premium_Adjustment__c != null ? ps.Premium_Adjustment__c : 0);
                    }else{
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Brokerage_Percent__c=ps.VG_Brokerage_Percent__c;
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c : 0)+(ps.Risk_Premium_Pro__c != null ? ps.Risk_Premium_Pro__c : 0);
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  : 0)+(ps.Endorsement_Premium_Pro__c  != null ? ps.Endorsement_Premium_Pro__c  : 0);
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_Written_Premium__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_Written_Premium__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_Written_Premium__c  : 0)+(ps.Gross_Written_Premium__c  != null ? ps.Gross_Written_Premium__c  : 0);
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c : 0)+(ps.VG_Fee_Income__c != null ? ps.VG_Fee_Income__c : 0);
                    }
                }else if(RecordType=='VFP'){
                    if(ps.Product__c!='W&I'){
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Written_share__c=ps.Written_share__c;
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Share__c=ps.Share__c;
                    }
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Limit__c=ps.Limit__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Brokerage_Percent__c=ps.VG_Brokerage_Percent__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).ILF_Layer__c =ps.ILF_Layer__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Attachment__c=ps.Attachment__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Gross_or_Net_Premium__c=ps.Gross_or_Net_Premium__c;
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Risk_Premium_Pro__c : 0)+(ps.Risk_Premium_Pro__c != null ? ps.Risk_Premium_Pro__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Endorsement_Premium_Pro__c  : 0)+(ps.Endorsement_Premium_Pro__c  != null ? ps.Endorsement_Premium_Pro__c  : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment__c : 0)+(ps.Premium_Adjustment__c != null ? ps.Premium_Adjustment__c : 0);
                    allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).Premium_Adjustment_2__c : 0)+(ps.Premium_Adjustment_2__c != null ? ps.Premium_Adjustment_2__c : 0);
                    if(ps.Product__c=='W&I'){
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c=(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Fee_Income__c : 0)+(ps.VG_Fee_Income__c != null ? ps.VG_Fee_Income__c : 0);
                        allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_VAT_Amount__c =(allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_VAT_Amount__c  != null ? allPSMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_VAT_Amount__c  : 0)+(ps.VG_VAT_Amount__c  != null ? ps.VG_VAT_Amount__c  : 0);
                    }
                }
            }
        }
        for(Policy_Schedule__c  ps: allPSMap.values()){
            if(!ps.VG_Is_MTA__c){
                if(RecordType=='Aesir'){
                    ps.Net_Premium__c=ps.VG_Technical_Model_Premium__c =ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c;
                    ps.Technical_UW_Premium__c =ps.VG_Technical_Model_Premium__c +ps.Premium_Adjustment__c;
                    ps.VG_Gross_Written_Premium_100__c =ps.Technical_UW_Premium__c+ps.Premium_Adjustment_2__c;
                    ps.VG_Brokerage_Amount__c=ps.Gross_Written_Premium__c*(ps.VG_Brokerage_Percent__c/100);
                    ps.Actual_GWP__c=ps.Gross_Written_Premium__c-ps.VG_Brokerage_Amount__c;
                    if(ps.Gross_or_Net_Premium__c =='Gross')
                        ps.Transaction_GWP__c =ps.Gross_Written_Premium__c;
                    else
                        ps.Transaction_GWP__c =ps.Actual_GWP__c;
                }else if(RecordType=='Imara' || RecordType=='Horizon'){
                    ps.Gross_Written_Premium__c=(ps.Premium_Adjustment_2__c+ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c)*(ps.Share__c/100);
                    ps.Technical_UW_Premium__c=ps.Gross_Written_Premium__c*(ps.VG_Technical_Loss_Ratio__c/100);
                    ps.VG_Brokerage_Amount__c=ps.Gross_Written_Premium__c*(ps.VG_Brokerage_Percent__c/100);
                    Decimal OA=ps.Gross_Written_Premium__c*(ps.VG_Overider_Percent__c/100);
                    ps.Actual_GWP__c=ps.Gross_Written_Premium__c-ps.VG_Brokerage_Amount__c-OA;
                    ps.VG_Gross_Written_Premium_100__c=ps.Premium_Adjustment_2__c+ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c;
                    if(RecordType=='Horizon')
                        ps.Transaction_GWP__c=ps.VG_Fee_Income__c+ps.Gross_Written_Premium__c-ps.VG_Brokerage_Amount__c-OA;
                }else if(RecordType=='Affinity'){
                    ps.Net_Premium__c=ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c;
                    ps.Technical_UW_Premium__c =ps.Net_Premium__c+ps.Premium_Adjustment__c;
                    ps.VG_Gross_Written_Premium_100__c=ps.Technical_UW_Premium__c+ps.Premium_Adjustment_2__c;
                    ps.Gross_Written_Premium__c=ps.VG_Gross_Written_Premium_100__c*(ps.Share__c/100);
                    ps.VG_Brokerage_Amount__c=ps.Gross_Written_Premium__c*(ps.VG_Brokerage_Percent__c/100);
                    ps.Actual_GWP__c=ps.Gross_Written_Premium__c-ps.VG_Brokerage_Amount__c;
                }else if(RecordType=='Gentium'){
                    if(ps.Product__c == 'Fleet'){
                        ps.VG_Gross_Written_Premium_100__c=ps.Gross_Written_Premium__c=ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c+ps.Premium_Adjustment__c;
                        ps.VG_Brokerage_Amount__c=ps.Gross_Written_Premium__c*(ps.VG_Brokerage_Percent__c/100);
                        ps.Actual_GWP__c=ps.Gross_Written_Premium__c-ps.VG_Brokerage_Amount__c;
                        ps.VG_VAT_Amount__c=(ps.VG_VAT__c/100)*ps.VG_Fee_Income__c;
                    }else{
                        ps.VG_Brokerage_Amount__c=ps.Gross_Written_Premium__c*(ps.VG_Brokerage_Percent__c/100);
                        ps.Actual_GWP__c=ps.Gross_Written_Premium__c-ps.VG_Brokerage_Amount__c;
                    }
                }else if(RecordType=='VFP'){
                    if(ps.Product__c=='W&I'){
                        ps.Technical_UW_Premium__c =ps.Premium_Adjustment__c;
                        ps.Gross_Written_Premium__c=ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c+ps.Technical_UW_Premium__c+ps.Premium_Adjustment_2__c;
                        ps.VG_Gross_Written_Premium_100__c=ps.Gross_Written_Premium__c*(ps.Share__c/100);
                        ps.Sum_Insured__c=ps.Limit__c;
                        ps.VG_Brokerage_Amount__c=ps.Gross_Written_Premium__c*(ps.VG_Brokerage_Percent__c/100);
                        ps.Actual_GWP__c=ps.Gross_Written_Premium__c-ps.VG_Brokerage_Amount__c;
                        ps.VG_Technical_Model_Premium__c=ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c;
                    }else if(ps.Product__c== 'Cyber' || ps.Product__c== 'Combined Cyber/ Tech E&O'){
                        ps.Technical_UW_Premium__c =ps.Premium_Adjustment__c;
                        ps.VG_Gross_Written_Premium_100__c=ps.Technical_UW_Premium__c+ps.Premium_Adjustment_2__c ;    
                        ps.Sum_Insured__c=ps.Limit__c*(ps.Share__c/100);
                        ps.Gross_Written_Premium__c=ps.VG_Gross_Written_Premium_100__c*(ps.Share__c/100);
                        ps.VG_Brokerage_Amount__c=ps.Gross_Written_Premium__c*(ps.VG_Brokerage_Percent__c/100);
                        ps.Actual_GWP__c=ps.Gross_Written_Premium__c-ps.VG_Brokerage_Amount__c;
                        ps.VG_Technical_Model_Premium__c=ps.Risk_Premium_Pro__c*(ps.Share__c/100);
                    }else{
                        ps.Net_Premium__c=ps.Risk_Premium_Pro__c+ps.Endorsement_Premium_Pro__c;
                        ps.Technical_UW_Premium__c =ps.Premium_Adjustment__c+ps.Net_Premium__c;
                        ps.VG_Gross_Written_Premium_100__c=ps.Technical_UW_Premium__c+ps.Premium_Adjustment_2__c ;    
                        ps.Sum_Insured__c=ps.Limit__c*(ps.Share__c/100);
                        ps.Gross_Written_Premium__c=ps.VG_Gross_Written_Premium_100__c*(ps.Share__c/100);
                        ps.VG_Brokerage_Amount__c=ps.Gross_Written_Premium__c*(ps.VG_Brokerage_Percent__c/100);
                        ps.Actual_GWP__c=ps.Gross_Written_Premium__c-ps.VG_Brokerage_Amount__c;
                        ps.VG_Technical_Model_Premium__c=ps.Net_Premium__c*(ps.Share__c/100);
                    }
                }
            }
        }
        List<VG_Policy_Schedule_Asset__c > psaList=new List<VG_Policy_Schedule_Asset__c>([select Annual_Rate_100__c,Asset__c,CreatedById,CreatedDate,CurrencyIsoCode,Id,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,RecordTypeId,SystemModstamp,Technical_UW_Premium__c,VG_AAD__c,VG_Address2__c,VG_Address3__c,VG_Address__c,VG_Adjusted_BI_Premium__c,VG_Adjusted_PD_Premium__c,VG_Aggregate_Precent__c,VG_Aggregate__c,VG_Attachment__c,VG_Avg_SI__c,VG_Base_Premium_Rate__c,VG_Base_Premium__c,VG_Binder_Ref__c,VG_BI_Indemnity_Period__c,VG_Bordereax_Date__c,VG_Brokerage__c,VG_Building_Discount_Loading__c,VG_CC_Information__c,VG_Ceding_Commission__c,VG_Cession__c,VG_CH_Commission__c,VG_Country__c,VG_Coverage_Type__c,VG_Coverage__c,VG_Date_of_Birth__c,VG_Declared_Value__c,VG_Deductible_Precent__c,VG_Deductible__c,VG_Deposit_Premium_Formula__c,VG_Deposit_Premium__c,VG_Event_Limit__c,VG_Expected_Ceding_Commission__c,VG_Expected_Loss_Ratio__c,VG_Expected_Premium_Income__c,VG_Expected_Profit_Commission__c,VG_Fee_Amounts__c,VG_GNPI__c,VG_Gross_Written_Premium__c,VG_Information__c,VG_Insured_Name__c,VG_IsTempDelete__c,VG_IsTemp__c,VG_Limit_Precent__c,VG_Limit__c,VG_Loss_Ratio_for_Max__c,VG_Loss_Ratio_for_Min__c,VG_Management_Expenses_for_PC__c,VG_Max_Ceding_Commission__c,VG_Max_Rate__c,VG_Max_SI__c,VG_MB_BI_Indemnity_Period__c,VG_MB_PD_Deductible__c,VG_MB_Waiting_Period__c,VG_Minimum_Premium_Formula__c,VG_Minimum_Premium__c,VG_Min_Ceding_Commission__c,VG_Min_Rate__c,VG_Net_BI_Premium__c,VG_Net_MB_Premium__c,VG_Net_PD_Premium__c,VG_Net_Risk_Premium__c,VG_No_Claims_Bonus_Value__c,VG_No_Claims_Bonus__c,VG_No_of_Surplus_Lines__c,VG_Number_of_Vehicles__c,VG_OtherRisk__c,VG_Payment_Ref__c,VG_Payment_Terms__c,VG_PD_Deductible__c,VG_Perils_Text__c,VG_Perils__c,VG_Policy_Basis__c,VG_Policy_Cover_End_Date__c,VG_Policy_Cover_Start_Date__c,VG_Policy_No__c,VG_Policy_Schedule__c,VG_Postcode__c,VG_Premium__c,VG_Profession__c,VG_Provisional_Rate__c,VG_Rate_on_Income__c,VG_Rate_Per_Vehicle__c,VG_Registration_Plate__c,VG_Retention_Line__c,VG_Retention__c,VG_Retroactive_Date__c,VG_Return_Period_Entry__c,VG_Return_Period_Exit__c,VG_Risk_End__c,VG_Risk_Premium__c,VG_Risk_start__c,VG_Scheme_Name__c,VG_Share__c,VG_Signed_Share__c,VG_Sub_Aggregation__c,VG_Sub_broker__c,VG_Sub_limit__c,VG_Sum_Insured__c,VG_Swing_Load__c,VG_Tax_on_Premium__c,VG_Technical_UW_Rate_Annual__c,VG_Territorial_Limits__c,VG_Transaction_Effective_date__c,VG_Transaction_Type__c,VG_Treaty_Limit__c,VG_Use__c,VG_Vehicle_Make__c,VG_Vehicle_Model__c,VG_Vehicle_Type__c,VG_Waiting_Period__c,VG_Written_Share__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psMap.keyset() OR VG_Policy_Schedule__c IN: psROCMap.keyset() ORDER By Name ASC]);
        List<VG_Policy_Schedule_Endorsement__c > pseList=new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,CurrencyIsoCode,CreatedDate,VG_Premium__c,VG_Policy_Schedule__c,VG_Title__c,VG_Endorsement_Details__c,VG_Endorsement_Library_Id__c,VG_Endorsement_Number__c,VG_IsTemp__c,VG_IsTempDelete__c,VG_Sub_limit__c,VG_Type__c,VG_Product__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c IN: psMap.keyset() OR VG_Policy_Schedule__c IN: psROCMap.keyset()  ORDER By Name DESC]);
        List<Risk_Capture__c> rcList=new List<Risk_Capture__c>([select id,Name,VG_Reinstatement_Premiums__c,CurrencyIsoCode,CreatedDate,Policy_Schedule__c,VG_Layer__c,VG_No_of_Reinstatements__c,VG_Plan_Loss_Ratio__c,VG_Rate_Type__c,VG_Territorial_Scope__c,VG_Governing_Law_of_Sale_Agreement__c,VG_Territorial_Limits__c,VG_Share__c,VG_Buyer__c,VG_Seller__c,VG_Risk_End__c,VG_Risk_start__c,VG_Company_Type__c,VG_Company_Domicile__c,VG_Target__c,VG_Revenue__c,VG_Total_Assets__c,VG_Net_Profit__c,VG_Market_Cap__c,VG_Net_Equity__c,VG_Headcount__c,VG_Class_1_Employees__c,VG_Industry__c,VG_Profession__c,VG_Fees_Current_Year__c,VG_Fees_Year_1__c,VG_Fees_Year_2__c,VG_Fees_Year_3__c,VG_Enterprise_Value__c,VG_Retention_Amount__c,VG_Endorsed__c,VG_Income_Basis__c,VG_Claims_Notification_Threshold__c,VG_Cash_Loss_Limit__c,VG_First_Premium_Payment_Date__c,VG_Ceding_Commission_Type__c,VG_Additional_Information__c,VG_Expense_Agreement_t_Amount_Tax__c,VG_De_Minimis_Applicable_to_all_risks__c,VG_Retention_of_EV__c,VG_De_Minimis_of_EV__c from Risk_Capture__c where Policy_Schedule__c IN: psMap.keyset() OR Policy_Schedule__c IN: psROCMap.keyset() ORDER BY CreatedDate ASC]);
        
        for(Risk_Capture__c  rc: rcList){
            if(!allPSMap.get(rc.Policy_Schedule__c).VG_Is_MTA__c){
                if(rcMap.containsKey(rc.Policy_Schedule__c)) {
                    List<Risk_Capture__c > temprcList = rcMap.get(rc.Policy_Schedule__c);
                    temprcList.add(rc);
                    rcMap.put(rc.Policy_Schedule__c, temprcList);
                } else {
                    rcMap.put(rc.Policy_Schedule__c, new List<Risk_Capture__c > { rc });
                }
            }else if(RecordType=='Gentium' && allPSMap.get(rc.Policy_Schedule__c).Product__c == 'Fleet'){
                if(rcMap.containsKey(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)) {
                    List<Risk_Capture__c > temprcList = rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c);
                    temprcList.add(rc);
                    rcMap.put(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c, temprcList);
                } else {
                    rcMap.put(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c, new List<Risk_Capture__c > { rc });
                }
            }else if(RecordType=='Imara' || RecordType=='Horizon' || RecordType=='VFP'){
                Integer i = 1;
                String currentId = allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c;
                while(allPSMap.get(currentId).VG_Is_MTA__c && i > 0 ){
                    if(allPSMap.get(allPSMap.get(currentId).MTA_Parent_Policy_Schedule__c).VG_Is_MTA__c ){
                        currentId = allPSMap.get(currentId).MTA_Parent_Policy_Schedule__c;
                    }else{
                        i = 0;
                        allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c = allPSMap.get(currentId).MTA_Parent_Policy_Schedule__c;
                    }
                }
                if(rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_No_of_Reinstatements__c!=null && rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_No_of_Reinstatements__c.IsNumeric()){
                    rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_No_of_Reinstatements__c=String.valueOf((rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_No_of_Reinstatements__c != null  ? Integer.valueOf(rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_No_of_Reinstatements__c) : 0 )+(rc.VG_No_of_Reinstatements__c !=null ? Integer.valueOf(rc.VG_No_of_Reinstatements__c): 0));
                    rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_Reinstatement_Premiums__c=(rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_Reinstatement_Premiums__c!= null ? rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_Reinstatement_Premiums__c: '' )+'<br>'+(rc.VG_Reinstatement_Premiums__c!=null ? rc.VG_Reinstatement_Premiums__c: '');
                }else{
                    rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_No_of_Reinstatements__c = rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_No_of_Reinstatements__c != null  ? rcMap.get(allPSMap.get(rc.Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)[0].VG_No_of_Reinstatements__c : '' ;
                }
            }
        }
        
        if(RecordType!='Aesir'){
            for(VG_Policy_Schedule_Endorsement__c pse: pseList){
                if(!allPSMap.get(pse.VG_Policy_Schedule__c).VG_Is_MTA__c){
                    if(pseMap.containsKey(pse.VG_Policy_Schedule__c)) {
                        List<VG_Policy_Schedule_Endorsement__c> tempPSEList = pseMap.get(pse.VG_Policy_Schedule__c);
                        tempPSEList.add(pse);
                        pseMap.put(pse.VG_Policy_Schedule__c, tempPSEList );
                    } else {
                        pseMap.put(pse.VG_Policy_Schedule__c, new List<VG_Policy_Schedule_Endorsement__c> { pse });
                    }
                }else{
                    if(pseMap.containsKey(allPSMap.get(pse.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)) {
                        List<VG_Policy_Schedule_Endorsement__c> tempPSEList = pseMap.get(allPSMap.get(pse.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c);
                        tempPSEList.add(pse);
                        pseMap.put(allPSMap.get(pse.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c, tempPSEList );
                    } else {
                        pseMap.put(allPSMap.get(pse.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c, new List<VG_Policy_Schedule_Endorsement__c> { pse });
                    }
                }
            }
            Set<ID> psIds=new Set<ID>();
            psIds.addAll(pseMap.keyset());
            for(String psid: psIds){
                List<VG_Policy_Schedule_Endorsement__c > newPSEList=new List<VG_Policy_Schedule_Endorsement__c>();
                Map<String,VG_Policy_Schedule_Endorsement__c > edmMap=new Map<String,VG_Policy_Schedule_Endorsement__c>();
                for(VG_Policy_Schedule_Endorsement__c pse: pseMap.get(psid)){
                    if(pse.VG_Endorsement_Number__c != null){
                        if(edmMap.containsKey(pse.VG_Endorsement_Number__c)){
                            if(pse.CreatedDate > edmMap.get(pse.VG_Endorsement_Number__c).createdDate){
                                edmMap.remove(pse.VG_Endorsement_Number__c);
                                edmMap.put(pse.VG_Endorsement_Number__c,pse);
                            }
                        }else{
                            edmMap.put(pse.VG_Endorsement_Number__c ,pse);
                        }
                    }else{
                        edmMap.put(pse.id,pse);
                    }
                }
                newPSEList.addAll(edmMap.values());
                pseMap.remove(psid);
                pseMap.put(psId,newPSEList);
            }
        }
        for(VG_Policy_Schedule_Asset__c  psa: psaList){
            System.debug('PSA ::'+ psa.Name +'::'+ psa.VG_Base_Premium_Rate__c);
            if(!allPSMap.get(psa.VG_Policy_Schedule__c).VG_Is_MTA__c){
                if(psaMap.containsKey(psa.VG_Policy_Schedule__c)) {
                    List<VG_Policy_Schedule_Asset__c > tempPSAList = psaMap.get(psa.VG_Policy_Schedule__c);
                    tempPSAList.add(psa);
                    psaMap.put(psa.VG_Policy_Schedule__c, tempPSAList );
                    if(RecordType=='Gentium' && allPSMap.get(psa.VG_Policy_Schedule__c).Product__c != 'Fleet')
                        allPSMap.get(psa.VG_Policy_Schedule__c).Actual_GWP__c=allPSMap.get(psa.VG_Policy_Schedule__c).Actual_GWP__c - (psa.VG_CH_Commission__c != null ? psa.VG_CH_Commission__c : 0);
                }else {
                    psaMap.put(psa.VG_Policy_Schedule__c, new List<VG_Policy_Schedule_Asset__c > { psa });
                    if(RecordType=='Gentium' && allPSMap.get(psa.VG_Policy_Schedule__c).Product__c != 'Fleet')
                        allPSMap.get(psa.VG_Policy_Schedule__c).Actual_GWP__c=allPSMap.get(psa.VG_Policy_Schedule__c).Actual_GWP__c - (psa.VG_CH_Commission__c != null ? psa.VG_CH_Commission__c : 0);
                }
            }else if(RecordType!='Imara' && RecordType!='Horizon'){
                if(psaMap.containsKey(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c)) {
                    List<VG_Policy_Schedule_Asset__c > tempPSAList = psaMap.get(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c);
                    tempPSAList.add(psa);
                    psaMap.put(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c, tempPSAList );
                    if(RecordType=='Gentium' && allPSMap.get(psa.VG_Policy_Schedule__c).Product__c != 'Fleet')
                        allPSMap.get(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c).Actual_GWP__c=allPSMap.get(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c).Actual_GWP__c - (psa.VG_CH_Commission__c != null ? psa.VG_CH_Commission__c : 0);
                } else {
                    psaMap.put(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c, new List<VG_Policy_Schedule_Asset__c > { psa });
                    if(RecordType=='Gentium' && allPSMap.get(psa.VG_Policy_Schedule__c).Product__c != 'Fleet')
                        allPSMap.get(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c).Actual_GWP__c=allPSMap.get(allPSMap.get(psa.VG_Policy_Schedule__c).MTA_Parent_Policy_Schedule__c).Actual_GWP__c - (psa.VG_CH_Commission__c != null ? psa.VG_CH_Commission__c : 0);
                }
            }
        }     
        //Creating Renewal Policy...
        Policy__c renewalPolicy=new Policy__c();
        renewalPolicy=policy.clone(false,true,false,false);
        renewalPolicy.VG_Is_Renewal__c=true;
        renewalPolicy.VG_Inception_Date__c=policy.VG_Expiry_Date__c.addDays(1);
        renewalPolicy.VG_Governance_Compliance__c=null;
        if(Math.mod(policy.VG_Inception_Date__c.year(),4) != 0){
            if(Math.mod(policy.VG_Expiry_Date__c.year(),4) == 0){
                if(policy.VG_Expiry_Date__c <= date.newInstance(policy.VG_Expiry_Date__c.year(),02,28)){
                    renewalPolicy.VG_Expiry_Date__c=renewalPolicy.VG_Expiry_Date__c.addDays(364);
                }else{
                    renewalPolicy.VG_Expiry_Date__c=renewalPolicy.VG_Expiry_Date__c.addDays(365);
                }
            }
        }else{
            if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                renewalPolicy.VG_Expiry_Date__c=renewalPolicy.VG_Expiry_Date__c.addDays(365);
            }else{
                renewalPolicy.VG_Expiry_Date__c=renewalPolicy.VG_Expiry_Date__c.addDays(364);
            }
        }
        renewalPolicy.VG_Expiry_Date__c=renewalPolicy.VG_Inception_Date__c.addDays(364);
        renewalPolicy.Policy_Status__c='Prospect';
        renewalPolicy.VG_Sub_Status__c=null;
        renewalPolicy.CurrencyIsoCode=policy.CurrencyIsoCode;
        String[] polName = policy.Name.split('/');
        //renewalPolicy.Name = polName[0]+'/'+polName[1]+'/'+polName[2]+'/'+polName[3]+'/'+(Integer.valueOf(polName[4])+1);
        VG_Programme__c pgm;
        try{
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
            renewalPolicy.VG_Is_Temp__c = true;
            Utilities.SkipMethods('Trigger Context');
            Utilities.SkipMethods('Trigger Context2');
            Insert renewalPolicy;
            
            
        }Catch(Exception e){
            System.debug('Exception::'+e);
            String errMsg;
            if(pgm.id != null)
                delete pgm;
            if(renewalPolicy.id != null)
                delete renewalPolicy;
            if(e.getMessage().contains('is required in')){
                errMsg='Fill Required Fields \n';
                System.debug(errMsg);
                System.debug(e.getMessage());
                String[] errors=e.getMessage().split(',');
                String error=errors[1].replace(': []','');
                error=error.replace('<br/>',',').replace('is required in',':');
                error=error.removeEnd(',');
                errors=error.split(',');
                System.debug(errors);
                System.debug(error);
                Map<String,List<String>> errorMap= new Map<String,List<String>>();
                for(integer i=0;i<errors.size();i++){
                    String[] temp=errors[i].split(':');
                    System.debug(temp);
                    if(errorMap.containsKey(temp[0])){
                        List<String> tmpList=errorMap.get(temp[0]);
                        if(temp[0].contains('Policy Field'))
                            tmpList.add(temp[1]);
                        else
                            tmpList.add(temp[1]+'-'+temp[2]);
                        errorMap.put(temp[0],tmpList);
                    }else{
                        if(temp[0].contains('Policy Field'))
                            errorMap.put(temp[0] ,new List<String>{temp[1]});
                        else
                            errorMap.put(temp[0] ,new List<String>{temp[1]+'-'+temp[2]});
                    }                  
                }
                System.debug(errorMap);
                for(String s: errorMap.keySet()){
                    errMsg=errMsg+s+':';
                    for(String str: errorMap.get(s)){
                        errMsg=errMsg+str+',';
                    }
                    errMsg=errMsg.removeEnd(',');
                    errMsg=errMsg+'\n';
                }
                System.debug(errMsg);
            }else if(e.getMessage().contains('failed')){
                String[] errors=e.getMessage().split('error:');
                errMsg='An error was encountered. Please provide the below details to the Administrator for debugging:\n';               
                errMsg = errMsg+'  '+errors[1];            
            }else{                
                errMsg='Something went wrong. please contact Admin...';
            }  
            String refId = ErrorTrace.insertLog(e,policyId);           
            return errMsg;
        }
        
        renewalPolicy=[select id,Name,CurrencyIsoCode,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,Insured__c,AP_TP__c,Adjustment_Reason__c,Am_I_Underwriter__c,Broker_Name__c,Declaration_Type__c,Deductible_or_Excess_Amount__c,Deductible_or_Excess_Basis__c,Formula_Sum_Insured_Share__c,Inception_Expiry_Time__c,IsApproved_External__c,Line_Of_Business__c,Payment_Frequency__c,Policy_Basis__c,Policy_Status__c,Risk_Assessor__c,Sum_Insured_Share__c,Total_Sum_Insured__c,Type_of_Insurance__c,Underwriter__c,VG_Aggregate_Limit__c,VG_Booked_Time__c,VG_Brokerage_Percent__c,VG_Current_Insurer__c,VG_Expiry_Date__c,VG_Inception_Date__c,VG_IsApproved__c,VG_Prospect_Premium__c,VG_Sub_Broker__c,VG_Sub_Status__c,IPT__c,Gross_Written_Premium__c,Gross_Written_Premium_Rollup__c,VG_Brokerage_Amount__c,Earned_Aggregate_Balance__c,Extended_Reporting__c,Lead_Insurer__c,Loss_Ratio__c,Retroactive_Date__c,Total_Aggregate_Balance__c,Actual_GWP__c,Total_claims_o_s__c,MTA_Cancel_List__c,Endorsement_GWP__c,Jurisdiction__c,Levies__c,Premium_Adjustment__c,Risk_Premium__c,Technical_Model_Premium__c,Technical_UW_Premium__c,Total_claims_paid__c,Paid_Aggregate_Balance__c,VG_Fee_Income__c,VG_MGA_Commission_Amount__c,VG_Lloyds_Products__c,Total_claims_reserve__c,VG_Additional_Insureds__c,VG_Continuous_Cover_Date__c,VG_Governance_Compliance__c,VG_Local_Policies__c,VG_Plan_Rate__c,VG_Territorial_Limits__c,VG_Wording__c,Commercial_Adjustment__c,Transaction_GWP__c,VG_Is_Renewal__c,VG_Renewal_Policy_Id__c from Policy__c where id=:renewalPolicy.id limit 1];
        Integer psCount=0;
        for(Policy_Schedule__c temp: allPSMap.values()){
            if(!temp.VG_Is_MTA__c){
                System.debug('temp::'+temp);
                Integer psname = Integer.valueOf(temp.Name.split('/')[6]);                
                Policy_Schedule__c ps=new Policy_Schedule__c ();
                System.debug('PS::'+ps);
                ps=temp.clone(false,true,false,false);
                ps.IPT__c  = 0;
                ps.VG_Capacity_Paper__c = null;
                ps.VG_Status__c='Draft';
                ps.Base_Creation_Start_Date__c=renewalPolicy.VG_Inception_Date__c;
                ps.Base_Creation_End_Date__c=renewalPolicy.VG_Expiry_Date__c;
                System.debug('PS::'+ps);
                ps.id=null;
                ps.Policy__c=renewalPolicy.id;
                ps.Name=renewalPolicy.Name+'/PS/'+psCount;
                if(psCount != psname )
                   ps.Name=renewalPolicy.Name+'/PS/'+psname ;
                psCount++;
                ps.CurrencyIsoCode=renewalPolicy.CurrencyIsoCode;
                insertedPSMap.put(ps.Name,ps);
                if(rcMap.get(temp.id) != null){
                    for(Risk_Capture__c rc: rcMap.get(temp.id)){
                        if(insertedRCMap.containsKey(ps.Name)) {
                            List<Risk_Capture__c> tempRCList = insertedRCMap.get(ps.Name);
                            tempRCList.add(rc);
                            insertedRCMap.put(ps.Name, tempRCList);
                        } else {
                            insertedRCMap.put(ps.Name, new List<Risk_Capture__c> { rc });
                        }
                    }
                }
                if(pseMap.get(temp.id) != null){
                    for(VG_Policy_Schedule_Endorsement__c pse: pseMap.get(temp.id)){
                        if(insertedPSEMap.containsKey(ps.Name)) {
                            List<VG_Policy_Schedule_Endorsement__c> tempPSEList = insertedPSEMap.get(ps.Name);
                            tempPSEList.add(pse);
                            insertedPSEMap.put(ps.Name, tempPSEList);
                        } else {
                            insertedPSEMap.put(ps.Name, new List<VG_Policy_Schedule_Endorsement__c> { pse });
                        }
                    }
                }
                if(psaMap.get(temp.id) != null){
                    for(VG_Policy_Schedule_Asset__c  psa: psaMap.get(temp.id)){
                        if(insertedpsaMap.containsKey(ps.Name)) {
                            List<VG_Policy_Schedule_Asset__c > tempPSAList= insertedpsaMap.get(ps.Name);
                            tempPSAList.add(psa);
                            insertedpsaMap.put(ps.Name, tempPSAList);
                        } else {
                            insertedpsaMap.put(ps.Name, new List<VG_Policy_Schedule_Asset__c > { psa });
                        }
                    }
                }
            }   
        }
        try{
            if(insertedPSMap != null)
                insert insertedPSMap.values();
        }Catch(Exception e){
            System.debug('Exception::'+e);
            String errMsg;
            If(e.getMessage().contains('failed')){
                String[] errors=e.getMessage().split('error:');
                errMsg='An error was encountered. Please provide the below details to the Administrator for debugging:\n';            
                errMsg = errMsg+'  '+errors[1];
            }else{
                errMsg='Something went wrong. please contact Admin...';
            }
            String refId = ErrorTrace.insertLog(e,policyId); 
            if(renewalPolicy.id != null)
                delete renewalPolicy;
            return errMsg;
        }
        
        for(String psName: insertedPSMap.keyset()){
            Integer pseCount=1;
            Integer sbCount=1;
            if(insertedPSEMap.get(psName) != null){
                for(VG_Policy_Schedule_Endorsement__c pse: insertedPSEMap.get(psName)){
                    VG_Policy_Schedule_Endorsement__c tmp=new VG_Policy_Schedule_Endorsement__c();
                    tmp=pse.clone(false,true,false,false);
                    tmp.id=null;
                    if(tmp.VG_Type__c =='Endorsements'){
                        tmp.Name=psName+'/PE/'+pseCount;
                        pseCount++;
                    }else{
                        tmp.Name=psName+'/PESB/'+sbCount;
                        sbCount++;
                    }
                    tmp.VG_Policy_Schedule__c=insertedPSMap.get(psName).id;
                    pseInsertList.add(tmp);
                    
                }
            }
            Integer psaCount=1;
            if(insertedPSAMap.get(psName) != null){
                for(VG_Policy_Schedule_Asset__c  psa: insertedPSAMap.get(psName)){
                    VG_Policy_Schedule_Asset__c  tmp=new VG_Policy_Schedule_Asset__c ();
                    tmp=psa.clone(false,true,false,false);
                    tmp.id=null;
                    tmp.Name=psName+'/RR/'+psaCount;
                    psaCount++;
                    tmp.VG_Policy_Schedule__c=insertedPSMap.get(psName).id;
                    psaInsertList.add(tmp);
                }
            }
            Integer rcCount=1;
            if(insertedRCMap.get(psName) != null){
                for(Risk_Capture__c  rc: insertedRCMap.get(psName)){
                    Risk_Capture__c  tmp=new Risk_Capture__c ();
                    tmp=rc.clone(false,true,false,false);
                    tmp.id=null;
                    tmp.Name=psName+'/RD/'+rcCount;
                    rcCount++;
                    tmp.Policy_Schedule__c=insertedPSMap.get(psName).id;
                    if((RecordType=='VFP' || RecordType=='Imara' || RecordType=='Horizon' ) && rc.VG_Reinstatement_Premiums__c!= null){
                        System.debug(rc.VG_Reinstatement_Premiums__c);
                        String[] NOIList=tmp.VG_Reinstatement_Premiums__c.split('<br>'); 
                        tmp.VG_Reinstatement_Premiums__c='';  
                        for(integer i=1;i<=NOIList.size();i++){
                            System.debug(i+'::'+NOIList.size()+'::'+NOIList[(i-1)]+'::'+NOIList[(i-1)].split(':')+'::'+NOIList[(i-1)].split(':')[1]);
                            System.debug(rc.VG_Reinstatement_Premiums__c);
                            if(i==1)
                                tmp.VG_Reinstatement_Premiums__c='1st Reinstatement :'+NOIList[(i-1)].split(':')[1]+'<br/>';
                            if(i==2)
                                tmp.VG_Reinstatement_Premiums__c+='2nd Reinstatement :'+NOIList[(i-1)].split(':')[1]+'<br/>';
                            if(i==3)
                                tmp.VG_Reinstatement_Premiums__c+='3rd Reinstatement :'+NOIList[(i-1)].split(':')[1]+'<br/>';
                            if(i>3)
                                tmp.VG_Reinstatement_Premiums__c+=i+'th Reinstatement :'+NOIList[(i-1)].split(':')[1]+'<br/>';
                            System.debug(rc.VG_Reinstatement_Premiums__c);
                        }
                    }
                    rcInsertList.add(tmp);
                }
            }           
        }
        try{
            if(!psaInsertList.IsEmpty())
                insert psaInsertList;
            if(!pseInsertList.IsEmpty())
                insert pseInsertList;
            if(!rcInsertList.IsEmpty())
                insert rcInsertList;
            
            List<Policy__c> polUpdateList = new List<Policy__c>();
            policy.VG_Renewal_Policy_Id__c=renewalPolicy.id;
            policy.VG_Is_Temp__c =True;
            polUpdateList.add(policy);
            //renewalPolicy.VG_Renewal_Policy_Id__c = 'allowUpdate';
            renewalPolicy.VG_Is_Temp__c = false;
            polUpdateList.add(renewalPolicy);
            
            update polUpdateList;
            Utilities.clearMethods(); 
        }Catch(Exception e){
            System.debug('Exception::'+e);
            
            if(renewalPolicy.id != null)
                delete renewalPolicy;
            String errMsg;
            if(e.getMessage().contains('is required in')){
                errMsg='Fill Required Fields \n';
                System.debug(errMsg);
                System.debug(e.getMessage());
                String[] errors=e.getMessage().split(',');
                String error=errors[1].replace(': []','');
                error=error.replace('<br/>',',').replace('is required in',':');
                error=error.removeEnd(',');
                errors=error.split(',');
                System.debug(errors);
                System.debug(error);
                Map<String,List<String>> errorMap= new Map<String,List<String>>();
                for(integer i=0;i<errors.size();i++){
                    String[] temp=errors[i].split(':');
                    System.debug(temp);
                    if(errorMap.containsKey(temp[0])){
                        List<String> tmpList=errorMap.get(temp[0]);
                        if(temp[0].contains('Policy Field'))
                            tmpList.add(temp[1]);
                        else
                            tmpList.add(temp[1]+'-'+temp[2]);
                        errorMap.put(temp[0],tmpList);
                    }else{
                        if(temp[0].contains('Policy Field'))
                            errorMap.put(temp[0] ,new List<String>{temp[1]});
                        else
                            errorMap.put(temp[0] ,new List<String>{temp[1]+'-'+temp[2]});
                    }                  
                }
                System.debug(errorMap);
                for(String s: errorMap.keySet()){
                    errMsg=errMsg+s+':';
                    for(String str: errorMap.get(s)){
                        errMsg=errMsg+str+',';
                    }
                    errMsg=errMsg.removeEnd(',');
                    errMsg=errMsg+'\n';
                }
                System.debug(errMsg);
            }else if(e.getMessage().contains('failed')){
                String[] errors=e.getMessage().split('error:');
                errMsg='An error was encountered. Please provide the below details to the Administrator for debugging:\n';               
                errMsg = errMsg+'  '+errors[1];            
            }else{                
                errMsg='Something went wrong. please contact Admin...';
            }  
            String refId = ErrorTrace.insertLog(e,policyId); 
            return errMsg;
        }
        
        return String.valueOf(renewalPolicy.id);
    }
}