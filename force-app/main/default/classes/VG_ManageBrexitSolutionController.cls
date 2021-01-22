Public Class VG_ManageBrexitSolutionController{
    
    public Policy_Schedule__c ps {get; set;}
    public Policy__c pol {get; set;}
    public BrexitSolution bs {get;set;}
    
    public ID psId {get; set;} 
    public static ID VFPID {get; set;} 
     
    public List<BrexitSolution> BSList {get; set;}
    public List<SelectOption> VolanteEntity_Select {get; set;}
    public List<SelectOption> VFPsectionNoList {get; set;}
    
    public static List<VG_Policy_Schedule_Asset__c > psaList {get; set;}
    public Map<Id,Policy_Schedule__c> BSMap{get; set;}
    Map<Id,Policy_Schedule__c> psMap {get;set;}
    
    public Integer psCounter {get; set;}
    public Integer BSCounter {get; set;} 
    public Integer Index {get; set;} 
    
    public VG_ManageBrexitSolutionController(){
        psId =  ApexPages.currentPage().getParameters().get('id');
        System.debug('psId::'+psId);
        ps = [select id, Name,RecordType.Name,CurrencyIsoCode,RecordTypeId,CreatedDate,Policy__r.Name,CreatedById,VG_Co_Insurance_type__c,VG_IsTemp__c,VG_IsTempDelete__c,VG_Financials_Created__c,VG_Risk_Premium__c,Insured_Id__c,Declaration_Date__c,Product__c,Policy__c,VG_Plan_Rate__c,IPT_Percent__c,Premium_Adjustment__c,Endorsement_GWP__c,Levies__c,VG_Transaction_Type__c,VG_Risk_Transaction_Type__c,VG_Is_MTA__c,VG_MTA_Type__c,VG_MTA_Status__c,VG_MTA_Start_Date__c,VG_MTA_End_Date__c,VG_Current_Plan_Rate__c,VG_MTA_Cancellation_Date__c,MTA_Reason_for_Cancellation__c,VG_Declaration_Type__c,VG_Status__c,Net_Premium__c,VG_Declaration_Type_percent__c,VG_Fee_Income__c,VG_Adjustment_Reason__c,VG_Brokerage_Percent__c,VG_Net_Premium_Due__c,VG_Pre_MTA_Expiry_Date__c,VG_Base_Policy__c,Base_Creation_Start_Date__c,Base_Creation_End_Date__c,Commission__c,Gross_Base_Premium__c,VG_MGA_Commission_Amount__c,VG_Technical_Model_Premium__c,Technical_UW_Premium__c,Risk_Premium_Pro__c,Endorsement_Premium_Pro__c,Limit__c,Attachment__c,Sum_Insured__c,ILF_Factor__c,ILF_Premium__c,Rate_On_Line__c,Rate_Per_Mil__c,VG_Entity_Share__c,Share__c,VG_Entity_Split_Required__c,Underwriting_Premium__c,Premium_Adjustment_2__c,ORC__c,ORC_Amount__c,Account_Id__c,VG_VAT__c,VG_VAT_Amount__c,VG_Lloyds_Product__c,VG_Net_Premium_Receivable__c,VG_Auto_acquisition_Threshold__c,VG_Extended_Reporting_Period_AP__c,ILF_Layer__c,VG_Retired_Directors_Additional_Premium__c,VG_Retired_Directors_Year__c,VG_Extended_Reporting_Period__c,Technical_Layer_Premium__c,Written_Share__c,Gross_Written_Premium__c,Gross_or_Net_Premium__c,VG_Overider_Amount__c,VG_Overider_Percent__c,VG_Total_Layer_Premium__c,Transaction_GWP__c,Actual_GWP__c,IPT__c,VG_Brokerage_Amount__c,VG_Deductible__c,VG_Booked_Time__c,VG_Coverages__c,VG_Number_Of_vehicle__c,VG_Turn_Over__c,VG_Type_Of_Operation__c,VG_CREDIT_Augur_SCORE__c,VG_Exposure_Premium__c,VG_Experience_Premium__c,VG_Selected_Weight__c,VG_Net_Base_Premium__c,VG_Occupancy__c,VG_PD_Base_Rate__c,VG_BI_Base_Rate__c,VG_Machinery_Breakdown_Cover__c,VG_Machinery_Breakdown_BI_Cover__c,VG_Adjustment_Factor__c,VG_Adjusted_PD_Base_Rate__c,VG_Adjusted_BI_Base_Rate__c,VG_Witholding_Tax_Amount__c,VG_Net_Premium_Received__c,VG_Reinsurance_Type__c,VG_Structure__c,VG_Sub_Structure__c,VG_Technical_Loss_Ratio__c,MID_Check_Box__c,VG_Capacity_Paper__c,VG_Payment_Due_Date__c,VG_Wording__c,VG_Reporting_Date__c,VG_Rate_Change__c,VG_Municipality_Code__c,VG_Side_B_Rentention__c,VG_Side_C_Rentention__c,VG_D_O_Product__c,VG_Gross_Written_Premium_100__c,VG_Loss_Limit__c,VG_Bridge_Selected_Asset__c,MTA_Parent_Policy_Schedule__c,VG_Tax_Not_Applicable__c,VG_Last_Tax_Modified__c,VG_Norwegian_Nat_Cat_Pool_Premium__c,VG_MTA_Reduction_Date__c,VG_Tax_Amount_GWP_100__c from Policy_Schedule__c where id=:psId limit 1];
        VFPID  =  Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
        
        VolanteEntity_Select = new List<SelectOption>();
        VFPsectionNoList= new List<SelectOption>();
        
        BSList = new List<BrexitSolution>();
        BSMap = new Map<Id,Policy_Schedule__c>();
        List<Integer> psNumList = new List<Integer>();
        if(ps.RecordTypeId == VFPID){
            String CPList = '';
            if(ps.Product__c== 'PI'){
                CPList = Label.FIDO_PI_SectionNumber;
            }else if(ps.Product__c=='FI - D&O' || ps.Product__c=='FI - PI' || ps.Product__c=='FI - Crime' || ps.Product__c=='FI - Fiduciary' || ps.Product__c=='FI - Cyber' || ps.Product__c=='FI - Blend'){
                CPList = Label.FIDO_ALL_FI_SectionNumber;
            }else if(ps.Product__c=='D&O' || ps.Product__c=='Commercial Crime' || ps.Product__c=='Pre-paid Run-off'){
                CPList = Label.FIDO_D_O_Crime_SectionNumber;
            }else if(ps.Product__c=='W&I'){
                CPList = Label.FIDO_W_I_Crime_SectionNumber;
            }else if(ps.Product__c!='W&I' && ps.Product__c!='PI' && ps.Product__c!='D&O' && ps.Product__c!='Pre-paid Run-off' && ps.Product__c!='Commercial Crime' && ps.Product__c!='FI - D&O' && ps.Product__c!='FI - PI' && ps.Product__c!='FI - Crime' && ps.Product__c!='FI - Fiduciary' && ps.Product__c!='FI - Cyber' && ps.Product__c!='FI - Blend'){
                CPList = Label.FIDO_Others_SectionNumber;
            }
            for(String s : CPList.split(';')){
                VFPsectionNoList.add(new SelectOption(s,s));
            }
            Set<String> availableCapacityPapers = new Set<String>();
            for(SelectOption so : VFPsectionNoList){
                if(!availableCapacityPapers .contains(so.getLabel())){
                    availableCapacityPapers.add(so.getLabel());
                }
            }
        }
        VolanteEntity_Select.add(new SelectOption('VIL', 'VIL'));
        VolanteEntity_Select.add(new SelectOption('VG UK', 'VG UK'));
        VolanteEntity_Select.add(new SelectOption('VSR LLC', 'VSR LLC'));
        VolanteEntity_Select.add(new SelectOption('VTSL', 'VTSL'));

        String bsname;
        set<string> psnamelist = new set<string>();
        if(ps.Name.contains('/EEA')){
            bsname = ps.Name.remove('/EEA');          
            bsname += '/NonEEA';  
        }
        if(ps.Name.contains('/NonEEA')){
            bsname = ps.Name.remove('/NonEEA');  
            bsname += '/EEA';          
        }
        psnamelist.add(ps.Name);
        psnamelist.add(bsname);
        psMap = new Map<Id,Policy_Schedule__c>([select id, Name,RecordType.Name,CurrencyIsoCode,RecordTypeId,CreatedDate,Policy__r.Name,CreatedById,VG_Co_Insurance_type__c,VG_IsTemp__c,VG_IsTempDelete__c,VG_Financials_Created__c,VG_Risk_Premium__c,Insured_Id__c,Declaration_Date__c,Product__c,Policy__c,VG_Plan_Rate__c,IPT_Percent__c,Premium_Adjustment__c,Endorsement_GWP__c,Levies__c,VG_Transaction_Type__c,VG_Risk_Transaction_Type__c,VG_Is_MTA__c,VG_MTA_Type__c,VG_MTA_Status__c,VG_MTA_Start_Date__c,VG_MTA_End_Date__c,VG_Current_Plan_Rate__c,VG_MTA_Cancellation_Date__c,MTA_Reason_for_Cancellation__c,VG_Declaration_Type__c,VG_Status__c,Net_Premium__c,VG_Declaration_Type_percent__c,VG_Fee_Income__c,VG_Adjustment_Reason__c,VG_Brokerage_Percent__c,VG_Net_Premium_Due__c,VG_Pre_MTA_Expiry_Date__c,VG_Base_Policy__c,Base_Creation_Start_Date__c,Base_Creation_End_Date__c,Commission__c,Gross_Base_Premium__c,VG_MGA_Commission_Amount__c,VG_Technical_Model_Premium__c,Technical_UW_Premium__c,Risk_Premium_Pro__c,Endorsement_Premium_Pro__c,Limit__c,Attachment__c,Sum_Insured__c,ILF_Factor__c,ILF_Premium__c,Rate_On_Line__c,Rate_Per_Mil__c,VG_Entity_Share__c,Share__c,VG_Entity_Split_Required__c,Underwriting_Premium__c,Premium_Adjustment_2__c,ORC__c,ORC_Amount__c,Account_Id__c,VG_VAT__c,VG_VAT_Amount__c,VG_Lloyds_Product__c,VG_Net_Premium_Receivable__c,VG_Auto_acquisition_Threshold__c,VG_Extended_Reporting_Period_AP__c,ILF_Layer__c,VG_Retired_Directors_Additional_Premium__c,VG_Retired_Directors_Year__c,VG_Extended_Reporting_Period__c,Technical_Layer_Premium__c,Written_Share__c,Gross_Written_Premium__c,Gross_or_Net_Premium__c,VG_Overider_Amount__c,VG_Overider_Percent__c,VG_Total_Layer_Premium__c,Transaction_GWP__c,Actual_GWP__c,IPT__c,VG_Brokerage_Amount__c,VG_Deductible__c,VG_Booked_Time__c,VG_Coverages__c,VG_Number_Of_vehicle__c,VG_Turn_Over__c,VG_Type_Of_Operation__c,VG_CREDIT_Augur_SCORE__c,VG_Exposure_Premium__c,VG_Experience_Premium__c,VG_Selected_Weight__c,VG_Net_Base_Premium__c,VG_Occupancy__c,VG_PD_Base_Rate__c,VG_BI_Base_Rate__c,VG_Machinery_Breakdown_Cover__c,VG_Machinery_Breakdown_BI_Cover__c,VG_Adjustment_Factor__c,VG_Adjusted_PD_Base_Rate__c,VG_Adjusted_BI_Base_Rate__c,VG_Witholding_Tax_Amount__c,VG_Net_Premium_Received__c,VG_Reinsurance_Type__c,VG_Structure__c,VG_Sub_Structure__c,VG_Technical_Loss_Ratio__c,MID_Check_Box__c,VG_Capacity_Paper__c,VG_Payment_Due_Date__c,VG_Wording__c,VG_Reporting_Date__c,VG_Rate_Change__c,VG_Municipality_Code__c,VG_Side_B_Rentention__c,VG_Side_C_Rentention__c,VG_D_O_Product__c,VG_Gross_Written_Premium_100__c,VG_Loss_Limit__c,VG_Bridge_Selected_Asset__c,MTA_Parent_Policy_Schedule__c,VG_Tax_Not_Applicable__c,VG_Last_Tax_Modified__c,VG_Norwegian_Nat_Cat_Pool_Premium__c,VG_MTA_Reduction_Date__c,VG_Tax_Amount_GWP_100__c from Policy_Schedule__c where Name IN: psnamelist]);
        if(psMap.size() > 0 && psMap.size() != 1){
            BSCounter =0;
            for(Policy_Schedule__c psh: psMap.values()){
                bs=new BrexitSolution();
                bs.Name = psh.Name;
                bs.counter = String.valueOf(BSCounter);
                bs.BSId = psh.id;  
                bs.sharePrecent = psh.VG_Entity_Share__c;
                bs.previousSharePrecent = bs.SharePrecent;
                bs.SectionNo = psh.VG_Capacity_Paper__c;
                BSList.add(bs);
                BSCounter++;                              
            }
        }

        if(psMap.size() == 1){
            for(Policy_Schedule__c psh: psMap.values()){
                bs=new BrexitSolution();
                bs.Name = psh.Name;
                bs.counter = String.valueOf(BSCounter);
                bs.BSId = psh.id;                
                bs.sharePrecent = psh.VG_Entity_Share__c;
                bs.previousSharePrecent = bs.SharePrecent;
                bs.SectionNo = psh.VG_Capacity_Paper__c;
                BSList.add(bs);
                bsName = ps.Name.contains('/NonEEA') ? ps.Name.remove('/NonEEA')+'/EEA' : ps.Name.remove('/EEA')+'/NonEEA';
                bs =new BrexitSolution();
                bs.Name=bsName;
                bs.otherBSId = psh.id;
                bs.SectionNo = psh.VG_Capacity_Paper__c;
                bs.sharePrecent = psh.VG_Entity_Share__c;
                bs.previousSharePrecent = bs.SharePrecent;
                bs.counter = String.valueOf(BSCounter);
                BSList.add(bs);
            }
        } 
    }
    
    public PageReference cancel(){
        return new PageReference('/'+ps.Id);
    }
    
    public PageReference finish(){
        Decimal totalSharePrecent=0;
        
        for(BrexitSolution bs :BSList ){
            totalSharePrecent=totalSharePrecent+bs.sharePrecent;            
        }
        
        if(totalSharePrecent != 100){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Sum of all entity shares must be 100%..')); 
            return null;
        }else{
            List<Policy_Schedule__c> updatePSList = new List<Policy_Schedule__c>();
            List<Policy_Schedule__c> insertPSList = new List<Policy_Schedule__c>();
            List<VG_Policy_Schedule_Asset__c > insertpsaList = new List<VG_Policy_Schedule_Asset__c>();
            List<VG_Policy_Schedule_Endorsement__c > insertpseList = new List<VG_Policy_Schedule_Endorsement__c>();
            List<VG_Exposure_Premium__c> insertexpList = new List<VG_Exposure_Premium__c>();
            List<Risk_Capture__c> insertrcList = new List<Risk_Capture__c>();
            
            List<VG_Policy_Schedule_Asset__c > psaList = new List<VG_Policy_Schedule_Asset__c>([select id, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, VG_Premium__c, VG_Coverage__c, VG_Rate_Per_Vehicle__c, VG_Number_of_Vehicles__c, VG_Vehicle_Type__c, VG_Policy_Schedule__c, VG_Deductible__c, VG_Use__c, VG_IsTemp__c, VG_IsTempDelete__c, VG_Technical_UW_Rate_Annual__c, Technical_UW_Premium__c, VG_Limit__c, VG_Sub_Aggregation__c, Asset__c, VG_Territorial_Limits__c, VG_AAD__c, VG_Aggregate_Precent__c, VG_Aggregate__c, VG_Deductible_Precent__c, VG_Deposit_Premium_Formula__c, VG_Deposit_Premium__c, VG_GNPI__c, VG_Limit_Precent__c, VG_Max_Rate__c, VG_Min_Rate__c, VG_Minimum_Premium_Formula__c, VG_Minimum_Premium__c, VG_No_Claims_Bonus_Value__c, VG_No_Claims_Bonus__c, VG_Provisional_Rate__c, VG_Rate_on_Income__c, VG_Return_Period_Entry__c, VG_Return_Period_Exit__c, VG_Risk_Premium__c, VG_Swing_Load__c, VG_Sub_limit__c, VG_PD_Deductible__c, VG_MB_PD_Deductible__c,   VG_Adjusted_PD_Premium__c, VG_Adjusted_BI_Premium__c, VG_Building_Discount_Loading__c, VG_Net_PD_Premium__c, VG_Net_BI_Premium__c, VG_Net_MB_Premium__c, VG_Net_Risk_Premium__c, VG_Waiting_Period__c, VG_BI_Indemnity_Period__c, VG_MB_Waiting_Period__c, VG_MB_BI_Indemnity_Period__c, VG_Share__c, VG_Max_SI__c, VG_Avg_SI__c, VG_Coverage_Type__c,  VG_Fee_Amounts__c, VG_Base_Premium_Rate__c,  VG_Scheme_Name__c, VG_Binder_Ref__c, VG_Policy_No__c, VG_Insured_Name__c, VG_Address__c, VG_Country__c, VG_Vehicle_Make__c, VG_Vehicle_Model__c, VG_Payment_Ref__c, VG_Sum_Insured__c, VG_Gross_Written_Premium__c, VG_Brokerage__c, VG_Tax_on_Premium__c, VG_CH_Commission__c, VG_Bordereax_Date__c, VG_Policy_Cover_Start_Date__c, VG_Policy_Cover_End_Date__c, VG_Transaction_Type__c, VG_Payment_Terms__c, VG_Base_Premium__c, VG_Profession__c, VG_Declared_Value__c, VG_Perils__c, VG_Retention_Line__c, VG_Event_Limit__c, VG_Treaty_Limit__c, VG_Expected_Premium_Income__c, VG_Expected_Ceding_Commission__c, VG_Expected_Profit_Commission__c, VG_Ceding_Commission__c, VG_Expected_Loss_Ratio__c, VG_Min_Ceding_Commission__c, VG_Loss_Ratio_for_Min__c, VG_Max_Ceding_Commission__c, VG_Loss_Ratio_for_Max__c, VG_No_of_Surplus_Lines__c, VG_Retention__c, VG_Cession__c, VG_Perils_Text__c, VG_Information__c, VG_Retroactive_Date__c, VG_Policy_Basis__c, VG_Transaction_Effective_date__c, VG_Date_of_Birth__c, VG_Address2__c, VG_Address3__c, VG_Postcode__c, VG_Registration_Plate__c, VG_Sub_broker__c, VG_Risk_start__c, VG_Risk_End__c, VG_Attachment__c, VG_Written_Share__c, VG_Signed_Share__c, VG_CC_Information__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =: psId]);
            List<VG_Policy_Schedule_Endorsement__c > pseList = new List<VG_Policy_Schedule_Endorsement__c>([select id, Name, CurrencyIsoCode, CreatedDate, VG_Premium__c, VG_Policy_Schedule__c, VG_Title__c, VG_Endorsement_Details__c, VG_Endorsement_Library_Id__c, VG_Endorsement_Number__c, VG_IsTemp__c, VG_IsTempDelete__c, VG_Sub_limit__c, VG_Type__c, VG_Product__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =: psId]);
            List<VG_Exposure_Premium__c> expList = new List<VG_Exposure_Premium__c>([select id, Name, CurrencyIsoCode, CreatedDate, VG_Factor_Name__c, VG_Rating_Factor__c, VG_Rate__c, VG_Other_Factor__c, VG_Policy_Schedule__c from VG_Exposure_Premium__c where VG_Policy_Schedule__c =: psId]);
            List<Risk_Capture__c> rcList = new List<Risk_Capture__c>([select id, Name, CurrencyIsoCode, CreatedDate, Policy_Schedule__c, VG_Layer__c, VG_No_of_Reinstatements__c, VG_Plan_Loss_Ratio__c, VG_Rate_Type__c, VG_Territorial_Scope__c, VG_Governing_Law_of_Sale_Agreement__c, VG_Territorial_Limits__c, VG_Share__c, VG_Buyer__c, VG_Seller__c, VG_Risk_End__c, VG_Risk_start__c, VG_Company_Type__c, VG_Company_Domicile__c, VG_Target__c, VG_Revenue__c, VG_Total_Assets__c, VG_Net_Profit__c, VG_Market_Cap__c, VG_Net_Equity__c, VG_Headcount__c, VG_Class_1_Employees__c, VG_Industry__c, VG_Profession__c, VG_Fees_Current_Year__c, VG_Fees_Year_1__c, VG_Fees_Year_2__c, VG_Fees_Year_3__c, VG_Enterprise_Value__c, VG_Retention_Amount__c, VG_Endorsed__c, VG_Income_Basis__c, VG_Claims_Notification_Threshold__c, VG_Cash_Loss_Limit__c, VG_First_Premium_Payment_Date__c, VG_Ceding_Commission_Type__c, VG_Additional_Information__c, VG_Retention_Fixed_or_Tipping__c, VG_Policy_Details__c, VG_Dispute_Clause__c, VG_Retention_description__c,  VG_De_Minimis_Amount__c,  VG_Completion_Date__c, VG_Sector__c, VG_Expense_Agreement_Amount__c, VG_Expense_Agreement_t_Amount_Tax__c, VG_Retention_Applicable_to_all_risks__c, De_Minimis_description__c, VG_De_Minimis_Applicable_to_all_risks__c, VG_Retention_of_EV__c, VG_De_Minimis_of_EV__c from Risk_Capture__c where Policy_Schedule__c =: psId]);
            
            for(BrexitSolution bs : BSList ){
                if(bs.BSId == null){
                    ps = psMap.get(bs.otherBSId);
                    Policy_Schedule__c temp=new Policy_Schedule__c();
                    temp = ps.clone(false,true,false,false);
                    Decimal updatedSharePercent = (bs.sharePrecent / (100-bs.sharePrecent))*100;
                    temp.VG_Entity_Share__c = updatedSharePercent;
                    temp.VG_Entity_Split_Required__c = true;
                    temp.Name = bs.Name;
                    temp.VG_Capacity_Paper__c = bs.SectionNo ;
                    temp.VG_Volante_Entities__c = bs.VolanteEntity;
                    temp = summarayCalc(temp);
                    temp.VG_Entity_Share__c = bs.sharePrecent;
                    insertPSList.add(temp);
                }else{
                    Policy_Schedule__c temp=new Policy_Schedule__c();
                    temp.id = bs.BSId;
                    Decimal updatedSharePercent = bs.previousSharePrecent == null ? bs.sharePrecent : (bs.sharePrecent / bs.previousSharePrecent)*100;
                    temp = psMap.get(bs.BSId);
                    temp.VG_Entity_Share__c = updatedSharePercent;
                    temp.Name = bs.Name;
                    temp.VG_Capacity_Paper__c = bs.SectionNo ;
                    temp.VG_Volante_Entities__c = bs.VolanteEntity;
                    temp = summarayCalc(temp);
                    temp.VG_Entity_Share__c = bs.sharePrecent;
                    updatePSList.add(temp);
                }
            }
            if(!insertPSList.IsEmpty()){
                Insert insertPSList;
            }
            if(!updatePSList.IsEmpty()){
                Update updatePSList;
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
            psaList = insertpsaList;
            if(!insertpsaList.IsEmpty())
                Insert insertpsaList;
            if(!insertpseList.IsEmpty())
                Insert insertpseList;
            if(!insertrcList.IsEmpty())
                Insert insertrcList;
            if(!insertexpList.IsEmpty())
                Insert insertexpList;
            Utilities.clearMethods(); 
        }
        return new PageReference('/'+ps.Id);
    }
    
    public static Policy_Schedule__c UpdateBrexitCalculation(Policy_Schedule__c baseps,Policy_Schedule__c Brexitps){
        VFPID  =  Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
        Decimal sharepercent = (Brexitps.VG_Entity_Share__c/100)/(baseps.VG_Entity_Share__c/100); 
        System.debug('sharepercent::'+sharepercent);
        if(Brexitps.RecordTypeId == VFPID){
            If(Brexitps.Product__c == 'W&I'){
                Brexitps.Risk_Premium_Pro__c = (baseps.Risk_Premium_Pro__c * sharepercent) ;
                Brexitps.Endorsement_Premium_Pro__c =  baseps.Endorsement_Premium_Pro__c * sharepercent;
                Brexitps.Net_Premium__c = Brexitps.Risk_Premium_Pro__c + Brexitps.Endorsement_Premium_Pro__c;
                Brexitps.Premium_Adjustment_2__c = baseps.Premium_Adjustment_2__c *sharepercent;
                Brexitps.Premium_Adjustment__c = baseps.Premium_Adjustment_2__c *sharepercent;
                Brexitps.VG_Technical_Model_Premium__c  = Brexitps.Risk_Premium_Pro__c  + Brexitps.Endorsement_Premium_Pro__c ;
                System.debug('ReskPremium::'+Brexitps.Risk_Premium_Pro__c+'::'+Brexitps.Endorsement_Premium_Pro__c+'::'+ Brexitps.VG_Technical_Model_Premium__c);
                Brexitps.VG_Gross_Written_Premium_100__c  = ( Brexitps.Risk_Premium_Pro__c  + Brexitps.Endorsement_Premium_Pro__c + Brexitps.Technical_UW_Premium__c + Brexitps.Premium_Adjustment_2__c)  * (Brexitps.VG_Entity_Share__c/100); 
                If(Brexitps.Share__c != 0 && Brexitps.Share__c!= null && Brexitps.VG_Entity_Share__c != 0 && Brexitps.VG_Entity_Share__c != null)
                    Brexitps.Gross_Written_Premium__c  =  baseps.VG_Gross_Written_Premium_100__c*(Brexitps.Share__c/100) ;     
                Brexitps.VG_Brokerage_Amount__c = Brexitps.VG_Gross_Written_Premium_100__c  *(Brexitps.VG_Brokerage_Percent__c/100);              
                Brexitps.Actual_GWP__c = Brexitps.VG_Gross_Written_Premium_100__c  - Brexitps.VG_Brokerage_Amount__c ;            
                                                       
            }else{
                Brexitps.Risk_Premium_Pro__c =  (baseps.Risk_Premium_Pro__c * sharepercent) ;
                System.debug('ReskPremium::'+Brexitps.Risk_Premium_Pro__c+'::'+Brexitps.Endorsement_Premium_Pro__c );                
                Brexitps.Endorsement_Premium_Pro__c = baseps.Endorsement_Premium_Pro__c * sharepercent;
                Brexitps.Net_Premium__c = Brexitps.Risk_Premium_Pro__c + Brexitps.Endorsement_Premium_Pro__c;
                Brexitps.Premium_Adjustment_2__c = baseps.Premium_Adjustment_2__c *sharepercent;
                Brexitps.Premium_Adjustment__c = baseps.Premium_Adjustment__c * sharepercent;
                Brexitps.VG_Technical_Model_Premium__c  = (Brexitps.Risk_Premium_Pro__c + Brexitps.Endorsement_Premium_Pro__c);
                Brexitps.Technical_UW_Premium__c  = (Brexitps.Risk_Premium_Pro__c + Brexitps.Endorsement_Premium_Pro__c)+(Brexitps.Premium_Adjustment__c);
                Brexitps.VG_Gross_Written_Premium_100__c =  Brexitps.Technical_UW_Premium__c  +(Brexitps.Premium_Adjustment_2__c) ;
                If(Brexitps.Share__c != 0 && Brexitps.Share__c!= null)
                    Brexitps.Gross_Written_Premium__c  = Brexitps.VG_Gross_Written_Premium_100__c*(Brexitps.Share__c/100) ;      
                Brexitps.VG_Brokerage_Amount__c = Brexitps.Gross_Written_Premium__c  * (Brexitps.VG_Brokerage_Percent__c/100);              
                Brexitps.Actual_GWP__c = Brexitps.Gross_Written_Premium__c  - Brexitps.VG_Brokerage_Amount__c ;                             
                              
            }
        }
        return Brexitps;
    }
    
    public static Policy_Schedule__c summarayCalc(Policy_Schedule__c ps){
        VFPID  =  Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
        
        System.debug('ps.RecordTypeId::'+ps.RecordTypeId+'::'+VFPID);
        if(ps.RecordTypeId == VFPID){
            System.debug('RecordTypeId::'+ps.RecordTypeId);
            If(ps.Product__c == 'W&I'){
                ps.Risk_Premium_Pro__c =  ps.Risk_Premium_Pro__c * (ps.VG_Entity_Share__c/100);
                ps.Endorsement_Premium_Pro__c = ps.Endorsement_Premium_Pro__c * (ps.VG_Entity_Share__c/100);
                ps.Net_Premium__c = ps.Risk_Premium_Pro__c + ps.Endorsement_Premium_Pro__c;
                System.debug('ReskPremium::'+ps.Risk_Premium_Pro__c+'::'+ps.Endorsement_Premium_Pro__c );
                ps.Endorsement_Premium_Pro__c = ps.Endorsement_Premium_Pro__c * (ps.VG_Entity_Share__c/100);
                ps.Premium_Adjustment_2__c = ps.Premium_Adjustment_2__c * (ps.VG_Entity_Share__c/100);
                ps.Premium_Adjustment__c = ps.Premium_Adjustment__c * (ps.VG_Entity_Share__c/100);
                ps.VG_Technical_Model_Premium__c  = ps.Risk_Premium_Pro__c  + ps.Endorsement_Premium_Pro__c ;
                System.debug('ReskPremium::'+ps.Risk_Premium_Pro__c+'::'+ps.Endorsement_Premium_Pro__c+'::'+ ps.VG_Technical_Model_Premium__c);
                ps.VG_Gross_Written_Premium_100__c  = ( ps.Risk_Premium_Pro__c  + ps.Endorsement_Premium_Pro__c + ps.Technical_UW_Premium__c + ps.Premium_Adjustment_2__c)  * (ps.VG_Entity_Share__c/100); 
                If(ps.Share__c != 0 && ps.Share__c!= null && ps.VG_Entity_Share__c != 0 && ps.VG_Entity_Share__c != null)
                    ps.Gross_Written_Premium__c  = ps.VG_Gross_Written_Premium_100__c*(ps.Share__c/100) * (ps.VG_Entity_Share__c/100);      
                ps.VG_Brokerage_Amount__c = ps.VG_Gross_Written_Premium_100__c  *(ps.VG_Brokerage_Percent__c/100);              
                ps.Actual_GWP__c = ps.VG_Gross_Written_Premium_100__c  - ps.VG_Brokerage_Amount__c ;            
                                                       
            }else{
                ps.Risk_Premium_Pro__c =  (ps.Risk_Premium_Pro__c * (ps.VG_Entity_Share__c/100));
                System.debug('ReskPremium::'+ps.Risk_Premium_Pro__c+'::'+ps.Endorsement_Premium_Pro__c );                
                ps.Endorsement_Premium_Pro__c = ps.Endorsement_Premium_Pro__c * (ps.VG_Entity_Share__c/100);
                ps.Net_Premium__c = ps.Risk_Premium_Pro__c + ps.Endorsement_Premium_Pro__c;
                ps.Premium_Adjustment_2__c = ps.Premium_Adjustment_2__c * (ps.VG_Entity_Share__c/100);
                ps.Premium_Adjustment__c = ps.Premium_Adjustment__c * (ps.VG_Entity_Share__c/100);
                ps.VG_Technical_Model_Premium__c  = (ps.Share__c/100)*(ps.Risk_Premium_Pro__c + ps.Endorsement_Premium_Pro__c);
                ps.Technical_UW_Premium__c  = (ps.Risk_Premium_Pro__c + ps.Endorsement_Premium_Pro__c)+(ps.Premium_Adjustment__c);
                ps.VG_Gross_Written_Premium_100__c =  ps.Technical_UW_Premium__c  +(ps.Premium_Adjustment_2__c) ;
                If(ps.Share__c != 0 && ps.Share__c!= null && ps.VG_Entity_Share__c != 0 && ps.VG_Entity_Share__c != null)
                    ps.Gross_Written_Premium__c  = ps.VG_Gross_Written_Premium_100__c*(ps.Share__c/100) ;      
                ps.VG_Brokerage_Amount__c = ps.Gross_Written_Premium__c  *(ps.VG_Brokerage_Percent__c/100);              
                ps.Actual_GWP__c = ps.Gross_Written_Premium__c  - ps.VG_Brokerage_Amount__c ;                             
                              
            }
        }
        return ps;
    }
    
    public Class BrexitSolution{
        public String Name {get; set;}
        public String SectionNo {get; set;}
        public String BSId {get; set;}
        public String otherBSId {get; set;}
        public Decimal sharePrecent {get; set;}
        public Decimal previousSharePrecent {get; set;}
        public Boolean IsBase {get; set;}
        public String counter {get; set;}
        public string VolanteEntity {get;set;}
    
        public BrexitSolution(){
            sharePrecent = 0;
            previousSharePrecent = null;
            IsBase = false;
            BSId = null;
            otherBSId = null;
        }
    }
}