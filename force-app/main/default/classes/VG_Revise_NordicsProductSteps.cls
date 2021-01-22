public class VG_Revise_NordicsProductSteps {
    public Map<String,  PricingWrapper> pricingMap {get; set;}
    public Map<String,  PricingWrapper> FIPIpricingMap {get; set;}
    public Map<String,  Decimal> BIRates {get; set;}
    public Map<String,  Decimal> PDRates {get; set;}
    public Map<String,  Decimal> MBCMap {get; set;}
    public Map<String,  Decimal> MBBICMap {get; set;}
    public Map<Id,  Asset__c> allAccountAssets {get; set;}
    public Map<String,  VG_Exposure_Premium__c> exposuresMap {get; set;}
    public Map<String,  VG_Exposure_Premium__c> exposuresOthersMap {get; set;}
    Public Map<Id,  Policy_Schedule__c > oldPSIdDupPSRecMap {get; set;}
    public Map<Id,  List<VG_Policy_Schedule_Asset__c>> oldPSIdDupPSAMap {get; set;}
    public Map<Id,  List<VG_Policy_Schedule_Endorsement__c>> oldPSIdDupPSEMap {get; set;}
    public Map<Id,  List<VG_ReInsurance__c>> oldPSIdDupRIMap {get; set;}
    public Map<Id,  List<VG_Exposure_Premium__c>> oldPSIdDupExpMap {get; set;}
    public Map<Id,  List<Risk_Capture__c>> oldPSIdDupRCMap {get; set;}
    public Map<Id,  Policy_Schedule__c> psList {get; set;}
    
    public List<VG_Policy_Schedule_Endorsement__c> manualList{get;set;}
    public List<Endorsement_Library__c> ElList{get;set;}
    public List<PricingWrapper> otherFactors {get; set;}
    public List<PricingWrapper> FIPIFactors {get; set;}
    public List<VG_Pricing__c> priceList {get; set;}
    public List<OtherFactors> otherFactorsList {get; set;}
    public List<RRWrapper> riskRatingList {get; set;}
    public List<LibraryWrapper> LibraryWrapperList {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements {get; set;}
    public List<SelectOption> occupanciesList {get; set;}
    public List<SelectOption> MBCList {get; set;}
    public List<SelectOption> MBBICList {get; set;}
    public list<SelectOption> LP_Select {get; set;}
    public list<SelectOption> RRCoverage_Select {get; set;}
    public list<SelectOption> TerritorialLimits_Select {get; set;}
    public list<SelectOption> EEAVolanteEntity_Select {get; set;}
    public list<SelectOption> Prorateoption {get; set;} 
    Public List<SelectOption> splitTypes{get; set;}      
    public List<AssetWrapper> assetList {get; set;}
    public List<VG_Policy_Schedule_Asset__c> psaListDup {get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseListDup {get;set;}
    public List<VG_Exposure_Premium__c> expListDup {get;set;}
    public List<Risk_Capture__c> rcListDup {get;set;}
    //public List<PSWrapper> PSWrapperList {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements1 {get; set;}
    public List<Endorsement_Library__c> ElList1{get;set;}
    public List<LibraryWrapper> LibraryWrapperList1 {get; set;}
    public List<VG_Policy_Schedule_Asset__c> assetsList {get;set;}
    
    public Map<id, VG_Policy_Schedule_Endorsement__c> pseTempMap{get;set;}
    public Map<id, VG_Policy_Schedule_Endorsement__c> pseMap{get;set;}
    public Map<id, VG_Policy_Schedule_Asset__c> psaMap{get;set;}
    public Map<Id, PSWrapper> PSWrapperMap {get; set;}
    
    public PricingWrapper typeOfOperation {get; set;}
    public PricingWrapper deductibleFactor {get; set;}
    public LibraryWrapper LW{get;set;}   
    public AssetWrapper currentAsset {get; set;}    
    public LibraryWrapper LW1{get;set;}
    public VG_Pricing__c price {get;set;}
    public Policy_Schedule__c ps {get; set;}
    public Risk_Capture__c rc{get;set;} 
    public Policy__c p {get; set;}
    
    public Id policyId {get; set;}
    public Id accountId {get; set;}
    public Id PSId {get; set;}  
    
    public Boolean hasEndorsements {get; set;}
    public Boolean IsPricingGenerated {get; set;}
    public Boolean IsProperty {get; set;}
    public Boolean showAssetDetails {get; set;}
    public Boolean addAssetMode {get; set;}
    public Boolean showError {get; set;}
    public Boolean IsMTA {get; set;}
    public Boolean proSet{get;set;}
    Public Boolean skipSplit {get; set;}    
    public Boolean IsProrated {get; set;}
    public Boolean IsUWadjustmnetOverride {get; set;}
    public Boolean IsCommercialadjustmnetOverride {get; set;}
    
    public Long TurnoverValue{get;set;}
    public Long Turnover_Converted{get;set;}
    public Long limitAmount {get; set;}
    public Long attachment {get; set;}
    public Long limitAmount_Converted {get; set;}
    public Long attachment_Converted {get; set;}
    
    public Decimal fireNatCatPoolPremium {get;set;}
    public Decimal Losslimit {get;set;}
    public Decimal CreditScore {get;set;}
    public Decimal TOPRate {get;set;}
    public Decimal NBP{get;set;}
    public Decimal NBP_Converted{get;set;}
    public Decimal totalPremiumMovement {get; set;}
    public Decimal totalPremiumMovement_Converted {get; set;}
    public Decimal netExposurePremium {get; set;}
    public Decimal netExposurePremium_Converted {get; set;}
    public Decimal commissionPercent {get; set;}
    public Decimal netCommission {get; set;}
    public Decimal netPIPremium {get; set;}
    public Decimal netPIPremium_Converted {get; set;}
    public Decimal netCommission_Converted {get; set;}
    public Decimal grossBasePremium {get; set;}
    public Decimal grossBasePremium_Converted {get; set;}
    public Decimal exposurePremium {get; set;}
    public Decimal experiencePremium {get; set;}
    public Decimal experiencePremium_Converted {get; set;}
    public Decimal netModelPremium {get; set;}
    public Decimal deductible {get; set;}
    public Decimal seletedWeight {get; set;}
    public Decimal netBasePremium {get; set;}
    public Decimal netBasePremium_Converted_Pro {get; set;}
    public Decimal netBasePremium_Converted {get; set;}
    public Decimal brokerage {get; set;}
    public Decimal brokerageAmount {get; set;}
    public Decimal sumInsured {get; set;}
    public Decimal ilfPremium {get; set;}
    public Decimal ILFRate {get; set;}
    public Decimal ROL {get; set;}
    public Decimal RPM {get; set;}
    public Decimal RateChange {get;set;}
    public Decimal sharePercent {get; set;}
    public Decimal writtenShare {get; set;}
    public Decimal techPremium {get; set;}
    public Decimal techModelPremium {get; set;}
    public Decimal grossWrittenPremium {get; set;}
    public Decimal grossWrittenPremium2 {get; set;}
    public Decimal techLayerPremium {get; set;}
    //public Decimal IPTPercent {get; set;}
    public Decimal IPTAmount {get; set;}
    public Decimal DeductibleRate {get;set;}
    public Decimal DeductibleRate_Converted {get;set;}
    public Decimal adjustmentTechPremium {get; set;}
    public Decimal uwPremium {get; set;}
    public Decimal adjustment {get; set;}
    public Decimal actualPremium {get; set;}
    public Decimal orcPercent {get; set;}
    public Decimal orcAmount {get; set;}
    public Decimal endorsementPremium {get; set;}
    public Decimal transactionPremium {get; set;}
    public Decimal proratingFactor {get; set;}
    public Decimal adjustmentFactor {get; set;}
    public Decimal PDBaseRate {get; set;}
    public Decimal BIBaseRate {get; set;}
    public Decimal adjustedPDBaseRate {get; set;}
    public Decimal adjustedBIBaseRate {get; set;}
    public Decimal sekToUSDRate {get; set;}
    public Decimal levies {get; set;}
    public Decimal feeIncome {get; set;}
    public Decimal currentToUSDRate {get; set;}
    public Decimal currentToSEKRate {get; set;}
    public Decimal MBCRate {get; set;}
    public Decimal MBBICRate {get; set;}
    public Decimal ExtReportingPeriod_AP{get; set;}
    public Decimal AutoacqThreshold{get; set;}
    
    public Integer ExtReportingPeriod{get;set;}
    public Integer RDYear{get;set;}
    public Integer RDAP{get;set;}
    public Integer counter{get;set;}
    public Integer counterEnd {get; set;}
    public Integer orderIndex {get; set;}
    public Integer RRcounter {get; set;}
    public Integer numberOfPatients {get; set;}
    public Integer numberOfPatients_Converted {get; set;}
    
    public String pricingRate {get; set;}
    public String category {get; set;}
    public String Index{get;set;}
    public String selectedOccupancy {get; set;}
    public String policyCurrency {get; set;}
    public String layer {get; set;}
    public String ILFFactor {get; set;}
    public String MachineryBreakdownCover {get; set;}
    public String MachineryBreakdownBICover {get; set;}
    public String GrossOrNet {get; set;}
    public String LProduct {get;set;}
    public String MTAType {get; set;}
    public String MTAStartDate{get;set;}
    public String seletedProrateoption {get; set;} 
      
    public Date MTAcancellationDate{get;set;}
    
    public VG_Revise_NordicsProductSteps(){
        
        PSId  =  PSId != null? PSId : apexpages.currentpage().getparameters().get('PSId');
        MTAType  =  MTAType != null ? MTAType : apexpages.currentpage().getparameters().get('MTAType');
        policyId  = policyId != null ? policyId : apexpages.currentpage().getparameters().get('policyId');
        policyCurrency  =  policyCurrency != null ? policyCurrency : apexpages.currentpage().getparameters().get('policyCurrency');
        MTAStartDate  =  MTAStartDate != null ? MTAStartDate : apexpages.currentpage().getparameters().get('MTAStartDate');  
        seletedProrateoption  = seletedProrateoption != null ? seletedProrateoption : apexpages.currentpage().getparameters().get('seletedProrateoption');
        VG_Revise_NordicsProductSteps_Ext();
    }
     
        
     public Void VG_Revise_NordicsProductSteps_Ext(){
        assetsList  =  new List<VG_Policy_Schedule_Asset__c>();
        List<VG_Policy_Schedule_Endorsement__c> endList  =  new List<VG_Policy_Schedule_Endorsement__c>();
        existingEndorsements1  =  new List<VG_Policy_Schedule_Endorsement__c>();
        List<VG_Exposure_Premium__c> exposuresList  =  new List<VG_Exposure_Premium__c>();
        List<Risk_Capture__c> rcList  =  new List<Risk_Capture__c>();
        existingEndorsements  =  new List<VG_Policy_Schedule_Endorsement__c>();
        LibraryWrapperList1  =  new List<LibraryWrapper>();       
        pricingMap =  new Map<String,  PricingWrapper>();
        otherFactors  =  new List<PricingWrapper>();
        otherFactorsList  =  new List<OtherFactors>();
        assetList  =  new List<AssetWrapper>();
        FIPIFactors  =  new List<PricingWrapper>();
        riskRatingList  =  new List<RRWrapper>();
        LibraryWrapperList  =  new List<LibraryWrapper>();
        BIRates  =  new Map<String,  Decimal>();
        PDRates  =  new Map<String,  Decimal>();
        price  =  new VG_Pricing__c();
        exposuresMap  =  new Map<String,  VG_Exposure_Premium__c>();
        exposuresOthersMap  =  new Map<String,  VG_Exposure_Premium__c>();
        Prorateoption  =  new List<SelectOption>();
        Prorateoption.add(new SelectOption('--Select--', '--Select--'));
        Prorateoption.add(new SelectOption('Flat', 'Flat'));
        Prorateoption.add(new SelectOption('Prorated', 'Prorated'));
        IsPricingGenerated  =  False;
        proSet = false;
        counter = 0;
        RRcounter = 0;
        grossBasePremium  = 0;        
        IsProrated  =  false;
        IsUWadjustmnetOverride  =  false;
        IsCommercialadjustmnetOverride  =  false;
        sekToUSDRate  =  currentToUSDRate  =  1;
        List<CurrencyType> exchangeRates  =  [Select Id,  ConversionRate,  IsoCode from CurrencyType where IsoCode  =  'SEK' or IsoCode  = : policyCurrency];
        for(CurrencyType rt : exchangeRates){
            ////System.debug('Currency::'+rt.IsoCode+'::ConversionRate::'+rt.ConversionRate);
            if(rt.IsoCode  ==  'SEK' ){
                ////System.debug('SEK if::'+rt.ConversionRate);
                sekToUSDRate  =  rt.ConversionRate;
            }
            if(rt.IsoCode  ==  policyCurrency){
                ////System.debug('PolicyCurrency if::'+rt.ConversionRate);
                currentToUSDRate  =  rt.ConversionRate;
            }
        }
        currentToSEKRate  =  (currentToUSDRate/sekToUSDRate).setScale(3);
        if(MTAType  ==  null)
            IsMTA  =  False;
        else
            IsMTA  =  True;
        counterEnd  =  0;
        pseTempMap =  new Map<id, VG_Policy_Schedule_Endorsement__c>();            
        pseMap =  new Map<id, VG_Policy_Schedule_Endorsement__c>([select id, Name, VG_Endorsement_Library_Id__c, VG_Sub_limit__c, VG_Premium__c, VG_Endorsement_Details__c, VG_Title__c, VG_Type__c, VG_Product__c, VG_IsTempDelete__c, VG_Endorsement_Number__c  from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c = : PSID]);
        for(VG_Policy_Schedule_Endorsement__c pse: pseMap.values()){
            pseTempMap.put(pse.VG_Endorsement_Library_Id__c, pse);
        }
        manualList = new List<VG_Policy_Schedule_Endorsement__c>();
        for(VG_Policy_Schedule_Endorsement__c pse: pseMap.values()){
            if(pse.VG_Endorsement_Library_Id__c  ==  null)
                manualList.add(pse);
            else
                pseTempMap.put(pse.VG_Endorsement_Library_Id__c, pse);             
        }
        PSWrapperMap  =  new Map<Id, PSWrapper>();  
        EEAVolanteEntity_Select = new List<SelectOption>();
        for(String s : Label.Nordics_EEAVolanteEntity.split(';')){
            EEAVolanteEntity_Select.add(new SelectOption(s,s));
        }
        if(!IsMTA || MTAType == 'Revision of Cover'){
            //System.debug('19.10::'+PSID+PSId+'::'+ps);
            ps  =  [Select Id, Name,VG_Rate_Change__c,VG_Municipality_Code__c,VG_MTA_End_Date__c, VG_Co_Insurance_type__c,VG_Volante_Entities__c,VG_Entity_Split_Required__c,Split_Type__c,VG_MTA_Type__c,VG_Is_Co_Insurance__c, Policy__r.VG_Inception_Date__c, Policy__r.VG_Expiry_Date__c,  VG_MTA_Start_Date__c, VG_Norwegian_Nat_Cat_Pool_Premium__c, VG_Loss_Limit__c, VG_Pre_MTA_Expiry_Date__c, MTA_Parent_Policy_Schedule__c,  Policy__c, Policy__r.Insured__c,  VG_Lloyds_Product__c,  CurrencyISOCode,  Risk_Premium_Pro__c,  Endorsement_Premium_Pro__c,  VG_Turn_Over__c,  VG_Type_Of_Operation__c,  VG_Net_Base_Premium__c,  VG_Selected_Weight__c,  VG_Experience_Premium__c,  VG_Exposure_Premium__c,  VG_CREDIT_Augur_SCORE__c,  Net_Premium__c,  VG_Fee_Income__c,  VG_Adjusted_BI_Base_Rate__c,  VG_Adjusted_PD_Base_Rate__c,  VG_Adjustment_Factor__c,  VG_Machinery_Breakdown_BI_Cover__c,  VG_Machinery_Breakdown_Cover__c,  VG_BI_Base_Rate__c,  VG_PD_Base_Rate__c,  Levies__c,  VG_Occupancy__c,  IPT__c,  VG_Brokerage_Amount__c,  Actual_GWP__c,  VG_Brokerage_Percent__c,  ORC_Amount__c,  ORC__c,  VG_Technical_Model_Premium__c,  Premium_Adjustment_2__c,  Underwriting_Premium__c,  Premium_Adjustment__c,  Technical_UW_Premium__c,  Share__c,  Rate_Per_Mil__c,  VG_Extended_Reporting_Period_AP__c,  VG_Retired_Directors_Year__c,  VG_Retired_Directors_Additional_Premium__c,  VG_Auto_acquisition_Threshold__c,  Rate_On_Line__c,  Gross_or_Net_Premium__c,  Gross_Written_Premium__c,  VG_Deductible__c,  Technical_Layer_Premium__c,  Commission__c,  Product__c,  Written_share__c,  Gross_Base_Premium__c,  ILF_Layer__c,  ILF_Factor__c,  ILF_Premium__c,  Sum_Insured__c,  Attachment__c,  Transaction_GWP__c,VG_MTA_Cancellation_Date__c,VG_MTA_Reduction_Date__c,Limit__c, VG_Capacity_Paper__c from Policy_Schedule__c where Id  = : PSId limit 1];
            p  =  [Select Id, Name,VG_Is_Renewal__c,Insured__c, VG_Inception_Date__c,  VG_Expiry_Date__c from Policy__c where Id = : ps.Policy__c limit 1];
            accountId = ps.Policy__r.Insured__c;
            assetsList  =  [Select Id, VG_Premium__c, VG_Territorial_Limits__c,  VG_Net_Risk_Premium__c,  VG_Net_BI_Premium__c,  VG_Net_MB_Premium__c,  VG_Coverage__c,  VG_Net_PD_Premium__c,  VG_Deductible__c,  VG_Sub_limit__c,  VG_Share__c,  Asset__r.VG_Total_Property_Damage_SI__c,  Asset__r.VG_Full_Value_Building__c,  Asset__r.VG_Total_Business_Interruption_SI__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c  = : PSId];
            endList  =  [Select Id,  VG_Premium__c,  VG_Type__c, VG_Endorsement_Details__c,  VG_Sub_limit__c,VG_Title__c,  VG_Endorsement_Library_Id__c, VG_IsTempDelete__c, VG_Endorsement_Number__c from VG_Policy_Schedule_Endorsement__c where VG_Type__c  =  'Endorsements' AND VG_Policy_Schedule__c  = : PSId];
            exposuresList  =  [Select Id,  Name, VG_Factor_Name__c, VG_Other_Factor__c,  VG_Policy_Schedule__c,  VG_Rate__c,  VG_Rating_Factor__c from VG_Exposure_Premium__c where VG_Policy_Schedule__c  = : PSId];
            //System.debug('proratingFactor::'+proratingFactor+p.VG_Inception_Date__c+p.VG_Expiry_Date__c);
            splitTypes = new List<SelectOption>();            
            skipSplit = False;
            if(p.VG_Inception_Date__c.year() <= 2020){
                splitTypes.add(new SelectOption('','--None--'));
                skipSplit = True;
            }
            splitTypes.add(new SelectOption('EEA','EEA'));
                  
        
            if(MTAType  ==  null && ps.VG_MTA_Type__c  ==  null){
                if(Math.mod(ps.Policy__r.VG_Inception_Date__c.year(), 4) !=  0){
                    if(Math.mod(ps.Policy__r.VG_Expiry_Date__c.year(), 4)  ==  0){
                        if(ps.Policy__r.VG_Expiry_Date__c <=  date.newInstance(ps.Policy__r.VG_Expiry_Date__c.year(), 02, 28)){
                            proratingFactor = Decimal.valueOf(ps.Policy__r.VG_Inception_Date__c.daysBetween(ps.Policy__r.VG_Expiry_Date__c)+1)/365;
                        }else{
                            proratingFactor = Decimal.valueOf(ps.Policy__r.VG_Inception_Date__c.daysBetween(ps.Policy__r.VG_Expiry_Date__c))/365;
                        }
                    }else{
                        proratingFactor = Decimal.valueOf(ps.Policy__r.VG_Inception_Date__c.daysBetween(ps.Policy__r.VG_Expiry_Date__c)+1)/365;
                    }
                }else{
                    if(ps.Policy__r.VG_Inception_Date__c < date.newInstance(ps.Policy__r.VG_Inception_Date__c.year(),03,01)){
                        proratingFactor = Decimal.valueOf(ps.Policy__r.VG_Inception_Date__c.daysBetween(ps.Policy__r.VG_Expiry_Date__c))/365;
                    }else{
                        proratingFactor = Decimal.valueOf(ps.Policy__r.VG_Inception_Date__c.daysBetween(ps.Policy__r.VG_Expiry_Date__c)+1)/365;
                    }
                }
            }else{
                //proratingFactor = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
                if(Math.mod(ps.Policy__r.VG_Inception_Date__c.year(), 4) !=  0){
                    if(Math.mod(ps.Policy__r.VG_Expiry_Date__c.year(), 4)  ==  0){
                        if(ps.Policy__r.VG_Expiry_Date__c <=  date.newInstance(ps.Policy__r.VG_Expiry_Date__c.year(), 02, 28)){
                            proratingFactor = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
                        }else{
                            proratingFactor = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365;
                        }
                    }else{
                        proratingFactor = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
                    }
                }else{
                    if(ps.Policy__r.VG_Inception_Date__c < date.newInstance(ps.Policy__r.VG_Inception_Date__c.year(),03,01)){
                        proratingFactor = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365;
                    }else{
                        proratingFactor = MTAStartDate  !=   null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
                    }
                }
            }
            //System.debug('proratingFactor2::'+proratingFactor+'::'+p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c)/365+p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c));
            
            for(VG_Exposure_Premium__c exp : exposuresList ){
                if(!exp.VG_Other_Factor__c){
                    exposuresMap.put(exp.VG_Factor_Name__c,  exp);
                }else{
                    OtherFactors OFactor  =  new OtherFactors();
                    OFactor.expName = exp.Name;
                    OFactor.otherFactor  =  exp.VG_Factor_Name__c;
                    OFactor.factor  =  exp.VG_Rating_Factor__c;
                    OFactor.rate  =  exp.VG_Rate__c;
                    otherFactorsList.add(OFactor);
                    exposuresOthersMap.put(exp.Name, exp);
                    //System.debug('otherFactors::'+otherFactorsList);
                }
            }
            if(otherFactorsList.size() < 3){
                
                for(Integer i = otherFactorsList.size() ; i<3; i++){
                    otherFactorsList.add(new OtherFactors());
                }
            }
            policyId  =  ps.Policy__c;
            LProduct  =  ps.VG_Lloyds_Product__c; 
            //netBasePremium_Converted  =  ps.Risk_Premium_Pro__c / proratingFactor;
            endorsementPremium  =  ps.Endorsement_Premium_Pro__c !=  null ? ps.Endorsement_Premium_Pro__c/ proratingFactor : 0;
            netModelPremium  =  ps.Net_Premium__c;
            commissionPercent  =  ps.Commission__c;
            grossBasePremium  =  ps.Gross_Base_Premium__c;
            transactionPremium  =  ps.Transaction_GWP__c;
            limitAmount_Converted  =  ps.Limit__c  ==  null ? null : ps.Limit__c.longValue();
            attachment_Converted  =  ps.Attachment__c  ==  null ? null : ps.Attachment__c.longValue();
            sumInsured  =  ps.Sum_Insured__c;
            ilfFactor  =  ps.ILF_Factor__c;
            ilfPremium  =  ps.ILF_Premium__c;
            layer  =  ps.ILF_Layer__c;
            writtenShare  =  ps.Written_share__c;
            //System.debug('writtenShare::'+writtenShare+ps.Written_share__c);
            if(ps.Product__c  ==  'Property'){
                IsProperty  =  True;
            }else{
                IsProperty  =  False;
            }
            price.VG_Product__c  =  ps.Product__c;
            DeductibleRate_Converted  =  ps.VG_Deductible__c;
            techLayerPremium  =  ps.Technical_Layer_Premium__c;
            grossWrittenPremium  =  ps.Gross_Written_Premium__c;
            GrossOrNet  =  ps.Gross_or_Net_Premium__c;
            ROL  =  ps.Rate_On_Line__c;
            AutoacqThreshold  =  ps.VG_Auto_acquisition_Threshold__c;
            if(ps.VG_Retired_Directors_Additional_Premium__c !=  null)
                RDAP  =  ps.VG_Retired_Directors_Additional_Premium__c.intValue();
            if(ps.VG_Retired_Directors_Year__c !=  null)
                RDYear  =  ps.VG_Retired_Directors_Year__c.intValue();
            ExtReportingPeriod_AP  =  ps.VG_Extended_Reporting_Period_AP__c;
            RPM  =  ps.Rate_Per_Mil__c;
            sharePercent  =  ps.Share__c;
            uwPremium  =  ps.Technical_UW_Premium__c;
            adjustmentTechPremium  =  ps.Premium_Adjustment__c;
            uwPremium  =  ps.Underwriting_Premium__c;
            adjustment  =  ps.Premium_Adjustment_2__c;
            techModelPremium  =  ps.VG_Technical_Model_Premium__c;
            orcPercent  =  ps.ORC__c;
            orcAmount  =  ps.ORC_Amount__c;
            brokerage  =  ps.VG_Brokerage_Percent__c;
            RateChange = ps.VG_Rate_Change__c;
            //below 3 lines added by Anu 30.8.2018
            actualPremium  =  ps.Actual_GWP__c;
            brokerageAmount  =  ps.VG_Brokerage_Amount__c;
            IPTAmount  =  ps.IPT__c;
            //ps.IPT_Percent__c  =  IPTPercent;
            levies  =  ps.Levies__c;
            feeIncome  =  ps.VG_Fee_Income__c;
            if(ps.Product__c == 'FIPI'){
                rc = new Risk_Capture__c();
                rcList = new List<Risk_Capture__c >([select id, Name, VG_Additional_Information__c, Policy_Schedule__c from Risk_Capture__c where Policy_Schedule__c = :PSID limit 1]);
                if(rcList.size()>0)
                    rc = rcList[0];
            }
            if(IsProperty){
                selectedOccupancy  =  ps.VG_Occupancy__c;
                PDBaseRate  =  ps.VG_PD_Base_Rate__c;
                BIBaseRate  =  ps.VG_BI_Base_Rate__c;
                Losslimit  =  ps.VG_Loss_Limit__c;
                fireNatCatPoolPremium  =  ps.VG_Norwegian_Nat_Cat_Pool_Premium__c ;               
                MachineryBreakdownCover  =  ps.VG_Machinery_Breakdown_Cover__c;
                MachineryBreakdownBICover  =  ps.VG_Machinery_Breakdown_BI_Cover__c;
                adjustmentFactor  =  ps.VG_Adjustment_Factor__c;
                adjustedPDBaseRate  =  ps.VG_Adjusted_PD_Base_Rate__c;
                adjustedBIBaseRate  =  ps.VG_Adjusted_BI_Base_Rate__c;
            }else{
                if(ps.VG_Turn_Over__c !=  null){
                    if(ps.Product__c != 'Clinical Trials')
                        Turnover_Converted  =  ps.VG_Turn_Over__c.longValue();
                    if(ps.Product__c  == 'Clinical Trials')
                        numberOfPatients_Converted  =  Integer.valueOf(ps.VG_Turn_Over__c);
                }else{
                    Turnover_Converted  =  0;
                    numberOfPatients_Converted = 0;
                }
                //System.debug('numberOfPatients_Converted::'+numberOfPatients_Converted+ps.VG_Turn_Over__c);
                pricingRate  =  ps.VG_Type_Of_Operation__c;
                creditScore  =  ps.VG_CREDIT_Augur_SCORE__c;
                DeductibleRate_Converted  =  ps.VG_Deductible__c;
                netExposurePremium_Converted  =  ps.VG_Exposure_Premium__c;
                experiencePremium_Converted  =  ps.VG_Experience_Premium__c;
                seletedWeight  =  ps.VG_Selected_Weight__c;
                netBasePremium_Converted  =  ps.Risk_Premium_Pro__c;
            }
            existingEndorsements.addAll(endList);
            if(IsProperty){                
                for(VG_Policy_Schedule_Asset__c asset : assetsList){
                    //System.debug('Is Property');
                    AssetWrapper AW  =  new AssetWrapper();
                    AW.asset  =  asset;
                    AW.totalPropertyDamageSI  =  asset.Asset__r.VG_Total_Property_Damage_SI__c;
                    AW.totalBusinessInterruptionSI  =  asset.Asset__r.VG_Total_Business_Interruption_SI__c;
                    If(AW.totalPropertyDamageSI!= null && AW.totalBusinessInterruptionSI!= null)
                        AW.totalSumInsuredSI  =  AW.totalPropertyDamageSI + AW.totalBusinessInterruptionSI;
                    AW.fullValue  =  asset.Asset__r.VG_Full_Value_Building__c;
                    AW.NetPDPremium  =  asset.VG_Net_PD_Premium__c;
                    AW.NetBIPremium  =  asset.VG_Net_BI_Premium__c;
                    AW.AdjustedMBPremium  =  asset.VG_Net_MB_Premium__c;
                    AW.NetRiskPremium  =  asset.VG_Net_Risk_Premium__c;
                    assetList.add(AW);
                }
            }else{
                for(VG_Policy_Schedule_Asset__c asset : assetsList){
                    RRWrapper RW  =  new RRWrapper();
                    RW.TerritorialLimitsSelected  =  asset.VG_Territorial_Limits__c;
                    RW.CoverageSelected  =  asset.VG_Coverage__c;
                    RW.share  =  asset.VG_Share__c;
                    RW.psa  =  asset;
                    riskRatingList.add(RW);
                }
            }
            for(RRWrapper rr : riskRatingList){
                rr.CoverageSelected = rr.psa.VG_Coverage__c;
                rr.TerritorialLimitsSelected = rr.psa.VG_Territorial_Limits__c;
                //System.debug('rr.CoverageSelected::'+rr.CoverageSelected+rr.psa.VG_Coverage__c+'::'+rr.psa.VG_Territorial_Limits__c);
            }
            
            pseMap =  new Map<id, VG_Policy_Schedule_Endorsement__c>([select id, Name, VG_Endorsement_Library_Id__c, VG_Sub_limit__c, VG_Premium__c, VG_Endorsement_Details__c, VG_Title__c, VG_Type__c, VG_IsTempDelete__c, VG_Endorsement_Number__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c = : PSID]);
            for(VG_Policy_Schedule_Endorsement__c pse: pseMap.values()){
                pseTempMap.put(pse.VG_Endorsement_Library_Id__c, pse);
            }
            setLPList();
            List<String> TerritorialLimitsSplit = Label.Bridge_NonCC_TerritorialLimits.split(';');
            TerritorialLimits_Select = new List<SelectOption>();
            TerritorialLimits_Select.add(new SelectOption('--None--', '--None--'));
            for(String s : TerritorialLimitsSplit){
                TerritorialLimits_Select.add(new SelectOption(s,s));
            } 
            if(MTAType == 'Revision of Cover'){
                gotostep2();
                riskRatingList.clear();
                assetList.clear();
                //sharePercent  =  writtenShare  =  adjustmentTechPremium  =  adjustment  =  brokerage  =  feeIncome  =  levies  =  0;
            }
        }else{
            oldPSIdDupPSAMap  =  new Map<Id,  List<VG_Policy_Schedule_Asset__c>>();
            oldPSIdDupPSEMap  =  new Map<Id,  List<VG_Policy_Schedule_Endorsement__c>>();
            oldPSIdDupExpMap  =  new Map<Id,  List<VG_Exposure_Premium__c>>();
            oldPSIdDupRCMap  =  new Map<Id,  List<Risk_Capture__c>>();
            psList  =  new Map<Id,  Policy_Schedule__c>();
            List<Policy_Schedule__c> existingPSList  =  new List<Policy_Schedule__c>();
            existingPSList  =  [Select Id, VG_Rate_Change__c,VG_Municipality_Code__c,VG_Volante_Entities__c,VG_Entity_Split_Required__c,Split_Type__c,VG_Co_Insurance_type__c,MTA_Parent_Policy_Schedule__c,VG_MTA_End_Date__c,VG_Pre_MTA_Expiry_Date__c, VG_Norwegian_Nat_Cat_Pool_Premium__c, VG_Loss_Limit__c, VG_MTA_Start_Date__c,  Name,  Policy__c,  VG_Lloyds_Product__c,  CurrencyISOCode,  VG_MTA_Type__c,  VG_Is_MTA__c,  VG_Base_Policy__c,  Base_Creation_End_Date__c,  Base_Creation_Start_Date__c,  Risk_Premium_Pro__c,  Endorsement_Premium_Pro__c,  VG_Turn_Over__c,  VG_Type_Of_Operation__c,  VG_Net_Base_Premium__c,  VG_Selected_Weight__c,  VG_Experience_Premium__c,  VG_Exposure_Premium__c,  VG_CREDIT_Augur_SCORE__c,  Net_Premium__c,  VG_Fee_Income__c,  VG_Adjusted_BI_Base_Rate__c,  VG_Adjusted_PD_Base_Rate__c,  VG_Adjustment_Factor__c,  VG_Machinery_Breakdown_BI_Cover__c,  VG_Machinery_Breakdown_Cover__c,  VG_BI_Base_Rate__c,  VG_PD_Base_Rate__c,  Levies__c,  VG_Occupancy__c,  IPT__c,  VG_Brokerage_Amount__c,  Actual_GWP__c,  VG_Brokerage_Percent__c,  ORC_Amount__c,  ORC__c,  VG_Technical_Model_Premium__c,  Premium_Adjustment_2__c,  Underwriting_Premium__c,  Premium_Adjustment__c,  Technical_UW_Premium__c,  Share__c,  Rate_Per_Mil__c,  VG_Extended_Reporting_Period_AP__c,  VG_Retired_Directors_Year__c,  VG_Retired_Directors_Additional_Premium__c,  VG_Auto_acquisition_Threshold__c,  Rate_On_Line__c,  Gross_or_Net_Premium__c,  Gross_Written_Premium__c,  VG_Deductible__c,  Technical_Layer_Premium__c,  Commission__c,  Product__c,  Written_share__c,  Gross_Base_Premium__c,  ILF_Layer__c,  ILF_Factor__c,  ILF_Premium__c,  Sum_Insured__c,  Attachment__c,  Transaction_GWP__c, VG_MTA_Cancellation_Date__c, VG_MTA_Reduction_Date__c,Limit__c, VG_Capacity_Paper__c, VG_Is_Co_Insurance__c from Policy_Schedule__c where Policy__c  = : policyId];
            for(Policy_Schedule__c ps : existingPSList){
                ps.Levies__c  =  0;
                ps.VG_Fee_Income__c  =  0;
                psList.put(ps.Id,  ps);
                if(!ps.VG_Base_Policy__c){
                    //mtaListTemp.add(ps);
                } 
            }
            assetsList  =  [Select Id, VG_Premium__c,  VG_Territorial_Limits__c, VG_Policy_Schedule__c, VG_Net_Risk_Premium__c, VG_Net_BI_Premium__c,  VG_Net_MB_Premium__c,  VG_Coverage__c,  VG_Net_PD_Premium__c,  VG_Deductible__c,  VG_Sub_limit__c,  VG_Share__c,  Asset__r.VG_Total_Property_Damage_SI__c,  Asset__r.VG_Full_Value_Building__c,  Asset__r.VG_Total_Business_Interruption_SI__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psList.KeySet()];
            endList  =  [Select Id,  VG_Premium__c,  VG_Endorsement_Details__c,  VG_Sub_limit__c,  VG_Policy_Schedule__c,  VG_Title__c, VG_IsTempDelete__c, VG_Endorsement_Number__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c IN: psList.KeySet()];
            exposuresList  =  [Select Id,  VG_Factor_Name__c, VG_Other_Factor__c,  VG_Policy_Schedule__c,  VG_Rate__c,  VG_Rating_Factor__c from VG_Exposure_Premium__c where VG_Policy_Schedule__c IN: psList.KeySet()];
            rcList = new List<Risk_Capture__c>([select id, Name, CurrencyIsoCode, CreatedDate, Policy_Schedule__c, VG_Risk_start__c, VG_Additional_Information__c from Risk_Capture__c where Policy_Schedule__c IN:  psList.KeySet()]);
            for(Risk_Capture__c rc : rcList){
                if(oldPSIdDupRCMap.get(rc.Policy_Schedule__c)  ==  null){
                    rcListDup  =  new List<Risk_Capture__c>();
                }else{
                    rcListDup  =  oldPSIdDupRCMap.get(rc.Policy_Schedule__c);
                }
                
                rcListDup.add(rc);
                oldPSIdDupRCMap.put(rc.Policy_Schedule__c,  rcListDup);
            }
            for(VG_Policy_Schedule_Asset__c psa : assetsList){
                if(oldPSIdDupPSAMap.get(psa.VG_Policy_Schedule__c)  ==  null){
                    psaListDup  =  new List<VG_Policy_Schedule_Asset__c>();
                }else{
                    psaListDup  =  oldPSIdDupPSAMap.get(psa.VG_Policy_Schedule__c);
                }
                
                psaListDup.add(psa);
                oldPSIdDupPSAMap.put(psa.VG_Policy_Schedule__c,  psaListDup);
            }
            for(VG_Policy_Schedule_Endorsement__c pse : endList){
                if(oldPSIdDupPSEMap.get(pse.VG_Policy_Schedule__c)  ==  null){
                    pseListDup  =  new List<VG_Policy_Schedule_Endorsement__c>();
                }else{
                    pseListDup  =  oldPSIdDupPSEMap.get(pse.VG_Policy_Schedule__c);
                }
                pseListDup.add(pse);
                oldPSIdDupPSEMap.put(pse.VG_Policy_Schedule__c,  pseListDup);
            }
            for(VG_Exposure_Premium__c pse : exposuresList){
                if(oldPSIdDupExpMap.get(pse.VG_Policy_Schedule__c)  ==  null){
                    expListDup  =  new List<VG_Exposure_Premium__c>();
                }else{
                    expListDup  =  oldPSIdDupExpMap.get(pse.VG_Policy_Schedule__c);
                }
                expListDup.add(pse);
                oldPSIdDupExpMap.put(pse.VG_Policy_Schedule__c,  expListDup);
            }
            for(Policy_Schedule__c psch : psList.values()){                   
                PSWrapper PSW  =  new PSWrapper();
                PSW.ps  =  psch;
                PSW.netBasePremium_Converted  =  psch.Risk_Premium_Pro__c;
                //System.debug('PSW.netBasePremium::'+PSW.netBasePremium_Converted+'::'+PSW.ps.Premium_Adjustment__c);
                PSW.endorsementPremium  =  psch.Endorsement_Premium_Pro__c;
                PSW.netModelPremium  =  psch.Net_Premium__c;
                PSW.commissionPercent  =  psch.Commission__c;
                PSW.grossBasePremium  =  psch.Gross_Base_Premium__c;
                PSW.transactionPremium  =  (psch.Transaction_GWP__c!= null?psch.Transaction_GWP__c:0);
                PSW.limitAmount_Converted  =  psch.Limit__c !=  null ? psch.Limit__c.longValue() : 0;
                PSW.attachment_Converted  =  psch.Attachment__c !=  null ? psch.Attachment__c.longValue() : 0;
                PSW.sumInsured  =  psch.Sum_Insured__c;
                PSW.ilfFactor  =  psch.ILF_Factor__c !=  null ? psch.ILF_Factor__c : '';
                PSW.ilfPremium  =  (psch.ILF_Premium__c!= null? psch.ILF_Premium__c:0) ;
                PSW.layer  =  psch.ILF_Layer__c !=  null ? psch.ILF_Layer__c : '';
                PSW.writtenShare  =  psch.Written_share__c;
                //System.debug('PSW.psch.Product__c is' + PSW.ps.Product__c+PSW.ilfPremium);
                if(PSW.ps.Product__c  ==  'Property'){
                    IsProperty  =  True;
                }else{
                    IsProperty  =  False;
                }
                PSW.price.VG_Product__c  =  psch.Product__c;
                PSW.DeductibleRate_Converted  =  psch.VG_Deductible__c;
                PSW.techLayerPremium  =  psch.Technical_Layer_Premium__c;
                PSW.grossWrittenPremium  =  psch.Gross_Written_Premium__c;
                PSW.GrossOrNet  =  psch.Gross_or_Net_Premium__c;
                PSW.ROL  =  psch.Rate_On_Line__c;
                PSW.AutoacqThreshold  =  psch.VG_Auto_acquisition_Threshold__c;
                if(PSW.ps.VG_Retired_Directors_Additional_Premium__c !=  null)
                    PSW.RDAP  =  psch.VG_Retired_Directors_Additional_Premium__c.intValue();
                if(PSW.ps.VG_Retired_Directors_Year__c !=  null)
                    PSW.RDYear  =  psch.VG_Retired_Directors_Year__c.intValue();
                PSW.ExtReportingPeriod_AP  =  psch.VG_Extended_Reporting_Period_AP__c;
                PSW.RPM  =  psch.Rate_Per_Mil__c;
                PSW.sharePercent  =  psch.Share__c;
                PSW.uwPremium  =  (psch.Technical_UW_Premium__c!= null?psch.Technical_UW_Premium__c:0);
                PSW.adjustmentTechPremium  =  PSW.ps.Premium_Adjustment__c; 
                PSW.uwPremium  =  psch.Underwriting_Premium__c;
                PSW.adjustment  =  psch.Premium_Adjustment_2__c;
                PSW.techModelPremium  =  psch.VG_Technical_Model_Premium__c;
                PSW.orcPercent  =  psch.ORC__c;
                PSW.orcAmount  =  psch.ORC_Amount__c;
                PSW.brokerage  =  psch.VG_Brokerage_Percent__c;
                //below 3 lines added by Anu 30.8.2018
                PSW.actualPremium  =  psch.Actual_GWP__c;
                PSW.brokerageAmount  =  psch.VG_Brokerage_Amount__c;
                PSW.IPTAmount  =  psch.IPT__c;
                PSW.RateChange = psch.VG_Rate_Change__c;
                PSW.levies  =  psch.Levies__c;
                PSW.feeIncome  =  psch.VG_Fee_Income__c;
                if(IsProperty){
                    PSW.selectedOccupancy  =  psch.VG_Occupancy__c;
                    PSW.PDBaseRate  =  psch.VG_PD_Base_Rate__c;
                    PSW.BIBaseRate  =  psch.VG_BI_Base_Rate__c;
                    PSW.Losslimit  =  psch.VG_Loss_Limit__c;
                    PSW.fireNatCatPoolPremium  =  psch.VG_Norwegian_Nat_Cat_Pool_Premium__c;
                    PSW.MachineryBreakdownCover  =  psch.VG_Machinery_Breakdown_Cover__c;
                    PSW.MachineryBreakdownBICover  =  psch.VG_Machinery_Breakdown_BI_Cover__c;
                    PSW.adjustmentFactor  =  psch.VG_Adjustment_Factor__c;
                    PSW.adjustedPDBaseRate  =  psch.VG_Adjusted_PD_Base_Rate__c;
                    PSW.adjustedBIBaseRate  =  psch.VG_Adjusted_BI_Base_Rate__c;
                }else if(!IsProperty && PSW.ps.Product__c !=  'Commercial Combined'){
                    PSW.Turnover_Converted  =  (psch.VG_Turn_Over__c!= null? psch.VG_Turn_Over__c.longValue() : 0);
                    PSW.pricingRate  =  psch.VG_Type_Of_Operation__c;
                    PSW.creditScore  =  psch.VG_CREDIT_Augur_SCORE__c;
                    PSW.DeductibleRate_Converted  =  psch.VG_Deductible__c;
                    PSW.netExposurePremium_Converted  =  psch.VG_Exposure_Premium__c;
                    PSW.experiencePremium_Converted  =  psch.VG_Experience_Premium__c;
                    PSW.seletedWeight  =  psch.VG_Selected_Weight__c;
                    PSW.netBasePremium  =  ((0.5*(PSW.netExposurePremium_Converted)) + ((PSW.seletedWeight/100)*(PSW.experiencePremium_Converted)) + ((1 - ((PSW.seletedWeight)/100))*(0.5*(PSW.netExposurePremium_Converted)))).round(System.RoundingMode.CEILING);
                    //System.debug('netPremium::'+PSW.netExposurePremium_Converted+'::'+PSW.seletedWeight+'::');
                    //System.debug('netPremium::'+PSW.experiencePremium_Converted+'::'+PSW.netBasePremium+'::'+PSW.netBasePremium_Converted);
                } 
                if(oldPSIdDupPSAMap.get(psch.Id) !=  null && !oldPSIdDupPSAMap.get(psch.Id).IsEmpty()){
                    PSW.psaList  =  oldPSIdDupPSAMap.get(psch.Id);
                    PSW.hasAssets  =  True; 
                }else{
                    PSW.hasAssets  =  False; 
                    PSW.psaList  =  new List<VG_Policy_Schedule_Asset__c >();
                }   
                if(oldPSIdDupPSEMap.get(psch.Id) !=  null && !oldPSIdDupPSEMap.get(psch.Id).IsEmpty()){
                    //System.debug('DupPSE::'+oldPSIdDupPSEMap.get(psch.Id));
                    PSW.pseList  =  oldPSIdDupPSEMap.get(psch.Id);
                    PSW.hasEndorsements  =  True; 
                }else{
                    PSW.hasEndorsements  =  False; 
                    PSW.pseList  =  new List<VG_Policy_Schedule_Endorsement__c>();
                } 
                if(oldPSIdDupEXPMap.get(psch.Id) !=  null && !oldPSIdDupEXPMap.get(psch.Id).IsEmpty()){
                    //System.debug('DupRc::'+oldPSIdDupEXPMap.get(psch.Id));
                    PSW.expList  =  oldPSIdDupEXPMap.get(psch.Id);
                    PSW.hasEXPs  =  True; 
                }else{
                    PSW.hasEXPs  =  False; 
                    PSW.expList  =  new List<VG_Exposure_Premium__c>();
                }   
                if(oldPSIdDupRCMap.get(psch.Id) !=  null && !oldPSIdDupRCMap.get(psch.Id).IsEmpty()){
                    PSW.RCList  =  oldPSIdDupRCMap.get(psch.Id);
                    PSW.hasRCs  =  True; 
                }else{
                    PSW.hasRCs  =  False; 
                    PSW.RCList  =  new List<Risk_Capture__c>();
                } 
                PSWrapperMap.put(PSW.ps.id,PSW);
                //System.debug(' ==  = '+PSW.hasAssets+' '+PSW.hasEndorsements+' '+PSW.hasExps);
            }
            p  =  [Select Id, Name, VG_Is_Renewal__c, VG_Inception_Date__c,  VG_Expiry_Date__c from Policy__c where Id = : policyId];
            //proratingFactor  =  (p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c)+1)/365;
            if(Math.mod(p.VG_Inception_Date__c.year(), 4) !=  0){
                if(Math.mod(p.VG_Expiry_Date__c.year(), 4)  ==  0){
                    if(p.VG_Expiry_Date__c <=  date.newInstance(p.VG_Expiry_Date__c.year(), 02, 28)){
                        proratingFactor  = Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c)+1)/365;
                    }else{
                        proratingFactor  = Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c))/365;
                    }
                }else{
                    proratingFactor  = Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c)+1)/365;
                }
            }else{
                if(p.VG_Inception_Date__c < date.newInstance(p.VG_Inception_Date__c.year(),03,01)){
                    proratingFactor  = Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c))/365;
                }else{
                    proratingFactor  = Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c)+1)/365;
                }
            }
            ps  =  new Policy_Schedule__c();
            ps.VG_VAT__c = 0;
            ps.VG_VAT_Amount__c = 0;
            ps.VG_MTA_Start_Date__c  =  p.VG_Expiry_Date__c.addDays(1);
            ps.VG_Pre_MTA_Expiry_Date__c  =  p.VG_Expiry_Date__c;
        }
    }
    
     Public void setLPList(){
        LP_Select = new list<SelectOption>();
        RRCoverage_Select = new list<SelectOption>();
        String LPList = '';
        String CoverageList = '';
        if(price.VG_Product__c == 'Commercial'){
            LPList = Label.Bridge_LoydsProduct_NonCC_Commercial;
            CoverageList = Label.Bridge_Coverages_NonCC_Commercial;
        }else if(price.VG_Product__c == 'GLPL'){
            LPList = Label.Bridge_LoydsProduct_NonCC_GLPL;
            CoverageList = Label.Bridge_Coverages_NonCC_GLPL;
        }else if(price.VG_Product__c == 'Life Sciences'){
            LPList = Label.Bridge_LoydsProduct_NonCC_LS;
            CoverageList = Label.Bridge_Coverages_NonCC_LS;
        }else if(price.VG_Product__c == 'Clinical Trials'){
            LPList = Label.Bridge_LoydsProduct_NonCC_CT;
            CoverageList = Label.Bridge_Coverages_NonCC_CT;
        }else if(price.VG_Product__c == 'D&O'){
            LPList = Label.Bridge_LoydsProduct_NonCC_D_O;
            CoverageList = Label.Bridge_Coverages_NonCC_D_O;
        }else if(price.VG_Product__c == 'PI'){
            LPList = Label.Bridge_LoydsProduct_NonCC_PI;
            CoverageList = Label.Bridge_Coverages_NonCC_PI;
        }else if(price.VG_Product__c == 'FIPI'){
            LPList = Label.Bridge_LoydsProduct_NonCC_FIPI;
            CoverageList = Label.Bridge_Coverages_NonCC_FIPI;
        }else if(price.VG_Product__c == 'Crime'){
            LPList = Label.Bridge_LoydsProduct_NonCC_Crime;
            CoverageList = Label.Bridge_Coverages_NonCC_Crime;
        }else if(price.VG_Product__c == 'Property'){
            LPList = Label.Bridge_LoydsProduct_NonCC_Property;
        }
        for(String s : LPList.split(';')){
            LP_Select.add(new SelectOption(s,s));
        } 
        RRCoverage_Select.add(new SelectOption('--None--', '--None--'));
        for(String s : CoverageList.split(';')){
            RRCoverage_Select.add(new SelectOption(s,s));
        } 
    }
    
    public void updateExposure(){
        Decimal currentNBP_Converted;
        if(IsProperty){
            System.debug(selectedOccupancy);
            PDBaseRate  =  PDRates.get(selectedOccupancy);
            BIBaseRate  =  BIRates.get(selectedOccupancy);
            adjustmentFactor  =  1;
            for(PricingWrapper PW : otherFactors){
                PW.priceDecimal  =  Decimal.valueOf(PW.price.split('>')[0]);
                adjustmentFactor  =  adjustmentFactor + PW.priceDecimal;
            }
            If(PDBaseRate!= null && adjustmentFactor!= null)
                adjustedPDBaseRate  =  PDBaseRate*adjustmentFactor;
            If(BIBaseRate!= null && adjustmentFactor!= null)
                adjustedBIBaseRate  =  BIBaseRate*adjustmentFactor;
            MBCRate  =  MBCMap.get(MachineryBreakdownCover);
            MBBICRate  =  MBBICMap.get(MachineryBreakdownBICover);
            System.debug('MBCRate'+MBCRate +',  MBBICRate '+MBBICRate );
        }else{
            if(pricingRate !=  null && Turnover_Converted !=  0){
                //Turnover_Converted  =  TurnoverValue;
                if(Turnover_Converted !=  null)
                    TurnoverValue  =  (Turnover_Converted/currentToSEKRate).longValue();
                System.debug('currentToSEKRate:: '+currentToSEKRate);
                TOPRate  =  Decimal.valueOf(pricingRate.split('>')[0]);
                decimal tmp;
                if(price.VG_Product__c  ==  'GLPL')
                    tmp  =  (((155632*(1/(Math.exp(0.778*Math.log(TurnoverValue )))))/1000)*(TurnoverValue))*TOPRate; // Net Base Premium  =  ((155632 x (Revenue)^-0.778)/1000XRevenue)X Type of Operation
                else if(price.VG_Product__c  ==  'Life Sciences')
                    tmp  =  (((155632*(1/(Math.exp(0.778*Math.log(TurnoverValue)))))/1000)*(TurnoverValue ))*TOPRate; // Net Base Premium  =  (155632 X(Revenue)^-.778/1000)X Revenue
                else if(price.VG_Product__c  ==  'Clinical Trials' && numberOfPatients_Converted != 0){
                    numberOfPatients   =  (numberOfPatients_Converted /currentToSEKRate ).intValue();
                    tmp  =  (numberOfPatients*(3070.6*(1/(Math.exp(0.625*Math.log(numberOfPatients))))))*TOPRate; // Net Base Premium  =  (3070.6 X (Number of Patients)^-.625) X Number of patients X Type of Operation Lookup Net Base Premium  =  (3070.6 X (Number of Patients)^-.625) X Number of patients X Type of Operation Lookup
                }else if(price.VG_Product__c  ==  'PI' || price.VG_Product__c  ==  'FIPI')
                    tmp  =  ((465975*(1/(Math.exp(0.8*Math.log(TurnoverValue)))))/1000)*TurnoverValue*TOPRate; // Net Base Premium  =    465975  X (Revenue)^-.08/1000 X Revenue * Type of Operation Lookup 
                else if(price.VG_Product__c  ==  'IPO' || price.VG_Product__c  ==  'Crime')
                    tmp  =  (((66672*(1/(Math.exp(0.68*Math.log(TurnoverValue )))))/1000)*(TurnoverValue))*TOPRate; //getFLRates(TurnoverValue,  price.VG_Product__c)*TOPRate;
                else if(price.VG_Product__c  ==  'D&O')
                    tmp  =  (((27962*(1/(Math.exp(0.735*Math.log(TurnoverValue )))))/1000)*(TurnoverValue))*TOPRate;
                //tmp = tmp*currentToSEKRate;
                NBP =  tmp.setScale(2);
            }else{
                NBP  =  0;
            }
            Decimal currentNBP  =  NBP;
            NBP_Converted  =  (NBP*currentToSEKRate).setScale(2);
            totalPremiumMovement  =  0;
            for(PricingWrapper PW : otherFactors){
                if(PW.price !=  null){
                    PW.priceDecimal  =  Decimal.valueOf(PW.price.split('>')[0]);
                    if(PW.priceDecimal == 0){
                        PW.premiumMovement  =  0;
                    }else if(PW.priceDecimal<1){
                        PW.premiumMovement  =  (currentNBP * (PW.priceDecimal - 1)).round(System.RoundingMode.CEILING);
                        currentNBP  =  currentNBP + PW.premiumMovement;
                    }else if(PW.priceDecimal == 1){
                        PW.premiumMovement  =  0;
                    }else{
                        PW.premiumMovement  =  ((NBP) * (PW.priceDecimal - 1)).round(System.RoundingMode.CEILING);
                    }
                }else{
                    PW.premiumMovement  =  0;
                }
                totalPremiumMovement  =  totalPremiumMovement + PW.premiumMovement;
                PW.premiumMovement_Converted = (PW.premiumMovement*currentToSEKRate).setScale(2);
            }
            if(price.VG_Product__c  ==  'FIPI'){
                netPIPremium_Converted  =  NBP + totalPremiumMovement;
                Decimal CurrentnetPIPremium  =  netPIPremium_Converted;
                for(PricingWrapper PW : FIPIFactors){
                    if(PW.price !=  null){
                        PW.priceDecimal  =  Decimal.valueOf(PW.price.split('>')[0]);
                        if(PW.priceDecimal == 0){
                            PW.premiumMovement  =  0;
                        }else if(PW.priceDecimal<1){
                            PW.premiumMovement  =  (CurrentnetPIPremium * (PW.priceDecimal - 1)).round(System.RoundingMode.CEILING);
                            CurrentnetPIPremium  =  CurrentnetPIPremium + PW.premiumMovement;
                        }else if(PW.priceDecimal == 1){
                            PW.premiumMovement  =  0;
                        }else{
                            PW.premiumMovement  =  ((netPIPremium_Converted) * (PW.priceDecimal - 1)).round(System.RoundingMode.CEILING);
                        }
                    }else{
                        PW.premiumMovement  =  0;
                    }
                    totalPremiumMovement  =  totalPremiumMovement + PW.premiumMovement;
                    PW.premiumMovement_Converted = (PW.premiumMovement*currentToSEKRate).setScale(2);
                }
            }
            if(NBP !=  null){     
                System.debug('otherFactorsList::'+otherFactorsList);       
                for(OtherFactors ofc :otherFactorsList){
                    if(ofc.rate !=  null){
                        if(ofc.rate == 0){
                            ofc.premiumMovement  =  0;
                        }else if(ofc.rate<1){
                            ofc.premiumMovement   =  (currentNBP * (ofc.rate - 1)).round(System.RoundingMode.CEILING);
                            currentNBP  =  currentNBP + ofc.premiumMovement;
                        }else if(ofc.rate == 1){
                            ofc.premiumMovement  =  0;
                        }else{
                            ofc.premiumMovement  =  ((NBP) * (ofc.rate - 1)).round(System.RoundingMode.CEILING);
                        }
                        totalPremiumMovement  =  totalPremiumMovement + ofc.premiumMovement;
                        ofc.premiumMovement = ofc.premiumMovement;
                        ofc.premiumMovement_Converted = (ofc.premiumMovement*currentToSEKRate).setScale(2);
                    }else{
                        
                    }
                }
                //( !=  null && DeductibleRate_Converted > 0 )-> changed to (DeductibleRate_Converted !=  null ) by siddik 28.9.2019
                if(DeductibleRate_Converted !=  null ){
                    //DeductibleRate_Converted  =  DeductibleRate;
                    DeductibleRate  =  (DeductibleRate_Converted/currentToSEKRate)+1;
                    for(SelectOption s : deductibleFactor.factors){
                        if(s.getLabel() !=  '--Select--'){
                            if(s.getLabel().contains('<')){
                                Decimal baseValue  =  Decimal.valueOf(s.getLabel().split('<')[1]);
                                if(DeductibleRate < baseValue){
                                    deductibleFactor.price  =  s.getValue().split('>')[0];
                                    break;
                                }
                            }else if(s.getLabel().contains('-')){
                                System.debug(s.getLabel().split('-'));
                                Decimal baseValue1  =  Decimal.valueOf(s.getLabel().split('-')[0]);
                                Decimal baseValue2  =  Decimal.valueOf(s.getLabel().split('-')[1]);
                                if(DeductibleRate > =  baseValue1 && DeductibleRate < =  baseValue2){
                                    deductibleFactor.price  =  s.getValue().split('>')[0];
                                    break;
                                }
                            }else if(s.getLabel().contains('>')){
                                Decimal baseValue  =  Decimal.valueOf(s.getLabel().split('>')[1]);
                                deductibleFactor.price  =  s.getValue().split('>')[0];
                                if(DeductibleRate > =  baseValue){
                                    deductibleFactor.price  =  s.getValue().split('>')[0];
                                    break;
                                }
                            }
                        }
                    }
                    //deductibleFactor.price  =  DeductibleRate.split('>')[0];
                    System.debug('Hai::'+Decimal.valueOf(deductibleFactor.price));
                    deductibleFactor.priceDecimal  =  Decimal.valueOf(deductibleFactor.price);
                    if(deductibleFactor.priceDecimal  == 0){
                        deductibleFactor.premiumMovement  =  0;
                    }else if(deductibleFactor.priceDecimal <1){
                        deductibleFactor.premiumMovement  =  ((NBP + totalPremiumMovement) * (deductibleFactor.priceDecimal - 1)).round(System.RoundingMode.CEILING);
                        currentNBP  =  currentNBP + deductibleFactor.premiumMovement;
                    }else if(deductibleFactor.priceDecimal == 1){
                        deductibleFactor.premiumMovement  =  0;
                    }else{
                        deductibleFactor.premiumMovement  =  ((NBP + totalPremiumMovement) * (deductibleFactor.priceDecimal - 1)).round(System.RoundingMode.CEILING);
                    }
                }else{
                    deductibleFactor.premiumMovement  =  0;
                }
                deductibleFactor.premiumMovement_Converted = (deductibleFactor.premiumMovement*currentToSEKRate).setScale(2);
                totalPremiumMovement_Converted = (totalPremiumMovement*currentToSEKRate).setScale(2);
                netExposurePremium  =  (NBP + totalPremiumMovement) + deductibleFactor.premiumMovement;
                netExposurePremium_Converted  =  (netExposurePremium*currentToSEKRate).setScale(2);
            }
        }    
    }
    
    public void UpdateNBP(){
        if(experiencePremium_Converted !=  null && seletedWeight !=  null){
            try{
                //experiencePremium_Converted  =  experiencePremium;
                experiencePremium  =  experiencePremium_Converted  ==  0 || experiencePremium_Converted  ==  null? 0 : experiencePremium_Converted/currentToSEKRate;
                netBasePremium  =  ((0.5*(netExposurePremium)) + ((seletedWeight/100)*(experiencePremium)) + ((1 - ((seletedWeight)/100))*(0.5*(netExposurePremium)))).round(System.RoundingMode.CEILING);
                //System.debug('netBasePremium::'+netBasePremium+brokerage);
                grossBasePremium  =  (netBasePremium/(1-(brokerage/100))).round(System.RoundingMode.CEILING);
                netCommission  =  (grossBasePremium - netBasePremium).round(System.RoundingMode.CEILING);
                netBasePremium_Converted  =  (netBasePremium*currentToSEKRate).setScale(2);
                
                grossBasePremium_Converted  =  (grossBasePremium*currentToSEKRate).setScale(2);
                netCommission_Converted  =  (netCommission*currentToSEKRate).setScale(2);
                //System.debug('netBasePremium::'+netBasePremium+'::'+brokerage);
            }Catch(Exception ex){
                
            }
        }
    }
    
    public void addRR(){
        Boolean allOkToTaddNewAsset  =  True;
        RRWrapper waNew = new RRWrapper();
        waNew.Counter = string.valueOf(RRcounter);
        for(RRWrapper temp : riskRatingList){
            /*//System.debug('Rate::'+temp.psa.VG_Rate_Per_Vehicle__c +':No.of:'+temp.psa.VG_Number_of_Vehicles__c+':coverage:'+temp.psa.VG_Coverage__c+':type:'+temp.psa.VG_Vehicle_Type__c);
         if(temp.psa.VG_Technical_UW_Rate_Annual__c != null && temp.psa.VG_Rate_Per_Vehicle__c != null && temp.psa.VG_Number_of_Vehicles__c != null && temp.psa.VG_Coverage__c != null && temp.psa.VG_Vehicle_Type__c !=  null && temp.psa.VG_Use__c != null){
           //System.debug('if::');
           temp.psa.VG_Premium__c = (temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Rate_Per_Vehicle__c).setScale(2);
           temp.techPremium = (temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
           totalpre = totalpre+temp.psa.VG_Premium__c;

         }else{
           //System.debug('else::');
           ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please enter the Number, Use,  Rate,  Technical Rate  and Coverage for all vehicles before adding a new asset..'));    
           allOkToTaddNewAsset  =  False;     

        }*/
        }
        
        if(allOkToTaddNewAsset){
            VG_Policy_Schedule_Asset__c psaNew = new VG_Policy_Schedule_Asset__c();
            psaNew.CurrencyISOCode  =  policyCurrency;
            waNew.psa = psaNew;
            riskRatingList.add(waNew);
            RRcounter++;
        }
        //System.debug('riskRatingList::'+riskRatingList.size()+'::'+riskRatingList);
    }
    
    public void RemoveRR(){
        //System.debug('Index::'+integer.valueOf(Index));
        riskRatingList.remove(integer.valueOf(Index));
        //System.debug('Index::'+integer.valueOf(Index));
        RRcounter = 0;
        //System.debug('riskRatingList::'+riskRatingList.size()+'::'+riskRatingList);
        for(RRWrapper temp : riskRatingList){
            temp.Counter = String.valueOf(counter);
            RRcounter++;
        }
        if(riskRatingList.IsEmpty()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one asset to the policy schedule..'));   
        }
    }
    
    public void UpdateAssetPremium(){
        List<VG_Pricing__c > priceListRiskRating  =  new List<VG_Pricing__c>([select Id, Name, VG_Product__c, VG_Category__c, VG_Rating_Factor__c, VG_Rate__c,  Sum_Insured_Limit__c from VG_Pricing__c where VG_Product__c  =  'Property' and VG_Level__c  =  'Risk Rating' and VG_Rate__c !=  null and VG_Rating_Factor__c !=  null ORDER BY VG_Order__c]);
        Map<Decimal,  Map<Decimal,  Decimal>> deductiblesMap  =  new Map<Decimal,  Map<Decimal,  Decimal>>();
        Map<Decimal,  Decimal> tempMap;
        for(VG_Pricing__c pri : priceListRiskRating){
            if(pri.VG_Category__c  ==  'Deductible Adjustment'){
                if(deductiblesMap.get(pri.Sum_Insured_Limit__c)  ==  null){
                    tempMap  =  new Map<Decimal,  Decimal>();                
                }else{
                    tempMap  =  deductiblesMap.get(pri.Sum_Insured_Limit__c);
                }
                tempMap.put(Decimal.valueOf(pri.VG_Rating_Factor__c),  pri.VG_Rate__c);
                //System.debug('TempMap is' + tempMap);
                deductiblesMap.put(pri.Sum_Insured_Limit__c,  tempMap);
            }
        }
        if(allAccountAssets.get(currentAsset.asset.Asset__c) !=  null){
            showAssetDetails  =  True;
            Asset__c tempAsset  =  allAccountAssets.get(currentAsset.asset.Asset__c);
            currentAsset.name  =  tempAsset.Name;
            //currentAsset.totalPropertyDamageSI  =  adjustedPDBaseRate * tempAsset.VG_Total_Property_Damage_SI__c;
            currentAsset.totalPropertyDamageSI  =  tempAsset.VG_Total_Property_Damage_SI__c;
            currentAsset.fullValue  =  tempAsset.VG_Full_Value_Building__c;
            //currentAsset.totalBusinessInterruptionSI  =  adjustedBIBaseRate * tempAsset.VG_Total_Business_Interruption_SI__c;
            currentAsset.totalBusinessInterruptionSI  =  tempAsset.VG_Total_Business_Interruption_SI__c;
            currentAsset.totalSumInsuredSI  =  currentAsset.totalPropertyDamageSI + currentAsset.totalBusinessInterruptionSI;
            currentAsset.totalSumInsuredMBSI  =  tempAsset.VG_Machinery_SI__c;
            if(currentAsset.asset.VG_Deductible__c !=  null){
                for(SelectOption s : pricingMap.get('PD Deductible').factors){
                    if(currentAsset.asset.VG_Deductible__c < Decimal.valueOf(s.getLabel().split(' - ')[1])){
                        currentAsset.PDDeductible  =  Decimal.valueOf(s.getValue());
                        Break;
                    }
                }
            }else{
                currentAsset.PDDeductible  =  0;
            }
            /*if(currentAsset.asset.VG_Deductible__c !=  null){
              for(SelectOption s : pricingMap.get('PD Deductible').factors){
             if(currentAsset.asset.VG_Deductible__c < Decimal.valueOf(s.getLabel().split(' - ')[1])){
               currentAsset.MBPDDeductible  =  Decimal.valueOf(s.getValue());
              Break;
             }
             }
             }else{
            currentAsset.MBPDDeductible  =  0;
            }*/
            if(tempAsset.VG_Waiting_Period__c !=  null){
                //currentAsset.WaitingPeriod  =  Decimal.valueOf(currentAsset.waitingPeriodFactors.price);
                for(SelectOption so : currentAsset.waitingPeriodFactors.factors){
                    if(so.getLabel()  ==  tempAsset.VG_Waiting_Period__c){
                        currentAsset.WaitingPeriod  =  Decimal.valueOf(so.getValue());
                        Break;
                    }
                }
            }else{
                currentAsset.WaitingPeriod  =  0;
            }
            //System.debug('currentAsset.WaitingPeriod '+currentAsset.WaitingPeriod);
            if(tempAsset.VG_MB_Waiting_Period__c !=  null){
                //currentAsset.mbWaitingPeriod  =  Decimal.valueOf(currentAsset.mbwaitingPeriodFactors.price);
                for(SelectOption so : currentAsset.mbwaitingPeriodFactors.factors){
                    if(so.getLabel()  ==  tempAsset.VG_MB_Waiting_Period__c){
                        currentAsset.mbWaitingPeriod  =  Decimal.valueOf(so.getValue());
                        Break;
                    }
                }
            }else{
                currentAsset.mbWaitingPeriod  =  0;
            }
            if(tempAsset.VG_BI_Indemnity_Period__c !=  null){
                //currentAsset.BIIndemnityPeriod  =  Decimal.valueOf(currentAsset.biIndemnityPeriodFactors.price);
                for(SelectOption so : currentAsset.biIndemnityPeriodFactors.factors){
                    if(so.getLabel()  ==  tempAsset.VG_BI_Indemnity_Period__c){
                        currentAsset.BIIndemnityPeriod  =  Decimal.valueOf(so.getValue());
                        Break;
                    }
                }
            }else{
                currentAsset.BIIndemnityPeriod  =  0;
            }
            if(tempAsset.VG_MB_BI_Indemnity_Period__c !=  null){
                //currentAsset.mbBIIndemnityPeriod  =  Decimal.valueOf(currentAsset.mbbiIndemnityPeriodFactors.price);
                for(SelectOption so : currentAsset.mbbiIndemnityPeriodFactors.factors){
                    if(so.getLabel()  ==  tempAsset.VG_MB_BI_Indemnity_Period__c){
                        currentAsset.mbBIIndemnityPeriod  =  Decimal.valueOf(so.getValue());
                        Break;
                    }
                }
            }else{
                currentAsset.mbBIIndemnityPeriod  =  0;
            }
            //currentAsset.AdjustedPDPremium  =  currentAsset.totalPropertyDamageSI*(1+(currentAsset.PDDeductible));
            if(tempAsset.VG_Automatic_Fire_alarm__c !=  null){
                for(SelectOption s : pricingMap.get('Automatic Fire alarm').factors){
                    if(tempAsset.VG_Automatic_Fire_alarm__c  ==  s.getLabel()){
                        currentAsset.AutomaticFirealarm  =  Decimal.valueOf(s.getValue());
                        Break;
                    }
                    currentAsset.AutomaticFirealarm  =  0;
                }
            }else{
                currentAsset.AutomaticFirealarm  =  0;
            }
            if(tempAsset.VG_Water_sprinklers__c !=  null){
                for(SelectOption s : pricingMap.get('Water sprinklers?').factors){
                    if(tempAsset.VG_Water_sprinklers__c  ==  s.getLabel()){
                        currentAsset.WaterSprinklers  =  Decimal.valueOf(s.getValue());
                        Break;
                    }
                    currentAsset.WaterSprinklers  =  0;
                }
            }else{
                currentAsset.WaterSprinklers  =  0;
            }
            if(tempAsset.VG_Smoke_and_heat_venting_system__c !=  null){
                for(SelectOption s : pricingMap.get('Smoke and heat venting system?').factors){
                    if(tempAsset.VG_Smoke_and_heat_venting_system__c  ==  s.getLabel()){
                        currentAsset.SmokeAndHeatVentingSystem  =  Decimal.valueOf(s.getValue());
                        Break;
                    }
                    currentAsset.SmokeAndHeatVentingSystem  =  0;
                }
            }else{
                currentAsset.SmokeAndHeatVentingSystem  =  0;
            }
            if(tempAsset.VG_Foam_supression_system__c !=  null){
                for(SelectOption s : pricingMap.get('Foam supression system?').factors){
                    if(tempAsset.VG_Foam_supression_system__c  ==  s.getLabel()){
                        currentAsset.FoamSupressionSystem  =  Decimal.valueOf(s.getValue());
                        Break;
                    }
                    currentAsset.FoamSupressionSystem  =  0;
                }
            }else{
                currentAsset.FoamSupressionSystem  =  0;
            }
            if(tempAsset.VG_Full_time_public_Fire_Brigade_staff__c !=  null){
                for(SelectOption s : pricingMap.get('Full time public Fire Brigade staff?').factors){
                    //System.debug(tempAsset.VG_Full_time_public_Fire_Brigade_staff__c +'  =  '+s.getLabel());
                    if(tempAsset.VG_Full_time_public_Fire_Brigade_staff__c  ==  s.getLabel()){
                        currentAsset.FulltimePublicFireBrigadeStaff  =  Decimal.valueOf(s.getValue());
                        Break;
                    }
                    currentAsset.FulltimePublicFireBrigadeStaff  =  0;
                }
            }else{
                currentAsset.FulltimePublicFireBrigadeStaff  =  0;
            }
            Decimal SILowerLimit,  SIUpperLimit;
            Decimal MBSILowerLimit,  MBSIUpperLimit;
            SILowerLimit  =  SIUpperLimit  =  MBSILowerLimit  =  MBSIUpperLimit  =  null;
            for(Decimal SI : deductiblesMap.keySet()){
                if(SILowerLimit  ==  null){
                    SILowerLimit  =  SI;
                    SIUpperLimit  =  0;
                }else{
                    SILowerLimit  =  SIUpperLimit;
                }
                if(MBSILowerLimit  ==  null){
                    MBSILowerLimit  =  SI;
                    MBSIUpperLimit  =  0;
                }else{
                    MBSILowerLimit  =  MBSIUpperLimit;
                }
                SIUpperLimit  =  MBSIUpperLimit  =  SI;
                if(currentAsset.totalSumInsuredSI > SILowerLimit && currentAsset.totalSumInsuredSI < =  SIUpperLimit){
                    Decimal proRatingFactor  =  (SIUpperLimit  - currentAsset.totalSumInsuredSI)/(SIUpperLimit - SILowerLimit);
                    if(tempAsset.VG_PD_Deductible__c !=  null){
                        try{
                            Decimal tempPDDeductible  =  (tempAsset.VG_PD_Deductible__c).setscale(0, RoundingMode.DOWN);
                            Decimal lowerPDDeductible,  higherPDDeductible  =  0;
                            List<Decimal> tempList  =  new List<Decimal>();
                            tempList.addAll(deductiblesMap.get(SILowerLimit).keySet());
                            tempList.sort();
                            for(Decimal d : tempList){
                                if(d < tempPDDeductible){
                                    lowerPDDeductible  =  d;
                                }else{
                                    Break;
                                }
                            }
                            for(Decimal d : tempList){
                                if(d > tempPDDeductible){
                                    higherPDDeductible  =  d;
                                    Break;
                                }
                            }
                            Decimal dedProRatingFactor  =  (higherPDDeductible - tempPDDeductible)/(higherPDDeductible - lowerPDDeductible);
                            currentAsset.PDDeductible  =  0;
                            Decimal PDDeductible_Lower  =  (deductiblesMap.get(SILowerLimit).get(lowerPDDeductible)*proRatingFactor ) + ((deductiblesMap.get(SIUpperLimit).get(lowerPDDeductible))*(1-proRatingFactor) );
                            Decimal PDDeductible_Higher  =  (deductiblesMap.get(SILowerLimit).get(higherPDDeductible)*proRatingFactor ) + ((deductiblesMap.get(SIUpperLimit).get(higherPDDeductible))*(1-proRatingFactor) );
                            currentAsset.PDDeductible  =  -1 * ((dedProRatingFactor * PDDeductible_Lower) + ((1 - dedProRatingFactor) * PDDeductible_Higher));
                        }catch(Exception ex){
                            currentAsset.PDDeductible  =  0;
                            //System.debug('PDDeductible exception'+ex.getMessage());
                        }
                    }
                }
                //System.debug(currentAsset.totalSumInsuredMBSI + ' > ' + MBSILowerLimit + ' && ' + currentAsset.totalSumInsuredMBSI + ' < =  ' + MBSIUpperLimit);
                if(currentAsset.totalSumInsuredSI > MBSILowerLimit && currentAsset.totalSumInsuredSI < =  MBSIUpperLimit){
                    Decimal proRatingFactor  =  (MBSIUpperLimit  - currentAsset.totalSumInsuredSI)/(MBSIUpperLimit - MBSILowerLimit);
                    if(tempAsset.VG_MB_PD_Deductible__c !=  null){
                        try{
                            //currentAsset.MBPDDeductible  =   -1 * (deductiblesMap.get(MBSILowerLimit).get(tempAsset.VG_MB_PD_Deductible__c) + ((deductiblesMap.get(MBSILowerLimit).get(tempAsset.VG_MB_PD_Deductible__c) - deductiblesMap.get(MBSIUpperLimit).get(tempAsset.VG_MB_PD_Deductible__c))*proRatingFactor ));
                            Decimal tempMBPDDeductible  =  (tempAsset.VG_MB_PD_Deductible__c).setscale(0, RoundingMode.DOWN);
                            Decimal lowerMBPDDeductible,  higherMBPDDeductible  =  0;
                            List<Decimal> tempList  =  new List<Decimal>();
                            tempList.addAll(deductiblesMap.get(MBSILowerLimit).keySet());
                            tempList.sort();
                            for(Decimal d : tempList){
                                if(d < tempMBPDDeductible){
                                    lowerMBPDDeductible  =  d;
                                }else{
                                    Break;
                                }
                            }
                            for(Decimal d : tempList){
                                if(d > tempMBPDDeductible){
                                    higherMBPDDeductible  =  d;
                                    Break;
                                }
                            }
                            Decimal dedProRatingFactor  =  (higherMBPDDeductible - tempMBPDDeductible)/(higherMBPDDeductible - lowerMBPDDeductible);
                            currentAsset.MBPDDeductible  =  0;
                            Decimal MBPDDeductible_Lower  =  (deductiblesMap.get(MBSILowerLimit).get(lowerMBPDDeductible)*proRatingFactor ) + ((deductiblesMap.get(MBSIUpperLimit).get(lowerMBPDDeductible))*(1-proRatingFactor) );
                            Decimal MBPDDeductible_Higher  =  (deductiblesMap.get(MBSILowerLimit).get(higherMBPDDeductible)*proRatingFactor ) + ((deductiblesMap.get(MBSIUpperLimit).get(higherMBPDDeductible))*(1-proRatingFactor) );
                            currentAsset.MBPDDeductible  =  -1 * ((dedProRatingFactor * MBPDDeductible_Lower) + ((1 - dedProRatingFactor) * MBPDDeductible_Higher));
                        }catch(Exception ex){
                            currentAsset.MBPDDeductible  =  0;
                            //System.debug('MBPDDeductible exception'+ex.getMessage());
                        }
                    }
                }
            }
            currentAsset.AdjustedPDPremium  =  ((adjustedPDBaseRate * (currentAsset.totalPropertyDamageSI*(1+(currentAsset.PDDeductible))))/1000);
            //System.debug('currentAsset.totalBusinessInterruptionSI '+currentAsset.totalBusinessInterruptionSI+',  adjustedBIBaseRate '+adjustedBIBaseRate+',  currentAsset.WaitingPeriod '+currentAsset.WaitingPeriod+',  currentAsset.BIIndemnityPeriod '+currentAsset.BIIndemnityPeriod);
            currentAsset.AdjustedBIPremium  =  ((currentAsset.totalBusinessInterruptionSI*adjustedBIBaseRate) + (currentAsset.totalBusinessInterruptionSI*adjustedBIBaseRate* currentAsset.WaitingPeriod)+(currentAsset.totalBusinessInterruptionSI*adjustedBIBaseRate*currentAsset.BIIndemnityPeriod))/1000;
            //System.debug('currentAsset.AutomaticFirealarm: '+currentAsset.AutomaticFirealarm+',  currentAsset.FoamSupressionSystem: '+currentAsset.FoamSupressionSystem + ',  currentAsset.WaterSprinklers: ' + currentAsset.WaterSprinklers + ',  currentAsset.SmokeAndHeatVentingSystem: '+currentAsset.SmokeAndHeatVentingSystem + ',  currentAsset.FulltimePublicFireBrigadeStaff: ' + currentAsset.FulltimePublicFireBrigadeStaff);
            currentAsset.TotalDiscountLoading  =  currentAsset.AutomaticFirealarm  + currentAsset.FoamSupressionSystem + currentAsset.WaterSprinklers + currentAsset.SmokeAndHeatVentingSystem + currentAsset.FulltimePublicFireBrigadeStaff;
            if(currentAsset.TotalDiscountLoading < -0.45){
                currentAsset.TotalDiscountLoading  =  - 0.45;
            }
            currentAsset.NetPDPremium  =  currentAsset.AdjustedPDPremium*(1+(currentAsset.TotalDiscountLoading));
            currentAsset.NetBIPremium  =  currentAsset.AdjustedBIPremium*(1+(currentAsset.TotalDiscountLoading));
            try{
                currentAsset.AdjustedMBPremium  =  ((currentAsset.totalSumInsuredMBSI * MBCRate )+(currentAsset.totalSumInsuredMBSI * MBCRate * currentAsset.MBPDDeductible)+(currentAsset.totalSumInsuredMBSI * MBBICRate )+(currentAsset.totalSumInsuredMBSI * MBBICRate * currentAsset.MBWaitingPeriod)+(currentAsset.totalSumInsuredMBSI * MBBICRate * currentAsset.BIIndemnityPeriod))/1000;
            }catch(Exception ex){
                //System.debug('currentAsset.AdjustedMBPremium error'+ex.getmessage());
                currentAsset.AdjustedMBPremium  =  0;
            }
            currentAsset.NetRiskPremium  =  currentAsset.NetPDPremium + currentAsset.NetBIPremium + currentAsset.AdjustedMBPremium;
            //VG_Building_SI__c + VG_Machinery_SI__c + VG_Goods_SI__c + VG_Contents_SI__c + VG_Customer_Property_SI__c + VG_Other_SI__c
        }else{
            showAssetDetails  =  False;
            ApexPages.Message myMsg  =  new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select an asset from the account associated to the policy.');
            ApexPages.addMessage(myMsg);
        }
    }
    
    public void AddAsset(){
        addAssetMode  =  True;
        currentAsset  =  new AssetWrapper();
        currentAsset.asset  =  new VG_Policy_Schedule_Asset__c();
        currentAsset.Counter = string.valueOf(RRcounter);
        currentAsset.waitingPeriodFactors  =  pricingMap.get('Waiting Period');
        currentAsset.biIndemnityPeriodFactors  =  pricingMap.get('BI Indemnity Period');
        currentAsset.mbwaitingPeriodFactors  =  pricingMap.get('MB Waiting Period');
        currentAsset.mbbiIndemnityPeriodFactors  =  pricingMap.get('MB Indemnity Period');
    }
    
    public void EditAsset(){
        addAssetMode  =  True;
        currentAsset  =  assetList[integer.valueOf(Index)];
        assetList.remove(integer.valueOf(Index));
        RRcounter = 0;
        //System.debug('assetList::'+assetList);
        for(AssetWrapper temp : assetList){
            temp.Counter = String.valueOf(counter);
            RRcounter++;
        }
        if(riskRatingList.IsEmpty()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one asset to the policy schedule..'));   
        }
    }
    
    public void SaveAsset(){
        addAssetMode  =  False;
        assetList.add(currentAsset);
        RRcounter = 0;
        for(AssetWrapper temp : assetList){
            temp.Counter = String.valueOf(counter);
            RRcounter++;
        }
    }
    
    public void CancelAsset(){
        addAssetMode  =  False;
    }
    
    public void RemoveAsset(){
        assetList.remove(integer.valueOf(Index));
        RRcounter = 0;
        for(AssetWrapper temp : assetList){
            temp.Counter = String.valueOf(counter);
            RRcounter++;
        }
        if(riskRatingList.IsEmpty()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one asset to the policy schedule..'));   
        }
    }
    
    public void UpdateFinalCalculations(){
        If(RateChange==0.00 && p.VG_Is_Renewal__c == false)
            RateChange=null;
        Long attLimit;
        Decimal AttachmentRate;
        Decimal AttLimitRate;
        Long attachment_unrounded,  limitAmount_unrounded,  attachment_rounded,  limitAmount_rounded;
        Integer millionFactor;
        AttLimitRate = 0;
        AttachmentRate = 0;
        if(!IsProperty){
            //System.debug('policyCurrency ' + policyCurrency + ',  currentToSEKRate'+currentToSEKRate+',  attachment_Converted '+attachment_Converted +',  limitAmount_Converted '+limitAmount_Converted);
            if(attachment_Converted !=  null){
                attachment_unrounded  =  (attachment_Converted/currentToSEKRate).LongValue();
            }else{
                attachment_unrounded  =  0;
            }
            if(limitAmount_Converted !=  null){
                limitAmount_unrounded  =  (limitAmount_Converted/currentToSEKRate).LongValue();
            }else{
                limitAmount_unrounded  =  0;
            }
            attachment_rounded  =  attachment_unrounded - Math.MOD(attachment_unrounded,  10000000L);
            limitAmount_rounded  =  limitAmount_unrounded - Math.MOD(limitAmount_unrounded,  10000000L);
            //System.debug('attachment_Converted '+attachment_Converted+',  limitAmount_rounded '+limitAmount_rounded +',  attachment_rounded '+attachment_rounded +',  limitAmount_Converted '+limitAmount_Converted);
            if(Integer.valueOf(limitAmount_unrounded ) > 7500000 && Integer.valueOf(limitAmount_unrounded )< 10000000){
                limitAmount_rounded  =  7500000;
            }else if(Integer.valueOf(limitAmount_unrounded ) > 5000000 && Integer.valueOf(limitAmount_unrounded ) < =  7500000){
                limitAmount_rounded  =  5000000;
            }else if(Integer.valueOf(limitAmount_unrounded ) > 2500000 && Integer.valueOf(limitAmount_unrounded ) < =  5000000){
                limitAmount_rounded  =  2500000;
            }else if(Integer.valueOf(limitAmount_unrounded ) > 1000000 && Integer.valueOf(limitAmount_unrounded ) < =  2500000){
                limitAmount_rounded  =  1000000;
            }else if(Integer.valueOf(limitAmount_unrounded ) < 1000001){
                limitAmount_rounded  =  0;
            }
            //System.debug(' == >limitAmount_rounded '+limitAmount_rounded );
            List<ILF_Factors__c> ILFFactorLookups  =  new List<ILF_Factors__c>();
            netBasePremium_Converted_Pro  =  netBasePremium_Converted * proRatingFactor;
            netModelPremium  =  netBasePremium_Converted + endorsementPremium;// netBasePremium_Converted_Pro replace with netBasePremium_Converted 
            grossBasePremium  =  ((netModelPremium!= null?netModelPremium:0)/(1-((brokerage!= null?brokerage:0)/100)));
            try{
                sumInsured  =  limitAmount_Converted * (sharePercent/100);
            }catch(exception ex){
                sumInsured  =  0;
            }
            //System.debug('layer'+layer);
            if(layer  ==  'Primary'){
                try{
                    //System.debug('limitAmount_rounded: '+limitAmount_rounded);
                    ILF_Factors__c ILFFactorLookup  =  [Select Id,  Rate__c,  Limit__c from ILF_Factors__c where Limit__c  = : limitAmount_rounded AND Type__c  = : ILFFactor AND Level__c  =  'Premium' AND Product__c  = : price.VG_Product__c LIMIT 1];
                    ILFRate  =  (ILFFactorLookup.Rate__c-1)+Decimal.valueOf(deductibleFactor.price);
                }catch(exception ex){
                    //System.debug(ex.getMessage());
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Limit has No Rate Records..'));   
                    ILFRate  =  0;
                }
                attachment_Converted  =  (DeductibleRate_Converted).LongValue();
            }else{
                attLimit  =  attachment_rounded + limitAmount_rounded;
                //System.debug('Math.Mod(attLimit,  10000000): '+Math.Mod(attLimit,  10000000L));
                
                if(attLimit > =  10000000){
                    attLimit  =  attLimit - Math.Mod(attLimit,  10000000);
                }else if(attLimit > 7500000 && attLimit < 10000000){
                    limitAmount_rounded  =  7500000;
                }else if(attLimit > 5000000 && attLimit < =  7500000){
                    limitAmount_rounded  =  5000000;
                }else if(attLimit > 2500000 && attLimit < =  5000000){
                    limitAmount_rounded  =  2500000;
                }else if(attLimit > 1000000 && attLimit < =  2500000){
                    limitAmount_rounded  =  1000000;
                }else if(attLimit < 1000001){
                    limitAmount_rounded  =  0;
                }
                ILFFactorLookups  =  [Select Id,  Rate__c,  Limit__c from ILF_Factors__c where (Limit__c  = : attLimit OR Limit__c  = : attachment_rounded ) AND Type__c  = : ILFFactor AND Level__c  =  'Premium' AND Product__c  = : price.VG_Product__c];
                //System.debug(ILFFactorLookups);
                for(ILF_Factors__c IFactor : ILFFactorLookups){
                    if(IFactor.Limit__c  ==  attLimit){
                        AttLimitRate  =  IFactor.Rate__c;
                    }
                    if(IFactor.Limit__c  ==  attachment_rounded){
                        AttachmentRate  =  IFactor.Rate__c;
                    }
                }
                try{
                    ILFRate  =  AttLimitRate - AttachmentRate;
                }catch(exception ex){
                    ILFRate  =  0;
                }
            }
            //System.debug('ILFRate:: ' + ILFRate );
            //Below one line added by siddik on 12-9-18 for JIRA 113 [divide by zero error]
            If(deductibleFactor!= null && deductibleFactor.price!= null && ps.Product__c!= 'Commercial Combined'){
                if(Decimal.valueOf(deductibleFactor.price) > 0)
                    ilfPremium  =  (ILFRate * netModelPremium)/Decimal.valueOf(deductibleFactor.price);
            }else{
                ilfPremium  =  netModelPremium;
            }
            attLimit  =  attachment_unrounded + limitAmount_unrounded;
            attLimit  =  attLimit  - Math.Mod(Decimal.valueOf(attLimit ).longValue(),  10000000L);
            //System.debug(' ==  = >attLimit '+attLimit);
            ILFFactorLookups  =  [Select Id,  Rate__c,  Limit__c from ILF_Factors__c where (Limit__c  = : attLimit OR Limit__c  = : attachment_rounded ) AND Type__c  = : ILFFactor AND Level__c  =  'RPM' AND Product__c  = : price.VG_Product__c];
            for(ILF_Factors__c IFactor : ILFFactorLookups){
                if(IFactor.Limit__c  ==  attLimit){
                    AttLimitRate  =  IFactor.Rate__c;
                    //System.debug(' == AttLimitRate:'+AttLimitRate);
                }else if(IFactor.Limit__c  ==  attachment_rounded){ //attachment_unrounded){
                    AttachmentRate  =  IFactor.Rate__c;
                    //System.debug(' == AttachmentRate:'+AttachmentRate);
                }
            }
            try{
                ROL  =  AttLimitRate - AttachmentRate;
            }catch(exception ex){
                ROL  =  0;
            }
            ROL  =  ROL * currentToSEKRate;
            if(layer  ==  'Primary'){
                techLayerPremium  =  ilfPremium;
                ROL  =  0;
            }else{
                techLayerPremium  =  Math.max(ilfPremium,  ROL);
            }
            try{
                RPM  =  (techLayerPremium / limitAmount_Converted) * 1000;
            }catch(exception ex){
                RPM  =  0;
            }
            try{
                techModelPremium  =  techLayerPremium * (sharePercent/100);
            }catch(exception ex){
                techModelPremium  = 0;
            }
            techPremium  =  (techModelPremium!= null?techModelPremium:0) + (adjustmentTechPremium!= null?adjustmentTechPremium:0);
            uwPremium  =  (techModelPremium!= null?techModelPremium:0) + (adjustmentTechPremium!= null?adjustmentTechPremium:0);
            actualPremium  =  (uwPremium!= null?uwPremium:0) + (adjustment!= null?adjustment:0);
            grossWrittenPremium  =  (actualPremium!= null?actualPremium:0)/(1-((brokerage!= null?brokerage:0)/100));
            try{
                grossWrittenPremium2  = (grossWrittenPremium  != null?grossWrittenPremium :0)/((sharePercent!= null?sharePercent:0)/100);
            }catch(exception ex){
                grossWrittenPremium2  = 0;
            }
            brokerageAmount  =  (grossWrittenPremium!= null?grossWrittenPremium:0)*((brokerage!= null?brokerage:0)/100);
            try{
                if(GrossOrNet  ==  'Net'){
                    transactionPremium  =  actualPremium + IPTAmount + feeIncome + levies;
                }else{
                    transactionPremium  =  grossWrittenPremium + IPTAmount + feeIncome + levies;
                }
            }catch(exception ex){
                transactionPremium  =  0;
            }
            try{
                orcAmount  =  actualPremium*(orcPercent/100);
            }catch(exception ex){
                orcAmount  =  0;
            }
        }else{
            try{
                netBasePremium_Converted  =  0;
                for(AssetWrapper AW : assetList){
                    netBasePremium_Converted  =  netBasePremium_Converted + AW.NetRiskPremium ;
                }
                netBasePremium_Converted = netBasePremium_Converted *proratingFactor ;
            }catch(Exception ex){
                netBasePremium_Converted  =  0;
            }
            try{
                netModelPremium  =  netBasePremium_Converted + endorsementPremium;
            }catch(Exception ex){
                netModelPremium  =  0;
            }
            try{
                techModelPremium  =  netModelPremium * (sharePercent/100);
            }catch(Exception ex){
                techModelPremium  =  0;
            }
            try{
                uwPremium  =  techModelPremium + adjustmentTechPremium;
            }catch(Exception ex){
                uwPremium  =  0;
            }
            try{
                actualPremium  =  uwPremium + adjustment;
            }catch(Exception ex){
                actualPremium  =  0;
            }
            try{
                grossWrittenPremium  =  actualPremium/(1-(brokerage/100));
            }catch(Exception ex){
                grossWrittenPremium  =  0;
            }
            try{
                grossWrittenPremium2  = grossWrittenPremium  / (sharePercent/100);          
            }catch(Exception ex){
                grossWrittenPremium2 =  0;
            }
            try{
                brokerageAmount  =  (grossWrittenPremium)*(brokerage/100);
            }catch(Exception ex){
                brokerageAmount  =  0;
            }
            try{
                if(GrossOrNet  ==  'Net'){
                    transactionPremium  =  actualPremium + IPTAmount + feeIncome + levies;
                }else{
                    transactionPremium  =  grossWrittenPremium + IPTAmount + feeIncome + levies;
                }
            }catch(Exception ex){
                transactionPremium  =  0;
            }
        }
    }
    
    public void UpdateAdjustmentvalues(){
        IsProrated  =  false;
        IsUWadjustmnetOverride  =  false;
        IsCommercialadjustmnetOverride  =  false;             
        updateCancelExtendCalc();
    }
    
    public PageReference updateCancelExtendCalc(){
        //System.debug('proratingfator is ');
        Long attLimit;
        Decimal AttachmentRate;
        Decimal AttLimitRate;
        Long attachment_unrounded,  limitAmount_unrounded,  attachment_rounded,  limitAmount_rounded;
        Integer millionFactor;
        Decimal proratingfator  =  1;        
        if(MTAType  ==  'Extension'){
            if(ps.VG_MTA_End_Date__c  ==  null){
                proratingfator  =  -99;
            }else{
                if(Math.mod(p.VG_Inception_Date__c.year(), 4) !=  0){
                    if(Math.mod(p.VG_Expiry_Date__c.year(), 4)  ==  0){
                        if(p.VG_Expiry_Date__c <=  date.newInstance(p.VG_Expiry_Date__c.year(), 02, 28)){
                            proratingfator   = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c)+1);
                        }else{
                            proratingfator   = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c));
                        }
                    }else{
                        proratingfator   = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c)+1);
                    }
                }else{
                    if(p.VG_Inception_Date__c < date.newInstance(p.VG_Inception_Date__c.year(),03,01)){
                        proratingfator   = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c));
                    }else{
                        proratingfator   = Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c)+1);
                    }
                }
                //proratingfator  =  Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c)+1);
            }
            if(MTAType  ==  'Extension' && ps.VG_MTA_Start_Date__c > ps.VG_MTA_End_Date__c){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'MTA End Date must come after MTA Start Date..'));
            }          
        }       
        if(MTAType  ==  'Cancellation'  || MTAType  ==  'Reduction'){
            if(ps.VG_MTA_Cancellation_Date__c  ==  null){
                proratingfator  =  -99;
            }else{
                proratingfator  =  -1*(Decimal.valueOf(ps.VG_MTA_Cancellation_Date__c.daysBetween(ps.VG_Pre_MTA_Expiry_Date__c)+1)/365);
            }
        }
        
        //System.debug('proratingfator is '+proratingfator);
        for(PSWrapper PSW:PSWrapperMap.values()){
            //PSW.netBasePremium_Converted  =  PSW.ps.Risk_Premium_Pro__c / proratingfator;
            ////System.debug('PSW.netBasePremium_Converted::'+PSW.netBasePremium_Converted);
            if(MTAType  ==  'Cancellation'  || MTAType  ==  'Reduction'){                
                If(MTAType  ==  'Cancellation'){
                    MTAcancellationDate = ps.VG_MTA_Cancellation_Date__c;                     
                }If(MTAType  ==  'Reduction' ){
                    MTAcancellationDate = ps.VG_MTA_Reduction_Date__c;                   
                }
                
                if(MTAType  ==  'Cancellation' && ps.VG_Pre_MTA_Expiry_Date__c < ps.VG_MTA_Cancellation_Date__c){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Cancellation Date must come before Current Expiry Date..'));
                }
                if(MTAType  ==  'Reduction' && ps.VG_Pre_MTA_Expiry_Date__c < ps.VG_MTA_Reduction_Date__c){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Reduction Date must come before Current Expiry Date..'));
                }  
                if(PSW.ps.VG_Is_MTA__c && (PSW.ps.VG_MTA_Type__c  ==  'Revision of Cover' || PSW.ps.VG_MTA_Type__c  ==  'Extension')){
                    //System.debug('IF Cancellation:PS Details::'+PSW.ps.Name+':'+MTAcancellationDate+':'+PSW.ps.VG_MTA_End_Date__c+':'+PSW.ps.VG_MTA_Start_Date__c);
                    if(MTAcancellationDate > PSW.ps.VG_MTA_End_Date__c){
                        proratingfator  =  0;
                    }else if(MTAcancellationDate < =  PSW.ps.VG_MTA_Start_Date__c){
                        Decimal numDays  =  Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                        //System.debug('numDays1::'+numDays+'::'+PSW.ps.VG_MTA_Start_Date__c+PSW.ps.VG_MTA_End_Date__c);
                        if(numDays < =  0)
                            proratingfator  =  0;
                        else
                            proratingfator  =  -1*((numDays+1)/(numDays+1));
                    }else if(MTAcancellationDate > PSW.ps.VG_MTA_Start_Date__c){
                        Decimal numDays  =  Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                        Decimal numDays2  =  Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));                        
                        if(numDays < =  0)
                            proratingfator  =  0;
                        else
                            proratingfator  =  -1*((numDays+1)/(numDays2+1));
                    }
                }else if(!PSW.ps.VG_Is_MTA__c){
                    if(MTAcancellationDate > PSW.ps.Base_Creation_End_Date__c){
                        proratingfator  =  0;
                    }else if(MTAcancellationDate < =  PSW.ps.Base_Creation_Start_Date__c){
                        Decimal numDays  =  Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c));
                        //System.debug('numDays1::'+numDays+'::'+PSW.ps.Base_Creation_Start_Date__c+PSW.ps.Base_Creation_End_Date__c);
                        if(numDays < =  0)
                            proratingfator  =  0;
                        else
                            proratingfator  =  -1*((numDays+1)/(numDays+1));
                        //System.debug('proratingfator::'+proratingfator);     
                    }else if(MTAcancellationDate > PSW.ps.Base_Creation_Start_Date__c){
                        /*//System.debug('startdate::'+PSW.ps.Base_Creation_Start_Date__c);
                        Decimal numDays  =  Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c));
                        Decimal numDays2  =  Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c));                        
                        //System.debug('MTAstart::'+PSW.ps.Base_Creation_Start_Date__c+'::'+PSW.ps.Base_Creation_End_Date__c);
                        if(numDays < =  0)
                            proratingfator  =  0;
                        else
                            proratingfator  =  -1*((numDays+1)/(numDays2+1));*/
                        if(Math.mod(PSW.ps.Base_Creation_End_Date__c.year(), 4) !=  0){
                            if(Math.mod(PSW.ps.Base_Creation_End_Date__c.year(), 4)  ==  0){
                                if(PSW.ps.Base_Creation_End_Date__c <=  date.newInstance(PSW.ps.Base_Creation_End_Date__c.year(), 02, 28)){
                                    proratingfator   = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                                }else{
                                    proratingfator   = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)));
                                }
                            }else{
                                proratingfator   = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                            }
                        }else{
                            if(p.VG_Inception_Date__c < date.newInstance(p.VG_Inception_Date__c.year(),03,01)){
                                proratingfator   = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)));
                            }else{
                                proratingfator   = -1*(Decimal.valueOf(MTAcancellationDate.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1)/Decimal.valueOf(PSW.ps.Base_Creation_Start_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c)+1));
                            }
                        }
                        //System.debug('proratingfator::'+proratingfator);           
                    }                   
                }else{
                    //System.debug('numDays::'+PSW.ps.Base_Creation_End_Date__c+'::'+MTAcancellationDate);
                    Decimal numDays  =  Decimal.valueOf(MTAcancellationDate.daysBetween(ps.VG_Pre_MTA_Expiry_Date__c));
                    Decimal n2  =  Decimal.valueOf(p.VG_Inception_Date__c.daysBetween(p.VG_Expiry_Date__c));
                    if(numDays < =  0)
                        proratingfator  =  0;
                    else
                        proratingfator  =  -1*((numDays+1)/(n2+1));                     
                }
                if(PSW.ps.VG_MTA_Type__c  ==  'Declaration'){
                    proratingfator  =  proratingfator * (PSW.ps.VG_Declaration_Type_percent__c/100);
                }
            }
            //System.debug('proratingfator is '+proratingfator);
            AttLimitRate = 0;
            AttachmentRate = 0;
            if(PSW.ps.Product__c !=  'Property'){
            //System.debug('proratingfator is '+proratingfator+'::'+MTAType+seletedProrateoption );
                If(PSW.ps.Product__c !=  'Property' && PSW.ps.Product__c !=  'Commercial Combined')
                    PSW.netBasePremium_Converted  =  (MTAType  !=  'Cancellation' && seletedProrateoption == 'Flat'?0:(seletedProrateoption == 'Prorated'?PSW.ps.Risk_Premium_Pro__c* proratingfator:PSW.ps.Risk_Premium_Pro__c));
                //System.debug('PSW.netBasePremium_Converted::'+PSW.netBasePremium_Converted+'::'+seletedProrateoption+'::'+PSW.ps.Risk_Premium_Pro__c);
                if(PSW.ps.Product__c  ==  'Commercial Combined')
                    PSW.netBasePremium_Converted  =  (MTAType  !=  'Cancellation' && seletedProrateoption == 'Flat'?0:(seletedProrateoption == 'Prorated'?PSW.ps.Risk_Premium_Pro__c* proratingfator:PSW.ps.Risk_Premium_Pro__c));
                
                try{  
                    if(PSW.ps.Endorsement_Premium_Pro__c !=  null){
                        PSW.endorsementPremium  =  0;
                        for(VG_Policy_Schedule_Endorsement__c pse: PSW.pseList){
                            PSW.endorsementPremium  +=  pse.VG_Premium__c;                            
                        }
                        PSW.endorsementPremium =  (MTAType  !=  'Cancellation' && seletedProrateoption == 'Flat'?0:(seletedProrateoption == 'Prorated'?PSW.ps.Endorsement_Premium_Pro__c* proratingfator:PSW.ps.Endorsement_Premium_Pro__c));                      
                    }else{
                        PSW.endorsementPremium = 0;  
                    }                            
                }catch(Exception ex){
                    //System.debug('Exception Occored::'+ex);
                    PSW.netModelPremium  =  0;
                }
                PSW.netModelPremium  =  (PSW.netBasePremium_Converted+PSW.endorsementPremium);
                PSW.ilfPremium  =  ((seletedProrateoption == 'Flat' || seletedProrateoption == '--Select--')?PSW.ps.ILF_Premium__c:(PSW.ps.ILF_Premium__c!= null? PSW.ps.ILF_Premium__c * proratingfator:0));
                PSW.ROL  =  ((seletedProrateoption == 'Flat' || seletedProrateoption == '--Select--')?PSW.ps.Rate_On_Line__c:PSW.ps.Rate_On_Line__c * proratingfator);
                PSW.techLayerPremium  =   ((seletedProrateoption == 'Flat' || seletedProrateoption == '--Select--')?PSW.ps.Technical_Layer_Premium__c:PSW.ps.Technical_Layer_Premium__c * proratingfator);
                PSW.RPM  =  ((seletedProrateoption == 'Flat' || seletedProrateoption == '--Select--')?PSW.ps.Rate_Per_Mil__c:PSW.ps.Rate_Per_Mil__c * proratingfator);
                If(PSW.ps.Product__c !=  'Commercial Combined' )
                    PSW.techModelPremium  =  PSW.techLayerPremium * (PSW.sharePercent/100);  //PSW.ps.VG_Technical_Model_Premium__c * proratingfator;
                else
                    PSW.techModelPremium  =  PSW.netModelPremium * (PSW.sharePercent/100);
                If(!IsUWadjustmnetOverride){
                    try{                  
                        PSW.adjustmentTechPremium  =  ((seletedProrateoption == 'Flat' || seletedProrateoption == '--Select--')?PSW.ps.Premium_Adjustment__c:((PSW.ps.Premium_Adjustment__c * proratingfator).setScale(2)));                                                 
                    }catch(Exception ex){
                        //System.debug('Exception Occored::'+ex);
                        PSW.adjustmentTechPremium  =  0;
                    }
                    
                }              
                
                If(!IsCommercialadjustmnetOverride){
                    try{                    
                        PSW.adjustment  =  ((seletedProrateoption == 'Flat' || seletedProrateoption == '--Select--')?PSW.ps.Premium_Adjustment_2__c:((PSW.ps.Premium_Adjustment_2__c * proratingfator).setScale(2)));   
                    }catch(Exception ex){
                        //System.debug('Exception Occored::'+ex);
                        PSW.adjustment  =  0;
                    }                   
                }
                PSW.techPremium  =  PSW.techModelPremium + PSW.adjustmentTechPremium;
                PSW.uwPremium  =  PSW.techModelPremium + PSW.adjustmentTechPremium;
                PSW.actualPremium  =  PSW.uwPremium + PSW.adjustment;
                PSW.grossWrittenPremium  =  PSW.actualPremium/(1-(PSW.brokerage/100));
                PSW.brokerageAmount  =  (PSW.grossWrittenPremium)*(PSW.brokerage/100);
                If(PSW.sharePercent!= 0)
                    PSW.grossWrittenPremium2  = PSW.grossWrittenPremium/(PSW.sharePercent/100);
                try{
                    if(PSW.GrossOrNet  ==  'Net'){
                        PSW.transactionPremium  =  PSW.actualPremium + PSW.IPTAmount + PSW.feeIncome + PSW.levies;
                    }else{
                        PSW.transactionPremium  =  PSW.grossWrittenPremium + PSW.IPTAmount + PSW.feeIncome + PSW.levies;
                    }
                }catch(exception ex){
                    PSW.transactionPremium  =  0;
                }
                try{
                    PSW.orcAmount  =  PSW.actualPremium*(PSW.orcPercent/100);
                }catch(exception ex){
                    PSW.orcAmount  =  0;
                }
                PSW.feeIncome  =  PSW.ps.VG_Fee_Income__c;
                PSW.levies  =  PSW.ps.Levies__c;
            }else{                                
                //System.debug('Property');               
                assetsList  =  [Select Id,  VG_Territorial_Limits__c, VG_Net_PD_Premium__c, Asset__c, VG_Policy_Schedule__r.Product__c, VG_Net_Risk_Premium__c, VG_Net_MB_Premium__c, VG_Net_BI_Premium__c, Asset__r.VG_Full_Value_Building__c, Asset__r.VG_Total_Business_Interruption_SI__c, Asset__r.VG_Total_Property_Damage_SI__c, VG_Coverage__c,  VG_Deductible__c,  VG_Policy_Schedule__c ,  VG_Sub_limit__c,  VG_Share__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psList.KeySet()];                      
                for(VG_Policy_Schedule_Asset__c asset : assetsList){
                    //System.debug('Is Property');
                    If(asset.VG_Policy_Schedule__r.Product__c  ==  'Property'){      
                        AssetWrapper AW  =  new AssetWrapper();
                        AW.asset  =  asset;
                        AW.totalPropertyDamageSI  =  asset.Asset__r.VG_Total_Property_Damage_SI__c;
                        AW.totalBusinessInterruptionSI  =  asset.Asset__r.VG_Total_Business_Interruption_SI__c;
                        If(AW.totalPropertyDamageSI!= null && AW.totalBusinessInterruptionSI!= null)
                            AW.totalSumInsuredSI  =  AW.totalPropertyDamageSI + AW.totalBusinessInterruptionSI;
                        AW.fullValue  =  asset.Asset__r.VG_Full_Value_Building__c;
                        AW.NetPDPremium  =  asset.VG_Net_PD_Premium__c;
                        AW.NetBIPremium  =  asset.VG_Net_BI_Premium__c;
                        AW.AdjustedMBPremium  =  asset.VG_Net_MB_Premium__c;
                        AW.NetRiskPremium  =  asset.VG_Net_Risk_Premium__c;
                        assetList.add(AW);
                        //System.debug('assetList::'+assetList);
                    }
                }
                If(!IsProrated){
                    PSW.netBasePremium  =  0;                         
                    for(AssetWrapper AW : assetList){                                        
                        PSW.netBasePremium_Converted  =  PSW.netBasePremium +(AW.NetRiskPremium!= null?AW.NetRiskPremium:0) ;                        
                    }
                    PSW.netBasePremium_Converted  = (MTAType  !=  'Cancellation' && seletedProrateoption == 'Flat'?0:(seletedProrateoption == 'Prorated'?PSW.ps.Risk_Premium_Pro__c* proratingfator:PSW.ps.Risk_Premium_Pro__c));                                                               
                    //System.debug('PSW.netBasePremium_Converted::'+PSW.netBasePremium_Converted);
                    try{  
                        if(PSW.ps.Endorsement_Premium_Pro__c !=  null){
                            PSW.endorsementPremium  =  0;
                            for(VG_Policy_Schedule_Endorsement__c pse: PSW.pseList){
                                PSW.endorsementPremium  +=  pse.VG_Premium__c;
                            }
                            PSW.endorsementPremium =  (MTAType  !=  'Cancellation' && seletedProrateoption == 'Flat'?0:(seletedProrateoption == 'Prorated'?PSW.ps.Endorsement_Premium_Pro__c* proratingfator:PSW.ps.Endorsement_Premium_Pro__c));                         
                        }else{
                            PSW.endorsementPremium = 0;  
                        }                            
                    }catch(Exception ex){
                        //System.debug('Exception Occored::'+ex);
                        PSW.endorsementPremium = 0; 
                    }                  
                }
                
                try{
                    PSW.netModelPremium  =  (PSW.netBasePremium_Converted + PSW.endorsementPremium) ;                    
                }catch(Exception ex){
                    //System.debug('Exception Occored::'+ex);
                    PSW.netModelPremium  =  0;
                }
                try{
                    PSW.techModelPremium  =  PSW.netModelPremium * (PSW.sharePercent / 100);
                }catch(Exception ex){
                    //System.debug('Exception Occored::'+ex);
                    PSW.techModelPremium  =  0;
                }
                If(!IsUWadjustmnetOverride){
                    try{                  
                        PSW.adjustmentTechPremium  =((seletedProrateoption == 'Flat' || seletedProrateoption == '--Select--')?PSW.ps.Premium_Adjustment__c:((PSW.ps.Premium_Adjustment__c * proratingfator).setScale(2)));                                            
                    }catch(Exception ex){
                        //System.debug('Exception Occored::'+ex);
                        PSW.adjustmentTechPremium  =  0;
                    }                  
                }              
                
                If(!IsCommercialadjustmnetOverride){
                    try{                    
                        PSW.adjustment  =  ((seletedProrateoption == 'Flat'  || seletedProrateoption == '--Select--')?PSW.ps.Premium_Adjustment_2__c:((PSW.ps.Premium_Adjustment_2__c * proratingfator).setScale(2)));     
                    }catch(Exception ex){
                        //System.debug('Exception Occored::'+ex);
                        PSW.adjustment  =  0;
                    }                   
                }
                
                try{
                    PSW.uwPremium  =  PSW.techModelPremium + PSW.adjustmentTechPremium;
                }catch(Exception ex){
                    //System.debug('Exception Occored::'+ex);
                    PSW.uwPremium  =  0;
                }
                try{
                    PSW.actualPremium  =  PSW.uwPremium + PSW.adjustment;
                }catch(Exception ex){
                    //System.debug('Exception Occored::'+ex);
                    PSW.actualPremium  =  0;
                }
                try{
                    PSW.grossWrittenPremium  =  PSW.actualPremium/(1-(PSW.brokerage/100));
                }catch(Exception ex){
                    //System.debug('Exception Occored::'+ex);
                    PSW.grossWrittenPremium  =  0;
                }
                try{
                    PSW.grossWrittenPremium2  = PSW.grossWrittenPremium/(PSW.sharePercent/100);            
                }catch(Exception ex){
                    PSW.grossWrittenPremium2 =  0;
                }
                try{
                    PSW.brokerageAmount  =  (PSW.grossWrittenPremium)*(PSW.brokerage/100);
                }catch(Exception ex){
                    //System.debug('Exception Occored::'+ex);
                    PSW.brokerageAmount  =  0;
                }
                try{                    
                    if(GrossOrNet  ==  'Net'){
                        PSW.transactionPremium  =  (PSW.actualPremium!= null?PSW.actualPremium:0) + (PSW.IPTAmount!= null?PSW.IPTAmount:0) + (PSW.feeIncome!= null?PSW.feeIncome:0) + (PSW.levies!= null?PSW.levies:0);
                    }else{
                        PSW.transactionPremium  =  (PSW.grossWrittenPremium!= null?PSW.grossWrittenPremium:0) + (PSW.IPTAmount!= null?PSW.IPTAmount:0) + (PSW.feeIncome!= null?PSW.feeIncome:0) + (PSW.levies!= null?PSW.levies:0);
                    }
                }catch(Exception ex){
                    //System.debug('Exception Occored::'+ex);
                    PSW.transactionPremium  =  0;
                }
                PSW.feeIncome  =  PSW.ps.VG_Fee_Income__c;
                PSW.levies  =  PSW.ps.Levies__c;
            }
        }
        IsProrated  =  True; 
        IsUWadjustmnetOverride  =  True;
        IsCommercialadjustmnetOverride  =  True;
        netBasePremium_Converted  =  0;
        endorsementPremium  =  0;
        netModelPremium  =  0;
        ilfPremium  =  0;
        ROL  =  0;
        techLayerPremium  =  0;
        RPM  =  0;
        techModelPremium  =  0;
        techPremium  =  0;
        uwPremium  =  0;
        actualPremium  =  0;
        grossWrittenPremium = grossWrittenPremium2  =  0;
        brokerageAmount  =  0;
        transactionPremium  =  0;
        orcAmount  =  0;
        for(PSWrapper PSW:PSWrapperMap.values()){
            netBasePremium_Converted  +=   PSW.netBasePremium_Converted !=  null ? PSW.netBasePremium_Converted : 0;
            endorsementPremium  +=   PSW.endorsementPremium !=  null ? PSW.endorsementPremium : 0;
            netModelPremium  +=   PSW.netModelPremium !=  null ? PSW.netModelPremium : 0;
            ilfPremium  +=   PSW.ilfPremium !=  null ? PSW.ilfPremium : 0;
            ROL  +=   PSW.ROL !=  null ? PSW.ROL : 0;
            techLayerPremium  +=   PSW.techLayerPremium !=  null ? PSW.techLayerPremium : 0;
            RPM  +=   PSW.RPM !=  null ? PSW.RPM : 0;
            techModelPremium  +=   PSW.techModelPremium !=  null ? PSW.techModelPremium : 0;
            techPremium  +=   PSW.techPremium !=  null ? PSW.techPremium : 0;
            uwPremium  +=   PSW.uwPremium !=  null ? PSW.uwPremium : 0;
            actualPremium  +=   PSW.actualPremium !=  null ? PSW.actualPremium : 0;
            grossWrittenPremium  +=   PSW.grossWrittenPremium !=  null ? PSW.grossWrittenPremium : 0;
            brokerageAmount  +=   PSW.brokerageAmount !=  null ? PSW.brokerageAmount : 0;
            transactionPremium  +=   PSW.transactionPremium !=  null ? PSW.transactionPremium : 0;
            orcAmount  +=   PSW.orcAmount !=  null ? PSW.orcAmount : 0;
        }
        return null;
    }    
    
    
    public PageReference finish(){
        
        Policy__c pol = [select id, Name,VG_Is_Renewal__c, VG_Inception_Date__c, VG_Expiry_Date__c from Policy__c where Id = :policyId limit 1];
        
        if( MTAType  ==  'Cancellation' && ps.VG_MTA_Cancellation_Date__c  ==  null ){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please fill Cancellation Date..')); 
            return null;
        }
        
        if( MTAType  ==  'Cancellation' && ( ps.MTA_Reason_for_Cancellation__c  ==  '--None--' || ps.MTA_Reason_for_Cancellation__c  ==  null || ps.MTA_Reason_for_Cancellation__c  ==  '' ) ){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select Reason for Cancellation..')); 
            return null;
        }
        if(ps.VG_Pre_MTA_Expiry_Date__c<ps.VG_MTA_Cancellation_Date__c){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Cancellation Date Can\'t be greater than Current Expiry date..'));    
            return null;  
        }
        if(ps.VG_MTA_Cancellation_Date__c < pol.VG_Inception_Date__c){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Cancellation Date Can\'t be less than policy inception date'));    
            return null;  
        }
        if( MTAType  ==  'Reduction' && ps.VG_MTA_Reduction_Date__c ==  null ){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please fill Reduction Date..')); 
            return null;
        }
        if(ps.VG_Pre_MTA_Expiry_Date__c<ps.VG_MTA_Reduction_Date__c){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Reduction Date Can\'t be greater than Current Expiry date..'));    
            return null;  
        }        
        if(MTAType  ==  null || MTAType  == 'Revision of Cover'){
            
            List<VG_Policy_Schedule_Asset__c> assetsToBeInserted  =  new List<VG_Policy_Schedule_Asset__c>();
            List<VG_Policy_Schedule_Endorsement__c> endToBeUpdated  =  new List<VG_Policy_Schedule_Endorsement__c>();
            List<VG_Policy_Schedule_Endorsement__c> endToBeInserted  =  new List<VG_Policy_Schedule_Endorsement__c>();
            List<VG_Exposure_Premium__c> exposuresToBeInserted  =  new List<VG_Exposure_Premium__c>();
            ps.id = PSID;
            ps.Policy__c  =  policyId;
            ps.VG_Lloyds_Product__c = LProduct;
            ps.Risk_Premium_Pro__c  =  netBasePremium_Converted;
            ps.Endorsement_Premium_Pro__c  = endorsementPremium;
            ps.Net_Premium__c  =  netModelPremium;
            ps.Commission__c  =  commissionPercent;
            ps.Gross_Base_Premium__c  =  grossBasePremium;
            ps.Transaction_GWP__c  =  transactionPremium;
            ps.Limit__c  =  limitAmount_Converted;
            ps.Attachment__c  =  attachment_Converted;
            ps.Sum_Insured__c  =  sumInsured;
            ps.ILF_Factor__c  =  ilfFactor;
            ps.ILF_Premium__c  =  ilfPremium;
            ps.ILF_Layer__c  =  layer ;
            If(RateChange == 0.00 && p.VG_Is_Renewal__c   == false)       
                ps.VG_Rate_Change__c   =   null;
            else
                ps.VG_Rate_Change__c   =  RateChange;
            ps.Written_share__c  =  writtenShare ;
            ps.Product__c = price.VG_Product__c;
            ps.VG_Deductible__c = DeductibleRate_Converted;
            ps.Technical_Layer_Premium__c  =  techLayerPremium ;
            ps.Gross_Written_Premium__c  =  grossWrittenPremium ;
            if(sharePercent > 0)
                grossWrittenPremium2  = grossWrittenPremium/(sharePercent/100);  
            else
                grossWrittenPremium2  = 0;
            ps.VG_Gross_Written_Premium_100__c = grossWrittenPremium2;
            ps.Gross_or_Net_Premium__c  =  GrossOrNet ;
            ps.Rate_On_Line__c  =  ROL;
            ps.VG_Auto_acquisition_Threshold__c = AutoacqThreshold;
            ps.VG_Retired_Directors_Additional_Premium__c = RDAP;
            ps.VG_Retired_Directors_Year__c = RDYear;
            ps.VG_Extended_Reporting_Period_AP__c = ExtReportingPeriod_AP;
            ps.Rate_Per_Mil__c  =  RPM;
            ps.Share__c  =  sharePercent;
            ps.Technical_UW_Premium__c  =  uwPremium;
            ps.Premium_Adjustment__c  =  adjustmentTechPremium;
            ps.Underwriting_Premium__c  =  uwPremium;
            ps.Premium_Adjustment_2__c  =  adjustment;
            ps.VG_Technical_Model_Premium__c  =  techModelPremium;
            ps.ORC__c  =  orcPercent;
            ps.ORC_Amount__c  =  orcAmount;
            //ps.VG_Is_MTA__c  =  False;
            if(ps.VG_MTA_Type__c != 'Revision of Cover'){
                ps.Base_Creation_Start_Date__c  =  pol.VG_Inception_Date__c;
                ps.Base_Creation_End_Date__c  =  pol.VG_Expiry_Date__c;   
            }
            if(ps.VG_MTA_Type__c == 'Revision of Cover'){
                ps.Base_Creation_Start_Date__c = ps.VG_MTA_Start_Date__c;
                ps.Base_Creation_End_Date__c = ps.VG_MTA_End_Date__c;    
            }
            ps.VG_Brokerage_Percent__c  =  brokerage;
            //below 3 lines added by Anu 30.8.2018
            ps.Actual_GWP__c = actualPremium;
            ps.VG_Brokerage_Amount__c = brokerageAmount;
            ps.IPT__c = IPTAmount;
            //ps.IPT_Percent__c  =  IPTPercent;
            ps.Levies__c  =  levies;
            ps.VG_Fee_Income__c  =  feeIncome;
            ps.VG_Base_Policy__c  =  True;
            
            Decimal totalTSI = 0;
            for(AssetWrapper aw : assetList){
                try{
                    totalTSI = totalTSI + allAccountAssets.get(aw.asset.Asset__c).VG_True_TSI__c;
                }Catch(Exception ex){
                
                }
            }
        
            if(IsProperty){
                ps.VG_Occupancy__c  =  selectedOccupancy;
                ps.VG_PD_Base_Rate__c  =  PDBaseRate;
                ps.VG_BI_Base_Rate__c  =  BIBaseRate;
                ps.VG_Loss_Limit__c  =  Losslimit;
                ps.VG_Norwegian_Nat_Cat_Pool_Premium__c  =  fireNatCatPoolPremium;              
                ps.VG_Machinery_Breakdown_Cover__c  =  MachineryBreakdownCover;
                ps.VG_Machinery_Breakdown_BI_Cover__c  =  MachineryBreakdownBICover;
                ps.VG_Adjustment_Factor__c  =  adjustmentFactor;
                ps.VG_Adjusted_PD_Base_Rate__c  =  adjustedPDBaseRate;
                ps.VG_Adjusted_BI_Base_Rate__c  =  adjustedBIBaseRate;
            }else{
                ps.VG_Turn_Over__c  =  ps.Product__c !=  'Clinical Trials' ? Turnover_Converted : Decimal.valueOf(numberOfPatients_Converted );
                ps.VG_Type_Of_Operation__c  =  pricingRate;
                ps.VG_CREDIT_Augur_SCORE__c  =  creditScore;
                ps.VG_Deductible__c  =  DeductibleRate_Converted;
                ps.VG_Exposure_Premium__c  =  netExposurePremium_Converted;
                ps.VG_Experience_Premium__c  =  experiencePremium_Converted;
                ps.VG_Selected_Weight__c  =  seletedWeight;
                ps.VG_Net_Base_Premium__c  =  netBasePremium_Converted;
            }
            if(ps.Name.contains('/EEA')){                
                ps.Name = ps.Name.remove('/EEA');
            }
            if(ps.Split_Type__c == 'EEA'){
                ps.Name = ps.Name+'/EEA';
            }else{
                ps.VG_Volante_Entities__c = '';
            }
            Utilities.SkipMethods('ExpiryDate_Update_1');
            Utilities.SkipMethods('ExpiryDate_Update_2');            
            Utilities.SkipMethods('Bridge Context');                                     
            If(MTAType ==  null){
                Upsert ps;                            
            }else{
                List<Policy_Schedule__c> tmpList = new List<Policy_Schedule__c>([select id, Name, Policy__r.Name, VG_Pre_MTA_Expiry_Date__c,VG_MTA_Cancellation_Date__c,VG_MTA_Reduction_Date__c,MTA_Parent_Policy_Schedule__c, VG_Capacity_Paper__c, VG_Is_Co_Insurance__c from Policy_Schedule__c where Policy__c  = : p.id]);
                ps.VG_Is_MTA__c = true;
                ps.VG_MTA_Type__c = 'Revision of Cover';  
                ps.id = null;
                ps.VG_Base_Policy__c = true;
                ps.VG_MTA_Start_Date__c = Date.valueOf(MTAStartDate);
                ps.VG_MTA_End_Date__c = p.VG_Expiry_Date__c;
                ps.Base_Creation_Start_Date__c = ps.VG_MTA_Start_Date__c;
                ps.Base_Creation_End_Date__c = ps.VG_MTA_End_Date__c;
                if(ps.Split_Type__c == 'EEA'){
                    ps.Name = tmpList[0].Policy__r.Name+'/MTA/'+tmpList.size()+'/EEA'; 
                }else{
                    ps.Name = tmpList[0].Policy__r.Name+'/MTA/'+tmpList.size();
                }
                ps.IPT__c = null;
                ps.IPT_Percent__c = null;              
                ps.MTA_Parent_Policy_Schedule__c = PSID;
                PolicyScheduleTriggerFunction.stopCOIFlag = true;
                Insert ps;               
                if(price.VG_Product__c  == 'FIPI'){
                    String addInfo = '';
                    if(!IsProperty){
                        for(PricingWrapper pricing:FIPIFactors ){
                            addInfo +=  pricing.factorName+':'+pricing.price+':'+pricing.priceDecimal+':'+pricing.premiumMovement_Converted+'<br/>';
                        }
                    }else{
                        for(PricingWrapper pricing:FIPIFactors ){
                            addInfo +=  pricing.factorName+':'+pricing.price+':'+pricing.priceDecimal+'<br/>';
                        }
                    }
                    rc.VG_Additional_Information__c = addInfo;
                    if(MTAType == 'Revision of Cover'){
                        rc.id = null;
                        rc.Policy_Schedule__c  = ps.id;
                        rc.Name = ps.Name+'/RD/1';
                        Insert rc;
                    }
                }
                PolicyScheduleTriggerFunction.allowInsertRI  =  True;
                PolicyScheduleTriggerFunction.createRIRecords(new List<Policy_Schedule__c>{ps});                                
            }           
            if(price.VG_Product__c  == 'FIPI' && MTAType!= 'Revision of Cover'){
                String addInfo = '';
                if(!IsProperty){
                    for(PricingWrapper pricing:FIPIFactors ){
                        addInfo +=  pricing.factorName+':'+pricing.price+':'+pricing.priceDecimal+':'+pricing.premiumMovement_Converted+'<br/>';
                    }
                }else{
                    for(PricingWrapper pricing:FIPIFactors ){
                        addInfo +=  pricing.factorName+':'+pricing.price+':'+pricing.priceDecimal+'<br/>';
                    }
                }
                rc.VG_Additional_Information__c = addInfo;
                if(rc.Policy_Schedule__c  ==  null)
                    rc.Policy_Schedule__c  = ps.id;
                if(rc.Name == null)
                    rc.Name = ps.Name+'/RD/1';
                //Upsert rc;
                If(MTAType ==  null){
                    Upsert rc;
                }else{
                    rc.id = null;
                    Insert rc;
                }
            }
            Set<ID> pseIds = new Set<ID>();
            for(VG_Policy_Schedule_Endorsement__c pse : pseMap.values()){
                pseIds.add(pse.id);
            }
            for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements){
                if(pse.id == null || MTAType!=  null){
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
                if(pse.id == null || MTAType!=  null){
                    endToBeInserted.add(pse);
                }else{
                    VG_Policy_Schedule_Endorsement__c tmp =  new VG_Policy_Schedule_Endorsement__c ();
                    tmp.id = pse.id;
                    tmp = pse;
                    endToBeUpdated.add(tmp);
                    pseIds.remove(pse.id);
                }
            }
            if(pseIds.size() > 0 && MTAType ==  null){
                List<VG_Policy_Schedule_Endorsement__c> endToBeDeleted  =  new List<VG_Policy_Schedule_Endorsement__c>([select id, VG_IsTempDelete__c, VG_Endorsement_Number__c,VG_Title__c from VG_Policy_Schedule_Endorsement__c where id IN: pseIds]);
                Delete endToBeDeleted;
            }
            Integer psecount = 1;
            Integer psesbcount = 1;
            if(!endToBeUpdated.IsEmpty()){
                for(VG_Policy_Schedule_Endorsement__c pse : endToBeUpdated){
                    if(pse.VG_Type__c  ==  'Endorsements'){
                        pse.Name = ps.Name+'/PE/'+psecount;
                        psecount++;
                    }
                    else{
                        pse.Name = ps.Name+'/PESb/'+psesbcount;
                        psesbcount++;
                    }
                    if(MTAType!=  null)
                        pse.id = null;
                }
            }
            if(!endToBeInserted.IsEmpty()){
                for(VG_Policy_Schedule_Endorsement__c pse : endToBeInserted){
                    if(pse.VG_Type__c  ==  'Endorsements'){
                        pse.Name = ps.Name+'/PE/'+psecount;
                        psecount++;
                    }
                    else{
                        pse.Name = ps.Name+'/PESb/'+psesbcount;
                        psesbcount++;
                    }
                    if(MTAType!=  null)
                        pse.id = null;
                    pse.VG_Policy_Schedule__c = ps.id;
                    pse.CurrencyISOCode = ps.CurrencyISOCode;
                }
            }
            
            if(IsProperty){
                Integer asspsacount = 1;
                for(AssetWrapper AW : assetList){
                    AW.asset.VG_Policy_Schedule__c  =  ps.Id;
                    AW.asset.Name =  ps.Name + '/RR/' + asspsacount;
                    AW.asset.VG_PD_Deductible__c  =  AW.PDDeductible;
                    AW.asset.VG_Waiting_Period__c  =  AW.WaitingPeriod;
                    AW.asset.VG_BI_Indemnity_Period__c  =  AW.BIIndemnityPeriod;
                    AW.asset.VG_MB_PD_Deductible__c  =  AW.MBPDDeductible;
                    AW.asset.VG_MB_Waiting_Period__c  =  AW.MBWaitingPeriod;
                    AW.asset.VG_MB_BI_Indemnity_Period__c  =  AW.MBBIIndemnityPeriod;
                    AW.asset.VG_Adjusted_PD_Premium__c  =  AW.AdjustedPDPremium;
                    AW.asset.VG_Adjusted_BI_Premium__c  =  AW.AdjustedBIPremium;
                    AW.asset.VG_Building_Discount_Loading__c  =  AW.TotalDiscountLoading;
                    AW.asset.VG_Net_PD_Premium__c  =  AW.NetPDPremium;
                    AW.asset.VG_Net_BI_Premium__c  =  AW.NetBIPremium;
                    AW.asset.VG_Net_MB_Premium__c  =  AW.AdjustedMBPremium;
                    AW.asset.VG_Net_Risk_Premium__c  =  AW.NetRiskPremium;
                    AW.asset.VG_Sum_Insured__c   = totalTSI ;
                    if(MTAType!=  null)
                        AW.asset.id = null;
                    assetsToBeInserted.add(AW.asset);
                }
            }else{
                Integer psacount = 1;
                for(RRWrapper RW : riskRatingList){
                    RW.psa.VG_Policy_Schedule__c  =  ps.Id;
                    RW.psa.Name =  ps.Name + '/RR/' + psacount;
                    RW.psa.VG_Territorial_Limits__c = RW.TerritorialLimitsSelected;
                    RW.psa.VG_Coverage__c = RW.CoverageSelected;
                    RW.psa.VG_Share__c  =  RW.share;
                    if(MTAType!=  null)
                        RW.psa.id = null;
                    assetsToBeInserted.add(RW.psa);
                    psacount++;
                }
            }
            If(MTAType!= 'Revision of Cover'){
                for(PricingWrapper PW : otherFactors ){
                    if(exposuresMap.get(PW.factorName) !=  null){
                        //System.debug('PW::'+PW+'::'+PW.factorName+'::'+exposuresMap.get(PW.factorName));
                        VG_Exposure_Premium__c EP  =  exposuresMap.get(PW.factorName);
                        EP.VG_Factor_Name__c  =  PW.factorName;
                        EP.VG_Rating_Factor__c  =  PW.price;
                        EP.VG_Rate__c  =  PW.priceDecimal;
                        EP.VG_Other_Factor__c  =  False;
                        exposuresToBeInserted.add(EP);
                    }else{
                        //System.debug('PW::'+PW);
                        VG_Exposure_Premium__c EP = new VG_Exposure_Premium__c();
                        If(EP.VG_Policy_Schedule__c == null)
                            EP.VG_Policy_Schedule__c  =  ps.Id;
                        EP.VG_Factor_Name__c  =  PW.factorName;
                        EP.VG_Rating_Factor__c  =  PW.price;
                        EP.VG_Rate__c  =  PW.priceDecimal;
                        EP.VG_Other_Factor__c  =  False;
                        exposuresToBeInserted.add(EP);
                    }
                }            
                for(OtherFactors OW : otherFactorsList ){
                    //System.debug('OW ::'+OW );
                    VG_Exposure_Premium__c EP  =  exposuresOthersMap.get(OW.expName);
                    if(EP == null)
                        EP = new VG_Exposure_Premium__c();
                    if(OW.otherFactor != null)
                    EP.VG_Factor_Name__c  =  OW.otherFactor;
                    EP.VG_Rating_Factor__c  =  OW.factor;
                    EP.VG_Rate__c  =  OW.rate;
                    If(EP.VG_Policy_Schedule__c == null)
                        EP.VG_Policy_Schedule__c  =  ps.Id;            
                    EP.VG_Other_Factor__c  =  True;
                    exposuresToBeInserted.add(EP);
                }
            }
            If(MTAType  == 'Revision of Cover'){
                for(PricingWrapper PW : otherFactors ){
                    VG_Exposure_Premium__c EP  =  new VG_Exposure_Premium__c();
                    EP.VG_Factor_Name__c  =  PW.factorName;
                    EP.VG_Rating_Factor__c  =  PW.price;
                    EP.VG_Rate__c  =  PW.priceDecimal;
                    EP.VG_Policy_Schedule__c  =  ps.Id;
                    EP.VG_Other_Factor__c  =  False;
                    exposuresToBeInserted.add(EP);
                }
                for(OtherFactors OW : otherFactorsList ){
                    VG_Exposure_Premium__c EP  =  new VG_Exposure_Premium__c();
                    EP.VG_Factor_Name__c  =  OW.otherFactor;
                    EP.VG_Rating_Factor__c  =  OW.factor;
                    EP.VG_Rate__c  =  OW.rate;
                    EP.VG_Policy_Schedule__c  =  ps.Id;
                    EP.VG_Other_Factor__c  =  True;
                    exposuresToBeInserted.add(EP);
                }                
            }
            //Utilities.SkipMethods('Bridge Context');               
            if(!endToBeUpdated.IsEmpty()){
                update endToBeUpdated;
            }
            if(!endToBeInserted.IsEmpty()){
                insert endToBeInserted;
            }
            if(!assetsToBeInserted.IsEmpty()){
                Upsert assetsToBeInserted;
            }
            if(!exposuresToBeInserted.IsEmpty() && (MTAType == null)){
                Upsert exposuresToBeInserted;
            }else{
                List<VG_Exposure_Premium__c> tmpList =  new List<VG_Exposure_Premium__c>();
                for(VG_Exposure_Premium__c ep: exposuresToBeInserted){
                    VG_Exposure_Premium__c tmp = new VG_Exposure_Premium__c();
                    tmp = ep.clone(false, true, false, false);
                    tmp.id = null;
                    tmpList.add(tmp);
                }
                if(!tmpList.IsEmpty())
                    Insert tmpList;
            }
            Utilities.clearMethods();
               
            return new PageReference('/'+ps.Id);
        }else{
            Map<String, Policy_Schedule__c> insertPSMap = new Map<String, Policy_Schedule__c>();
            Map<String, List<VG_Policy_Schedule_Asset__c >> psaMapDup  =  new Map<String, List<VG_Policy_Schedule_Asset__c >>();
            Map<String, List<VG_Policy_Schedule_Endorsement__c >> pseMapDup  =  new Map<String, List<VG_Policy_Schedule_Endorsement__c >>();
            Map<String, List<VG_Exposure_Premium__c>> expMapDup  =  new Map<String, List<VG_Exposure_Premium__c>>();
            Map<String, List<Risk_Capture__c>> rcMapDup  =  new Map<String, List<Risk_Capture__c>>();
            List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([select id, Name,VG_Capacity_Paper__c, VG_Volante_Entities__c,VG_Entity_Split_Required__c,Split_Type__c, VG_Pre_MTA_Expiry_Date__c,VG_MTA_Cancellation_Date__c,VG_MTA_Reduction_Date__c,  VG_Is_Co_Insurance__c from Policy_Schedule__c where Policy__c  = : policyId]);
            List<VG_Policy_Schedule_Asset__c> finalpsaList  =  new List<VG_Policy_Schedule_Asset__c >();
            List<VG_Policy_Schedule_Endorsement__c> finalpseList  =  new List<VG_Policy_Schedule_Endorsement__c  >();
            List<VG_Exposure_Premium__c> finalExpList  =  new List<VG_Exposure_Premium__c>();
            List<Risk_Capture__c> finalrcList  =  new List<Risk_Capture__c>();
            
            Integer psCount  =  psList.size();
            for(PSWrapper psw : PSWrapperMap.values()){
                //System.debug('Ps::'+psw);
                Policy_Schedule__c temp = psw.ps.clone(false,  true,  false,  false);
                temp.IPT__c = null;
                temp.IPT_Percent__c = null;
                temp.Policy__c  =  policyId;
                temp.MTA_Parent_Policy_Schedule__c = psw.ps.id;
                temp.Risk_Premium_Pro__c = psw.netBasePremium_Converted;
                temp.VG_Technical_Model_Premium__c  = psw.techModelPremium;
                temp.Endorsement_Premium_Pro__c  = psw.endorsementPremium;
                temp.Premium_Adjustment__c  = psw.adjustmentTechPremium;
                temp.Net_Premium__c  = psw.netModelPremium;
                temp.Underwriting_Premium__c = temp.Technical_UW_Premium__c  = psw.uwPremium;
                if(price.VG_Product__c  ==  'Clinical Trials')
                    temp.ILF_Layer__c  = psw.layer;
                else
                    temp.ILF_Layer__c  = 'Primary';
                temp.Premium_Adjustment_2__c = psw.adjustment;
                temp.Limit__c  = psw.limitAmount_Converted;
                temp.Actual_GWP__c = psw.actualPremium;
                temp.Attachment__c  = psw.attachment_Converted;
                temp.VG_Brokerage_Percent__c  = psw.brokerage;
                temp.ILF_Factor__c  = psw.ILFFactor;
                temp.VG_Brokerage_Amount__c = psw.brokerageAmount;
                temp.ILF_Premium__c  = psw.ilfPremium;
                temp.Gross_Written_Premium__c  = psw.grossWrittenPremium;
                temp.VG_Gross_Written_Premium_100__c = psw.grossWrittenPremium2;
                temp.Rate_On_Line__c  = psw.ROL;
                temp.Technical_Layer_Premium__c  = psw.techLayerPremium;
                temp.Rate_Per_Mil__c  = psw.RPM;
                temp.Levies__c  = psw.levies;
                temp.Written_share__c  = psw.writtenShare;
                temp.VG_Fee_Income__c  = psw.feeIncome;
                temp.Share__c  = psw.sharePercent;
                temp.Gross_or_Net_Premium__c  = psw.GrossOrNet;
                temp.Sum_Insured__c  = psw.sumInsured;
                temp.VG_Base_Policy__c  =  False;
                temp.id  =  null;
                if(IsProperty){
                    temp.VG_Occupancy__c  = psw.selectedOccupancy;
                    temp.VG_PD_Base_Rate__c  = psw.PDBaseRate;
                    temp.VG_BI_Base_Rate__c  = psw.BIBaseRate;
                    temp.VG_Machinery_Breakdown_Cover__c  = psw.MachineryBreakdownCover;
                    temp.VG_Machinery_Breakdown_BI_Cover__c  = psw.MachineryBreakdownBICover;
                    temp.VG_Adjustment_Factor__c  = psw.adjustmentFactor;
                    temp.VG_Adjusted_PD_Base_Rate__c  = psw.adjustedPDBaseRate;
                    temp.VG_Adjusted_BI_Base_Rate__c  = psw.adjustedBIBaseRate;
                }
                if(temp.Split_Type__c == 'EEA'){
                    temp.Name  =  pol.Name + '/MTA/' + psCount+'/EEA';
                }else{
                    temp.Name  =  pol.Name + '/MTA/' + psCount;
                }  
                psCount++;
                temp.VG_Is_MTA__c  =  true;
                temp.VG_MTA_Type__c  =  MTAType;
                if(MTAType  ==  'Cancellation' || MTAType  ==  'Reduction'){
                    temp.VG_MTA_Start_Date__c  =  pol.VG_Inception_Date__c;
                    If(MTAType  ==  'Cancellation'){
                        temp.VG_MTA_Cancellation_Date__c = ps.VG_MTA_Cancellation_Date__c;
                        temp.MTA_Reason_for_Cancellation__c  =  ps.MTA_Reason_for_Cancellation__c;                      
                        pol.VG_Expiry_Date__c  =  ps.VG_MTA_Cancellation_Date__c; 
                        pol.VG_Sub_Status__c = 'Cancelled';              
                    }else If(MTAType  ==  'Reduction'){
                        temp.Base_Creation_End_Date__c = ps.VG_MTA_Reduction_Date__c;
                        temp.VG_MTA_Reduction_Date__c=ps.VG_MTA_Reduction_Date__c;  
                        pol.VG_Expiry_Date__c  = ps.VG_MTA_Reduction_Date__c-1;                                   
                    }                                         
                }
                
                if(MTAType  ==  'Extension'){
                    temp.MTA_Reason_for_Cancellation__c  =  ps.MTA_Reason_for_Cancellation__c;
                    temp.VG_MTA_Start_Date__c  =  pol.VG_Expiry_Date__c+1;
                    temp.VG_MTA_End_Date__c  =  ps.VG_MTA_End_Date__c;
                    //pol.VG_Expiry_Date__c  =  ps.VG_MTA_End_Date__c;
                }
                if(temp.VG_Is_Co_Insurance__c || temp.VG_Co_Insurance_type__c  == 'Child'){
                    temp = VG_ManageCoInsuranceController.summarayCalc(temp);
                }
                insertPSMap.put(temp.Name, temp);                
                psaMapDup.put(temp.Name, new List<VG_Policy_Schedule_Asset__c >());
                psaMapDup.get(temp.Name).addAll(PSW.psaList);
                pseMapDup.put(temp.Name, new List<VG_Policy_Schedule_Endorsement__c >());
                pseMapDup.get(temp.Name).addAll(PSW.pseList );
                expMapDup.put(temp.Name, new List<VG_Exposure_Premium__c >());
                expMapDup.get(temp.Name).addAll(PSW.EXPList);
                rcMapDup.put(temp.Name, new List<Risk_Capture__c>());
                rcMapDup.get(temp.Name).addAll(PSW.RCList);
                
            }
            for(Policy_Schedule__c ps : insertPSMap.values()){
                if(ps.VG_MTA_Type__c  ==  'Extension'){
                    pol.VG_Expiry_Date__c  =  ps.VG_MTA_End_Date__c;
                    //System.debug('expiry::'+pol.VG_Expiry_Date__c+'::'+ps.VG_MTA_End_Date__c);                               
                }else{
                    If(MTAType  ==  'Cancellation'){
                        pol.VG_Expiry_Date__c  =  ps.VG_MTA_Cancellation_Date__c;                                     
                    }else If(MTAType  ==  'Reduction'){
                        pol.VG_Expiry_Date__c  = ps.VG_MTA_Reduction_Date__c-1;                                   
                    }  
                }
                //System.debug('expiry::'+pol.VG_Expiry_Date__c+'::'+ps.VG_MTA_End_Date__c);                               
            }
            update pol;
            PolicyScheduleTriggerFunction.allowCOI_Ext_Cac_Reduc_Flag = true;
            //System.debug('insertPSMap::'+insertPSMap.keyset()+'::'+insertPSMap);
            if(!insertPSMap.IsEmpty())
                Insert insertPSMap.values();
            
            for(String psName : insertPSMap.keyset()){
                counter = 1;
                for(VG_Policy_Schedule_Asset__c temp: psaMapDup.get(psName)){
                    temp.Id  =  null;
                    temp.Name = psName+'/RR/'+counter;
                    temp.VG_Policy_Schedule__c  =  insertPSMap.get(psName).Id;
                    counter++;
                    finalpsaList.add(temp);
                    //System.debug('finalpsaList::'+finalpsaList.size());
                }
                counter = 1;
                If(!pseMapDup.IsEmpty()){
                    for(VG_Policy_Schedule_Endorsement__c temp: pseMapDup.get(psName)){
                        temp.Id  =  null;
                        temp.Name = psName+'/PE/'+counter; 
                        temp.VG_Policy_Schedule__c  =  insertPSMap.get(psName).Id;
                        counter++;
                        finalpseList.add(temp);
                    }
                }
                If(!expMapDup.IsEmpty()){
                    for(VG_Exposure_Premium__c temp: expMapDup.get(psName)){
                        temp.Id  =  null;
                        temp.VG_Policy_Schedule__c  =  insertPSMap.get(psName).Id;
                        finalExpList.add(temp);  
                    }
                }
                if(!rcMapDup.IsEmpty()){
                    for(Risk_Capture__c temp: rcMapDup.get(psName)){
                        temp.Id  =  null;
                        temp.Policy_Schedule__c  =  insertPSMap.get(psName).Id;  
                        finalrcList.add(temp);
                    }
                }
            }
            //System.debug('finalpsaList::'+finalpsaList.size());
            if(finalrcList != null && !finalrcList.IsEmpty())
                Insert finalrcList ;
            if(psaListDup!= null && !psaListDup.IsEmpty())
                Insert finalpsaList;
            if(finalpseList!= null && !finalpseList.IsEmpty())
                Insert finalpseList;
            if(finalExpList!= null && !finalExpList.IsEmpty())
                Insert finalExpList;
            PolicyScheduleTriggerFunction.allowInsertRI  =  True;
            PolicyScheduleTriggerFunction.createRIRecords(insertPSMap.values());
            return new PageReference('/'+policyid);
        }
        
    }      
    
    public PageReference gotostep2(){
        if(price.VG_Product__c  ==  null ){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select Product..'));   
            showError = true; 
            return null;  
        }
        List<SelectOption> tempFactorsList;
        PricingWrapper pWrapper;
        Integer counter  =  0;
        
        if(price.VG_Product__c  ==  'Clinical Trials'){
            //System.debug('Product selected:'+price.VG_Product__c); 
            layer  =  'Primary';
        }
        //System.debug('IsPricingGenerated::'+(!IsPricingGenerated));
        if(!IsPricingGenerated){
            if(price.VG_Product__c  ==  'GLPL' || price.VG_Product__c  ==  'IPO' || price.VG_Product__c  ==  'Life Sciences' || price.VG_Product__c  ==  'Clinical Trials' || price.VG_Product__c  ==  'PI' || price.VG_Product__c  ==  'D&O' || price.VG_Product__c  ==  'Crime' ||  price.VG_Product__c  ==  'FIPI'){
                if(price.VG_Product__c  ==  'FIPI' ){
                    priceList = new List<VG_Pricing__c>([select id, Name, VG_Product__c, VG_Category__c, VG_Rating_Factor__c, VG_Rate__c from VG_Pricing__c where ((VG_Product__c  =  'PI' AND VG_Category__c !=  'Type of operation') OR (VG_Product__c  =  'FIPI')) and VG_Level__c  =  'Risk Detail' and VG_Rating_Factor__c !=  null ORDER BY VG_Order__c]);// ]);
                }else{
                    priceList = new List<VG_Pricing__c>([select id, Name, VG_Product__c, VG_Category__c, VG_Rating_Factor__c, VG_Rate__c from VG_Pricing__c where VG_Product__c = : price.VG_Product__c and VG_Level__c  =  'Risk Detail' and VG_Rating_Factor__c !=  null ORDER BY VG_Order__c]);// ]);
                }
                pricingMap  =  new Map<String,  PricingWrapper>();
                FIPIpricingMap  =  new Map<String,  PricingWrapper>();
                for(VG_Pricing__c price: priceList){
                    if(price.VG_Product__c !=  'FIPI' || price.VG_Category__c  ==  'Type of operation'){
                        if(pricingMap.get(price.VG_Category__c)  ==  null){
                            pWrapper  =  new PricingWrapper();
                            if(price.VG_Category__c  ==  'Type of operation'){
                                
                            }else{
                                counter++;
                            }
                            pWrapper.order  =  counter;
                            pWrapper.factors.add(new SelectOption('0', '--Select--'));
                        }else{
                            pWrapper  =  pricingMap.get(price.VG_Category__c);
                        }
                    }else{
                        if(FIPIpricingMap.get(price.VG_Category__c)  ==  null){
                            pWrapper  =  new PricingWrapper();
                            if(price.VG_Category__c  ==  'Type of operation'){
                                
                            }else{
                                counter++;
                            }
                            pWrapper.order  =  counter;
                            pWrapper.factors.add(new SelectOption('0', '--Select--'));
                        }else{
                            pWrapper  =  FIPIpricingMap.get(price.VG_Category__c);
                        }
                    }
                    if(pWrapper.factors.IsEmpty()){
                        tempFactorsList  =  new List<SelectOption>();
                    }else{
                        tempFactorsList  =  pWrapper.factors;
                    }
                    tempFactorsList.add(new SelectOption(String.valueOf(price.VG_Rate__c)+'>'+price.VG_Rating_Factor__c,  price.VG_Rating_Factor__c));
                    pWrapper.factorName  =  price.VG_Category__c;
                    pWrapper.factors  =  tempFactorsList;
                    pWrapper.productName  =  price.VG_Product__c;
                    if(price.VG_Product__c !=  'FIPI' || price.VG_Category__c  ==  'Type of operation' ){
                        pricingMap.put(pWrapper.factorName,  pWrapper);
                    }else{
                        FIPIpricingMap.put(pWrapper.factorName,  pWrapper);
                    }
                }
                for(String s : pricingMap.keySet()){
                    if(s  ==  'Type of operation'){
                        typeOfOperation  =  pricingMap.get(s);
                    }else if(s  ==  'Deductible Adjustment'){
                        deductibleFactor  =  pricingMap.get(s);
                    }else{
                        pWrapper  =  pricingMap.get(s);
                        if(exposuresMap.get(s) !=  null){
                            pWrapper.price  =  exposuresMap.get(s).VG_Rating_Factor__c;
                        }
                        otherFactors.add(pWrapper); 
                    }
                }
                for(String s : FIPIpricingMap.keySet()){
                    //System.debug('FIPIFactors:'+FIPIFactors+'; FIPIpricingMap.get(s):'+FIPIpricingMap.get(s));
                    FIPIFactors.add(FIPIpricingMap.get(s));
                }
                if(price.VG_Product__c  ==  'FIPI' && rc.VG_Additional_Information__c != null){
                    Map<String, PricingWrapper> pwl = new Map<String, PricingWrapper>();
                    String[] addInfo = rc.VG_Additional_Information__c.split('<br>');
                    if(!IsProperty){
                        for(Integer i = 0;i<addInfo.size();i++){
                            String[] s = addInfo[i].split(':');
                            PricingWrapper pw = new PricingWrapper();
                            pw.factorName = s[0];
                            pw.price = s[1].replace('&gt;', '>');
                            pw.priceDecimal = Decimal.valueOf(s[2]);
                            pw.premiumMovement_Converted = Double.valueOf(s[3]);
                            pwl.put(pw.factorName, pw);
                        }
                    }else{
                        for(Integer i = 0;i<addInfo.size();i++){
                            String[] s = addInfo[i].split(':');
                            PricingWrapper pw = new PricingWrapper();
                            pw.factorName = s[0];
                            pw.price = s[1];
                            pw.priceDecimal = Decimal.valueOf(s[2]);
                            pwl.put(pw.factorName, pw);
                        }
                    }
                    for(PricingWrapper pw:FIPIFactors){
                        if(pwl.get(pw.factorName) !=  null)
                            pw.price = pwl.get(pw.factorName).price;
                    }
                }
                FIPIpricingMap  =  null;
                pricingMap  =  null;
                IsPricingGenerated  =  True;
                IsProperty  =  False;
                updateExposure();
            }else if(price.VG_Product__c  ==  'Property'){
                occupanciesList  =  new List<SelectOption>();
                MBCList  =  new List<SelectOption>();
                MBBICList  =  new List<SelectOption>();
                MBCMap  =  new Map<String,  Decimal>();
                MBBICMap  =  new Map<String,  Decimal>();
                occupanciesList.add(new SelectOption('0', '--Select--'));
                pricingMap  =  new Map<String,  PricingWrapper>();
                priceList = new List<VG_Pricing__c>([select id, Name, VG_Product__c, VG_Category__c, VG_Rating_Factor__c, VG_Rate__c,  Sum_Insured_Limit__c from VG_Pricing__c where VG_Product__c  =  'Property' and VG_Level__c  =  'Risk Detail' and VG_Rate__c !=  null and VG_Rating_Factor__c !=  null ORDER BY VG_Order__c]);
                Set<String> occupanciesSet  =  new Set<String>();
                for(VG_Pricing__c price : priceList){
                    if(price.VG_Category__c  ==  'PD Base Rate' || price.VG_Category__c  ==  'BI Base Rate'){
                        if(price.VG_Category__c  ==  'BI Base Rate'){
                            BIRates.put(price.VG_Rating_Factor__c,  price.VG_Rate__c);
                        }else{
                            PDRates.put(price.VG_Rating_Factor__c,  price.VG_Rate__c);
                        }
                        occupanciesList.add(new SelectOption(price.VG_Rating_Factor__c,  price.VG_Rating_Factor__c));
                    }else if(price.VG_Category__c  ==  'Machinery Breakdown Cover'){
                        if(MBCList.IsEmpty()){
                            MBCList.add(new SelectOption('--None--',  '--None--'));
                        }
                        MBCMap.put(price.VG_Rating_Factor__c,  price.VG_Rate__c);
                        MBCList.add(new SelectOption(price.VG_Rating_Factor__c,  price.VG_Rating_Factor__c));
                    }else if(price.VG_Category__c  ==  'Machinery Breakdown BI Cover'){ 
                        if(MBBICList.IsEmpty()){
                            MBBICList.add(new SelectOption('--None--',  '--None--'));
                        }  
                        MBBICMap.put(price.VG_Rating_Factor__c,  price.VG_Rate__c);  
                        MBBICList.add(new SelectOption(price.VG_Rating_Factor__c,  price.VG_Rating_Factor__c));
                    }else{
                        if(pricingMap.get(price.VG_Category__c)  ==  null){
                            pWrapper  =  new PricingWrapper();
                            counter++;
                            pWrapper.order  =  counter;
                            pWrapper.factors.add(new SelectOption('0', '--Select--'));
                        }else{
                            pWrapper  =  pricingMap.get(price.VG_Category__c);
                        }
                        if(pWrapper.factors.IsEmpty()){
                            tempFactorsList  =  new List<SelectOption>();
                        }else{
                            tempFactorsList  =  pWrapper.factors;
                        }
                        //System.debug(tempFactorsList+',  '+price.VG_Rate__c+',  '+price.VG_Rating_Factor__c);
                        tempFactorsList.add(new SelectOption(String.valueOf(price.VG_Rate__c)+'>'+price.VG_Rating_Factor__c,  price.VG_Rating_Factor__c));
                        pWrapper.factorName  =  price.VG_Category__c;
                        pWrapper.factors  =  tempFactorsList;
                        if(exposuresMap.get(pWrapper.factorName) !=  null){
                            pWrapper.price  =  exposuresMap.get(pWrapper.factorName).VG_Rating_Factor__c;
                        }
                        pricingMap.put(pWrapper.factorName,  pWrapper);
                    }
                }    
                otherFactors  =  pricingMap.values(); 
                pricingMap  =  new Map<String,  PricingWrapper>();
                priceList = new List<VG_Pricing__c>([select id, Name, VG_Product__c, VG_Category__c, VG_Rating_Factor__c, VG_Rate__c from VG_Pricing__c where VG_Product__c  =  'Property' and VG_Level__c  =  'Risk Rating' and VG_Rate__c !=  null and VG_Rating_Factor__c !=  null ORDER BY VG_Order__c]);
                for(VG_Pricing__c price : priceList){
                    if(pricingMap.get(price.VG_Category__c)  ==  null){
                        pWrapper  =  new PricingWrapper();
                        counter++;
                        pWrapper.order  =  counter;
                    }else{
                        pWrapper  =  pricingMap.get(price.VG_Category__c);
                    }
                    if(pWrapper.factors.IsEmpty()){
                        tempFactorsList  =  new List<SelectOption>();
                    }else{
                        tempFactorsList  =  pWrapper.factors;
                    }
                    //System.debug(tempFactorsList+',  '+price.VG_Rate__c+',  '+price.VG_Rating_Factor__c);
                    tempFactorsList.add(new SelectOption(String.valueOf(price.VG_Rate__c),  price.VG_Rating_Factor__c));
                    pWrapper.factorName  =  price.VG_Category__c;
                    pWrapper.factors  =  tempFactorsList;
                    pricingMap.put(pWrapper.factorName,  pWrapper);
                }
                IsPricingGenerated  =  True;
                IsProperty  =  True;
                if(assetList  ==  null){
                    assetList  =  new List<AssetWrapper>();
                }
                RRcounter  =  0;
                allAccountAssets  =  new Map<Id,  Asset__c>([Select Id,VG_True_TSI__c,  Name, VG_PD_Deductible__c, VG_Waiting_Period__c,   VG_BI_Indemnity_Period__c, VG_MB_PD_Deductible__c, VG_MB_Waiting_Period__c, VG_MB_BI_Indemnity_Period__c,  VG_Total_Property_Damage_SI__c,  VG_Full_Value_Building__c,  VG_Total_Business_Interruption_SI__c,  VG_Automatic_Fire_alarm__c,  VG_Water_sprinklers__c,  VG_Smoke_and_heat_venting_system__c,  VG_Foam_supression_system__c,  VG_Machinery_SI__c,  VG_Full_time_public_Fire_Brigade_staff__c from Asset__c where VG_Account__c  = : accountId]);
                updateExposure();
            }else{
                IsPricingGenerated  =  False;
                IsProperty  =  False;
            }
        }
        UpdateNBP();
        return new PageReference('/apex/VG_Revise_Nordics_Step2');
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
        tempEndsmt.VG_Premium__c  =  0;
        tempEndsmt.VG_Sub_limit__c = 0;
        tempEndsmt.VG_Type__c = 'Endorsements';
        existingEndorsements.add(tempEndsmt);
    }
    
    public PageReference gotostep1A(){
        return new PageReference('/apex/VG_Revise_Nordics_Step1');
    }
    
    public PageReference gotostep3(){
        /*If((pricingRate == '' || pricingRate == null || pricingRate == '0') || Turnover_Converted == null ){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please Select Type Of Operation and give value for Turnover...')); 
           return null;       
        }*/
        UpdateNBP();
        return new PageReference('/apex/VG_Revise_Nordics_Step3');
    }
    
    public PageReference gotostep4(){
        for(VG_Policy_Schedule_Endorsement__c pse: existingEndorsements){
            if(pse.id != null && pse.VG_Endorsement_Library_Id__c  == null && manualList.IsEmpty())
                manualList.add(pse);
        }
        if(!existingEndorsements.IsEmpty()){
            existingEndorsements.clear();
        }
        for(RRWrapper rr : riskRatingList){
            rr.psa.VG_Coverage__c = rr.CoverageSelected;
            rr.psa.VG_Territorial_Limits__c = rr.TerritorialLimitsSelected;
        }
        
        ElList = [select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where VG_Product__c = : price.VG_Product__c AND Type__c = :'Endorsements' AND RecordType.Name  = : 'Bridge' ORDER By Name ASC];
        LibraryWrapperList.clear();
        for(Endorsement_Library__c EL : ElList){            
            LW  =  new LibraryWrapper();
            LW.EL  =  EL;            
            LW.isSelected  =  False;
            if(pseTempMap.containsKey(EL.id)) { 
                LW.isSelected  =  True;
            }                         
            LibraryWrapperList.add(LW); 
        }
        if(!IsProperty && riskRatingList.IsEmpty()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one asset to the policy schedule..'));    
            return null;  
        }else{
            if(!IsProperty){
                decimal totalShare  =  0;
                for(RRWrapper rr : riskRatingList){
                    try{
                        System.debug('share::'+rr.share+rr.CoverageSelected+riskRatingList);
                        totalShare  =  totalShare + rr.share;
                    }Catch(Exception ex){
                
                    }
                }
            }
            
            return new PageReference('/apex/VG_Revise_Nordics_Step4');
        }
    }
    
    public PageReference gotostep4b(){
        if(proSet){
            proSet = false;
            netBasePremium_Converted = netBasePremium_Converted /proratingFactor;
        }
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
                //System.debug('Type::'+tempEndsmt.VG_Type__c+'::'+LW.EL.Type__c);
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
        //System.debug('manualList ::'+manualList.size());
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
        return new PageReference('/apex/VG_Revise_Nordics_Step4b');
    }
    
    public PageReference gotostep6(){
        if(!existingEndorsements1.IsEmpty()){
            //existingEndorsements1.clear();
        }
        for(RRWrapper rr : riskRatingList){
            rr.psa.VG_Coverage__c = rr.CoverageSelected;
            rr.psa.VG_Territorial_Limits__c = rr.TerritorialLimitsSelected;
        }
        
        ElList1 = [select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where Type__c = :'Sub-limits' AND VG_Product__c = : price.VG_Product__c AND RecordType.Name  = : 'Bridge' ORDER By Name ASC];        
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
        if(! IsProperty && riskRatingList.IsEmpty()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one asset to the policy schedule..'));    
            return null;  
        }else{
            if(!IsProperty){
                decimal totalShare  =  0;
                for(RRWrapper rr : riskRatingList){
                    //System.debug('share::'+rr.share+riskRatingList);
                    try{
                        totalShare  =  totalShare + rr.share;
                    }Catch(Exception ex){
                    
                    }
                }
                
            }                      
        }
        return new PageReference('/apex/VG_Revise_Nordics_Step6');
    }
    public PageReference gotostep6b(){
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
                tempEndsmt.VG_Endorsement_Library_Id__c  = LW.EL.Id;
                if(pseTempMap.containsKey(LW.EL.Id))
                    tempEndsmt.VG_Endorsement_Details__c  =  pseTempMap.get(LW.EL.Id).VG_Endorsement_Details__c; 
                else
                    tempEndsmt.VG_Endorsement_Details__c  =  LW.EL.Text__c;                
                tempEndsmt.VG_Title__c  =  LW.EL.Endorsement_Title__c;                
                if(pseTempMap.containsKey(LW.EL.Id))
                    tempEndsmt.VG_Premium__c  =  pseTempMap.get(LW.EL.Id).VG_Premium__c;
                else
                    tempEndsmt.VG_Premium__c  = 0;
                if(pseTempMap.containsKey(LW.EL.Id))
                    tempEndsmt.VG_Sub_limit__c  =  pseTempMap.get(LW.EL.Id).VG_Sub_limit__c;
                else
                    tempEndsmt.VG_Sub_limit__c  = 0;
                tempEndsmt.VG_Endorsement_Number__c  =  LW.EL.Name;
                tempEndsmt.CurrencyISOCode  =  policyCurrency;
                tempEndsmt.VG_Type__c = LW.EL.Type__c;
                //System.debug('Type::'+tempEndsmt.VG_Type__c+'::'+LW.EL.Type__c);
                tempEndsmt.VG_IsTempDelete__c  =  False;
                tempEndsmt.VG_IsTemp__c  =  True;
                counterEnd++;
                existingEndorsements1.add(tempEndsmt);
            }
        }        
        
        if(existingEndorsements1.IsEmpty()){
            hasEndorsements  =  False;
            counterEnd  =  0;
        }else{
            hasEndorsements  =  True;
            counterEnd  =  existingEndorsements1.size();    
        }
        return new PageReference('/apex/VG_Revise_Nordics_Step6b');
    }
    
    
    
    public PageReference gotostep5(){
        endorsementPremium  =  0;
        for(VG_Policy_Schedule_Endorsement__c en : existingEndorsements){
            endorsementPremium  =  endorsementPremium + en.VG_Premium__c;
        }
        if(!proSet){
            proSet = true;
            netBasePremium_Converted  = (netBasePremium_Converted !=  null ? netBasePremium_Converted  : 0 )*proratingFactor;
        }
        endorsementPremium = endorsementPremium*proratingFactor;
        UpdateFinalCalculations();
        return new PageReference('/apex/VG_Revise_Nordics_Step5');
    }
    
    public PageReference cancel(){
        if(MTAType == 'Cancellation' || MTAType == 'Extension' || MTAType  ==  'Reduction'){
            return new PageReference('/'+policyid);
        }else{
            return new PageReference('/'+PSId);
        }
    }
    
    //Sub Classes Begins...
    public Class PricingWrapper{
        Public String factorName {get; set;}
        Public List<SelectOption> factors {get; set;}
        public String price {get; set;}
        public Integer order {get; set;}
        public String selectedFactor {get; set;}
        public String productName {get; set;}
        public Decimal premiumMovement {get; set;}
        public Decimal premiumMovement_Converted {get; set;}
        public Decimal priceDecimal {get; set;}
        
        Public PricingWrapper(){
            factorName  =  '';
            factors  =  new List<SelectOption>();
            price  =  '0';
            priceDecimal  =  0;
            order  =  0;
            selectedFactor  =  '';
            productName  =  '';
            premiumMovement  =  0;
            premiumMovement_Converted  =  0;
        }
    }
    
    public class OtherFactors{
        public String expName{get; set;}
        public String otherFactor {get; set;}
        public String factor {get; set;}
        public Decimal rate {get; set;}
        public Decimal premiumMovement {get; set;}
        public Decimal premiumMovement_Converted {get; set;}
    }    
    
    public class RRWrapper{
        public VG_Policy_Schedule_Asset__c psa{get;set;}
        public String Counter{get;set;}
        public Decimal share {get; set;}
        public String CoverageSelected{get;set;}
        public String TerritorialLimitsSelected{get;set;}
        public Decimal techPremium{get;set;}
    }
    
    public class AssetWrapper{
        public VG_Policy_Schedule_Asset__c asset {get; set;}
        public PricingWrapper waitingPeriodFactors {get; set;}
        public PricingWrapper biIndemnityPeriodFactors {get; set;}
        public PricingWrapper mbwaitingPeriodFactors {get; set;}
        public PricingWrapper mbbiIndemnityPeriodFactors {get; set;}
        public String name {get; set;}
        public String counter {get; set;}
        public Decimal totalPropertyDamageSI {get; set;}
        public Decimal totalBusinessInterruptionSI {get; set;}
        public Decimal totalSumInsuredSI {get; set;}
        public Decimal totalSumInsuredMBSI {get; set;}
        Public Decimal fullValue {get; set;}
        public Decimal PDDeductibleAmount {get; set;}
        public Decimal PDDeductible {get; set;}
        public Decimal WaitingPeriod {get; set;}
        public Decimal BIIndemnityPeriod {get; set;}  
        public Decimal MBPDDeductibleAmount {get; set;}
        public Decimal MBPDDeductible {get; set;}
        public Decimal MBWaitingPeriod {get; set;}
        public Decimal MBBIIndemnityPeriod {get; set;}  
        public Decimal AdjustedPDPremium {get; set;}
        public Decimal AdjustedMBPremium {get; set;}
        public Decimal AdjustedBIPremium {get; set;}
        public Decimal AutomaticFirealarm {get; set;}
        public Decimal WaterSprinklers {get; set;}
        public Decimal FoamSupressionSystem {get; set;}
        public Decimal SmokeAndHeatVentingSystem {get; set;}
        public Decimal FulltimePublicFireBrigadeStaff {get; set;}
        public Decimal TotalDiscountLoading {get; set;}
        public Decimal NetPDPremium {get; set;}
        public Decimal NetBIPremium {get; set;}
        public Decimal NetRiskPremium {get; set;}
    }
    
    Public Class LibraryWrapper{
        Public Endorsement_Library__c EL {get; set;}
        Public Boolean isSelected {get; set;} 
        
        Public LibraryWrapper(){
            EL  =  new Endorsement_Library__c();
            isSelected  =  False;
        }
    }
    
    Public Class PSWrapper{
        public Policy_Schedule__c ps {get; set;}
        public VG_Pricing__c price {get;set;}
        public List<VG_Policy_Schedule_Asset__c> psaList {get; set;}
        public List<VG_Policy_Schedule_Endorsement__c> pseList {get; set;}
        public List<VG_Exposure_Premium__c> EXPList {get; set;}
        public List<Risk_Capture__c> RCList {get; set;}
        public Boolean hasAssets {get; set;}    
        public Boolean hasExps {get; set;}
        public Boolean hasRCs {get; set;}
        public Boolean hasEndorsements {get; set;}
        
        public Long TurnoverValue{get;set;}
        public Long Turnover_Converted{get;set;}
        public Long limitAmount {get; set;}
        public Long attachment {get; set;}
        public Long limitAmount_Converted {get; set;}
        public Long attachment_Converted {get; set;}
        
        public Decimal fireNatCatPoolPremium {get;set;}
        public Decimal Losslimit {get;set;}
        public Decimal CreditScore {get;set;}
        public Decimal TOPRate {get;set;}
        public Decimal NBP{get;set;}
        public Decimal NBP_Converted{get;set;}
        public Decimal totalPremiumMovement {get; set;}
        public Decimal totalPremiumMovement_Converted {get; set;}
        public Decimal netExposurePremium {get; set;}
        public Decimal netExposurePremium_Converted {get; set;}
        public Decimal commissionPercent {get; set;}
        public Decimal netCommission {get; set;}
        public Decimal netPIPremium {get; set;}
        public Decimal netPIPremium_Converted {get; set;}
        public Decimal netCommission_Converted {get; set;}
        public Decimal grossBasePremium {get; set;}
        public Decimal grossBasePremium_Converted {get; set;}
        public Decimal exposurePremium {get; set;}
        public Decimal experiencePremium {get; set;}
        public Decimal experiencePremium_Converted {get; set;}
        public Decimal netModelPremium {get; set;}
        public Decimal deductible {get; set;}
        public Decimal seletedWeight {get; set;}
        public Decimal netBasePremium {get; set;}
        public Decimal netBasePremium_Converted {get; set;}
        public Decimal brokerage {get; set;}
        public Decimal brokerageAmount {get; set;}
        public Decimal sumInsured {get; set;}
        public Decimal ilfPremium {get; set;}
        public Decimal ILFRate {get; set;}
        public Decimal ROL {get; set;}
        public Decimal RPM {get; set;}
        public Decimal sharePercent {get; set;}
        public Decimal writtenShare {get; set;}
        public Decimal techPremium {get; set;}
        public Decimal techModelPremium {get; set;}
        public Decimal grossWrittenPremium {get; set;}       
        public Decimal grossWrittenPremium2 {get; set;}
        public Decimal techLayerPremium {get; set;}
        public Decimal RateChange {get;set;}
        public Decimal IPTAmount {get; set;}
        public Decimal DeductibleRate {get;set;}
        public Decimal DeductibleRate_Converted {get;set;}
        public Decimal adjustmentTechPremium {get; set;}
        public Decimal uwPremium {get; set;}
        public Decimal adjustment {get; set;}
        public Decimal actualPremium {get; set;}
        public Decimal orcPercent {get; set;}
        public Decimal orcAmount {get; set;}
        public Decimal endorsementPremium {get; set;}
        public Decimal transactionPremium {get; set;}
        public Decimal proratingFactor {get; set;}
        public Decimal adjustmentFactor {get; set;}
        public Decimal PDBaseRate {get; set;}
        public Decimal BIBaseRate {get; set;}
        public Decimal adjustedPDBaseRate {get; set;}
        public Decimal adjustedBIBaseRate {get; set;}
        public Decimal sekToUSDRate {get; set;}
        public Decimal levies {get; set;}
        public Decimal feeIncome {get; set;}
        public Decimal currentToUSDRate {get; set;}
        public Decimal currentToSEKRate {get; set;}
        public Decimal MBCRate {get; set;}
        public Decimal MBBICRate {get; set;}
        public Decimal ExtReportingPeriod_AP{get; set;}
        public Decimal AutoacqThreshold{get; set;}
        public Decimal netPremium {get;set;}
        
        public Integer ExtReportingPeriod{get;set;}
        public Integer RDYear{get;set;}
        public Integer RDAP{get;set;}
        public Integer counter{get;set;}
        public Integer counterEnd {get; set;}
        public Integer orderIndex {get; set;}
        public Integer RRcounter {get; set;} 
        public Integer numberOfPatients {get; set;}
        public Integer numberOfPatients_Converted {get; set;}
        
        public String pricingRate {get; set;}
        public String category {get; set;}
        public String Index{get;set;}
        public String selectedOccupancy {get; set;}
        public String policyCurrency {get; set;}
        public String layer {get; set;}
        public String ILFFactor {get; set;}
        public String MachineryBreakdownCover {get; set;}
        public String MachineryBreakdownBICover {get; set;}
        public String GrossOrNet {get; set;}
        public String LProduct {get;set;}
        public String MTAType {get; set;}
        public String seletedProrateoption {get; set;}       
        
        Public PSWrapper(){
            ps  =  new Policy_Schedule__c();
            price  =  new VG_Pricing__c();
            psaList  =  new List<VG_Policy_Schedule_Asset__c>();
            pseList  =  new List<VG_Policy_Schedule_Endorsement__c>();
            EXPList  =  new List<VG_Exposure_Premium__c>();
            RCList  =  new List<Risk_Capture__c>();
            hasAssets  =  False;
            hasExps  =  False;
            hasEndorsements  =  False;
            hasRCs = false;
        }
        
    } 
}