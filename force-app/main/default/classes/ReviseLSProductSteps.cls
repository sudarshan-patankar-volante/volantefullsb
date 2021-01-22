Public Class ReviseLSProductSteps{
    
    public String Product{get;set;}
    public string CapacityPaper{get;set;}
    public String pdtext{get;set;}
    public String BItext{get;set;}
    public String LLtext{get;set;}
    public String GDtext{get;set;} 
    public String MAtext{get;set;}
    public String FLtext{get;set;}
    public String ELtext{get;set;}
    public String APtext{get;set;}
    public String AENtext{get;set;}
    public String AERNtext{get;set;}
    public String AERtext{get;set;}
    public String PRRZtext{get;set;}
    public String PPLtext{get;set;}
    public String PItext{get;set;} 
    public String DOtext{get;set;}
    public String PAtext{get;set;}
    public String CBtext{get;set;}
    public String CEtext{get;set;}
    public String CEEtext{get;set;}
    public String DoEtext{get;set;}
    public String DrEtext{get;set;}
    public String FEtext{get;set;}
    public String HPEtext{get;set;}
    public String HMEtext{get;set;}
    public String Bentext{get;set;}
    public String MCtext{get;set;}
    public String LOItext{get;set;}
    public String RCOtext{get;set;}
    public String NJMtext{get;set;}
    public String NAMtext{get;set;}
    public String Clubtext{get;set;}
    
    public String LEtext{get;set;}
    public String SCtext{get;set;}
    public String PStext{get;set;}
    public String AEtext{get;set;}
    public String IVtext{get;set;}
    public String GPtext{get;set;}
    public String GRtext{get;set;}
    public String ICWtext{get;set;}
    public String AICWtext{get;set;}
    public String RRtext{get;set;}
    public String BDtext{get;set;}
    public String Index{get;set;}
    public String GrossOrNet {get; set;}
    public String rd{get;set;}
    public String aInfo{get;set;}
    public Id psid {get; set;}
    public String MTAType{get;set;}
    public String MTAStartDate{get;set;}
    public String seletedProrateoption {get; set;}    
    
    public Integer RRcounter {get; set;}
    public Integer counter{get;set;}
    public Integer counterEnd {get; set;}
    
    public Decimal RiskPremium {get;set;}
    public Decimal netModelPremium {get; set;}
    public Decimal adjustment {get;set;}
    public Decimal writtenShare {get; set;}
    public Decimal actualPremium {get; set;}
    public Decimal sumInsured {get; set;}
    public Decimal brokerage {get; set;}
    public Decimal uwPremium {get; set;}
    public Decimal levies {get; set;}
    public Decimal brokerageAmount {get; set;}
    public Decimal RateChange {get;set;}
    public Decimal grossWrittenPremium {get; set;}
    public Decimal grossWrittenPremium2 {get; set;}
    public Decimal feeIncome {get; set;}
    public Decimal IPTAmount {get; set;}
    public Decimal IPTPercent {get; set;}
    public Decimal sharePercent {get; set;}
    public Decimal vat{get; set;}
    public Decimal vatamount {get; set;}
    public Decimal techModelPremium {get; set;}
    public Decimal adjustmentTechPremium {get; set;}
    public Decimal taxamount {get; set;}
    public Decimal endorsementPremium {get; set;} 
    public Decimal TSI {get; set;}  
    public Decimal proRata{get; set;}   
    
    Public Risk_Capture__c rc{get;set;}
    public Policy__c policy{get;set;}
    public Policy_Schedule__c ps {get; set;} 
    public LibraryWrapper LW1{get;set;}
    public LibraryWrapper LW{get;set;}
    
    public list<SelectOption> Product_Select {get; set;}
    public list<SelectOption> RRCoverage_Select {get; set;}
    public list<SelectOption> NonEEAVolanteEntity_Select {get; set;}
    public list<SelectOption> EEAVolanteEntity_Select {get; set;}
    Public List<SelectOption> splitTypes{get; set;}

    public List<RRWrapper> riskRatingList {get; set;}   
    public List<LibraryWrapper> LibraryWrapperList1 {get; set;}
    public List<LibraryWrapper> LibraryWrapperList {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements1 {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements {get; set;}
    public List<Endorsement_Library__c> ElList1{get;set;}
    public List<Endorsement_Library__c> ElList{get;set;} 
    public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> manualList{get;set;}
    
    public Map<id, VG_Policy_Schedule_Endorsement__c> pseTempMap{get;set;}
    public Map<id, VG_Policy_Schedule_Endorsement__c> pseMap{get;set;}
    public Map<id, VG_Policy_Schedule_Asset__c> psaMap{get;set;}
    
    public boolean enableMList{get;set;}
    Public Boolean skipSplit {get; set;}
    
    Public ReviseLSProductSteps(){
        psid =  apexpages.currentpage().getparameters().get('Id');
        MTAType = apexpages.currentpage().getparameters().get('MTAType');
        seletedProrateoption  = apexpages.currentpage().getparameters().get('seletedProrateoption');
        MTAStartDate = apexpages.currentpage().getparameters().get('MTAStartDate');        
        ps=[select id, Name, VG_Volante_Entities__c,VG_Entity_Split_Required__c,Split_Type__c,Policy__r.Name,Policy__r.VG_Is_Renewal__c, Policy__r.VG_Inception_Date__c, Policy__r.VG_Expiry_Date__c, VG_Rate_Change__c, IsDeleted, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, VG_IsTemp__c, VG_IsTempDelete__c, VG_Financials_Created__c, VG_Risk_Premium__c, Insured_Id__c, Declaration_Date__c, Product__c, Policy__c, VG_Plan_Rate__c, IPT_Percent__c, Premium_Adjustment__c, Endorsement_GWP__c, Levies__c, VG_Is_MTA__c, VG_MTA_Type__c, VG_MTA_Status__c, VG_MTA_Start_Date__c, VG_MTA_End_Date__c, VG_Current_Plan_Rate__c, VG_MTA_Cancellation_Date__c, MTA_Reason_for_Cancellation__c, VG_Declaration_Type__c, VG_Status__c, Net_Premium__c, VG_Declaration_Type_percent__c, VG_Fee_Income__c, VG_Adjustment_Reason__c, VG_Brokerage_Percent__c, VG_Pre_MTA_Expiry_Date__c, VG_Base_Policy__c, Base_Creation_Start_Date__c, Base_Creation_End_Date__c, Commission__c, Gross_Base_Premium__c, VG_MGA_Commission_Amount__c, VG_Technical_Model_Premium__c, Technical_UW_Premium__c, Risk_Premium_Pro__c, Endorsement_Premium_Pro__c, Limit__c, Attachment__c, Sum_Insured__c, ILF_Factor__c, ILF_Premium__c, Rate_On_Line__c, Rate_Per_Mil__c, Share__c, Underwriting_Premium__c, Premium_Adjustment_2__c, ORC__c, ORC_Amount__c, Account_Id__c, VG_VAT__c, VG_VAT_Amount__c, VG_Lloyds_Product__c, VG_Auto_acquisition_Threshold__c, VG_Extended_Reporting_Period_AP__c, ILF_Layer__c, VG_Retired_Directors_Additional_Premium__c, VG_Retired_Directors_Year__c, VG_Extended_Reporting_Period__c, Technical_Layer_Premium__c, Written_share__c, Gross_Written_Premium__c, Gross_or_Net_Premium__c, VG_Overider_Amount__c, VG_Overider_Percent__c, VG_Total_Layer_Premium__c, Transaction_GWP__c, Actual_GWP__c, IPT__c, VG_Brokerage_Amount__c, VG_Deductible__c, VG_Booked_Time__c, VG_Coverages__c, VG_Number_Of_vehicle__c, VG_Turn_Over__c, VG_Type_Of_Operation__c, VG_CREDIT_Augur_SCORE__c, VG_Exposure_Premium__c, VG_Experience_Premium__c, VG_Selected_Weight__c, VG_Net_Base_Premium__c, VG_Occupancy__c, VG_PD_Base_Rate__c, VG_BI_Base_Rate__c, VG_Machinery_Breakdown_Cover__c, VG_Machinery_Breakdown_BI_Cover__c, VG_Adjustment_Factor__c, VG_Adjusted_PD_Base_Rate__c, VG_Adjusted_BI_Base_Rate__c, VG_Witholding_Tax_Amount__c, VG_Reinsurance_Type__c, VG_Structure__c, VG_Sub_Structure__c, VG_Technical_Loss_Ratio__c, MID_Check_Box__c, VG_Capacity_Paper__c, VG_Payment_Due_Date__c from Policy_Schedule__c where id=:psid limit 1];
        rc=[select id, Name, IsDeleted, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, Policy_Schedule__c, Drivers_Name__c, Drivers_License_Ban_Details__c, Drivers_Claims__c, Drivers_Medical_Conditions__c, Drivers_DOB__c, Drivers_Conviction_Points__c, Drivers_Convictions__c, VG_IsTemp__c, VG_IsTempDelete__c, VG_Layer__c, VG_No_of_Reinstatements__c, VG_Plan_Loss_Ratio__c, VG_Rate_Type__c, VG_Territorial_Scope__c, VG_Territorial_Limits__c, VG_Share__c, VG_Risk_End__c, VG_Risk_start__c, VG_Company_Type__c, VG_Company_Domicile__c, VG_Revenue__c, VG_Total_Assets__c, VG_Net_Profit__c, VG_Market_Cap__c, VG_Net_Equity__c, VG_Headcount__c, VG_Class_1_Employees__c, VG_Industry__c, VG_Profession__c, VG_Fees_Current_Year__c, VG_Fees_Year_1__c, VG_Fees_Year_2__c, VG_Fees_Year_3__c, VG_Income_Basis__c, VG_Claims_Notification_Threshold__c, VG_Cash_Loss_Limit__c, VG_First_Premium_Payment_Date__c, VG_Ceding_Commission_Type__c, VG_Additional_Information__c, VG_Policy_Details__c, VG_Dispute_Clause__c from Risk_Capture__c where Policy_Schedule__c=:psid limit 1];
        psaMap = new Map<id, VG_Policy_Schedule_Asset__c>([select id, Name, IsDeleted, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, VG_Premium__c, VG_Coverage__c, VG_Rate_Per_Vehicle__c, VG_Number_of_Vehicles__c, VG_Vehicle_Type__c, VG_Policy_Schedule__c, VG_Deductible__c, VG_Use__c, VG_IsTemp__c, VG_IsTempDelete__c, VG_Technical_UW_Rate_Annual__c, Technical_UW_Premium__c, VG_Limit__c, VG_Sub_Aggregation__c, Asset__c, VG_Territorial_Limits__c, VG_AAD__c, VG_Aggregate_Precent__c, VG_Aggregate__c, VG_Deductible_Precent__c, VG_Deposit_Premium_Formula__c, VG_Deposit_Premium__c, VG_GNPI__c, VG_Limit_Precent__c, VG_Max_Rate__c, VG_Min_Rate__c, VG_Minimum_Premium_Formula__c, VG_Minimum_Premium__c, VG_No_Claims_Bonus_Value__c, VG_No_Claims_Bonus__c, VG_Provisional_Rate__c, VG_Rate_on_Income__c, VG_Return_Period_Entry__c, VG_Return_Period_Exit__c, VG_Risk_Premium__c, VG_Swing_Load__c, VG_Sub_limit__c, VG_PD_Deductible__c, VG_MB_PD_Deductible__c, VG_Adjusted_PD_Premium__c, VG_Adjusted_BI_Premium__c, VG_Building_Discount_Loading__c, VG_Net_PD_Premium__c, VG_Net_BI_Premium__c, VG_Net_MB_Premium__c, VG_Net_Risk_Premium__c, VG_Waiting_Period__c, VG_BI_Indemnity_Period__c, VG_MB_Waiting_Period__c, VG_MB_BI_Indemnity_Period__c, VG_Share__c, VG_Max_SI__c, VG_Avg_SI__c, VG_Coverage_Type__c, VG_Fee_Amounts__c, VG_Base_Premium_Rate__c, VG_Scheme_Name__c, VG_Binder_Ref__c, VG_Policy_No__c, VG_Insured_Name__c, VG_Address__c, VG_Country__c, VG_Vehicle_Make__c, VG_Vehicle_Model__c, VG_Payment_Ref__c, VG_Sum_Insured__c, VG_Gross_Written_Premium__c, VG_Brokerage__c, VG_Tax_on_Premium__c, VG_CH_Commission__c, VG_Bordereax_Date__c, VG_Policy_Cover_Start_Date__c, VG_Policy_Cover_End_Date__c, VG_Transaction_Type__c, VG_Payment_Terms__c, VG_Base_Premium__c, VG_Profession__c, VG_Declared_Value__c, VG_Perils__c, VG_Retention_Line__c, VG_Event_Limit__c, VG_Treaty_Limit__c, VG_Expected_Premium_Income__c, VG_Expected_Ceding_Commission__c, VG_Expected_Profit_Commission__c, VG_Ceding_Commission__c, VG_Expected_Loss_Ratio__c, VG_Min_Ceding_Commission__c, VG_Loss_Ratio_for_Min__c, VG_Max_Ceding_Commission__c, VG_Loss_Ratio_for_Max__c, VG_No_of_Surplus_Lines__c, VG_Retention__c, VG_Cession__c, VG_Perils_Text__c, VG_Information__c, VG_Retroactive_Date__c, VG_Policy_Basis__c, VG_Transaction_Effective_date__c, VG_Date_of_Birth__c, VG_Address2__c, VG_Address3__c, VG_Postcode__c, VG_Registration_Plate__c, VG_Sub_broker__c, VG_Risk_start__c, VG_Risk_End__c, VG_Attachment__c, VG_Written_Share__c, VG_Signed_Share__c, VG_CC_Information__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c=: psid]);
        if(MTAType  ==  null && ps.VG_MTA_Type__c  ==  null){
            if(Math.mod(ps.Policy__r.VG_Inception_Date__c.year(), 4) !=  0){
                if(Math.mod(ps.Policy__r.VG_Expiry_Date__c.year(), 4)  ==  0){
                    if(ps.Policy__r.VG_Expiry_Date__c <=  date.newInstance(ps.Policy__r.VG_Expiry_Date__c.year(), 02, 28)){
                        proRata = Decimal.valueOf(ps.Policy__r.VG_Inception_Date__c.daysBetween(ps.Policy__r.VG_Expiry_Date__c)+1)/365;
                    }else{
                        proRata = Decimal.valueOf(ps.Policy__r.VG_Inception_Date__c.daysBetween(ps.Policy__r.VG_Expiry_Date__c))/365;
                    }
                }else{
                    proRata = Decimal.valueOf(ps.Policy__r.VG_Inception_Date__c.daysBetween(ps.Policy__r.VG_Expiry_Date__c)+1)/365;
                }
            }else{
                if(ps.Policy__r.VG_Inception_Date__c < date.newInstance(ps.Policy__r.VG_Inception_Date__c.year(),03,01)){
                    proRata = Decimal.valueOf(ps.Policy__r.VG_Inception_Date__c.daysBetween(ps.Policy__r.VG_Expiry_Date__c))/365;
                }else{
                    proRata = Decimal.valueOf(ps.Policy__r.VG_Inception_Date__c.daysBetween(ps.Policy__r.VG_Expiry_Date__c)+1)/365;
                }
            }
        }else{
            //proRata = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
            if(Math.mod(ps.Policy__r.VG_Inception_Date__c.year(), 4) !=  0){
                if(Math.mod(ps.Policy__r.VG_Expiry_Date__c.year(), 4)  ==  0){
                    if(ps.Policy__r.VG_Expiry_Date__c <=  date.newInstance(ps.Policy__r.VG_Expiry_Date__c.year(), 02, 28)){
                        proRata = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
                    }else{
                        proRata = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365;
                    }
                }else{
                    proRata = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
                }
            }else{
                if(ps.Policy__r.VG_Inception_Date__c < date.newInstance(ps.Policy__r.VG_Inception_Date__c.year(),03,01)){
                    proRata = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365;
                }else{
                    proRata = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
                }
            }
        }
        If(MTAType != null && MTAType!='')
            psaMap.Clear();
        pseTempMap =  new Map<id, VG_Policy_Schedule_Endorsement__c>();
        pseMap =  new Map<id, VG_Policy_Schedule_Endorsement__c>([select id, Name, VG_IsTempDelete__c, VG_Endorsement_Number__c, VG_Endorsement_Library_Id__c, VG_Sub_limit__c, VG_Premium__c, VG_Endorsement_Details__c, VG_Title__c, VG_Type__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c=: PSID]);
        manualList = new List<VG_Policy_Schedule_Endorsement__c>();
        for(VG_Policy_Schedule_Endorsement__c pse: pseMap.values()){
            if(pse.VG_Endorsement_Library_Id__c  ==  null)
                manualList.add(pse);
            else
                pseTempMap.put(pse.VG_Endorsement_Library_Id__c, pse);             
        }
        RRCoverage_Select  =  new List<SelectOption>();
        Product_Select  =  new List<SelectOption>();
        Product_Select.add(new SelectOption('--None--','--None--'));
        Product_Select.add(new SelectOption('Property','Property'));
        Product_Select.add(new SelectOption('Liability','Liability'));
        Product_Select.add(new SelectOption('PA','PA'));
        Product_Select.add(new SelectOption('Legal','Legal'));
        Product_Select.add(new SelectOption('D&O','D&O'));
        splitTypes = new List<SelectOption>();            
        skipSplit = False;
        if(ps.Policy__r.VG_Inception_Date__c.year() <= 2020){
            splitTypes.add(new SelectOption('','None'));
            skipSplit = True;
        }
        splitTypes.add(new SelectOption('EEA','EEA'));
        splitTypes.add(new SelectOption('Non EEA','Non EEA'));
                
        NonEEAVolanteEntity_Select = new List<SelectOption>();
        for(String s : Label.Affinity_NonEEAVolanteEntity.split(';')){
            NonEEAVolanteEntity_Select.add(new SelectOption(s,s));
        }
        EEAVolanteEntity_Select = new List<SelectOption>();
        for(String s : Label.Affinity_EEAVolanteEntity.split(';')){
            EEAVolanteEntity_Select.add(new SelectOption(s,s));
        }
        
        LibraryWrapperList  =  new List<LibraryWrapper>();
        LibraryWrapperList1  =  new List<LibraryWrapper>();
        existingEndorsements  =  new List<VG_Policy_Schedule_Endorsement__c>();
        existingEndorsements1  =  new List<VG_Policy_Schedule_Endorsement__c>();
        Product = ps.Product__c;
        System.debug('Product::'+ps.Product__c+'Product::'+Product);
        netModelPremium = ps.Net_Premium__c ;
        RiskPremium = ps.Risk_Premium_Pro__c ;
        writtenShare  = ps.Written_share__c ;
        sharePercent = ps.Share__c;
        actualPremium = ps.Actual_GWP__c;
        brokerage = ps.VG_Brokerage_Percent__c ;
        brokerageAmount = ps.VG_Brokerage_Amount__c.setScale(2);
        grossWrittenPremium  = ps.Gross_Written_Premium__c ;
        System.debug('grossWrittenPremium::'+grossWrittenPremium+sharePercent);
        
        if(ps.Share__c  != 0)
            grossWrittenPremium2 = ps.Gross_Written_Premium__c/(ps.Share__c/100);
        else
            grossWrittenPremium2 = 0;
        adjustmentTechPremium = ps.Premium_Adjustment__c ;
        adjustment = ps.Premium_Adjustment_2__c ;
        IPTAmount = ps.IPT__c;
        IPTPercent = ps.IPT_Percent__c ;
        feeIncome = ps.VG_Fee_Income__c ;
        levies = ps.Levies__c ;
        GrossOrNet  = ps.Gross_or_Net_Premium__c ;
        sumInsured = ps.Sum_Insured__c ;
        vat = ps.VG_VAT__c;
        RateChange = ps.VG_Rate_Change__c;
        vatamount = ps.VG_VAT_Amount__c;
        taxamount = ps.VG_Witholding_Tax_Amount__c;
        uwPremium = ps.Technical_UW_Premium__c ;
        CapacityPaper = ps.VG_Capacity_Paper__c;
        techModelPremium = ps.VG_Technical_Model_Premium__c ;
        aInfo = rc.VG_Additional_Information__c;
        String[] tempDetail = aInfo.split('<br>');
        List<String> sList = new List<String>();
        if(Product=='Property')
            tempDetail.remove(10);
        for(Integer i = 0;i<tempDetail.size();i++){
            System.debug('3-1-19::'+tempDetail[i]);
            String[] tmp = tempDetail[i].split(':');
            if(tmp.size() > 1)
                sList.add(tmp[1].trim());
            else
                sList.add('');
        }
        system.debug('7-1-19::'+sList.size()+Product);
        if(Product=='Property'){
            pdtext = sList[0];
            BItext = sList[1];
            LLtext = sList[2];
            GDtext = sList[3];
            MAtext = sList[4];
            FLtext = sList[5];
            SCtext = sList[6];
            PStext = sList[7];
            AEtext = sList[8];
            if(sList[9]!=null || sList[9]!=''){ 
               IVtext = sList[9];                
               If(IVtext.contains('%')){                           
                   IVtext = IVtext.remove('%');
               }
               System.debug('IVtext::'+IVtext);  
               IVtext = IVtext+'%';                  
            }else{
                IVtext='0.00%';
            }
            GPtext = sList[10];
            GRtext = sList[11];
            ICWtext = sList[12];
            AICWtext = sList[13];
            RRtext = sList[14];
            BDtext = sList[15];
            If(sList.size()>16)
                PRRZtext = sList[16];                
            else
                PRRZtext ='';   
        }else if(Product=='Liability'){
            ELtext = sList[0];
            PPLtext = sList[1];
            PItext = sList[2];
            If(ELtext!='Not Covered'){
                APtext = sList[3];
                AENtext = sList[4];
                AERNtext = sList[5];
                AERtext = sList[6];
            }
        }else if(Product=='PA'){
            PAtext = sList[0];
            Bentext = sList[1];
            MCtext = sList[2];
            LOItext = sList[3];
            CBtext = sList[4];
            CEtext = sList[5];
            CEEtext = sList[6];
            DoEtext = sList[7];
            DrEtext = sList[8];
            FEtext = sList[9];
            HPEtext = sList[10];
            HMEtext = sList[11];
            if(sList[12]=='' || sList[12]==null){
                NAMtext='0';
            }else{
                NAMtext = sList[12];
            }
            if(sList[13]=='' || sList[13]==null){
                NJMtext='0';
            }else{
                NJMtext = sList[13];
            }
            if(sList[14]=='' || sList[14]==null){
                RCOtext='0';
            }else{
                RCOtext = sList[14];
            }
            if(sList[15]=='' || sList[15]==null){
                Clubtext='0';
            }else{
                Clubtext = sList[15];
            }
            System.debug('NAMtext::'+NAMtext+'::'+NJMtext+RCOtext+Clubtext);
        
        }else if(Product=='Legal'){
            LEtext = sList[0];
        }else if(Product=='D&O'){
            DOtext = sList[0];
        }
        counter = counterEnd = 0;
        Index='0';
        riskRatingList  =  new List<RRWrapper>();
        RRcounter = 0;
        setLPList();
        RRCalc();
        for(VG_Policy_Schedule_Asset__c psa : psaMap.values()){
            RRWrapper RRW  =  new RRWrapper();
            RRW.psa  =  psa;
            RRW.counter  =  '0';
            RRW.CoverageSelected = psa.VG_Coverage__c;
            System.debug('CoverageSelected::'+RRW.CoverageSelected+psa.VG_Coverage__c);
            RRW.PerilsSelected = psa.VG_Perils__c;
            RRW.share = 0;        
            riskRatingList.add(RRW);
            RRcounter++;
        }
        Set<ID> assetIds = new Set<ID>();
        for(VG_Policy_Schedule_Asset__c psa : psaMap.values()){
            if(psa.id  !=  null && !assetIds.contains(psa.id))
                assetIds.add(psa.id);
        }
        enableMList = true;
    }
    public void setLPList(){
       RRCoverage_Select.clear();
       if(Product=='Property'){ 
            RRCoverage_Select.add(new SelectOption('--None--','--None--'));                
            RRCoverage_Select.add(new SelectOption('Property Damage','Property Damage'));
            RRCoverage_Select.add(new SelectOption('Specified Items','Specified Items'));                               
            RRCoverage_Select.add(new SelectOption('Business Interruption','Business Interruption'));
            RRCoverage_Select.add(new SelectOption('Loss of License','Loss of License'));
            RRCoverage_Select.add(new SelectOption('Goods In Transit','Goods In Transit'));
            RRCoverage_Select.add(new SelectOption('Money','Money'));
            RRCoverage_Select.add(new SelectOption('Fidelity','Fidelity'));
        }
        if(Product=='Liability'){
            RRCoverage_Select.add(new SelectOption('--None--','--None--'));  
            RRCoverage_Select.add(new SelectOption('Employers Liability','Employers Liability'));
            RRCoverage_Select.add(new SelectOption('Public & Product Liability','Public & Product Liability'));
            RRCoverage_Select.add(new SelectOption('Professional Indemnity','Professional Indemnity'));
        }
        if(Product=='PA'){
            RRCoverage_Select.add(new SelectOption('--None--','--None--'));  
            RRCoverage_Select.add(new SelectOption('Personal Accident','Personal Accident'));
        }
        if(Product=='D&O'){
            RRCoverage_Select.add(new SelectOption('--None--','--None--'));  
            RRCoverage_Select.add(new SelectOption('D&O','D&O'));
        }
        if(Product=='Legal'){  
            RRCoverage_Select.add(new SelectOption('--None--','--None--'));               
            RRCoverage_Select.add(new SelectOption('Legal Expenses','Legal Expenses'));
        }                           
    }
    public PageReference cancel(){
         return new PageReference('/'+psid);
    }
    Public PageReference gotostep1(){
        return new PageReference('/apex/VG_Revise_LS_Step_1');
    } 
    Public PageReference gotostep2(){  
        if(Product=='' || Product ==  null || Product=='--None--'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please Select Product..'));   
            return null;
        }      
        return new PageReference('/apex/VG_Revise_LS_Step_2');
    }   
    public PageReference gotostep3(){
        /*If((PRRZtext == null || PRRZtext=='') && Product=='Property'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please give value for Pool Re Rating Zone..'));   
            return null;
        } 
        If(((APtext == null || APtext=='') || (AERNtext == null || AERNtext=='') || (AERtext == null || AERtext=='')) && Product=='Liability'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please give value for "Additional Insured,  policy type", "Additional Insured,  employer,  ERN exempt flag", "Additional Insured,  employer reference number"..'));   
            return null;
        }*/      
        return new PageReference('/apex/VG_Revise_LS_Step_3');
    }
    public PageReference gotostep4(){
        if(riskRatingList.IsEmpty()){
           ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one Risk Rating to the policy schedule..'));   
           return null;
        }
        for(RRWrapper rr : riskRatingList){
            rr.psa.VG_Coverage__c = rr.CoverageSelected;
            rr.psa.VG_Perils__c = rr.PerilsSelected;            
        }
        Map<Id, VG_Policy_Schedule_Endorsement__c> tmpPSEMap = new Map<Id, VG_Policy_Schedule_Endorsement__c>();
        for(VG_Policy_Schedule_Endorsement__c pse: existingEndorsements1){
            if(!tmpPSEMap.containsKey(pse.VG_Endorsement_Library_Id__c)){
                tmpPSEMap.put(pse.VG_Endorsement_Library_Id__c, pse);
            }
        }
        if(!existingEndorsements1.IsEmpty()){
            existingEndorsements1.clear();
        }
        ElList1=[select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where Type__c=:'Sub-limits' AND VG_Product__c=:Product AND RecordType.Name =: 'Affinity' ORDER By Name ASC];        
        LibraryWrapperList1.clear();  
         for(Endorsement_Library__c EL1 : ElList1){            
            LW1  =  new LibraryWrapper();
            LW1.EL  =  EL1;            
            LW1.isSelected  =  False;                    
            LibraryWrapperList1.add(LW1); 
        }
        return new PageReference('/apex/VG_Revise_LS_Step_4');
    }
     public PageReference gotostep4b(){
        Set<ID> elid = new Set<ID>();
        Map<Id, VG_Policy_Schedule_Endorsement__c> tmpPSEMap = new Map<Id, VG_Policy_Schedule_Endorsement__c>();
        for(VG_Policy_Schedule_Endorsement__c pe:existingEndorsements1){
            tmpPSEMap.put(pe.VG_Endorsement_Library_Id__c, pe);
        }
        existingEndorsements1.clear();
        VG_Policy_Schedule_Endorsement__c tempEndsmt;
        for(LibraryWrapper LW:LibraryWrapperList1){
            elid.add(LW.EL.Id);
            if(LW.isSelected){
                tempEndsmt  =  new VG_Policy_Schedule_Endorsement__c();
                tempEndsmt.VG_Endorsement_Details__c  =  LW.EL.Text__c;
                tempEndsmt.VG_Endorsement_Library_Id__c  =  LW.EL.Id;
                tempEndsmt.VG_Title__c  =  LW.EL.Endorsement_Title__c;
                tempEndsmt.VG_Premium__c  =  0;
                tempEndsmt.VG_Sub_limit__c  =  0;
                tempEndsmt.CurrencyISOCode  =  ps.CurrencyISOCode;
                //tempEndsmt.Name  =  PSName + '/PE/' + counterEnd;
                tempEndsmt.VG_Endorsement_Number__c  =  LW.EL.Name;
                tempEndsmt.VG_Type__c = LW.EL.Type__c;
                System.debug('Type::'+tempEndsmt.VG_Type__c+'::'+LW.EL.Type__c);
                tempEndsmt.VG_IsTempDelete__c  =  False;
                tempEndsmt.VG_IsTemp__c  =  True;
                if(MTAType  ==  'Revision of Cover'){
                    tempEndsmt.VG_Premium__c  = 0;
                    tempEndsmt.VG_Sub_limit__c  = 0;
                }
                counterEnd++;
                existingEndorsements1.add(tempEndsmt);
            }
        }        
        for(VG_Policy_Schedule_Endorsement__c pse:existingEndorsements1){
            if(tmpPSEMap.containsKey(pse.VG_Endorsement_Library_Id__c)){
                if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c  !=  0){
                    pse.VG_Premium__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c;
                }
                if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c  !=  0){
                    pse.VG_Sub_limit__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c;
                }
            }
        }
        if(existingEndorsements1.IsEmpty()){
            counterEnd  =  0;
        }else{
            counterEnd  =  existingEndorsements1.size();    
        }
       return new PageReference('/apex/VG_Revise_LS_Step_4b');
    }
    public PageReference gotostep5(){
         Map<Id, VG_Policy_Schedule_Endorsement__c> tmpPSEMap = new Map<Id, VG_Policy_Schedule_Endorsement__c>();
        for(VG_Policy_Schedule_Endorsement__c pe:existingEndorsements){
            if(pe.VG_Endorsement_Library_Id__c  !=  null && !pseTempMap.containsKey(pe.VG_Endorsement_Library_Id__c))
                tmpPSEMap.put(pe.VG_Endorsement_Library_Id__c, pe);
                System.debug('tmpPSEMap::'+tmpPSEMap.size()+'::'+pe.VG_Title__C+'::'+pe.VG_Endorsement_Library_Id__c);
        }
        for(VG_Policy_Schedule_Endorsement__c pse:existingEndorsements){
            if(pse.VG_Endorsement_Library_Id__c  ==  null)
                manualList.add(pse);
                System.debug('manualList::'+manualList.size()+'::'+pse.Name);
        }
        for(VG_Policy_Schedule_Endorsement__c pse:pseTempMap.values()){
            if(manualList.IsEmpty()){
                if(pse.VG_Endorsement_Library_Id__c  ==  null){
                    pse.VG_IsTempDelete__c  = false;
                    manualList.add(pse);
                }
                    
            }else{
                for(VG_Policy_Schedule_Endorsement__c pse1:existingEndorsements){
                    if(pse.Name  !=  pse1.Name && pse1.Name  !=  null && !(new Set<VG_Policy_Schedule_Endorsement__c>(manualList)).contains(pse1)){
                        manualList.add(pse);
                        System.debug('manualList::'+manualList.size()+'::'+pse.Name);
                    }
                }
            }
        }
        System.debug('tmpPSEMap::'+tmpPSEMap.size());
        System.debug('manualList::'+manualList.size());
        if(!existingEndorsements.IsEmpty()){
            existingEndorsements.clear();
        }
        ElList=[select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where Type__c=:'Endorsements' AND VG_Product__c=:Product AND  RecordType.Name =: 'Affinity' ORDER By Endorsement_Title__c];
        LibraryWrapperList.clear();
        for(Endorsement_Library__c EL : ElList){            
            LW  =  new LibraryWrapper();
            LW.EL  =  EL;            
            LW.isSelected  =  False;
            if(pseTempMap.containsKey(EL.id)) { 
                LW.isSelected  =  True;
            }
            if(tmpPSEMap.containsKey(EL.id)) { 
                LW.isSelected  =  True;
            }                      
            LibraryWrapperList.add(LW); 
        }
        return new PageReference('/apex/VG_Revise_LS_Step_5');
    }
     
    public PageReference gotostep5b(){
       Set<ID> elid = new Set<ID>();
        List<VG_Policy_Schedule_Endorsement__c> tmpPSEList = new List<VG_Policy_Schedule_Endorsement__c>();
        Map<Id, VG_Policy_Schedule_Endorsement__c> tmpPSEMap = new Map<Id, VG_Policy_Schedule_Endorsement__c>();
        for(VG_Policy_Schedule_Endorsement__c pe:existingEndorsements){
            tmpPSEMap.put(pe.VG_Endorsement_Library_Id__c, pe);
            if(pe.VG_Endorsement_Library_Id__c == null)tmpPSEList.add(pe);
        }
        existingEndorsements.clear();
        VG_Policy_Schedule_Endorsement__c tempEndsmt;
        for(LibraryWrapper LW:LibraryWrapperList){
            elid.add(LW.EL.Id);
            if(LW.isSelected){
                tempEndsmt  =  new VG_Policy_Schedule_Endorsement__c();
                tempEndsmt.VG_Endorsement_Library_Id__c  = LW.EL.Id;
                if(tmpPSEMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Endorsement_Details__c  =  tmpPSEMap.get(LW.EL.Id).VG_Endorsement_Details__c; 
                }else if(pseTempMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Endorsement_Details__c  =  pseTempMap.get(LW.EL.Id).VG_Endorsement_Details__c; 
                }else{
                    tempEndsmt.VG_Endorsement_Details__c  =  LW.EL.Text__c;                
                }
                if(tmpPSEMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Title__c  =  tmpPSEMap.get(LW.EL.Id).VG_Title__c ; 
                    tempEndsmt.VG_Endorsement_Details__c  =  tmpPSEMap.get(LW.EL.Id).VG_Endorsement_Details__c; 
                }else if(pseTempMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Title__c  =  pseTempMap.get(LW.EL.Id).VG_Title__c ; 
                    tempEndsmt.VG_Endorsement_Details__c  =  pseTempMap.get(LW.EL.Id).VG_Endorsement_Details__c; 
                }else{
                    tempEndsmt.VG_Title__c  =  LW.EL.Endorsement_Title__c;     
                }
                if(pseTempMap.containsKey(LW.EL.Id))
                    tempEndsmt.VG_Premium__c  =  pseTempMap.get(LW.EL.Id).VG_Premium__c;
                else
                    tempEndsmt.VG_Premium__c  = 0;
                if(pseTempMap.containsKey(LW.EL.Id))
                    tempEndsmt.VG_Sub_limit__c  =  pseTempMap.get(LW.EL.Id).VG_Sub_limit__c;
                else
                    tempEndsmt.VG_Sub_limit__c  = 0;
                tempEndsmt.VG_Endorsement_Number__c  =  LW.EL.Name;
                tempEndsmt.VG_Type__c = LW.EL.Type__c;
                System.debug('Type::'+tempEndsmt.VG_Type__c+'::'+LW.EL.Type__c);
                tempEndsmt.VG_IsTempDelete__c  =  False;
                tempEndsmt.VG_IsTemp__c  =  True;
                if(MTAType  ==  'Revision of Cover'){
                    tempEndsmt.VG_Premium__c  = 0;
                    tempEndsmt.VG_Sub_limit__c  = 0;
                }
                counterEnd++;
                existingEndorsements.add(tempEndsmt);
            }
        }        
       for(VG_Policy_Schedule_Endorsement__c pse:tmpPSEList){
            existingEndorsements.add(pse);
        }
        for(VG_Policy_Schedule_Endorsement__c pse:manualList){
            existingEndorsements.add(pse);
        }
        manualList.clear();
        for(VG_Policy_Schedule_Endorsement__c pse:existingEndorsements){
            If(pse.VG_Endorsement_Library_Id__c!=null){
                if(tmpPSEMap.containsKey(pse.VG_Endorsement_Library_Id__c)){           
                    if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c !=  0){
                        pse.VG_Premium__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c;
                    }
                    if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c !=  0){
                        pse.VG_Sub_limit__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c;
                    }
                }
            }
        }           
        if(existingEndorsements.IsEmpty()){
            counterEnd  =  0;
        }else{
            counterEnd  =  existingEndorsements.size();    
        }       
       return new PageReference('/apex/VG_Revise_LS_Step_5b');
    }
     public PageReference gotostep6(){
        endorsementPremium  =  0;
        TSI = 0;
        for(VG_Policy_Schedule_Endorsement__c en : existingEndorsements){
            endorsementPremium  =  endorsementPremium + en.VG_Premium__c;
        }
        RiskPremium = 0;
        for(RRWrapper rrw: riskRatingList){                  
            RiskPremium  =  RiskPremium + rrw.psa.VG_Premium__c;
            If(rrw.psa.VG_Sum_Insured__c != null){
                TSI = TSI+rrw.psa.VG_Sum_Insured__c;
            }         
        }        
        if(MTAType  ==  'Revision of Cover'){
            If(seletedProrateoption=='Flat'){
                RiskPremium  =  RiskPremium;
                EndorsementPremium  =  EndorsementPremium;                
            }else If(seletedProrateoption=='Prorated'){
                RiskPremium  =  RiskPremium * proRata;
                EndorsementPremium  =  EndorsementPremium * proRata;
            }
        }else{
            RiskPremium  =  RiskPremium * proRata;
            EndorsementPremium  =  EndorsementPremium * proRata;
        }
        netModelPremium  =  RiskPremium + EndorsementPremium;
        UpdateFinalCalculations();
        return new PageReference('/apex/VG_Revise_LS_Step_6');
    }
    public PageReference finish(){
        ps.Product__c = Product;
        System.debug('Product::'+ps.Product__c+'Product::'+Product);
        ps.Net_Premium__c  =  netModelPremium;
        ps.Endorsement_Premium_Pro__c = endorsementPremium;
        ps.Risk_Premium_Pro__c  =  RiskPremium;
        ps.Written_share__c  =  writtenShare ;
        ps.Share__c = sharePercent;
        ps.Actual_GWP__c = actualPremium;
        ps.VG_Brokerage_Percent__c  =  brokerage;
        ps.VG_Brokerage_Amount__c = brokerageAmount;
        If(RateChange == 0.00 && ps.Policy__r.VG_Is_Renewal__c== false)       
            ps.VG_Rate_Change__c   =   null;
        else
            ps.VG_Rate_Change__c   =  RateChange;
        ps.Gross_Written_Premium__c  =  grossWrittenPremium2 ;
        ps.VG_Gross_Written_Premium_100__c  =  grossWrittenPremium;
        ps.Premium_Adjustment__c  =  adjustmentTechPremium;
        ps.Premium_Adjustment_2__c  =  adjustment;
        ps.IPT__c = IPTAmount;
        ps.IPT_Percent__c  =  IPTPercent;
        ps.VG_Fee_Income__c  =  feeIncome;
        ps.Levies__c  =  levies;
        ps.Gross_or_Net_Premium__c  =  GrossOrNet ;
        ps.Sum_Insured__c  =  sumInsured;
        ps.VG_Capacity_Paper__c  =  CapacityPaper;
        ps.VG_VAT__c = vat;
        ps.VG_VAT_Amount__c = vatamount;
        ps.VG_Witholding_Tax_Amount__c = taxamount;
        ps.Technical_UW_Premium__c  =  uwPremium;
        if(ps.VG_MTA_Type__c != 'Revision of Cover'){
            ps.Base_Creation_Start_Date__c  =  ps.Policy__r.VG_Inception_Date__c;
            ps.Base_Creation_End_Date__c  =  ps.Policy__r.VG_Expiry_Date__c;   
        }
        if(ps.VG_MTA_Type__c == 'Revision of Cover'){
            ps.Base_Creation_Start_Date__c = ps.VG_MTA_Start_Date__c;
            ps.Base_Creation_End_Date__c = ps.VG_MTA_End_Date__c;    
        }
        ps.VG_Base_Policy__c = true;       
        ps.VG_Technical_Model_Premium__c  =  techModelPremium;
        if(MTAType !=  'Revision of Cover'){
            ps.Name = ps.Name.remove('/EEA').remove('/NonEEA');
            if(ps.Split_Type__c == 'EEA'){
                ps.Name += '/EEA';
            }else if(ps.Split_Type__c == 'Non EEA'){
                ps.Name += '/NonEEA';            
            } 
            update ps;                                
        }
        rc.VG_Additional_Information__c='';
        if(Product=='Property'){
            rd='Property Damage : '+pdText+'<br/>';
            rd+='Business Interruption : '+BItext+'<br/>';
            rd+='Loss of Licence  : '+LLtext+'<br/>';
            rd+='Goods in Transit :'+GDtext+'<br/>';
            rd+='Money and Assault  :'+MAtext+'<br/>';
            rd+='Fidelity :'+FLtext+'<br/>';
            rd+='Subsidence Cover :'+SCtext+'<br/>';
            rd+='Playing Surfaces :'+PStext+'<br/>';
            rd+='Terrorism :'+AEtext+'<br/>';
            If(IVtext.contains('%')){
                IVtext = IVtext.remove('%');                
            }
            rd+='Inflation Value :'+IVtext+'%'+'<br/>';
            rd+='<b>'+'Business Interruption | Max Indemnity Period'+'</b><br/>';
            rd+='Gross Profit :'+GPtext+'<br/>';
            rd+='Gross Revenue :'+GRtext+'<br/>';
            rd+='Increased Cost of Working :'+ICWtext+'<br/>';
            rd+='Additional Increased cost of working :'+AICWtext+'<br/>';
            rd+='Rent Receivable :'+RRtext+'<br/>';            
            rd+='Book Debts :'+BDtext+'<br/>';
            rd+='Pool Re Rating Zone :'+PRRZtext+'<br/>';
        }else if(Product=='Liability'){
            rd='Employer’s Liability :'+ELtext+'<br/>';
            rd+='Public and Products Liability :'+PPLtext+'<br/>';
            rd+='Professional Indemnity :'+PItext+'<br/>';
            If(ELtext!='Not Covered'){
                rd+='Additional Insured,  policy type:'+APtext+'<br/>';
                rd+='Additional Insured,  employer name:'+AENtext+'<br/>';
                rd+='Additional Insured,  employer,  ERN exempt flag:'+AERNtext+'<br/>';
                rd+='Additional Insured,  employer reference number:'+AERtext+'<br/>';
            }   
        }else if(Product=='PA'){
            rd='Personal Accident :'+PAtext+'<br/>';
            rd+='Benefit :'+Bentext+'<br/>';
            rd+='Medical Costs :'+MCtext+'<br/>';
            rd+='Loss of Income :'+LOItext+'<br/>';
            rd+='Coma Benefit :'+CBtext+'<br/>';
            rd+='Childcare Expenses :'+CEtext+'<br/>';
            rd+='Continued Education Expenses :'+CEEtext+'<br/>';
            rd+='Domestic Expenses :'+DoEtext+'<br/>';
            rd+='Driver Expenses :'+DrEtext+'<br/>';
            rd+='Funeral Expenses :'+FEtext+'<br/>';
            rd+='Hospital In-Patents Expenses  :'+HPEtext+'<br/>';
            rd+='Home Modification Expenses  :'+HMEtext+'<br/>';
            rd+='Number of adult members :'+NAMtext+'<br/>';
            rd+='Number of Junior members :'+NJMtext+'<br/>';
            rd+='Referees / coaches / Officials :'+RCOtext+'<br/>';
            rd+='Clubs :'+Clubtext+'<br/>';
           
        }else if(Product=='D&O'){
            rd='Directors & Officers Liability :'+DOtext+'<br/>';
        }else if(Product=='Legal'){
            rd='Legal Expenses :'+LEtext+'<br/>';
        }
        System.debug('Test::'+rd);
        rc.VG_Additional_Information__c = rd;
        if(MTAType  !=  'Revision of Cover'){
            RC.Name =  ps.Name+'/RD/1';
            Update rc; 
        }
        List<VG_Policy_Schedule_Endorsement__c> endToBeUpdated  =  new List<VG_Policy_Schedule_Endorsement__c>();
        List<VG_Policy_Schedule_Endorsement__c> endToBeInserted  =  new List<VG_Policy_Schedule_Endorsement__c>();
        Set<ID> pseIds = new Set<ID>();
        for(VG_Policy_Schedule_Endorsement__c pse : pseMap.values()){
            pseIds.add(pse.id);
        }
        for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements){
            if(pse.id == null){
                endToBeInserted.add(pse);
            }else{
                VG_Policy_Schedule_Endorsement__c tmp =  new VG_Policy_Schedule_Endorsement__c ();
                tmp.id = pse.id;
                tmp = pse;
                endToBeUpdated.add(tmp);
                pseIds.remove(pse.id);
            }
        }
        for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements1){
            if(pse.id == null){
                endToBeInserted.add(pse);
            }else{
                VG_Policy_Schedule_Endorsement__c tmp =  new VG_Policy_Schedule_Endorsement__c ();
                tmp.id = pse.id;
                tmp = pse;
                endToBeUpdated.add(tmp);
                pseIds.remove(pse.id);
            }
        }
        
        Integer psecount = 1;
        Integer psesbcount = 1;
        if(!endToBeUpdated.IsEmpty()){
            for(VG_Policy_Schedule_Endorsement__c pse : endToBeUpdated){
                if(pse.VG_Type__c  ==  'Endorsements'){
                    pse.Name = ps.Name+'/PE/'+psecount;
                    psecount++;
                }else{
                    pse.Name = ps.Name+'/PESB/'+psesbcount;
                    psesbcount++;
                }
            }
        }
        if(!endToBeInserted.IsEmpty()){
            for(VG_Policy_Schedule_Endorsement__c pse : endToBeInserted){
                if(pse.VG_Type__c  ==  'Endorsements'){
                    pse.Name = ps.Name+'/PE/'+psecount;
                    psecount++;
                }else{
                    pse.Name = ps.Name+'/PESB/'+psesbcount;
                    psesbcount++;
                }
                pse.VG_Policy_Schedule__c = ps.id;
                pse.CurrencyISOCode = ps.CurrencyISOCode;
            }
        }
        if(MTAType  !=  'Revision of Cover'){
            if(pseIds.size() > 0){
                List<VG_Policy_Schedule_Endorsement__c> endToBeDeleted  =  new List<VG_Policy_Schedule_Endorsement__c>([select id from VG_Policy_Schedule_Endorsement__c where id IN: pseIds]);
                Delete endToBeDeleted;
            }
            if(!endToBeUpdated.IsEmpty()){
                update endToBeUpdated;
            }
            if(!endToBeInserted.IsEmpty()){
                insert endToBeInserted;
            }
        }
        List<VG_Policy_Schedule_Asset__c> assetToBeInserted  =  new List<VG_Policy_Schedule_Asset__c>();
        List<VG_Policy_Schedule_Asset__c> assetToBeUpdated  =  new List<VG_Policy_Schedule_Asset__c>();        
        Set<ID> psaIds = new Set<ID>();
        for(VG_Policy_Schedule_Asset__c psa: psaMap.values()){
            psaIds.add(psa.id);
        }
        for(RRWrapper rrw : riskRatingList){
            if(rrw.psa.id == null){
                assetToBeInserted.add(rrw.psa);
            }else{
                assetToBeUpdated.add(rrw.psa);
                psaIds.remove(rrw.psa.id);
            }
        }
        Integer psacount = 1;
         if(!assetToBeUpdated.IsEmpty()){
            for(VG_Policy_Schedule_Asset__c psa : assetToBeUpdated){
                psa.Name = ps.Name+'/RR/'+psacount;
                psacount++;
            }
        }
        if(!assetToBeInserted.IsEmpty()){
            for(VG_Policy_Schedule_Asset__c psa : assetToBeInserted){
                psa.Name = ps.Name+'/RR/'+psacount;
                psa.VG_Policy_Schedule__c = ps.id;
                psa.CurrencyISOCode = ps.CurrencyISOCode;
                psacount++;
            }
        }
        if(MTAType  !=  'Revision of Cover'){
            if(psaIds.size() > 0){
                List<VG_Policy_Schedule_Asset__c > assetToBeDeleted  =  new List<VG_Policy_Schedule_Asset__c >([select id from VG_Policy_Schedule_Asset__c where id IN: psaIds]);
                Delete assetToBeDeleted;
            }
            if(!assetToBeUpdated.IsEmpty()){
                Update assetToBeUpdated;
            }
            if(!assetToBeInserted.IsEmpty()){
                insert assetToBeInserted;
            }
            return new PageReference('/'+ps.Id);
         }else{
            List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([select id, Name, Policy__r.Name from Policy_Schedule__c where Policy__c=:ps.Policy__c]);
            Policy_Schedule__c rocps = new Policy_Schedule__c();
            rocps = ps;
            rocps.VG_Is_MTA__c = true;
            rocps.VG_Base_Policy__c = true;            
            rocps.VG_MTA_Type__c='Revision of Cover';
            rocps.id = null;
            rocps.VG_MTA_Start_Date__c = Date.valueOf(MTAStartDate);
            rocps.VG_MTA_End_Date__c = ps.Policy__r.VG_Expiry_Date__c;
            rocps.Base_Creation_Start_Date__c = rocps.VG_MTA_Start_Date__c;
            rocps.Base_Creation_End_Date__c = rocps.VG_MTA_End_Date__c;
            rocps.VG_Status__c='Draft';
            rocps.IPT__c = null;
            rocps.IPT_Percent__c = null;
            rocps.MTA_Parent_Policy_Schedule__c = psid;           
            integer tmp;
            String[] tempDetail;
            if(psList.size() > 0){
                List<Integer> psNumList=new List<Integer>();
                for(Policy_Schedule__c psh: psList){
                    psh.Name = psh.Name.remove('/EEA').remove('/NonEEA');
                    if(psh.Name.contains('/PS/'))
                        psNumList.add(Integer.valueOf(psh.Name.split('/PS/')[1]));
                    else if(psh.Name.contains('/MTA/'))
                        psNumList.add(Integer.valueOf(psh.Name.split('/MTA/')[1]));
                }
                psNumList.sort();
                rocps.Name  =  ps.Policy__r.Name+'/MTA/'+((psNumList[psNumList.size()-1])+1);        
            }else{
                rocps.Name  =  ps.Policy__r.Name+'/MTA/0';    
            }   
            if(rocps.Split_Type__c == 'EEA'){
                rocps.Name += '/EEA';
            }else if(rocps.Split_Type__c == 'Non EEA'){
                rocps.Name += '/NonEEA';
            }else{
                rocps.VG_Volante_Entities__c='';
            }       
            insert rocps; 
            List<Policy_Schedule__c> TriggerNew  =  new List<Policy_Schedule__c>();
            TriggerNew.add(rocps);
            PolicyScheduleTriggerFunction.allowInsertRI  =  True;
            PolicyScheduleTriggerFunction.createRIRecords(TriggerNew);
            Risk_Capture__c rocrc = new Risk_Capture__c();
            rocrc = rc;
            rocrc.id = null;
            rocrc.Name = rocps.Name+'/RD/1';
            rocrc.Policy_Schedule__c = rocps.id;
            insert rocrc;            
            List<VG_Policy_Schedule_Endorsement__c> rocend =  new List<VG_Policy_Schedule_Endorsement__c>();
            rocend.addAll(endToBeUpdated);
            rocend.addAll(endToBeInserted);
            Integer psecounter = 1;
            Integer psesbcounter = 1;
            if(!rocend.IsEmpty()){
                for(VG_Policy_Schedule_Endorsement__c pse : rocend){
                    pse.id = null;
                    pse.VG_Policy_Schedule__c = rocps.id;
                    if(pse.VG_Type__c  ==  'Endorsements'){
                        pse.Name = rocps.Name+'/PE/'+psecounter;
                        psecounter++;
                    }else{
                        pse.Name = rocps.Name+'/PESB/'+psesbcounter;
                        psesbcounter++;
                    }
                }
                Insert rocend;
            }
            List<VG_Policy_Schedule_Asset__c> rocpsa =  new List<VG_Policy_Schedule_Asset__c>();
            rocpsa.addAll(assetToBeUpdated);
            rocpsa.addAll(assetToBeInserted);
            Integer psacounter = 1;
            if(!rocpsa.IsEmpty()){
                for(VG_Policy_Schedule_Asset__c  psa : rocpsa){
                    psa.id = null;
                    psa.VG_Policy_Schedule__c = rocps.id;
                    psa.Name = rocps.Name+'/RR/'+psacounter;
                    psacounter++;                   
                }
                Insert rocpsa;
            }
            return new PageReference('/'+rocps.Id);
         }          
    }
     public void UpdateFinalCalculations(){
        If(RateChange==0.00 && ps.Policy__r.VG_Is_Renewal__c == false)
            RateChange=null;
        sumInsured = TSI*(sharePercent/100)  ;
        uwPremium = netModelPremium+adjustmentTechPremium;
        grossWrittenPremium  = uwPremium+adjustment;
         If(sharePercent != 0 && sharePercent != null)
            grossWrittenPremium2  = grossWrittenPremium*(sharePercent/100); 
        brokerageAmount  =  (grossWrittenPremium2 *(brokerage/100)).setScale(2);
        actualPremium = grossWrittenPremium2 -brokerageAmount;
        techModelPremium=(sharePercent/100)*netModelPremium;
        vatamount=(vat/100)*feeIncome;
        /*If(IPTPercent != null){
            IPTAmount = grossWrittenPremium*(IPTPercent/100);
        }
        If(GrossOrNet  ==  'Gross'){
            transactionPremium = grossWrittenPremium+grossWrittenPremium+feeIncome;
        }else{
            transactionPremium = actualPremium+grossWrittenPremium+feeIncome;
        }*/ 
    }
    public void RemoveCustom(){
        List<VG_Policy_Schedule_Endorsement__c> newPSEList = new List<VG_Policy_Schedule_Endorsement__c>();
        newPSEList.addAll(existingEndorsements);
        existingEndorsements.clear();
        for(VG_Policy_Schedule_Endorsement__c pse: newPSEList){
            if(!pse.VG_IsTempDelete__c){
                existingEndorsements.add(pse);
            }
        }
    }
    public void AddCustom(){
        VG_Policy_Schedule_Endorsement__c tempEndsmt  =  new VG_Policy_Schedule_Endorsement__c();
        tempEndsmt.CurrencyISOCode  =  ps.CurrencyISOCode;
        tempEndsmt.VG_Premium__c  =  0;
        tempEndsmt.VG_Sub_limit__c = 0;
        tempEndsmt.VG_Type__c='Endorsements';
        existingEndorsements.add(tempEndsmt);
    }
    public void addRR(){
        Boolean allOkToTaddNewAsset  =  True;
        RRWrapper waNew = new RRWrapper();
        waNew.Counter = string.valueOf(RRcounter);            
        if(allOkToTaddNewAsset){
            VG_Policy_Schedule_Asset__c psaNew = new VG_Policy_Schedule_Asset__c();
            psaNew.CurrencyISOCode  =  ps.CurrencyISOCode;
            psaNew.VG_Base_Premium__c = 0;
            psaNew.VG_Base_Premium_Rate__c = 0;
            psaNew.VG_Premium__c = 0;
            psaNew.CurrencyISOCode  =  ps.CurrencyISOCode;
            waNew.psa = psaNew;
            riskRatingList.add(waNew);
            RRcounter++;
        }
        System.debug('riskRatingList::'+riskRatingList.size()+'::'+riskRatingList);
    }
    public void RRCalc(){           
        for(RRWrapper rrw:riskRatingList){
          If(Product!='PA'){               
            If(rrw.psa.VG_Base_Premium_Rate__c != null && rrw.psa.VG_Declared_Value__c != null) 
                rrw.psa.VG_Premium__c=(rrw.psa.VG_Base_Premium_Rate__c/100)*rrw.psa.VG_Declared_Value__c; 
          }else{
            If(rrw.psa.VG_Base_Premium_Rate__c != null && rrw.psa.VG_Declared_Value__c != null) 
                rrw.psa.VG_Premium__c=(rrw.psa.VG_Base_Premium_Rate__c)*rrw.psa.VG_Declared_Value__c; 
          }
        }
    }
    public void RemoveRR(){
        riskRatingList.remove(integer.valueOf(Index));
        RRcounter = 0;
        System.debug('riskRatingList::'+riskRatingList.size()+'::'+riskRatingList);
        for(RRWrapper temp : riskRatingList){
            temp.Counter = String.valueOf(RRcounter);
            RRcounter++;
        }
        if(riskRatingList.IsEmpty()){
           ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one asset to the policy schedule..'));   
        }
    }
    public class RRWrapper{
        public VG_Policy_Schedule_Asset__c psa{get;set;}
        public String Counter{get;set;}
        public Decimal share {get; set;}
        public Decimal totalfeeAmt {get; set;}
        public String CoverageSelected{get;set;}
        public String PerilsSelected{get;set;}
        public String TerritorialLimitsSelected{get;set;}
        public Decimal techPremium{get;set;}
       
    }
    Public Class LibraryWrapper{
        Public Endorsement_Library__c EL {get; set;}
        Public Boolean isSelected {get; set;} 
        
        Public LibraryWrapper(){
            EL  =  new Endorsement_Library__c();
            isSelected  =  False;
        }
    }
}