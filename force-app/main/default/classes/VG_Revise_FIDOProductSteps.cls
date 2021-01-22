Public Class VG_Revise_FIDOProductSteps{
    
    Public Id PSID {get; set;}
    public Id EEAPSID {get; set;}
    public Id NonEEAPSID {get; set;}
    public Id policyId {get; set;}
    
    Public Risk_Capture__c rc{get;set;}
    Public Policy__c policy{get;set;}
    Public Policy_Schedule__c ps {get; set;} 
    public Policy_Schedule__c NonEEAps {get; set;}
    public Policy_Schedule__c EEAps {get; set;}
    public Policy_Schedule__c tempPS{get; set;} 
    public Policy_Schedule__c DatePS{get; set;}
    public Policy_Schedule__c BrexitPS{get; set;}
    
    Public Boolean EnableReinstatement{get;set;}
    Public Boolean hasEndorsements {get; set;}
    Public Boolean stopProcess{get; set;}
    Public Boolean showSplitType {get; set;}
    Public Boolean skipSplit {get; set;}
    
    Public Integer RRcounter {get; set;}
    Public Integer counter{get;set;}
    Public Integer counterEnd {get; set;}
    
    public String bsname{get;set;}
    Public String layer {get; set;}
    Public String GrossOrNet {get; set;}
    Public String Index{get;set;}
    Public String LProduct{get;set;}
    Public String Product{get;set;}
    Public String policyCurrency {get; set;}
    Public string CapacityPaper{get;set;}
    Public String IndustrySelected {get; set;}
    Public String MTAType{get;set;}
    Public String MTAStartDate{get;set;}
    Public String MTAEndDate{get;set;}
    Public String DOProduct{get; set;}
    Public String CompanyType {get; set;}
    Public String seletedProrateoption {get; set;}  
    Public String sideBRententionCurrency{get;set;}
    Public String sideCRententionCurrency{get;set;}
    
    Public decimal proRata{get;set;}    
    Public decimal sideBAmount{get;set;}
    Public decimal sideCAmount{get;set;}
    Public decimal sideBRentention{get;set;}
    Public decimal sideCRentention{get;set;}
    Public decimal totalFeeAmount{get;set;}
    Public decimal totalbasepremium{get;set;}
    Public decimal totalbasepremiumrate{get;set;}
    Public Decimal netModelPremium {get; set;}
    Public Decimal RiskPremium {get;set;}
    Public Decimal lmt {get;set;}
    Public Decimal attachment {get;set;}
    Public Decimal adjustment {get;set;}
    Public Decimal writtenShare {get; set;}
    Public Decimal actualPremium {get; set;}
    Public Decimal sumInsured {get; set;}
    Public Decimal brokerage {get; set;}
    Public Decimal uwPremium {get; set;}
    Public Decimal levies {get; set;}
    Public Decimal RateChange {get;set;}
    Public Decimal brokerageAmount {get; set;}
    Public Decimal grossWrittenPremium {get; set;}
    Public Decimal grossWrittenPremium2 {get; set;}
    Public Decimal feeIncome {get; set;}
    Public Decimal IPTAmount {get; set;}
    Public Decimal IPTPercent {get; set;}
    Public Decimal sharePercent {get; set;}
    Public Decimal vat {get; set;}
    Public Decimal vatamount {get; set;}
    Public Decimal techModelPremium {get; set;}
    Public Decimal adjustmentTechPremium {get; set;}
    Public Decimal taxamount {get; set;}     
    Public Decimal endorsementPremium {get; set;}         
    Public decimal retention{get;set;}
    Public decimal deminimis{get;set;}
    
    Public list<Integer> createLoop {get; set;}
    Public List<RRWrapper> riskRatingList {get; set;}
    public list<SelectOption> NonEEAVolanteEntity_Select {get; set;}
    public list<SelectOption> EEAVolanteEntity_Select {get; set;}
    public list<SelectOption> VFPsectionNoList {get; set;}
    Public list<SelectOption> Product_Select {get; set;}
    Public list<SelectOption> Profession_Select{get; set;}
    Public List<SelectOption> splitTypes{get; set;}
    Public list<SelectOption> LP_Select {get; set;}
    Public list<SelectOption> RRCoverage_Select {get; set;}
    Public list<SelectOption> Industry_Select {get; set;}
    Public list<SelectOption> CompanyType_Select {get; set;}
    Public list<SelectOption> FI_Industry_Select {get; set;}
    Public list<SelectOption> SideCurrencies{get; set;}
    Public list<SelectOption> DOProduct_Select {get; set;}
    Public list<SelectOption> CapacityPaperList {get; set;}
    Public List<Integer> NOIList{get;set;}
    Public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    Public List<Endorsement_Library__c> ElList1{get;set;}
    Public List<Endorsement_Library__c> ElList{get;set;} 
    Public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements1 {get; set;}
    Public List<LibraryWrapper> LibraryWrapperList1 {get; set;}
    Public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements {get; set;}
    Public List<LibraryWrapper> LibraryWrapperList {get; set;}
    Public List<VG_Policy_Schedule_Endorsement__c> manualList{get;set;}
    
    Public LibraryWrapper LW1{get;set;}
    Public LibraryWrapper LW{get;set;}
    
    Public Map<id,VG_Policy_Schedule_Endorsement__c> pseTempMap{get;set;}
    Public Map<id,VG_Policy_Schedule_Endorsement__c> pseMap{get;set;}
    Public Map<id,VG_Policy_Schedule_Asset__c> psaMap{get;set;}
    Public Map<String, CurrencyType> currencyRateMap{get;set;}
    
    Public VG_Revise_FIDOProductSteps(){
      stopProcess = false;
      try{
        MTAType=apexpages.currentpage().getparameters().get('MTAType');
        MTAStartDate=apexpages.currentpage().getparameters().get('MTAStartDate');
        MTAEndDate=apexpages.currentpage().getparameters().get('MTAEndDate');       
        seletedProrateoption  = apexpages.currentpage().getparameters().get('seletedProrateoption');               
        PSID = apexpages.currentpage().getparameters().get('Id');
        NonEEAps   =   new Policy_Schedule__c(); 
        EEAps  =   new Policy_Schedule__c(); 
        ps = [select id, Name, Policy__r.Name, MTA_Parent_Policy_Schedule__c, VG_Is_MTA__c, VG_Entity_Split_Required__c,Base_Creation_Start_Date__c, VG_Gross_Written_Premium_100__c, VG_Entity_Share__c,VG_Risk_Start_Date__c,VG_Risk_End_Date__c,VG_MTA_End_Date__c,VG_Type_Of_Operation__c,Base_Creation_End_Date__c,VG_Rate_Change__c, VG_Side_C_Retention_Currency__c,VG_Side_B_Retention_Currency__c,VG_Side_B_Rentention__c, VG_Side_C_Rentention__c, VG_D_O_Product__c, VG_MTA_Type__c, VG_MTA_Start_Date__c, Endorsement_Premium_Pro__c, Policy__c, CurrencyISOCode, Policy__r.VG_Expiry_Date__c, Policy__r.VG_Inception_Date__c, VG_Capacity_Paper__c, Product__c, VG_Lloyds_Product__c, Net_Premium__c , Risk_Premium_Pro__c, Limit__c, Attachment__c, ILF_Layer__c, Written_share__c, Share__c, Actual_GWP__c, VG_Brokerage_Percent__c, Gross_or_Net_Premium__c, VG_Technical_Model_Premium__c, Technical_UW_Premium__c, VG_Witholding_Tax_Amount__c, VG_VAT_Amount__c, VG_VAT__c, Sum_Insured__c, Levies__c, VG_Fee_Income__c, VG_Brokerage_Amount__c, Gross_Written_Premium__c, Transaction_GWP__c, Premium_Adjustment__c, Premium_Adjustment_2__c, IPT__c, IPT_Percent__c, Split_Type__c, VG_Volante_Entities__c from Policy_Schedule__c where id = : PSID limit 1];
        policy = [select id, Name, Insured__c,VG_Is_Renewal__c,VG_Inception_Date__c, VG_Volante_Entities__c, CurrencyIsoCode, VG_Expiry_Date__c from Policy__c where id = :ps.Policy__c limit 1];
        rc = [select id, Name, VG_Industry__c,VG_Proposal_form_date__c,VG_Profession__c,VG_Buyer__c,VG_Completion_Date__c,VG_De_Minimis_of_EV__c,De_Minimis_description__c,VG_Governing_Law_of_Sale_Agreement__c,VG_Endorsed__c,VG_De_Minimis_Amount__c,VG_De_Minimis_Applicable_to_all_risks__c,VG_Enterprise_Value__c,VG_Expense_Agreement_Amount__c,VG_Expense_Agreement_t_Amount_Tax__c,VG_Retention_of_EV__c,VG_Retention_Amount__c,VG_Retention_Applicable_to_all_risks__c,VG_Retention_Fixed_or_Tipping__c,VG_Retention_description__c,VG_Sector__c,VG_Seller__c,VG_Target__c,VG_Company_Type__c,VG_Company_Domicile__c,VG_Revenue__c,VG_Total_Assets__c,VG_Market_Cap__c,VG_Net_Profit__c,VG_Net_Equity__c,VG_Headcount__c,VG_Class_1_Employees__c,VG_No_of_Reinstatements__c,VG_Reinstatement_Premium__c,VG_Fees_Current_Year__c,VG_Fees_Year_1__c,VG_Fees_Year_2__c,VG_Fees_Year_3__c,VG_Dispute_Clause__c,VG_Reinstatement_Premiums__c from Risk_Capture__c where Policy_Schedule__c=:PSID limit 1];
        psaMap = new Map<id,VG_Policy_Schedule_Asset__c>([select id,Name,Asset__c,VG_Sum_Insured__c,VG_Territorial_Limits__c,VG_Share__c,VG_Deductible__c,VG_Sub_limit__c,VG_Premium__c,VG_Base_Premium_Rate__c ,VG_Profession__c,VG_Fee_Amounts__c,VG_Base_Premium__c,VG_Coverage__c ,VG_Coverage_Type__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =: PSID]);
        policyId = ps.Policy__c;
        ps.Split_Type__c = ps.Split_Type__c == null ? '' : ps.Split_Type__c;
        if(ps.VG_MTA_Type__c != 'Cancellation' && ps.VG_MTA_Type__c != 'Extension' && ps.VG_MTA_Type__c != 'Reduction'){
            showSplitType = True;
        }else{
            showSplitType = False;
        }
        if(ps.Name.contains('/NonEEA')){
            bsName = ps.Name.replace('/NonEEA', '/EEA');
        }else{
            bsName = ps.Name.replace('/EEA', '/NonEEA');
        }
        Set<String> bsNamesSet = new Set<String>();
        bsNamesSet.add(ps.Name);
        bsNamesSet.add(bsName);
        List<Policy_Schedule__c> entityPS = [select id, Name, VG_Type_Of_Operation__c, VG_Gross_Written_Premium_100__c, VG_MTA_End_Date__c,VG_Risk_Start_Date__c,VG_Risk_End_Date__c,Policy__r.VG_Is_Renewal__c,Policy__r.Name, Base_Creation_End_Date__c,VG_Rate_Change__c, VG_Side_B_Rentention__c, VG_Side_C_Rentention__c, VG_D_O_Product__c, VG_MTA_Type__c, VG_MTA_Start_Date__c, Endorsement_Premium_Pro__c, Policy__c, CurrencyISOCode, Policy__r.VG_Expiry_Date__c, Policy__r.VG_Inception_Date__c, VG_Capacity_Paper__c, Product__c, VG_Lloyds_Product__c, Net_Premium__c , Risk_Premium_Pro__c, Limit__c, Attachment__c, ILF_Layer__c, Written_share__c, Share__c, Actual_GWP__c, VG_Brokerage_Percent__c, Gross_or_Net_Premium__c, VG_Technical_Model_Premium__c, Technical_UW_Premium__c, VG_Witholding_Tax_Amount__c, VG_VAT_Amount__c, VG_VAT__c, Sum_Insured__c, Levies__c, VG_Fee_Income__c, VG_Brokerage_Amount__c, Gross_Written_Premium__c, Transaction_GWP__c, Premium_Adjustment__c, Premium_Adjustment_2__c, IPT__c, IPT_Percent__c,VG_Entity_Share__c,VG_Entity_Split_Required__c, VG_Volante_Entities__c, Split_Type__c from Policy_Schedule__c where Name IN : bsNamesSet];
        for(Policy_Schedule__c eps : entityPS){
            if(eps.Split_Type__c == 'Non EEA'){
                NonEEAPS = eps;
                NonEEAPSID = eps.Id;
            }
            if(eps.Split_Type__c == 'EEA'){
                EEAPS = eps;
                EEAPSID = eps.Id;
            }
        }     
        
        if(ps.VG_Entity_Split_Required__c){
            ps.Split_Type__c = 'Both';
            ps.Premium_Adjustment__c = ps.Premium_Adjustment__c / (ps.VG_Entity_Share__c/100);
            ps.Premium_Adjustment_2__c = ps.Premium_Adjustment_2__c / (ps.VG_Entity_Share__c/100);
            EEAps.Premium_Adjustment__c = EEAps.Premium_Adjustment__c / (EEAps.VG_Entity_Share__c/100); 
            EEAps.Premium_Adjustment_2__c = EEAps.Premium_Adjustment_2__c / (EEAps.VG_Entity_Share__c/100); 
            NonEEAps.Premium_Adjustment__c = NonEEAps.Premium_Adjustment__c / (NonEEAps.VG_Entity_Share__c/100); 
            NonEEAps.Premium_Adjustment_2__c = NonEEAps.Premium_Adjustment_2__c / (NonEEAps.VG_Entity_Share__c/100);
        }
        
        
            
        PolicyCurrency = policy.CurrencyIsoCode;
        riskRatingList=new List<RRWrapper>();
        NOIList=new List<Integer>();
        Industry_Select = new List<SelectOption>();
        Profession_Select = new List<SelectOption>();
        FI_Industry_Select = new List<SelectOption>();
        LP_Select = new List<SelectOption>();
        RRCoverage_Select = new List<SelectOption>();
        CompanyType_Select = new List<SelectOption>();
        Product_Select = new List<SelectOption>();
        SideCurrencies =  new List<SelectOption>();
        CapacityPaperList = new List<SelectOption>();
        splitTypes = new List<SelectOption>();
        LibraryWrapperList = new List<LibraryWrapper>();
        LibraryWrapperList1 = new List<LibraryWrapper>();
        existingEndorsements = new List<VG_Policy_Schedule_Endorsement__c>();
        existingEndorsements1 = new List<VG_Policy_Schedule_Endorsement__c>();
        manualList=new List<VG_Policy_Schedule_Endorsement__c>();
        counter = counterEnd = 0;
        totalFeeAmount=0;
        totalbasepremium=0;
        totalbasepremiumrate=0;
        sideBAmount = sideCAmount = 0;
        sideBRententionCurrency = sideCRententionCurrency = PolicyCurrency;
        
        RRCalc();
        for(VG_Policy_Schedule_Asset__c psa : psaMap.values()){
            RRWrapper tmp=new RRWrapper();
            tmp.psa=psa;
            tmp.Counter=String.valueOf(counter);
            riskRatingList.add(tmp);
            counter++;
        }
        
        If(MTAType !=  'Run-off'){
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
        }else{
            proRata =1;
        }
        if(MTAType!= null && MTAType!=''){
            riskRatingList.clear();
        }
        pseTempMap= new Map<id,VG_Policy_Schedule_Endorsement__c>();
        pseMap= new Map<id,VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Endorsement_Library_Id__c,VG_IsTempDelete__c,VG_Endorsement_Number__c,VG_Sub_limit__c,VG_Premium__c,VG_Endorsement_Details__c,VG_Title__c,VG_Type__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c=: PSID]);
        for(VG_Policy_Schedule_Endorsement__c pse: pseMap.values()){
            pseTempMap.put(pse.VG_Endorsement_Library_Id__c,pse);
        }
        Set<ID> assetIds=new Set<ID>();
        for(VG_Policy_Schedule_Asset__c psa : psaMap.values()){
            if(psa.id != null && !assetIds.contains(psa.id))
                assetIds.add(psa.id);
        }
        EnableReinstatement=False;
        createLoop=new List<Integer>();                     
        RRcounter = 1;
        LibraryWrapper LW;
        LibraryWrapper LW1;
        tempPS = new Policy_Schedule__c();
        DatePS = new Policy_Schedule__c();
        BrexitPS  = new Policy_Schedule__c();
        
        DatePS.VG_Risk_Start_Date__c = ps.VG_Risk_Start_Date__c;
        DatePS.VG_Risk_End_Date__c   = ps.VG_Risk_End_Date__c ; 
        if(MTAType  ==  'Run-Off' || ps.VG_MTA_Type__c == 'Run-Off'){
            system.debug('tempPS::');
            tempPS.VG_Risk_Start_Date__c = ps.VG_Risk_Start_Date__c;
            tempPS.VG_Risk_End_Date__c   = ps.VG_Risk_End_Date__c ;                            
        }
        if(rc.VG_Reinstatement_Premiums__c!= null){
            String[] NOI=rc.VG_Reinstatement_Premiums__c.split('<br>');
            EnableReinstatement=False;
            if(rc.VG_No_of_Reinstatements__c.isNumeric()){
                for(integer i = 0 ; i < Integer.valueOf(rc.VG_No_of_Reinstatements__c) ; i++){
                    createLoop.add(i);
                    NOIList.add(Integer.valueOf(NOI[i].split(':')[1]));
                }
            }
        }
        for(VG_Policy_Schedule_Endorsement__c pse: pseMap.values()){
            if(pse.VG_Endorsement_Library_Id__c == null)
                manualList.add(pse);
            else
                pseTempMap.put(pse.VG_Endorsement_Library_Id__c,pse);             
        }
        List<CurrencyType> exchangeRates  =  [Select Id,  ConversionRate,  IsoCode from CurrencyType];
        currencyRateMap = new Map<String, CurrencyType>();
        for(CurrencyType cr : exchangeRates){
            currencyRateMap.put(cr.IsoCode, cr);
        }
        
        skipSplit = False;
        if(policy.VG_Inception_Date__c.year() <= 2020){
            splitTypes.add(new SelectOption('','None'));
            skipSplit = True;
        }
        splitTypes.add(new SelectOption('EEA','EEA'));
        splitTypes.add(new SelectOption('Non EEA','Non EEA'));
        splitTypes.add(new SelectOption('Both','Both'));
        
        Product_Select.add(new SelectOption('--None--','--None--'));
        Product_Select.add(new SelectOption('FI - D&O','FI - D&O'));
        Product_Select.add(new SelectOption('FI - PI','FI - PI'));
        Product_Select.add(new SelectOption('FI - Crime','FI - Crime'));
        Product_Select.add(new SelectOption('FI - Fiduciary','FI - Fiduciary'));
        Product_Select.add(new SelectOption('FI - Cyber','FI - Cyber'));
        Product_Select.add(new SelectOption('FI - Blend','FI - Blend'));
        Product_Select.add(new SelectOption('D&O','Directors & Officers'));
        Product_Select.add(new SelectOption('Pre-paid Run-off', 'Pre-paid Run-off'));
        Product_Select.add(new SelectOption('PI','Professional Indemnity'));
        Product_Select.add(new SelectOption('Commercial Crime','Commercial Crime'));
        Product_Select.add(new SelectOption('W&I','Warranty & Indemnity'));        
        DOProduct_Select = new List<SelectOption>();
        DOProduct_Select.add(new SelectOption('Side A','Side A'));
        DOProduct_Select.add(new SelectOption('A Side DIC','A Side DIC'));
        DOProduct_Select.add(new SelectOption('AB','AB'));
        DOProduct_Select.add(new SelectOption('ABC','ABC'));
        DOProduct_Select.add(new SelectOption('POSI','POSI'));
        DOProduct=ps.VG_D_O_Product__c;
        Product = ps.Product__c;               
        LProduct = ps.VG_Lloyds_Product__c;
        
        for(RRWrapper rr : riskRatingList){
            rr.CoverageSelected=rr.psa.VG_Coverage__c;
            
        }            
        setLPList();
        FI_Industry_Select.add(new SelectOption('--None--','--None--'));
        for(String s : Label.FIDO_FI_Industry_Select.split(';')){
            FI_Industry_Select.add(new SelectOption(s,s));
        }
        
        CompanyType_Select.add(new SelectOption('--None--','--None--'));
        CompanyType_Select.add(new SelectOption('Public','Public'));
        CompanyType_Select.add(new SelectOption('Private','Private'));
        CompanyType_Select.add(new SelectOption('Not for Profit','Not for Profit'));
        CompanyType = rc.VG_Company_Type__c;
        
        Industry_Select.add(new SelectOption('--None--', '--None--'));
        for(String s : Label.FIDO_Industry_Select.split(';')){
            Industry_Select.add(new SelectOption(s,s));
            FI_Industry_Select.add(new SelectOption(s,s));
        }
            
        Schema.DescribeFieldResult fieldResult1  =  Policy__c.VG_Policy_Currency__c.getDescribe();
        List<Schema.PicklistEntry> currencyList =  fieldResult1.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : currencyList){
            SideCurrencies.add(new SelectOption(pickListVal.getLabel(),  pickListVal.getLabel()));
        }  
        
        netModelPremium =  ps.Net_Premium__c ;
        RiskPremium = ps.Risk_Premium_Pro__c;
        EndorsementPremium=ps.Endorsement_Premium_Pro__c;
        lmt = ps.Limit__c;
        attachment =ps.Attachment__c;
        layer = ps.ILF_Layer__c ;
        writtenShare = ps.Written_share__c;
        sharePercent = ps.Share__c;
        actualPremium=ps.Actual_GWP__c;
        brokerage=ps.VG_Brokerage_Percent__c;
        brokerageAmount=ps.VG_Brokerage_Amount__c;
        grossWrittenPremium2 = ps.Gross_Written_Premium__c;
        if(sharePercent !=0)
            grossWrittenPremium=grossWrittenPremium2 /(sharePercent/100);
        else
            grossWrittenPremium=0;
        adjustmentTechPremium=ps.Premium_Adjustment__c.setScale(2);
        adjustment =ps.Premium_Adjustment_2__c.setScale(2);
        IPTAmount = ps.IPT__c;
        IPTPercent = ps.IPT_Percent__c;
        CapacityPaper=ps.VG_Capacity_Paper__c;
        RateChange = ps.VG_Rate_Change__c;
        feeIncome = ps.VG_Fee_Income__c;
        levies = ps.Levies__c;
        sumInsured = ps.Sum_Insured__c;
        vat = ps.VG_VAT__c;
        vatamount = ps.VG_VAT_Amount__c;
        taxamount = ps.VG_Witholding_Tax_Amount__c;
        uwPremium = ps.Technical_UW_Premium__c;
        techModelPremium= ps.VG_Technical_Model_Premium__c ;
        GrossOrNet = ps.Gross_or_Net_Premium__c;
        IndustrySelected  = ps.VG_Type_Of_Operation__c;
        sideBRententionCurrency =ps.VG_Side_B_Retention_Currency__c != null ? ps.VG_Side_B_Retention_Currency__c : policyCurrency;
        sideCRententionCurrency =ps.VG_Side_C_Retention_Currency__c != null ? ps.VG_Side_C_Retention_Currency__c : policyCurrency;
        sideBRentention = (ps.VG_Side_B_Rentention__c!=null?ps.VG_Side_B_Rentention__c:0);
        sideCRentention = (ps.VG_Side_C_Rentention__c!=null?ps.VG_Side_C_Rentention__c:0);        
        sideBCurrencyConvertion();
        sideCCurrencyConvertion();
        setCapacityPaper();
        NonEEAVolanteEntity_Select = new List<SelectOption>();
        NonEEAVolanteEntity_Select.add(new SelectOption('VIL', 'VIL'));
        NonEEAVolanteEntity_Select.add(new SelectOption('VSR LLC', 'VSR LLC'));
        NonEEAVolanteEntity_Select.add(new SelectOption('VTSL', 'VTSL')); 
        EEAVolanteEntity_Select = new List<SelectOption>();
        EEAVolanteEntity_Select.add(new SelectOption('VG UK', 'VG UK'));     
        }Catch(Exception e){
            stopProcess = true;
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'An error occurred please contact admin'));   
        }  
    }
    
    
    Public void setCapacityPaper(){
        CapacityPaperList.clear();
        String CPList = '';
        if(Product == 'PI'){
            CPList = Label.FIDO_PI_SectionNumber;
        }else if(Product=='FI - D&O' || Product=='FI - PI' || Product=='FI - Crime' || Product=='FI - Fiduciary' || Product=='FI - Cyber' || Product=='FI - Blend'){
            CPList = Label.FIDO_ALL_FI_SectionNumber;
        }else if(Product=='D&O' || Product=='Pre-paid Run-off' || Product=='Commercial Crime'){
            CPList = Label.FIDO_D_O_Crime_SectionNumber;
        }else if(Product=='W&I'){
            CPList = Label.FIDO_W_I_Crime_SectionNumber;
        }else if(Product!='W&I' && Product!='PI' && Product!='Pre-paid Run-off' && Product!='D&O' && Product!='Commercial Crime' && Product!='FI - D&O' && Product!='FI - PI' && Product!='FI - Crime' && Product!='FI - Fiduciary' && Product!='FI - Cyber' && Product!='FI - Blend'){
            CPList = Label.FIDO_Others_SectionNumber;
        }
        for(String s : CPList.split(';')){
            CapacityPaperList.add(new SelectOption(s,s));
        }
        Set<String> availableCapacityPapers = new Set<String>();
        for(SelectOption so : CapacityPaperList){
            if(!availableCapacityPapers .contains(so.getLabel())){
                availableCapacityPapers.add(so.getLabel());
            }
        }
        if(CapacityPaper != null){
            if(!availableCapacityPapers.contains(CapacityPaper)){
                CapacityPaperList.add(new SelectOption(CapacityPaper, CapacityPaper));
            }
        }
    }
    
    
    Public Void sideBCurrencyConvertion(){
        if(sideBRententionCurrency !=  'USD' && PolicyCurrency !=  'USD'){
            sideBAmount = ((sideBRentention!=null?sideBRentention:0)/currencyRateMap.get(sideBRententionCurrency).ConversionRate).setScale(2);
            sideBAmount = (sideBAmount*currencyRateMap.get(PolicyCurrency).ConversionRate).setScale(2);
        }else if(sideBRententionCurrency !=  'USD' && PolicyCurrency  ==  'USD'){
            sideBAmount = (sideBRentention/currencyRateMap.get(sideBRententionCurrency ).ConversionRate).setScale(2);
        }else if(sideBRententionCurrency  ==  'USD' && PolicyCurrency !=  'USD'){
            sideBAmount = (sideBRentention*currencyRateMap.get(PolicyCurrency).ConversionRate).setScale(2);
        }else{
            sideBAmount = sideBRentention;
        }
    }
    
    
    Public Void sideCCurrencyConvertion(){
        if(sideCRententionCurrency !=  'USD' && PolicyCurrency !=  'USD'){
            sideCAmount = (sideCRentention/currencyRateMap.get(sideCRententionCurrency ).ConversionRate).setScale(2);
            sideCAmount = (sideCAmount*currencyRateMap.get(PolicyCurrency).ConversionRate).setScale(2);
        }else if(sideCRententionCurrency !=  'USD' && PolicyCurrency  ==  'USD'){
            sideCAmount = (sideCRentention/currencyRateMap.get(sideCRententionCurrency ).ConversionRate).setScale(2);
        }else if(sideCRententionCurrency  ==  'USD' && PolicyCurrency !=  'USD'){
            sideCAmount = (sideCRentention*currencyRateMap.get(PolicyCurrency).ConversionRate).setScale(2);
        }else{
            sideCAmount = sideCRentention;
        }
    }
    
    
    Public Void generateReinstatement(){
      try{
        EnableReinstatement=True;
        createLoop.clear();
        NOIList.clear();
        if(rc.VG_No_of_Reinstatements__c.isNumeric()){
            for(integer i = 0 ; i < Integer.valueOf(rc.VG_No_of_Reinstatements__c) ; i++){
                NOIList.add(0);
                createLoop.add(i);                
            }
        }
        }Catch(Exception e){
            showError(e);
        }
    } 
    
    
    Public void setLPList(){
        try{    
            LP_Select.clear();
            RRCoverage_Select.clear();
            String LPString, CoverageString;
            if(Product=='FI - D&O'){
                LPString = Label.FIDO_LoydsProduct_FI_D_O;              
                CoverageString = Label.FIDO_Coverages_FI_D_O;
            }else if(Product=='FI - PI'){
                LPString = Label.FIDO_LoydsProduct_FI_PI;
                CoverageString = Label.FIDO_Coverages_FI_PI;                
            }else if(Product=='FI - Crime'){
                LPString = Label.FIDO_LoydsProduct_FI_Crime;                
                CoverageString = Label.FIDO_Coverages_FI_Crime;
            }else if(Product=='FI - Fiduciary'){
                LPString = Label.FIDO_LoydsProduct_FI_Fiduciary;
                CoverageString = Label.FIDO_Coverages_FI_Fiduciary;
            }else if(Product=='FI - Cyber'){
                LPString = Label.FIDO_LoydsProduct_FI_Cyber;
                CoverageString = Label.FIDO_Coverages_FI_Cyber;
            }else if(Product=='FI - Blend'){
                LPString = Label.FIDO_LoydsProduct_FI_Blend;
                CoverageString = Label.FIDO_Coverages_FI_Blend;
            }else if(Product=='D&O' || Product=='Pre-paid Run-off'){
                LPString = Label.FIDO_LoydsProduct_D_O;
                CapacityPaper='Liberty Mutual - D&O/Crime';
                CoverageString = Label.FIDO_Coverages_D_O;
            }else if(Product=='PI'){
                LPString = Label.FIDO_LoydsProduct_PI;
                CoverageString = Label.FIDO_Coverages_PI;
            }else if(Product=='Commercial Crime'){
                LPString = Label.FIDO_LoydsProduct_CC;
                CoverageString = Label.FIDO_Coverages_CC;
            }else if(Product=='W&I'){
                LPString = Label.FIDO_LoydsProduct_WI;
                CoverageString = Label.FIDO_Coverages_WI;            
            }   
            for(String s : LPString.split(';')){
                LP_Select.add(new SelectOption(s,s));  
            }
            for(String s : CoverageString.split(';')){
                RRCoverage_Select.add(new SelectOption(s,s));   
            }
            setCapacityPaper();             
        }Catch(Exception e){
            showError(e);
        }
    }
    
    
    Public void RRCalc(){
        try{ 
            totalFeeAmount=0;
            totalbasepremium=0;
            totalbasepremiumrate=0;
            for(RRWrapper rrw:riskRatingList){
                totalFeeAmount=totalFeeAmount+rrw.psa.VG_Fee_Amounts__c;
                rrw.psa.VG_Base_Premium__c=(rrw.psa.VG_Base_Premium_Rate__c/100)*rrw.psa.VG_Fee_Amounts__c;                
                totalbasepremium=totalbasepremium+rrw.psa.VG_Base_Premium__c;
                totalbasepremiumrate=(totalbasepremium/totalFeeAmount).SetScale(2);
            }
        }Catch(Exception e){
            showError(e);
        }
    }
    
    
    Public void RemoveCustom(){
        List<VG_Policy_Schedule_Endorsement__c> newPSEList = new List<VG_Policy_Schedule_Endorsement__c>();
        newPSEList.addAll(existingEndorsements);
        existingEndorsements.clear();
        for(VG_Policy_Schedule_Endorsement__c pse: newPSEList){
            if(!pse.VG_IsTempDelete__c){
                existingEndorsements.add(pse);
            }
        }
    }
    
    
    Public void AddCustom(){
        hasEndorsements = True;    
        VG_Policy_Schedule_Endorsement__c tempEndsmt = new VG_Policy_Schedule_Endorsement__c();            
        tempEndsmt.VG_Premium__c = 0;
        tempEndsmt.VG_Sub_limit__c=0;
        tempEndsmt.VG_Type__c='Endorsements';
        existingEndorsements.add(tempEndsmt);
    }
    
    
    Public void addRR(){
        try{
            Boolean allOkToTaddNewAsset = True;
            RRWrapper waNew=new RRWrapper();
            waNew.Counter=string.valueOf(RRcounter);            
            if(allOkToTaddNewAsset){
                VG_Policy_Schedule_Asset__c psaNew=new VG_Policy_Schedule_Asset__c();
                psaNew.VG_Base_Premium__c=0;
                psaNew.VG_Base_Premium_Rate__c=0;
                psaNew.VG_Fee_Amounts__c=0;
                psaNew.VG_Premium__c=0;
                waNew.psa=psaNew;
                waNew.totalfeeAmt=0;
                riskRatingList.add(waNew);
                RRcounter++;
            }
        }Catch(Exception e){
            showError(e);
        }
    }
    
    Public void RemoveRR(){
        riskRatingList.remove(integer.valueOf(Index));
        RRcounter=0;
        for(RRWrapper temp : riskRatingList){
            temp.Counter=String.valueOf(counter);
            RRcounter++;
        }
        if(riskRatingList.IsEmpty()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please add atleast one asset to the policy schedule..'));   
        }
    }
    
    Public pagereference total(){
        return null;
    }
    
    Public PageReference gotostep1(){
        return new PageReference('/apex/VG_Revise_FIDO_Step1');
    } 
    
    
    Public PageReference gotostep2(){
        if(CapacityPaper == '--None--'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select Capacity Paper'));    
            return null;
        }       
        If(Product == 'PI'){
            Schema.DescribeFieldResult fieldResult2   =   Risk_Capture__c.VG_Profession__c.getDescribe();
            List<Schema.PicklistEntry> ProfessionList  =   fieldResult2.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ProfessionList  ){
                Profession_Select.add(new SelectOption(pickListVal.getLabel(),  pickListVal.getLabel()));
            }
        }  
        return new PageReference('/apex/VG_Revise_FIDO_Step2');
    }   
    
    
    Public PageReference gotostep3(){
        return new PageReference('/apex/VG_Revise_FIDO_Step3');
    }
    
    
    Public PageReference gotostep4(){
        try{
            if(!existingEndorsements1.IsEmpty()){
                existingEndorsements1.clear();
            }
            List<String> coverageList  =  new List<String>();
            for(RRWrapper rr : riskRatingList){
                rr.psa.VG_Coverage__c = rr.CoverageSelected;
                If(LProduct  ==  rr.CoverageSelected)           
                    coverageList.add(rr.psa.VG_Coverage__c);
            }
            If(Product != 'Cyber' && Product != 'Combined Cyber/ Tech E&O'){
                If(!riskRatingList.IsEmpty() && coverageList.IsEmpty()){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one matching coverage with the Lloyds Product ..'));          
                    return null;
                }
            }
            ElList1 = [select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where Type__c = :'Sub-limits' AND RecordType.Name  = : 'VFP' ORDER By Name ASC];        
            LibraryWrapperList1.clear();       
            for(Endorsement_Library__c EL1 : ElList1){            
                LW1  =  new LibraryWrapper();
                LW1.EL  =  EL1;            
                LW1.isSelected  =  False;
                if(pseTempMap.containsKey(EL1.id)) { 
                    LW1.isSelected  =  True;
                }                         
                LibraryWrapperList1.add(LW1); 
            }
            return new PageReference('/apex/VG_Revise_FIDO_Step4');
        }Catch(Exception e){
            showError(e);
            return null;
        }
    }
    
    Public PageReference gotostep4b(){
        try{
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
                    tempEndsmt.CurrencyISOCode  =  policyCurrency;
                    tempEndsmt.VG_Endorsement_Number__c  =  LW.EL.Name;
                    tempEndsmt.VG_Type__c = LW.EL.Type__c;
                    tempEndsmt.VG_IsTempDelete__c  =  False;
                    tempEndsmt.VG_IsTemp__c  =  True;
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
            return new PageReference('/apex/VG_Revise_FIDO_Step4b');
        }Catch(Exception e){
            showError(e);
            return null;
        }
    }
    
    
    Public PageReference gotostep5(){
        try{
            Map<Id, VG_Policy_Schedule_Endorsement__c> tmpPSEMap = new Map<Id, VG_Policy_Schedule_Endorsement__c>();
            for(VG_Policy_Schedule_Endorsement__c pe:existingEndorsements){
                if(pe.VG_Endorsement_Library_Id__c !=  null && !pseTempMap.containsKey(pe.VG_Endorsement_Library_Id__c))
                    tmpPSEMap.put(pe.VG_Endorsement_Library_Id__c, pe);
            }
            for(VG_Policy_Schedule_Endorsement__c pse:existingEndorsements){
                if(pse.VG_Endorsement_Library_Id__c  ==  null)
                    manualList.add(pse);
            }
            for(VG_Policy_Schedule_Endorsement__c pse:pseTempMap.values()){
                if(manualList.IsEmpty()){
                    if(pse.VG_Endorsement_Library_Id__c  ==  null){
                        pse.VG_IsTempDelete__c  = false;
                        manualList.add(pse);
                    }
                }else{
                    for(VG_Policy_Schedule_Endorsement__c pse1:existingEndorsements){
                        if(pse.Name !=  pse1.Name && pse1.Name !=  null && !(new Set<VG_Policy_Schedule_Endorsement__c>(manualList)).contains(pse1)){
                            manualList.add(pse);
                        }
                    }
                }
            }
            if(!existingEndorsements.IsEmpty()){
                existingEndorsements.clear();
            }
            for(RRWrapper rr : riskRatingList){
                rr.psa.VG_Coverage__c = rr.CoverageSelected;                 
            }
            ElList = [select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where RecordType.Name  = : 'VFP' ORDER By Name ASC];       
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
            return new PageReference('/apex/VG_Revise_FIDO_Step5');
        }Catch(Exception e){
            showError(e);
            return null;
        }
    }
    
    
    Public PageReference gotostep5b(){
        try{
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
                        tempEndsmt.id=  tmpPSEMap.get(LW.EL.Id).id; 
                    }else if(pseTempMap.containsKey(LW.EL.Id)){
                        tempEndsmt.id=  pseTempMap.get(LW.EL.Id).id; 
                    }
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
            return new PageReference('/apex/VG_Revise_FIDO_Step5b');
        }Catch(Exception e){
            showError(e);
            return null;
        } 
    }
    
    
    Public PageReference gotostep6(){
        try{
            If(Product!= 'W&I')
                endorsementPremium  =  0;
            for(VG_Policy_Schedule_Endorsement__c en : existingEndorsements){
                If(Product!= 'W&I')
                    endorsementPremium  =  endorsementPremium + en.VG_Premium__c;
            }
            If(Product!= 'W&I')
                RiskPremium = 0;
            for(RRWrapper rrw: riskRatingList){ 
                If(Product == 'PI'){         
                    RiskPremium  =  RiskPremium + rrw.psa.VG_Base_Premium__c;
                }else{
                    RiskPremium  =  RiskPremium + rrw.psa.VG_Premium__c;            
                }
            }
            rc.VG_Company_Type__c  =  CompanyType ;
            If(Product == 'W&I'){
                RiskPremium  =  RiskPremium;
                EndorsementPremium =   EndorsementPremium;
            }else{
                if(MTAType  ==  'Revision of Cover'){
                    If(seletedProrateoption == 'Flat'){
                        RiskPremium  =  RiskPremium;
                        EndorsementPremium  =  EndorsementPremium;                
                    }else If(seletedProrateoption == 'Prorated'){
                        RiskPremium  =  RiskPremium * proRata;
                        EndorsementPremium  =  EndorsementPremium * proRata;                    
                    }
                }else{
                    RiskPremium  =  RiskPremium * proRata;
                    EndorsementPremium  =  EndorsementPremium * proRata;
                }            
            }
            netModelPremium  =  RiskPremium + EndorsementPremium;
            UpdateFinalCalculations();
            return new PageReference('/apex/VG_Revise_FIDO_Step6');
        }Catch(Exception e){
          showError(e);
          return null;
        }
    }
    
    
    Public void RCCalc(){
        try{
            If(rc.VG_Retention_Amount__c!=null && rc.VG_Enterprise_Value__c!=null){
                retention=rc.VG_Retention_Amount__c/(rc.VG_Enterprise_Value__c/100);
                rc.VG_Retention_of_EV__c=retention;
            }
            If(rc.VG_De_Minimis_Amount__c!=null && rc.VG_Enterprise_Value__c!=null){
                deminimis=rc.VG_De_Minimis_Amount__c/(rc.VG_Enterprise_Value__c/100);
                rc.VG_De_Minimis_of_EV__c=deminimis;
            }
        }Catch(Exception e){
            showError(e);
        }
    }
    
    
    Public void UpdateFinalCalculations(){
        system.debug(Product+','+MTAType);
        try{
            if(ps.Split_Type__c == 'Both'){
                ps.VG_Entity_Split_Required__c = True;
            }else{
                ps.VG_Entity_Split_Required__c = False;
            }
            
            endorsementPremium = 0;
            ps.VG_Entity_Share__c = ps.VG_Entity_Split_Required__c == False ? null : ps.VG_Entity_Share__c;
            for(VG_Policy_Schedule_Endorsement__c en : existingEndorsements){
                If(Product!= 'W&I')
                    endorsementPremium  =  endorsementPremium + en.VG_Premium__c;
            }
            
            
            If(Product!= 'W&I')
                RiskPremium = 0;
            for(RRWrapper rrw: riskRatingList){ 
                If(Product == 'PI'){         
                    RiskPremium  =  RiskPremium + rrw.psa.VG_Base_Premium__c;
                }else{
                    RiskPremium  =  RiskPremium + rrw.psa.VG_Premium__c;          
                }
            }
            
            if(MTAType  ==  'Revision of Cover'){
                If(seletedProrateoption == 'Flat'){
                    RiskPremium  =  RiskPremium;
                    EndorsementPremium  =  EndorsementPremium;                
                }else If(seletedProrateoption == 'Prorated'){
                    RiskPremium  =  RiskPremium * proRata;
                    endorsementPremium  =  endorsementPremium * proRata;                    
                }
            }else{
                RiskPremium  =  RiskPremium * proRata;
                EndorsementPremium  =  EndorsementPremium * proRata;
            }  
            netModelPremium  =  RiskPremium + EndorsementPremium;
            
            If(RateChange==0.00 && policy.VG_Is_Renewal__c == false)
                RateChange=null;
            If(Product=='W&I'){
                techModelPremium=RiskPremium+endorsementPremium;
                uwPremium = adjustmentTechPremium; 
                grossWrittenPremium = RiskPremium+endorsementPremium+ uwPremium +adjustment; 
                brokerageAmount=grossWrittenPremium *(brokerage/100);              
                actualPremium=grossWrittenPremium -brokerageAmount;
                sumInsured=lmt; 
            }else{            
                uwPremium=netModelPremium +adjustmentTechPremium;
                grossWrittenPremium = uwPremium+adjustment;
                If(sharePercent!=0 && sharePercent!=null)
                    grossWrittenPremium2 =grossWrittenPremium*(sharePercent/100);
                brokerageAmount = grossWrittenPremium2 *(brokerage/100);
                actualPremium=grossWrittenPremium2 -brokerageAmount;
                techModelPremium = netModelPremium*(sharePercent/100);                
                vatamount=(vat/100)*feeIncome;
                If(sharePercent!=null){
                    sumInsured=lmt*(sharePercent/100);    
                }         
            } 
            updatePSDetails();
            if(ps.VG_Entity_Split_Required__c){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.INFO,  'You have chosen to split entities. Please refer to the individual entity sections for split.')); 
                String CPList = '';
                if(Product == 'PI'){
                    CPList = Label.FIDO_PI_SectionNumber;
                }else if(Product =='FI - D&O' || Product =='FI - PI' || Product =='FI - Crime' || Product =='FI - Fiduciary' || Product =='FI - Cyber' || Product =='FI - Blend'){
                    CPList = Label.FIDO_ALL_FI_SectionNumber;
                }else if(Product =='D&O' || Product =='Commercial Crime' || Product =='Pre-paid Run-off'){
                    CPList = Label.FIDO_D_O_Crime_SectionNumber;
                }else if(Product =='W&I'){
                    CPList = Label.FIDO_W_I_Crime_SectionNumber;
                }else if(Product !='W&I' && Product !='PI' && Product !='D&O' && Product !='Pre-paid Run-off' && Product !='Commercial Crime' && Product !='FI - D&O' && Product !='FI - PI' && Product !='FI - Crime' && Product !='FI - Fiduciary' && Product !='FI - Cyber' && Product !='FI - Blend'){
                    CPList = Label.FIDO_Others_SectionNumber;
                }
                VFPsectionNoList = new List<SelectOption>();
                for(String s : CPList.split(';')){
                    VFPsectionNoList.add(new SelectOption(s,s));
                }
                Decimal NonEEAShare = NonEEAps.VG_Entity_Share__c == null ? 0 : NonEEAps.VG_Entity_Share__c;
                Decimal EEAShare = EEAps.VG_Entity_Share__c == null ? 0 : EEAps.VG_Entity_Share__c;
                String NonEEAEntity = NonEEAps.VG_Volante_Entities__c;
                String EEAEntity = EEAps.VG_Volante_Entities__c;
                String NonEEACapacityPaper = NonEEAps.VG_Capacity_Paper__c;
                String EEACapacityPaper = EEAps.VG_Capacity_Paper__c;
                ps.name = ps.name.remove('/NonEEA').remove('/EEA');
                NonEEAps = ps.clone(false,true,false,false);
                NonEEAps.VG_Entity_Share__c = NonEEAShare;
                NonEEAps.VG_Volante_Entities__c = NonEEAEntity;
                NonEEAps.Name += '/NonEEA';
                NonEEAps.Split_Type__c = 'Non EEA';
                NonEEAps.VG_Capacity_Paper__c = NonEEACapacityPaper;
                NonEEAps = VG_ManageBrexitSolutionController.summarayCalc(NonEEAps);
                EEAps = ps.clone(false,true,false,false);
                EEAps.VG_Entity_Share__c = EEAShare;
                EEAps.VG_Volante_Entities__c = EEAEntity;
                EEAps.Name += '/EEA';
                EEAps.Split_Type__c = 'EEA';
                EEAps.VG_Capacity_Paper__c = EEACapacityPaper;
                EEAps = VG_ManageBrexitSolutionController.summarayCalc(EEAps);
            }
        }Catch(Exception e){
            showError(e);
        }                                    
    }
    
    Public Void updatePSDetails(){
        ps.id=PSID;
        ps.VG_Lloyds_Product__c=LProduct;
        ps.Product__c=Product;
        ps.Net_Premium__c = netModelPremium;
        ps.Risk_Premium_Pro__c = RiskPremium;
        ps.Endorsement_Premium_Pro__c=EndorsementPremium;
        ps.Limit__c=lmt;
        ps.Attachment__c=attachment;
        ps.ILF_Layer__c = layer ;
        ps.Written_share__c = writtenShare ;
        ps.Share__c=sharePercent;
        ps.Actual_GWP__c=actualPremium;
        ps.VG_Brokerage_Percent__c = brokerage;
        ps.VG_Brokerage_Amount__c=brokerageAmount;
        If(Product!='W&I'){
            ps.Gross_Written_Premium__c = grossWrittenPremium2;
            ps.VG_Gross_Written_Premium_100__c = grossWrittenPremium;
        }else{
            ps.Gross_Written_Premium__c = grossWrittenPremium;
            ps.VG_Gross_Written_Premium_100__c=0;
        }    
        ps.Premium_Adjustment__c = adjustmentTechPremium;
        ps.Premium_Adjustment_2__c = adjustment;
        ps.IPT__c=IPTAmount;
        ps.IPT_Percent__c = IPTPercent;
        ps.VG_Fee_Income__c = feeIncome;
        ps.Levies__c = levies;
        ps.Sum_Insured__c = sumInsured;
        If(RateChange == 0.00 && policy.VG_Is_Renewal__c   == false)       
            ps.VG_Rate_Change__c   =   null;
        else
            ps.VG_Rate_Change__c   =  RateChange;
        ps.VG_Capacity_Paper__c=CapacityPaper;
        ps.VG_VAT__c=vat;
        ps.VG_VAT_Amount__c=vatamount;
        ps.VG_Witholding_Tax_Amount__c=taxamount;
        ps.Technical_UW_Premium__c = uwPremium;
        ps.VG_Technical_Model_Premium__c = techModelPremium;
        ps.Gross_or_Net_Premium__c = GrossOrNet ;
        ps.VG_Base_Policy__c=true;
        If(Product == 'D&O' || Product=='Pre-paid Run-off' || Product == 'FI - D&O'){
            ps.VG_Side_C_Rentention__c = sideCRentention;
            ps.VG_Side_B_Rentention__c = sideBRentention;
            ps.VG_Side_B_Retention_Currency__c =sideBRententionCurrency;
            ps.VG_Side_C_Retention_Currency__c =sideCRententionCurrency;
            ps.VG_D_O_Product__c = DOProduct;
            
        }
         if((Product == 'D&O' || Product=='Pre-paid Run-off') && (MTAType == 'Run-off' || ps.VG_MTA_Type__c == 'Run-Off')){
                system.debug('Pre-paid Run-off000::');
                ps.VG_Risk_Start_Date__c = tempPS.VG_Risk_Start_Date__c;
                ps.VG_Risk_End_Date__c = tempPS.VG_Risk_End_Date__c ;
                system.debug('Pre-paid Run-off000::'+tempPS.VG_Risk_Start_Date__c+'::'+tempPS.VG_Risk_End_Date__c);
         }
         if(Product=='Pre-paid Run-off' && MTAType != 'Run-off' && ps.VG_MTA_Type__c != 'Run-Off' ){
             system.debug('Pre-paid Run-off::');
              ps.VG_Risk_Start_Date__c = DatePS.VG_Risk_Start_Date__c;
              ps.VG_Risk_End_Date__c = DatePS.VG_Risk_End_Date__c ;
         }
         if(Product == 'PI' || Product == 'D&O' || Product=='Pre-paid Run-off' || Product == 'Commercial Crime' || Product == 'FI - D&O' || Product == 'FI - PI' || Product == 'FI - Crime' || Product == 'FI - Fiduciary' || Product == 'FI - Cyber' || Product == 'FI - Blend')
            ps.VG_Type_Of_Operation__c = IndustrySelected ;
        if(!ps.VG_Is_MTA__c){
            ps.Base_Creation_Start_Date__c = ps.Policy__r.VG_Inception_Date__c;
            ps.Base_Creation_End_Date__c = ps.Policy__r.VG_Expiry_Date__c;   
        }
    }
    
    Public PageReference cancel(){
        return new PageReference('/'+ps.id);
    }
    
    
    Public PageReference finish(){
        Savepoint sp = Database.setSavepoint();
        try{
            List<Policy_Schedule__c> updatepslist = new List<Policy_Schedule__c>();
            Policy_Schedule__c rocps;
            updatePSDetails();
            System.debug(MTAType);
            if(NOIList.size() > 0){
                Integer i = 1;
                for(Integer noi : NOIList){
                    if(i == 1)
                        rc.VG_Reinstatement_Premiums__c = '1st Reinstatement :'+noi+'<br/>';
                    if(i == 2)
                        rc.VG_Reinstatement_Premiums__c +=  '2nd Reinstatement :'+noi+'<br/>';
                    if(i == 3)
                        rc.VG_Reinstatement_Premiums__c +=  '3rd Reinstatement :'+noi+'<br/>';
                    if(i>3)
                        rc.VG_Reinstatement_Premiums__c +=  i+'th Reinstatement :'+noi+'<br/>';
                    
                    i++;
                }
                rc.VG_Reinstatement_Premiums__c = rc.VG_Reinstatement_Premiums__c.removeEnd('<br/>');
            }else{
                rc.VG_Reinstatement_Premiums__c = '';
            }
            
            /*if(MTAType !=  'Revision of Cover' &&t MTAType  !=  'Run-off'){
                if(!updatepslist.IsEmpty())
                    update updatepslist;
            }*/
            /*if(MTAType !=  'Revision of Cover' && MTAType  !=  'Run-off')
                Update RC;*/
            List<VG_Policy_Schedule_Endorsement__c> endToBeUpdated  =  new List<VG_Policy_Schedule_Endorsement__c>();
            List<VG_Policy_Schedule_Endorsement__c> endToBeInserted  =  new List<VG_Policy_Schedule_Endorsement__c>();
            List<VG_Policy_Schedule_Asset__c> assetToBeInserted  =  new List<VG_Policy_Schedule_Asset__c>();
            List<VG_Policy_Schedule_Asset__c> assetToBeUpdated  =  new List<VG_Policy_Schedule_Asset__c>();        
            
            Set<ID> pseIds = new Set<ID>();
            for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements){
                endToBeInserted.add(pse);
            }
            for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements1){
                endToBeInserted.add(pse);
            }
            
            if(!endToBeInserted.IsEmpty()){
                Integer psecount = 1;
                Integer psesbcount = 1;
                for(VG_Policy_Schedule_Endorsement__c pse : endToBeInserted){
                    if(pse.VG_Type__c  ==  'Endorsements'){
                        pse.Name = ps.Name+'/PE/'+psecount;
                        psecount++;
                    }
                    else{
                        pse.Name = ps.Name+'/PESB/'+psesbcount;
                        psesbcount++;
                    }
                    pse.VG_Policy_Schedule__c = ps.id;
                    pse.CurrencyISOCode = ps.CurrencyISOCode;
                }
            }
            for(RRWrapper rrw : riskRatingList){
                assetToBeInserted.add(rrw.psa);
            }
            Integer psacount = 1;
            if(!assetToBeInserted.IsEmpty()){
                for(VG_Policy_Schedule_Asset__c psa : assetToBeInserted){
                    psa.Name = ps.Name+'/RR/'+psacount;
                    psa.VG_Policy_Schedule__c = ps.id;
                    psa.CurrencyISOCode = ps.CurrencyISOCode;
                    psacount++;
                }
            }
            if(MTAType !=  'Revision of Cover' && MTAType !=  'Run-off'){ 
                
            }else{
                List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([select id, Name, Policy__r.Name,VG_MTA_Type__c from Policy_Schedule__c where Policy__c = :ps.Policy__c]);
                rocps = new Policy_Schedule__c();
                rocps = ps.clone(false,true,false,false);
                rocps.VG_Is_MTA__c = true;
                If(MTAType  ==  'Revision of Cover'){
                    rocps.VG_MTA_Type__c = 'Revision of Cover';
                    rocps.VG_MTA_End_Date__c = ps.Policy__r.VG_Expiry_Date__c;
                }
                If(MTAType  ==  'Run-off'){
                    rocps.VG_MTA_Type__c  =  'Run-off';
                    System.debug('tempPS::'+tempPS.VG_Risk_Start_Date__c+'::'+tempPS.VG_Risk_End_Date__c);
                    rocps.VG_Risk_Start_Date__c = tempPS.VG_Risk_Start_Date__c;
                    rocps.VG_Risk_End_Date__c = tempPS.VG_Risk_End_Date__c ;
                    System.debug('rocPS::'+rocps.VG_Risk_Start_Date__c+'::'+rocps.VG_Risk_End_Date__c);                    
                    If(MTAEndDate!=null)
                        rocps.VG_MTA_End_Date__c=Date.valueOf(MTAEndDate);
                    System.debug('pslist::'+psList.size());
                    If(psList.size() <= 1){
                        policy.VG_Expiry_Date__c = rocps.VG_MTA_End_Date__c;
                        update policy;
                    }
                }
                rocps.id = null;
                If(MTAStartDate!=null)
                    rocps.VG_MTA_Start_Date__c=Date.valueOf(MTAStartDate);
                rocps.IPT__c = null;
                rocps.IPT_Percent__c = null; 
                rocps.Base_Creation_Start_Date__c=rocps.VG_MTA_Start_Date__c;
                rocps.Base_Creation_End_Date__c=rocps.VG_MTA_End_Date__c;
                rocps.MTA_Parent_Policy_Schedule__c=PSID;
                rocps.VG_Base_Policy__c=true;
                integer tmp;
                String[] tempDetail;
                String temp;
                if(psList.size()>0){
                    List<Integer> nums = new List<Integer>();
                    for(Policy_Schedule__c ps : psList){
                        If(ps.Name.contains('/PS/')){
                            tempDetail = ps.Name.split('/PS/');
                            if(tempDetail[1].contains('/EEA'))
                                temp = tempDetail[1].remove('/EEA');
                            else
                                temp = tempDetail[1].remove('/NonEEA');
                        }else If(ps.Name.contains('/MTA/')){
                            tempDetail = ps.Name.split('/MTA/');
                            if(tempDetail[1].contains('/EEA'))
                                temp = tempDetail[1].remove('/EEA');
                            else
                                temp = tempDetail[1].remove('/NonEEA');
                        }
                        tmp = Integer.valueOf(temp);
                        nums.add(tmp);
                    }
                    nums.sort();
                    System.debug('max::'+nums[0]+'::'+nums[nums.size()-1]);
                    rocps.Name = ps.Policy__r.Name+'/MTA/'+(nums[nums.size()-1]+1);
                }              
                Boolean checkRunoff = false;
                List<Policy_Schedule__c> psList2 = new List<Policy_Schedule__c>([select id, VG_Volante_Entities__c, Name, Policy__r.VG_Renewal_Policy_Id__c,Policy__r.Policy_Status__c,Policy__r.MTA_Cancel_List__c,Policy__r.VG_Is_Renewal__c,Policy__r.Name,  VG_MTA_Type__c,Policy__c, CurrencyISOCode, Policy__r.VG_Expiry_Date__c, Policy__r.VG_Inception_Date__c, Split_Type__c from Policy_Schedule__c where (Policy__c = : policy.Id OR Id =: rocps.Id)]);
                List<Policy_Schedule__c> runoffpsList = new List<Policy_Schedule__c>();
                List<Policy_Schedule__c> notrunoffpsList = new List<Policy_Schedule__c>();
                for(Policy_Schedule__c ps: psList2){
                    System.debug('MTAType::'+ps.VG_MTA_Type__c+'::'+rocps.VG_MTA_Type__c);
                    if(ps.VG_MTA_Type__c == 'Run-off'){
                        System.debug('MTAType::'+ps.VG_MTA_Type__c+'::'+rocps.VG_MTA_Type__c);
                        runoffpsList.add(ps);
                        System.debug('runoffpsList::'+runoffpsList); 
                    }
                    if(ps.VG_MTA_Type__c == null)
                        notrunoffpsList.add(ps);            
                }
                System.debug('runoffpsList::'+runoffpsList);
                System.debug('runoff::'+runoffpsList.size()+'::'+notrunoffpsList.size());
                if(runoffpsList.size() == notrunoffpsList.size()){ 
                    System.debug('runoff::'+runoffpsList.size()+'::'+notrunoffpsList.size());
                    policy.VG_Expiry_Date__c = rocps.VG_MTA_End_Date__c;
                    System.debug('policydate::'+policy.VG_Expiry_Date__c+'::'+rocps.VG_MTA_End_Date__c);
                    update policy;
                }                                        
            }
            List<sObject> recordsToBeDeleted = new List<sObject>();
            List<sObject> recordsToBeInserted = new List<sObject>();
            if(!ps.VG_Entity_Split_Required__c){
                if(!skipSplit && (ps.Split_Type__c == null || ps.Split_Type__c == '--None--')){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select a split type.'));   
                    return null;
                }
                if(ps.VG_Volante_Entities__c != null && policy.VG_Volante_Entities__c != null && !policy.VG_Volante_Entities__c.contains(ps.VG_Volante_Entities__c)){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Entity selected on Policy Schedule must match the entity on Policy.'));   
                    return null;
                }
                Set<String> eeaCountries = new Set<String>();
                eeaCountries.addAll(Label.EEA_Countries.split(';'));
                if(rc.VG_Company_Domicile__c != null && ps.Split_Type__c == 'EEA' && (!eeaCountries.contains(rc.VG_Company_Domicile__c))){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please check company domicile as policy schedule split is for EEA and company domicile is Non EEA'));
                    return null;
                }else if(rc.VG_Company_Domicile__c != null && ps.Split_Type__c == 'Non EEA' && (eeaCountries.contains(rc.VG_Company_Domicile__c))){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please check company domicile as policy schedule split is for Non EEA and company domicile is EEA'));
                    return null;
                }
                if(MTAType !=  'Revision of Cover' && MTAType !=  'Run-off'){ 
                    ps.Name = ps.Name.remove('/EEA').remove('/NonEEA');
                    System.debug(ps.Name);
                    if(ps.Name.contains('MTA')){
                        ps.VG_Is_MTA__c = True;
                    }
                    String basePSName, otherPSName;
                    if(ps.Split_Type__c == 'EEA'){
                        ps.Name += '/EEA';
                        otherPSName = ps.Name.replace('EEA','NonEEA');
                    }else if(ps.Split_Type__c == 'Non EEA'){
                        ps.Name += '/NonEEA';
                        otherPSName = ps.Name.replace('NonEEA','EEA');
                    }        
                    basePSName = ps.Name.remove('/EEA').remove('/NonEEA');     
                    List<Policy_Schedule__c> psDelList = [Select Id from Policy_Schedule__c where (Name =: basePSName OR Name =: otherPSName OR Name =: ps.Name) AND Id <>: ps.Id];
                    Utilities.avoidRecursionSet.add('deleteSplitPairPS');
                    Delete psDelList;
                    Utilities.clearMethods();
                    //ps.Id = null;
                    PolicyScheduleTriggerFunction.allowInsertRI = True;
                    updatepslist.add(ps);
                    Utilities.SkipMethods('Trigger Context');
                    Utilities.SkipMethods('Trigger Context2');
                    Upsert updatepslist;
                    RC.Name =  ps.Name+'/RD/0';
                    //RC.Id = null;
                    RC.Policy_Schedule__c = ps.Id;
                    Update RC;
                    List<VG_Policy_Schedule_Asset__c> psaDelList = [Select Id from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =: ps.Id];
                    List<VG_Policy_Schedule_Endorsement__c> pseDelList = [Select Id from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =: ps.Id];
                    Delete psaDelList;
                    Delete pseDelList;
                    List<VG_Payment_Frequency__c> pfList = [Select Id from VG_Payment_Frequency__c where VG_Policy_Schedule__c =: ps.Id]; 
                    if(!pfList.IsEmpty()){
                        Integer pfCount = 0;
                        for(VG_Payment_Frequency__c pf : pfList){
                            pf.Name = ps.Name + '/PF/' + pfCount;
                            pfCount++;
                        }
                        Update pfList;
                    }
                    psacount = 1;
                    if(!assetToBeInserted.IsEmpty()){
                        for(VG_Policy_Schedule_Asset__c psa : assetToBeInserted){
                            VG_Policy_Schedule_Asset__c tempPSA = psa.clone(false, true, false, false);
                            tempPSA.VG_Policy_Schedule__c = ps.Id;
                            tempPSA.Name = ps.Name+'/RR/'+psacount;
                            recordsToBeInserted.add(tempPSA);
                            psacount++;
                        }
                    }

                    if(!endToBeInserted.IsEmpty()){
                        Integer psecount = 1;
                        Integer psesbcount = 1;
                        for(VG_Policy_Schedule_Endorsement__c pse : endToBeInserted){
                            VG_Policy_Schedule_Endorsement__c tempPSE = pse.clone(false, true, false, false);
                            if(tempPSE.VG_Type__c  ==  'Endorsements'){
                                tempPSE.Name = ps.Name+'/PE/'+psecount;
                                psecount++;
                            }
                            else{
                                tempPSE.Name = ps.Name+'/PESB/'+psesbcount;
                                psesbcount++;
                            }
                            tempPSE.VG_Policy_Schedule__c = ps.Id;
                            recordsToBeInserted.add(tempPSE);
                            pse.VG_Policy_Schedule__c = ps.Id;
                        }
                    }
                    Utilities.SkipMethods('Trigger Context');
                    Utilities.SkipMethods('Trigger Context2');
                    Insert recordsToBeInserted;
                    return new PageReference('/'+ps.Id);
                }else{
                    rocps.Name = rocps.Name.remove('/EEA').remove('/NonEEA').replace('PS','MTA');
                    String basePSName = rocps.Name;
                    String otherPSName;
                    List<Policy_Schedule__c> psDelList;
                    if(rocps.Split_Type__c == 'EEA'){
                        rocps.Name += '/EEA';
                        otherPSName = rocps.Name.replace('EEA','NonEEA');
                    }else if(rocps.Split_Type__c == 'Non EEA'){
                        rocps.Name += '/NonEEA';
                        otherPSName = rocps.Name.replace('NonEEA','EEA');
                    }
                    Policy_Schedule__c psInsert = rocps.clone(false, true, false, false);
                    psInsert.Id = null;
                    psInsert.VG_Is_MTA__c = True;
                    //psDelList = [Select Id from Policy_Schedule__c where Name =: basePSName OR Name =: rocps.Name OR Name =: otherPSName];
                    //Delete psDelList;
                    PolicyScheduleTriggerFunction.allowInsertRI  =  True;
                    Utilities.SkipMethods('Trigger Context');
                    Utilities.SkipMethods('Trigger Context2');
                    Insert psInsert;
                    //if(ps.Id != null)
                    //    recordsToBeDeleted.add(ps);
                    List<Policy_Schedule__c> TriggerNew  =  new List<Policy_Schedule__c>();
                    TriggerNew.add(psInsert);
                    Risk_Capture__c rocrc = new Risk_Capture__c();
                    rocrc = rc.clone(false, true, false, false);
                    rocrc.id = null;
                    rocrc.Policy_Schedule__c = psInsert.id;
                    rocrc.Name = psInsert.Name+'/RD/0';
                    recordsToBeInserted.add(rocrc);
                    //if(rc.Id != null)
                    //    recordsToBeDeleted.add(rc);
                    Integer psacounter = 0;
                    for(VG_Policy_Schedule_Asset__c  psa : assetToBeInserted){
                        VG_Policy_Schedule_Asset__c tpsa = psa.clone(false, true, false, false);
                        tpsa.VG_Policy_Schedule__c = psInsert.id;
                        tpsa.Name = psInsert.Name+'/RR/'+psacounter;
                        psacounter++;  
                        recordsToBeInserted.add(tpsa);
                        //if(psa.Id != null)
                        //    recordsToBeDeleted.add(psa);                 
                    }
                    Integer psecounter = 0;
                    Integer psesbcounter = 0;
                    for(VG_Policy_Schedule_Endorsement__c pse : endToBeInserted){
                        VG_Policy_Schedule_Endorsement__c tpse = pse.clone(false, true, false, false);
                        tpse.VG_Policy_Schedule__c = psInsert.id;
                        if(tpse.VG_Type__c  ==  'Endorsements'){
                            tpse.Name = psInsert.Name+'/PE/'+psecounter;
                            psecounter++;
                        }else{
                            tpse.Name = psInsert.Name+'/PESB/'+psesbcounter;
                            psesbcounter++;
                        }
                        recordsToBeInserted.add(tpse);
                        //if(pse.Id != null)
                        //    recordsToBeDeleted.add(pse); 
                    }
                    Utilities.SkipMethods('Trigger Context');
                    Utilities.SkipMethods('Trigger Context2');
                    Insert recordsToBeInserted;
                    Database.delete(recordsToBeDeleted, False);
                    return new PageReference('/'+psInsert.Id); 
                }
            }else{
                if(NonEEAps.VG_Entity_Share__c + EEAps.VG_Entity_Share__c != 100){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'All entity shares must add up to 100%'));   
                    return null;
                }
                if(policy.VG_Volante_Entities__c != null && !policy.VG_Volante_Entities__c.contains(EEAps.VG_Volante_Entities__c)){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Entity selected on EEA Policy Schedule must match the entity on Policy.'));   
                    return null;
                }
                if(policy.VG_Volante_Entities__c != null && !policy.VG_Volante_Entities__c.contains(NonEEAps.VG_Volante_Entities__c)){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Entity selected on Non EEA Policy Schedule must match the entity on Policy.'));   
                    return null;
                }
                if(NonEEAps.VG_Entity_Share__c ==0  || EEAps.VG_Entity_Share__c == 0){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'All entity shares must be greater than 0%'));   
                    return null;
                }
                if(MTAType !=  'Revision of Cover' && MTAType !=  'Run-off'){ 
                    if(EEAPS.Name.contains('MTA')){
                        EEAPS.VG_Is_MTA__c = True;
                    }    
                    if(NonEEAPS.Name.contains('MTA')){
                        NonEEAPS.VG_Is_MTA__c = True;
                    }                   
                    String basePSName = EEAPS.Name.remove('/EEA').remove('/NonEEA');
                    Map<Id, Policy_Schedule__c> psDelList = new Map<Id, Policy_Schedule__c>([Select Id from Policy_Schedule__c where (Name =: basePSName OR Name =: EEAPS.Name OR Name =: NonEEAPS.Name) AND (Id <>: EEAPSID AND ID <>: NonEEAPSID)]);
                    Utilities.avoidRecursionSet.add('deleteSplitPairPS');
                    Delete psDelList.values();
                    Utilities.clearMethods();
                    EEAPS.Id = EEAPSID;
                    NonEEAPS.Id = NonEEAPSID;
                    Set<Id> exPSIds = new Set<ID>();
                    if(EEAPSId != null)
                        exPSIds.add(EEAPSId);
                    if(NonEEAPSId != null)
                        exPSIds.add(NonEEAPSId);
                    NonEEAps.IPT__c = 0;
                    NonEEAps.VG_Tax_Amount_GWP_100__c = 0;
                    EEAps.IPT__c = 0;
                    EEAps.VG_Tax_Amount_GWP_100__c = 0;
                    if(!exPSIds.IsEmpty()){
                        List<VG_Taxes__c> existingTaxes = [Select Id, VG_Tax_Paid_By__c, VG_Tax_Amount_GWP_100__c, VG_Tax_Amount__c, VG_Tax_Administered_By__c, VG_Policy_Schedule__c from VG_Taxes__c where VG_Policy_Schedule__c IN: exPSIds];
                        List<VG_Taxes__c> subListOfAllTaxes;
                        Map<Id,  List<VG_Taxes__c>> PSTaxMap  =  new Map<Id,  List<VG_Taxes__c>>();
                        for(VG_Taxes__c tx: existingTaxes){
                            if(PSTaxMap.get(tx.VG_Policy_Schedule__c)  ==  null){
                                subListOfAllTaxes  =  new List<VG_Taxes__c>();
                            }else{
                                subListOfAllTaxes  =  PSTaxMap.get(tx.VG_Policy_Schedule__c);
                            }
                            subListOfAllTaxes.add(tx);
                            PSTaxMap.put(tx.VG_Policy_Schedule__c,  subListOfAllTaxes);
                        }
                        if(!PSTaxMap.IsEmpty() && PSTaxMap.containsKey(EEAPSId)){
                            Decimal IPT = 0;
                            Decimal IPTHun = 0;
                            for(VG_Taxes__c tx: PSTaxMap.get(EEAPSId)){ 
                                if((tx.VG_Tax_Administered_By__c == 'Insured' && tx.VG_Tax_Paid_By__c=='Insurer') || (tx.VG_Tax_Administered_By__c == 'Broker' && tx.VG_Tax_Paid_By__c=='Insurer') || (tx.VG_Tax_Administered_By__c == 'Insurer' && tx.VG_Tax_Paid_By__c=='Insured')){
                                    IPT = IPT+tx.VG_Tax_Amount__c;
                                    IPTHun = IPTHun + (tx.VG_Tax_Amount_GWP_100__c !=null ? tx.VG_Tax_Amount_GWP_100__c : 0) ;
                                }    
                            }
                            EEAps.IPT__c = IPT;
                            EEAps.VG_Tax_Amount_GWP_100__c = IPTHun;
                        }
                        if(!PSTaxMap.IsEmpty() && PSTaxMap.containsKey(NonEEAPSId)){
                            Decimal IPT = 0;
                            Decimal IPTHun = 0;
                            for(VG_Taxes__c tx: PSTaxMap.get(NonEEAPSId)){ 
                                if((tx.VG_Tax_Administered_By__c == 'Insured' && tx.VG_Tax_Paid_By__c=='Insurer') || (tx.VG_Tax_Administered_By__c == 'Broker' && tx.VG_Tax_Paid_By__c=='Insurer') || (tx.VG_Tax_Administered_By__c == 'Insurer' && tx.VG_Tax_Paid_By__c=='Insured')){
                                    IPT = IPT+tx.VG_Tax_Amount__c;
                                    IPTHun = IPTHun + (tx.VG_Tax_Amount_GWP_100__c !=null ? tx.VG_Tax_Amount_GWP_100__c : 0) ;
                                }    
                            }
                            NonEEAps.IPT__c = IPT;
                            NonEEAps.VG_Tax_Amount_GWP_100__c = IPTHun;
                        }
                    }
                    updatepslist.add(EEAps);
                    updatepslist.add(NonEEAps);
                    PolicyScheduleTriggerFunction.allowInsertRI  =  True;
                    Utilities.SkipMethods('Trigger Context');
                    Utilities.SkipMethods('Trigger Context2');
                    Upsert updatepslist;
                    List<VG_Policy_Schedule_Asset__c> finalListPSA = [Select Id from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =: EEAPS.Id OR VG_Policy_Schedule__c =: NonEEAPS.Id];
                    List<VG_Policy_Schedule_Endorsement__c> finalListPSE = [Select Id from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =: EEAPS.Id OR VG_Policy_Schedule__c =: NonEEAPS.Id ];
                    List<Risk_Capture__c> finalListRC = [Select Id from Risk_Capture__c where Policy_Schedule__c =: EEAPS.Id OR Policy_Schedule__c =: NonEEAPS.Id ];
                    recordsToBeDeleted.addAll(finalListPSA);
                    recordsToBeDeleted.addAll(finalListPSE);
                    recordsToBeDeleted.addAll(finalListRC);
                    List<VG_Payment_Frequency__c> pfList = [Select Id, Name from VG_Payment_Frequency__c where VG_Policy_Schedule__c =: EEAPS.Id OR VG_Policy_Schedule__c =: NonEEAPS.Id]; 
                    if(!pfList.IsEmpty()){
                        Integer pfCountEEA = 0;
                        Integer pfCountNonEEA = 0;
                        for(VG_Payment_Frequency__c pf : pfList){
                            if(ps.Name.contains('/EEA')){
                                pf.Name = ps.Name + '/PF/' + pfCountEEA;
                                pfCountEEA++;
                            }
                            if(ps.Name.contains('/NonEEA')){
                                pf.Name = ps.Name + '/PF/' + pfCountNonEEA;
                                pfCountNonEEA++;
                            }
                        }
                        Update pfList;
                    }
                    List<Risk_Capture__c> rcList = new List<Risk_Capture__c>();
                    for(Policy_Schedule__c entityPS : updatepslist){
                        Risk_Capture__c entityrc = rc.clone(false, true, false, false);
                        entityrc.id = null;
                        entityrc.Policy_Schedule__c = entityPS.id;
                        entityrc.Name = entityPS.Name+'/RD/0';
                        recordsToBeInserted.add(entityrc);
                    }
                    
                    psacount = 1;
                    if(!assetToBeInserted.IsEmpty()){
                        for(VG_Policy_Schedule_Asset__c  psa : assetToBeInserted){
                            VG_Policy_Schedule_Asset__c tempPSA = psa.clone(false,true,false,false);
                            tempPSA.VG_Policy_Schedule__c = EEAPS.Id;
                            tempPSA.id = null;
                            tempPSA.Name = EEAPS.Name+'/RR/'+psacount;
                            recordsToBeInserted.add(tempPSA);
                            tempPSA = psa.clone(false,true,false,false);
                            tempPSA.VG_Policy_Schedule__c = NonEEAPS.Id;
                            tempPSA.id = null;
                            tempPSA.Name = NonEEAPS.Name+'/RR/'+psacount;
                            recordsToBeInserted.add(tempPSA);
                            psacount++;
                        }
                    }
                    Integer psecount = 1;
                    Integer psesbcount = 1;
                    if(!endToBeInserted.IsEmpty()){
                        for(VG_Policy_Schedule_Endorsement__c pse : endToBeInserted){
                            VG_Policy_Schedule_Endorsement__c tempPSE = pse.clone(false,true,false,false);
                            tempPSE.VG_Policy_Schedule__c = EEAPS.Id;
                            tempPSE.id = null;
                            if(tempPSE.VG_Type__c  ==  'Endorsements'){
                                tempPSE.Name = EEAPS.Name+'/PE/'+psecount;
                            }
                            else{
                                tempPSE.Name = EEAPS.Name+'/PESB/'+psesbcount;
                            }
                            recordsToBeInserted.add(temppse);
                            tempPSE = pse.clone(false,true,false,false);
                            tempPSE.VG_Policy_Schedule__c = NonEEAPS.Id;
                            tempPSE.id = null;
                            if(tempPSE.VG_Type__c  ==  'Endorsements'){
                                tempPSE.Name = NonEEAPS.Name+'/PE/'+psecount;
                                psecount++;
                            }
                            else{
                                tempPSE.Name = NonEEAPS.Name+'/PESB/'+psesbcount;
                                psesbcount++;
                            }
                            recordsToBeInserted.add(tempPSE);
                        }
                    }
                    Utilities.SkipMethods('Trigger Context');
                    Utilities.SkipMethods('Trigger Context2');
                    Insert recordsToBeInserted;
                    //Database.delete(recordsToBeDeleted,False);
                    Delete recordsToBeDeleted;
                    return new PageReference('/'+policyId);
                }else{
                    List<Policy_Schedule__c> InsertpsList = new List<Policy_Schedule__c>();
                    System.debug(ps.Name);
                    Set<String> mtaParents = new Set<String>();
                    mtaParents.add(ps.Name+'/EEA');
                    mtaParents.add(ps.Name+'/NonEEA');
                    List<Policy_Schedule__c> mtaParentsList = [Select Id, Split_Type__c from Policy_Schedule__c where Name IN: mtaParents];
                    for(Policy_Schedule__c mps : mtaParentsList){
                        if(mps.Split_Type__c == 'EEA'){
                            EEAPS.MTA_Parent_Policy_Schedule__c = mps.Id;
                        }else if(mps.Split_Type__c == 'Non EEA'){
                            NonEEAPS.MTA_Parent_Policy_Schedule__c = mps.Id;
                        }
                    }
                    
                    NonEEAPS.id=null;  
                    NonEEAPS.Name = rocps.Name + '/NonEEA';                                            
                    NonEEAPS.VG_MTA_Type__c = 'Revision of Cover';              
                    NonEEAPS.Split_Type__c = 'Non EEA';
                    NonEEAPS.VG_Is_MTA__c = true;
                    NonEEAPS.VG_MTA_Start_Date__c=rocps.VG_MTA_Start_Date__c;
                    NonEEAPS.VG_MTA_End_Date__c=rocps.VG_MTA_End_Date__c;
                    NonEEAPS.Base_Creation_Start_Date__c=rocps.VG_MTA_Start_Date__c;
                    NonEEAPS.Base_Creation_End_Date__c=rocps.VG_MTA_End_Date__c;
                    NonEEAPS.VG_Base_Policy__c=true;
                    
                    EEAPS.id=null;       
                    EEAPS.Name = rocps.Name + '/EEA';                                       
                    EEAPS.VG_MTA_Type__c = 'Revision of Cover';               
                    EEAPS.Split_Type__c = 'EEA';
                    EEAPS.VG_Is_MTA__c = true;
                    EEAPS.VG_MTA_Start_Date__c=rocps.VG_MTA_Start_Date__c;
                    EEAPS.VG_MTA_End_Date__c=rocps.VG_MTA_End_Date__c;
                    EEAPS.Base_Creation_Start_Date__c=rocps.VG_MTA_Start_Date__c;
                    EEAPS.Base_Creation_End_Date__c=rocps.VG_MTA_End_Date__c;
                    EEAPS.VG_Base_Policy__c=true;
                    
                    String otherpsName;
                    if(!rocps.Name.contains('/NonEEA')){
                        otherpsName = rocps.Name.replace('/EEA','/NonEEA');
                    }else{
                        otherpsName = rocps.Name.replace('/NonEEA','/EEA');
                    }
                    
                    
                    String basePSName = rocps.Name.remove('/EEA').remove('/NonEEA');
                    List<Policy_Schedule__c> psDelList = [Select Id from Policy_Schedule__c where Name =: basePSName];
                    Delete psDelList;
                    PolicyScheduleTriggerFunction.allowInsertRI  =  True;
                    InsertpsList.add(EEAPS);
                    InsertpsList.add(NonEEAPS);
                    Utilities.SkipMethods('Trigger Context');
                    Utilities.SkipMethods('Trigger Context2');
                    Upsert InsertpsList;
                    List<Risk_Capture__c> rcList = new List<Risk_Capture__c>();
                    for(Policy_Schedule__c entityPS : InsertpsList){
                        Risk_Capture__c rocrc = new Risk_Capture__c();
                        rocrc = rc.clone(false, true, false, false);
                        rocrc.id = null;
                        rocrc.Policy_Schedule__c = entityPS.id;
                        rocrc.Name = entityPS.Name+'/RD/0';
                        rcList.add(rocrc);
                    }
                    Insert rcList;
                    List<VG_Policy_Schedule_Asset__c> psaList = new List<VG_Policy_Schedule_Asset__c>();
                    for(Policy_Schedule__c entityPS : InsertpsList){
                        Integer psacounter = 0;
                        for(VG_Policy_Schedule_Asset__c  psa : assetToBeInserted){
                            VG_Policy_Schedule_Asset__c tempPSA = psa.clone(false, true, false, false);
                            tempPSA.VG_Policy_Schedule__c = entityPS.id;
                            tempPSA.Name = entityPS.Name+'/RR/'+psacounter;
                            psacounter++;   
                            psaList.add(tempPSA);                
                        }
                    }
                    
                    List<VG_Policy_Schedule_Endorsement__c> pseList = new List<VG_Policy_Schedule_Endorsement__c>();
                    for(Policy_Schedule__c entityPS : InsertpsList){
                        Integer psecounter = 0;
                        Integer psesbcounter = 0;
                        for(VG_Policy_Schedule_Endorsement__c pse : endToBeInserted){
                            VG_Policy_Schedule_Endorsement__c tempPSE = pse.clone(false, true, false, false);
                            tempPSE.VG_Policy_Schedule__c = entityPS.id;
                            if(tempPSE.VG_Type__c  ==  'Endorsements'){
                                tempPSE.Name = entityPS.Name+'/PE/'+psecounter;
                                psecounter++;
                            }else{
                                tempPSE.Name = entityPS.Name+'/PESB/'+psesbcounter;
                                psesbcounter++;
                            }
                            pseList.add(tempPSE);
                        }
                    }
                    Utilities.SkipMethods('Trigger Context');
                    Utilities.SkipMethods('Trigger Context2');
                    Insert psaList;
                    Insert pseList;
                    return new PageReference('/'+policyId);
                }
                
            }
        }Catch(Exception e){
            Database.rollback(sp);
            showError(e);
            return null;
        }  
    }
    
    
    Public void showError(Exception e){
        String refId = ErrorTrace.insertLog(e , PSID);
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'An error occurred please contact admin with this reference id '+refId));     
    }
    
    
    Public class RRWrapper{
        Public VG_Policy_Schedule_Asset__c psa{get;set;}
        Public String Counter{get;set;}
        Public Decimal share {get; set;}
        Public Decimal totalfeeAmt {get; set;}
        Public String CoverageSelected{get;set;}
        Public String TerritorialLimitsSelected{get;set;}
        Public RRWrapper(){
            totalfeeAmt=0;
        }
    }
    
    
    Public Class LibraryWrapper{
        Public Endorsement_Library__c EL {get; set;}
        Public Boolean isSelected {get; set;} 
        
        Public LibraryWrapper(){
            EL = new Endorsement_Library__c();
            isSelected = False;
        }
    }
}