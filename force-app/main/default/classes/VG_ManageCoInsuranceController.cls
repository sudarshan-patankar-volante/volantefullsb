Public Class VG_ManageCoInsuranceController{
    
    public Policy_Schedule__c ps {get; set;}
    public CoInsurance coi {get;set;}
    
    public ID psId {get; set;} 
    
    public List<CoInsurance> COIList {get; set;}
    public List<SelectOption> sectionNoList {get; set;}
    
    public Map<Id,Policy_Schedule__c> CIMap{get; set;}
    Map<Id,Policy_Schedule__c> psMap {get;set;}
    
    public Integer psCounter {get; set;}
    public Integer COICounter {get; set;} 
    public Integer Index {get; set;} 
    
    public VG_ManageCoInsuranceController(){
        psId =  ApexPages.currentPage().getParameters().get('id');
        System.debug('psId::'+psId);
        ps = [select id, Name,CurrencyIsoCode,Split_Type__c,VG_Volante_Entities__c,RecordTypeId,CreatedDate,Policy__r.Name,CreatedById,VG_Co_Insurance_type__c,VG_IsTemp__c,VG_IsTempDelete__c,VG_Financials_Created__c,VG_Risk_Premium__c,Insured_Id__c,Declaration_Date__c,Product__c,Policy__c,VG_Plan_Rate__c,IPT_Percent__c,Premium_Adjustment__c,Endorsement_GWP__c,Levies__c,VG_Transaction_Type__c,VG_Risk_Transaction_Type__c,VG_Is_MTA__c,VG_MTA_Type__c,VG_MTA_Status__c,VG_MTA_Start_Date__c,VG_MTA_End_Date__c,VG_Current_Plan_Rate__c,VG_MTA_Cancellation_Date__c,MTA_Reason_for_Cancellation__c,VG_Declaration_Type__c,VG_Status__c,Net_Premium__c,VG_Declaration_Type_percent__c,VG_Fee_Income__c,VG_Adjustment_Reason__c,VG_Brokerage_Percent__c,VG_Net_Premium_Due__c,VG_Pre_MTA_Expiry_Date__c,VG_Base_Policy__c,Base_Creation_Start_Date__c,Base_Creation_End_Date__c,Commission__c,Gross_Base_Premium__c,VG_MGA_Commission_Amount__c,VG_Technical_Model_Premium__c,Technical_UW_Premium__c,Risk_Premium_Pro__c,Endorsement_Premium_Pro__c,Limit__c,Attachment__c,Sum_Insured__c,ILF_Factor__c,ILF_Premium__c,Rate_On_Line__c,Rate_Per_Mil__c,Share__c,Underwriting_Premium__c,Premium_Adjustment_2__c,ORC__c,ORC_Amount__c,Account_Id__c,VG_VAT__c,VG_VAT_Amount__c,VG_Lloyds_Product__c,VG_Net_Premium_Receivable__c,VG_Auto_acquisition_Threshold__c,VG_Extended_Reporting_Period_AP__c,ILF_Layer__c,VG_Retired_Directors_Additional_Premium__c,VG_Retired_Directors_Year__c,VG_Extended_Reporting_Period__c,Technical_Layer_Premium__c,Written_share__c,Gross_Written_Premium__c,Gross_or_Net_Premium__c,VG_Overider_Amount__c,VG_Overider_Percent__c,VG_Total_Layer_Premium__c,Transaction_GWP__c,Actual_GWP__c,IPT__c,VG_Brokerage_Amount__c,VG_Deductible__c,VG_Booked_Time__c,VG_Coverages__c,VG_Number_Of_vehicle__c,VG_Turn_Over__c,VG_Type_Of_Operation__c,VG_CREDIT_Augur_SCORE__c,VG_Exposure_Premium__c,VG_Experience_Premium__c,VG_Selected_Weight__c,VG_Net_Base_Premium__c,VG_Occupancy__c,VG_PD_Base_Rate__c,VG_BI_Base_Rate__c,VG_Machinery_Breakdown_Cover__c,VG_Machinery_Breakdown_BI_Cover__c,VG_Adjustment_Factor__c,VG_Adjusted_PD_Base_Rate__c,VG_Adjusted_BI_Base_Rate__c,VG_Witholding_Tax_Amount__c,VG_Net_Premium_Received__c,VG_Reinsurance_Type__c,VG_Structure__c,VG_Sub_Structure__c,VG_Technical_Loss_Ratio__c,MID_Check_Box__c,VG_Capacity_Paper__c,VG_Payment_Due_Date__c,VG_Wording__c,VG_Reporting_Date__c,VG_Rate_Change__c,VG_Municipality_Code__c,VG_Side_B_Rentention__c,VG_Side_C_Rentention__c,VG_D_O_Product__c,VG_Gross_Written_Premium_100__c,VG_Loss_Limit__c,VG_Bridge_Selected_Asset__c,MTA_Parent_Policy_Schedule__c,VG_Tax_Not_Applicable__c,VG_Last_Tax_Modified__c,VG_Norwegian_Nat_Cat_Pool_Premium__c,VG_MTA_Reduction_Date__c,VG_Tax_Amount_GWP_100__c from Policy_Schedule__c where id=:psId limit 1];
        System.debug('ps::'+ps);
        psMap = new Map<Id,Policy_Schedule__c>([select id,VG_Co_Insurance_Parent__c, Name,CurrencyIsoCode,RecordTypeId,CreatedDate,Policy__r.Name,CreatedById,VG_IsTemp__c,VG_IsTempDelete__c,VG_Financials_Created__c,VG_Risk_Premium__c,Insured_Id__c,Declaration_Date__c,Product__c,Policy__c,VG_Plan_Rate__c,IPT_Percent__c,Premium_Adjustment__c,Endorsement_GWP__c,Levies__c,VG_Transaction_Type__c,VG_Risk_Transaction_Type__c,VG_Is_MTA__c,VG_MTA_Type__c,VG_MTA_Status__c,VG_MTA_Start_Date__c,VG_MTA_End_Date__c,VG_Current_Plan_Rate__c,VG_MTA_Cancellation_Date__c,MTA_Reason_for_Cancellation__c,VG_Declaration_Type__c,VG_Status__c,Net_Premium__c,VG_Declaration_Type_percent__c,VG_Fee_Income__c,VG_Adjustment_Reason__c,VG_Brokerage_Percent__c,VG_Net_Premium_Due__c,VG_Pre_MTA_Expiry_Date__c,VG_Base_Policy__c,Base_Creation_Start_Date__c,Base_Creation_End_Date__c,Commission__c,Gross_Base_Premium__c,VG_MGA_Commission_Amount__c,VG_Technical_Model_Premium__c,Technical_UW_Premium__c,Risk_Premium_Pro__c,Endorsement_Premium_Pro__c,Limit__c,Attachment__c,Sum_Insured__c,ILF_Factor__c,ILF_Premium__c,Rate_On_Line__c,Rate_Per_Mil__c,Share__c,Underwriting_Premium__c,Premium_Adjustment_2__c,ORC__c,ORC_Amount__c,Account_Id__c,VG_VAT__c,VG_VAT_Amount__c,VG_Lloyds_Product__c,VG_Net_Premium_Receivable__c,VG_Auto_acquisition_Threshold__c,VG_Extended_Reporting_Period_AP__c,ILF_Layer__c,VG_Retired_Directors_Additional_Premium__c,VG_Retired_Directors_Year__c,VG_Extended_Reporting_Period__c,Technical_Layer_Premium__c,Written_share__c,Gross_Written_Premium__c,Gross_or_Net_Premium__c,VG_Overider_Amount__c,VG_Overider_Percent__c,VG_Total_Layer_Premium__c,Transaction_GWP__c,Actual_GWP__c,IPT__c,VG_Brokerage_Amount__c,VG_Deductible__c,VG_Booked_Time__c,VG_Coverages__c,VG_Number_Of_vehicle__c,VG_Turn_Over__c,VG_Type_Of_Operation__c,VG_CREDIT_Augur_SCORE__c,VG_Exposure_Premium__c,VG_Experience_Premium__c,VG_Selected_Weight__c,VG_Net_Base_Premium__c,VG_Occupancy__c,VG_PD_Base_Rate__c,VG_BI_Base_Rate__c,VG_Machinery_Breakdown_Cover__c,VG_Machinery_Breakdown_BI_Cover__c,VG_Adjustment_Factor__c,VG_Adjusted_PD_Base_Rate__c,VG_Adjusted_BI_Base_Rate__c,VG_Witholding_Tax_Amount__c,VG_Net_Premium_Received__c,VG_Reinsurance_Type__c,VG_Structure__c,VG_Sub_Structure__c,VG_Technical_Loss_Ratio__c,MID_Check_Box__c,VG_Capacity_Paper__c,VG_Payment_Due_Date__c,VG_Wording__c,VG_Reporting_Date__c,VG_Rate_Change__c,VG_Municipality_Code__c,VG_Side_B_Rentention__c,VG_Side_C_Rentention__c,VG_D_O_Product__c,VG_Gross_Written_Premium_100__c,VG_Loss_Limit__c,VG_Bridge_Selected_Asset__c,MTA_Parent_Policy_Schedule__c,VG_Tax_Not_Applicable__c,VG_Last_Tax_Modified__c,VG_Norwegian_Nat_Cat_Pool_Premium__c,VG_MTA_Reduction_Date__c,VG_Tax_Amount_GWP_100__c from Policy_Schedule__c where Policy__c =: ps.Policy__c]);
        
        
        sectionNoList = new List<SelectOption>();
        COIList = new List<CoInsurance>();
        CIMap = new Map<Id,Policy_Schedule__c>();
        List<Integer> psNumList = new List<Integer>();
        
        List<VG_UMR__c> umrList = new List<VG_UMR__c>([select id,Name from VG_UMR__c where RecordType.Name = 'Bridge' AND VG_Type__c = 'Co-Insurance']);
        
        for(VG_UMR__c u : umrList ){
            sectionNoList.add(new SelectOption(u.Name,u.Name));
        }
        for(Policy_Schedule__c psh:psMap.values()){
            System.debug('check::'+psh.VG_Co_Insurance_Parent__c+'::'+ps.id);
            if(psh.VG_Co_Insurance_Parent__c  == ps.id){
                CIMap.put(psh.id,psh);
            }
            System.debug('name::'+psh.Name);
            psNumList.add(Integer.valueOf(psh.Name.split('/')[6]));
        }
        psNumList.sort();
        System.debug(psNumList);
        psCounter = psNumList[psNumList.size()-1];
        
        coi=new CoInsurance();
        COICounter = 0;
        coi.Name = ps.Name;
        coi.IsBase = true;
        coi.counter = '0';
        coi.sharePrecent = ps.Share__c;
        coi.SectionNo = ps.VG_Capacity_Paper__c;
        COIList.add(coi);
        COICounter ++;
        
        if(CIMap.size() > 0){
            for(Policy_Schedule__c psh:CIMap.values()){
                coi=new CoInsurance();
                coi.Name = psh.Name;
                coi.counter = String.valueOf(COICounter);
                coi.coiId = psh.id;
                coi.sharePrecent = psh.Share__c;
                coi.SectionNo = psh.VG_Capacity_Paper__c;
                COIList.add(coi);
                COICounter ++;
            }
        }
    }
    
    public PageReference cancel(){
        return new PageReference('/'+ps.Id);
    }
    public PageReference finish(){
        Decimal totalSharePrecent=0;
        
        for(CoInsurance coi:COIList ){
            totalSharePrecent=totalSharePrecent+coi.sharePrecent ;
        }
        if(totalSharePrecent != 100){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Sum of all Co-Insurance Share(%) must be 100..')); 
            return null;
        }else{
            List<Policy_Schedule__c> updatePSList = new List<Policy_Schedule__c>();
            List<Policy_Schedule__c> insertPSList = new List<Policy_Schedule__c>();
            List<VG_Policy_Schedule_Asset__c > insertpsaList = new List<VG_Policy_Schedule_Asset__c>();
            List<VG_Policy_Schedule_Endorsement__c > insertpseList = new List<VG_Policy_Schedule_Endorsement__c>();
            List<VG_Exposure_Premium__c> insertexpList = new List<VG_Exposure_Premium__c>();
            List<Risk_Capture__c> insertrcList = new List<Risk_Capture__c>();
            
            List<VG_Policy_Schedule_Asset__c > psaList = new List<VG_Policy_Schedule_Asset__c>([SELECT Annual_Rate_100__c,Asset__c,CreatedById,CreatedDate,CurrencyIsoCode,Id,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,RecordTypeId,SystemModstamp,Technical_UW_Premium__c,VG_AAD__c,VG_Address2__c,VG_Address3__c,VG_Address__c,VG_Adjusted_BI_Premium__c,VG_Adjusted_PD_Premium__c,VG_Aggregate_Precent__c,VG_Aggregate__c,VG_Attachment__c,VG_Avg_SI__c,VG_Base_Premium_Rate__c,VG_Base_Premium__c,VG_Binder_Ref__c,VG_BI_Indemnity_Period__c,VG_Bordereax_Date__c,VG_Brokerage__c,VG_Building_Discount_Loading__c,VG_CC_Information__c,VG_Ceding_Commission__c,VG_Cession__c,VG_CH_Commission__c,VG_Country__c,VG_Coverage_Type__c,VG_Coverage__c,VG_Date_of_Birth__c,VG_Declared_Value__c,VG_Deductible_Precent__c,VG_Deductible__c,VG_Deposit_Premium_Formula__c,VG_Deposit_Premium__c,VG_Event_Limit__c,VG_Expected_Ceding_Commission__c,VG_Expected_Loss_Ratio__c,VG_Expected_Premium_Income__c,VG_Expected_Profit_Commission__c,VG_Fee_Amounts__c,VG_GNPI__c,VG_Gross_Written_Premium__c,VG_Information__c,VG_Insured_Name__c,VG_IsTempDelete__c,VG_IsTemp__c,VG_Limit_Precent__c,VG_Limit__c,VG_Loss_Ratio_for_Max__c,VG_Loss_Ratio_for_Min__c,VG_Management_Expenses_for_PC__c,VG_Max_Ceding_Commission__c,VG_Max_Rate__c,VG_Max_SI__c,VG_MB_BI_Indemnity_Period__c,VG_MB_PD_Deductible__c,VG_MB_Waiting_Period__c,VG_Minimum_Premium_Formula__c,VG_Minimum_Premium__c,VG_Min_Ceding_Commission__c,VG_Min_Rate__c,VG_Net_BI_Premium__c,VG_Net_MB_Premium__c,VG_Net_PD_Premium__c,VG_Net_Risk_Premium__c,VG_No_Claims_Bonus_Value__c,VG_No_Claims_Bonus__c,VG_No_of_Surplus_Lines__c,VG_Number_of_Vehicles__c,VG_OtherRisk__c,VG_Payment_Ref__c,VG_Payment_Terms__c,VG_PD_Deductible__c,VG_Perils_Text__c,VG_Perils__c,VG_Policy_Basis__c,VG_Policy_Cover_End_Date__c,VG_Policy_Cover_Start_Date__c,VG_Policy_No__c,VG_Policy_Schedule__c,VG_Postcode__c,VG_Premium__c,VG_Profession__c,VG_Provisional_Rate__c,VG_Rate_on_Income__c,VG_Rate_Per_Vehicle__c,VG_Registration_Plate__c,VG_Retention_Line__c,VG_Retention__c,VG_Retroactive_Date__c,VG_Return_Period_Entry__c,VG_Return_Period_Exit__c,VG_Risk_End__c,VG_Risk_Premium__c,VG_Risk_start__c,VG_Scheme_Name__c,VG_Share__c,VG_Signed_Share__c,VG_Sub_Aggregation__c,VG_Sub_broker__c,VG_Sub_limit__c,VG_Sum_Insured__c,VG_Swing_Load__c,VG_Tax_on_Premium__c,VG_Technical_UW_Rate_Annual__c,VG_Territorial_Limits__c,VG_Transaction_Effective_date__c,VG_Transaction_Type__c,VG_Treaty_Limit__c,VG_Use__c,VG_Vehicle_Make__c,VG_Vehicle_Model__c,VG_Vehicle_Type__c,VG_Waiting_Period__c,VG_Written_Share__c FROM VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =: psId]);
            List<VG_Policy_Schedule_Endorsement__c > pseList = new List<VG_Policy_Schedule_Endorsement__c>([select id, Name, CurrencyIsoCode, CreatedDate, VG_Premium__c, VG_Policy_Schedule__c, VG_Title__c, VG_Endorsement_Details__c, VG_Endorsement_Library_Id__c, VG_Endorsement_Number__c, VG_IsTemp__c, VG_IsTempDelete__c, VG_Sub_limit__c, VG_Type__c, VG_Product__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =: psId]);
            List<VG_Exposure_Premium__c> expList = new List<VG_Exposure_Premium__c>([select id, Name, CurrencyIsoCode, CreatedDate, VG_Factor_Name__c, VG_Rating_Factor__c, VG_Rate__c, VG_Other_Factor__c, VG_Policy_Schedule__c from VG_Exposure_Premium__c where VG_Policy_Schedule__c =: psId]);
            List<Risk_Capture__c> rcList = new List<Risk_Capture__c>([SELECT CreatedById,CreatedDate,CurrencyIsoCode,De_Minimis_description__c,Drivers_Claims__c,Drivers_Convictions__c,Drivers_Conviction_Points__c,Drivers_DOB__c,Drivers_License_Ban_Details__c,Drivers_Medical_Conditions__c,Drivers_Name__c,Id,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,Policy_Schedule__c,SystemModstamp,VG_Additional_Information__c,VG_Buyer__c,VG_Cash_Loss_Limit__c,VG_Ceding_Commission_Type__c,VG_Claims_Notification_Threshold__c,VG_Class_1_Employees__c,VG_Company_Domicile__c,VG_Company_Type__c,VG_Completion_Date__c,VG_De_Minimis_Amount__c,VG_De_Minimis_Applicable_to_all_risks__c,VG_De_Minimis_of_EV__c,VG_Dispute_Clause__c,VG_Endorsed__c,VG_Enterprise_Value__c,VG_Expense_Agreement_Amount__c,VG_Expense_Agreement_t_Amount_Tax__c,VG_Fees_Current_Year__c,VG_Fees_Year_1__c,VG_Fees_Year_2__c,VG_Fees_Year_3__c,VG_First_Premium_Payment_Date__c,VG_Governing_Law_of_Sale_Agreement__c,VG_Headcount__c,VG_Income_Basis__c,VG_Industry__c,VG_Layer__c,VG_Market_Cap__c,VG_Net_Equity__c,VG_Net_Profit__c,VG_No_of_Reinstatements__c,VG_Plan_Loss_Ratio__c,VG_Policy_Details__c,VG_Profession__c,VG_Proposal_form_date__c,VG_Rate_Type__c,VG_Reinstatement_Premiums__c,VG_Reinstatement_Premium__c,VG_Retention_Amount__c,VG_Retention_Applicable_to_all_risks__c,VG_Retention_description__c,VG_Retention_Fixed_or_Tipping__c,VG_Retention_of_EV__c,VG_Revenue__c,VG_Risk_End__c,VG_Risk_start__c,VG_Sector__c,VG_Seller__c,VG_Share__c,VG_Target__c,VG_Territorial_Limits__c,VG_Territorial_Scope__c,VG_Total_Assets__c FROM Risk_Capture__c where Policy_Schedule__c =: psId]);
            
            for(CoInsurance coi : COIList ){
                System.debug('coi.IsBase::'+coi.IsBase);
                if(coi.IsBase){
                    ps.Share__c = coi.sharePrecent ;
                    ps.VG_Co_Insurance_type__c='Parent' ;
                    //ps.VG_Capacity_Paper__c = coi.SectionNo ;
                    ps=summarayCalc(ps);
                    updatePSList.add(ps);
                }else{
                    if(coi.coiId == null){
                        Policy_Schedule__c temp=new Policy_Schedule__c();
                        temp = ps.clone(false,true,false,false);
                        temp.Share__c = coi.sharePrecent ;
                        temp.Name = coi.Name;
                        temp.VG_Co_Insurance_type__c='Child' ;
                        temp.VG_Capacity_Paper__c = coi.SectionNo ;
                        temp.VG_Co_Insurance_Parent__c = ps.id;
                        temp = summarayCalc(temp);
                        insertPSList.add(temp);
                    }else{
                        Policy_Schedule__c temp=new Policy_Schedule__c();
                        temp.id = coi.coiId;
                        temp = psMap.get(coi.coiId);
                        temp.Share__c = coi.sharePrecent ;
                        temp.Name = coi.Name;
                        temp.VG_Capacity_Paper__c = coi.SectionNo ;
                        temp.VG_Co_Insurance_Parent__c = ps.id;
                        temp = summarayCalc(temp);
                        updatePSList.add(temp);
                        CIMap.remove(coi.coiId);
                    }
                }
            }
            
            if(!insertPSList.IsEmpty()){
                Insert insertPSList;
            }
            if(!updatePSList.IsEmpty()){
                Update updatePSList;
            }
            if(CIMap.size() > 0){
                delete CIMap.values();
            }
            for(Policy_Schedule__c  ps: insertPSList){
                Integer psaCount=1;
                for(VG_Policy_Schedule_Asset__c psa: psaList ){
                    VG_Policy_Schedule_Asset__c temp = new VG_Policy_Schedule_Asset__c ();
                    temp = psa.Clone(false,true,false,false);
                    temp.Name = ps.Name+'/RR/'+psaCount;
                    temp.VG_Policy_Schedule__c = ps.id;  
                    insertpsaList.add(temp);
                    psaCount++;
                }
                for(VG_Exposure_Premium__c exp: expList){
                    VG_Exposure_Premium__c temp = new VG_Exposure_Premium__c ();
                    temp=exp.Clone(false,true,false,false);
                    temp.VG_Policy_Schedule__c = ps.id;  
                    insertexpList.add(temp);
                }
                for(Risk_Capture__c  rc: rcList ){
                    Risk_Capture__c temp = new Risk_Capture__c();
                    temp = rc.Clone(false,true,false,false);
                    temp.Name = ps.Name+'/RD/1';
                    temp.Policy_Schedule__c = ps.id;  
                    insertrcList.add(temp);
                }
                Integer pseCount = 1;
                Integer pseSBCount = 1 ;
                
                for(VG_Policy_Schedule_Endorsement__c pse: pseList){
                    VG_Policy_Schedule_Endorsement__c temp = new VG_Policy_Schedule_Endorsement__c();
                    temp = pse.Clone(false,true,false,false);
                    temp.VG_Policy_Schedule__c = ps.id;  
                    if(temp.VG_Type__c == 'Endorsements'){
                        temp.Name = ps.Name+'/PE/'+pseCount ;
                        pseCount++;
                    }else if(temp.VG_Type__c == 'Sub-limits'){
                        temp.Name = ps.Name+'/PESb/'+pseSBCount ;
                        pseSBCount ++;
                    }
                    insertpseList.add(temp);
                }
            }
            if(!insertpsaList.IsEmpty())
                Insert insertpsaList;
            if(!insertpseList.IsEmpty())
                Insert insertpseList;
            if(!insertrcList.IsEmpty())
                Insert insertrcList;
            if(!insertexpList.IsEmpty())
                Insert insertexpList;
        }
        return new PageReference('/'+ps.Id);
    }
    public static Policy_Schedule__c summarayCalc(Policy_Schedule__c ps){
        if(ps.Product__c != 'Property' && ps.Product__c != 'Commercial Combined' ){
            ps.Sum_Insured__c = ps.Limit__c * (ps.Share__c/100) ;
            System.debug('check2::'+ps.Technical_Layer_Premium__c+ps.Share__c);
            ps.VG_Technical_Model_Premium__c = ps.Technical_Layer_Premium__c * (ps.Share__c/100);
            ps.Technical_UW_Premium__c = ps.Underwriting_Premium__c = ps.VG_Technical_Model_Premium__c + ( ps.Premium_Adjustment__c * (ps.Share__c/100) ) ;
            ps.Actual_GWP__c = (ps.Premium_Adjustment_2__c  * (ps.Share__c/100) ) + ps.Underwriting_Premium__c;
            ps.Gross_Written_Premium__c =  ps.Actual_GWP__c /(1-(ps.VG_Brokerage_Percent__c/100));
            ps.VG_Gross_Written_Premium_100__c = (ps.Share__c!=null && ps.Share__c!=0)?(ps.Gross_Written_Premium__c /(ps.Share__c/100)):0;
            ps.VG_Brokerage_Amount__c = ps.Gross_Written_Premium__c * (ps.VG_Brokerage_Percent__c / 100);
        }else{
            ps.VG_Technical_Model_Premium__c = ps.Net_Premium__c * (ps.Share__c/100);
            ps.Technical_UW_Premium__c = ps.Underwriting_Premium__c = ps.VG_Technical_Model_Premium__c +  ( ps.Premium_Adjustment__c * (ps.Share__c/100) )  ;
            ps.Actual_GWP__c = (ps.Premium_Adjustment_2__c  * (ps.Share__c/100) ) + ps.Underwriting_Premium__c;
            ps.Gross_Written_Premium__c =  ps.Actual_GWP__c /(1-(ps.VG_Brokerage_Percent__c/100));
            ps.VG_Gross_Written_Premium_100__c = ps.Gross_Written_Premium__c /(ps.Share__c/100);
            if(ps.Product__c == 'Property')
                ps.VG_Brokerage_Amount__c = ps.Gross_Written_Premium__c * (ps.VG_Brokerage_Percent__c / 100);
            else
                ps.VG_Brokerage_Amount__c = ps.Gross_Written_Premium__c ==  ps.Actual_GWP__c ? 0 : ps.Gross_Written_Premium__c - ps.Actual_GWP__c;
        }
        return ps;
    }
    
    public void removeCoInsurance(){
        System.debug(Index);
        COIList.remove(Index);
        COICounter = 0;
        for(CoInsurance coi : COIList ){
            coi.counter = string.valueOf(COICounter) ;
            if(!coi.Isbase){
                if(ps.Split_Type__c == 'EEA')
                    coi.Name=ps.Policy__r.Name+'/PS/'+(psCounter+COICounter)+'/EEA';
                else
                    coi.Name=ps.Policy__r.Name+'/PS/'+(psCounter+COICounter);
            }            
            COICounter ++;
        }
    }
    
    public void addCoInsurance(){
        System.debug(psCounter);
        System.debug(COICounter );
        CoInsurance coi=new CoInsurance();
        if(ps.Split_Type__c == 'EEA')
            coi.Name=ps.Policy__r.Name+'/PS/'+(psCounter+COICounter)+'/EEA';
        else
            coi.Name=ps.Policy__r.Name+'/PS/'+(psCounter+COICounter);
        coi.counter = String.valueOf(COICounter);
        COIList.add(coi);
        COICounter ++;
    }
    
    public Class CoInsurance{
        public String Name {get; set;}
        public String SectionNo {get; set;}
        public String coiId {get; set;}
        public Decimal sharePrecent {get; set;}
        public Boolean IsBase {get; set;}
        public String counter {get; set;}
        
        public CoInsurance(){
            sharePrecent = 0;
            IsBase = false;
            coiId = null;
        }
    }
    
}