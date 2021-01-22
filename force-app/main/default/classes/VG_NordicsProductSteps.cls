Public without sharing Class VG_NordicsProductSteps{
    
    public Map<String,  PricingWrapper> pricingMap {get; set;}
    public Map<String,  PricingWrapper> FIPIpricingMap {get; set;}
    public Map<String,  Decimal> BIRates {get; set;}
    public Map<String,  Decimal> PDRates {get; set;}
    public Map<String,  Decimal> MBCMap {get; set;}
    public Map<String,  Decimal> MBBICMap {get; set;}
    public Map<Id,  Asset__c> allAccountAssets {get; set;}
    
    public List<Endorsement_Library__c> ElList{get;set;}
    public List<Endorsement_Library__c> ElList1{get;set;}    
    public List<PricingWrapper> otherFactors {get; set;}
    public List<PricingWrapper> FIPIFactors {get; set;}
    public List<VG_Pricing__c> priceList {get; set;}
    public List<OtherFactors> otherFactorsList {get; set;}
    public List<RRWrapper> riskRatingList {get; set;}
    public List<LibraryWrapper> LibraryWrapperList {get; set;}
    public List<LibraryWrapper> LibraryWrapperList1 {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements1 {get; set;}
    
    public List<SelectOption> occupanciesList {get; set;}
    Public List<SelectOption> splitTypes{get; set;}
    public List<SelectOption> MBCList {get; set;}
    public List<SelectOption> MBBICList {get; set;}
    public list<SelectOption> LP_Select {get; set;}
    public list<SelectOption> RRCoverage_Select {get; set;}
    public list<SelectOption> TerritorialLimits_Select {get; set;}
    public list<SelectOption> Product_Select {get; set;}
    public list<SelectOption> EEAVolanteEntity_Select {get; set;}
    public List<AssetWrapper> assetList {get; set;}
    
    public PricingWrapper typeOfOperation {get; set;}
    public PricingWrapper deductibleFactor {get; set;}
    public LibraryWrapper LW{get;set;}
    public LibraryWrapper LW1{get;set;}   
    public AssetWrapper currentAsset {get; set;} 
    public Policy__c policy{get;set;}   
    
    public VG_Pricing__c price {get;set;}
    public Policy_Schedule__c ps {get; set;} 
    public Id policyId {get; set;}
    public Id accountId {get; set;}
    
    public Boolean hasEndorsements {get; set;}
    public Boolean IsPricingGenerated {get; set;}
    public Boolean IsProperty {get; set;}
    public Boolean showAssetDetails {get; set;}
    public Boolean addAssetMode {get; set;}
    public Boolean showError {get; set;}
    Public Boolean skipSplit {get; set;}

    
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
    public String LProduct{get;set;}
    
    //Constructor Begins}
    public VG_NordicsProductSteps(){
        showError = false;
        ps  =  new Policy_Schedule__c();   
        IsProperty  =  False;
        addAssetMode  =  False;
        showAssetDetails  =  False;
        policyId  =  apexpages.currentpage().getparameters().get('Id');
        policyCurrency  =  apexpages.currentpage().getparameters().get('Currency');
        ps.CurrencyISOCode  =  policyCurrency;
        IsPricingGenerated  =  False;
        price = new VG_Pricing__c();
        String policyLOB  =  [Select Id,  Line_Of_Business__c from Policy__c where Id  = : policyId].Line_Of_Business__c;
        policy = [select id, Name,VG_Is_Renewal__c, VG_Expiry_Date__c, VG_Inception_Date__c, Line_Of_Business__c from Policy__c where id = : policyId];
        if(policyLOB  ==  'Commercial Combined'){
            price.VG_Product__c  =  'Commercial Combined';
            gotoStep2();
        }
        sekToUSDRate  =  currentToUSDRate  =  1;
        List<CurrencyType> exchangeRates  =  [Select Id,  ConversionRate,  IsoCode from CurrencyType where IsoCode  =  'SEK' or IsoCode  = : policyCurrency];
        for(CurrencyType rt : exchangeRates){
            if(rt.IsoCode  ==  'SEK' ){
                System.debug('SEK if::'+rt.ConversionRate);
                sekToUSDRate  =  rt.ConversionRate;
            }
            if(rt.IsoCode  ==  policyCurrency){
                System.debug('PolicyCurrency if::'+rt.ConversionRate);
                currentToUSDRate  =  rt.ConversionRate;
            }
        }
        Product_Select  =  new List<SelectOption>();
        LP_Select  =  new List<SelectOption>();
        RRCoverage_Select  =  new List<SelectOption>();
        currentToSEKRate  =  (currentToUSDRate/sekToUSDRate).setScale(3);
        System.debug('currentToUSDRate: '+currentToUSDRate+',  sekToUSDRate: '+sekToUSDRate+',  currentToSEKRate: '+currentToSEKRate  );
        accountId  =  apexpages.currentpage().getparameters().get('AccountId');
        brokerage  =  10;//apexpages.currentpage().getparameters().get('Id');
        pricingMap =  new Map<String,  PricingWrapper>();
        otherFactors  =  new List<PricingWrapper>();
        FIPIFactors  =  new List<PricingWrapper>();
        existingEndorsements  =  new List<VG_Policy_Schedule_Endorsement__c>();
        existingEndorsements1  =  new List<VG_Policy_Schedule_Endorsement__c>();
        counter = counterEnd = numberOfPatients = numberOfPatients_Converted = 0;
        TurnoverValue = 0;
        fireNatCatPoolPremium = Losslimit = CreditScore = TOPRate = NBP = totalPremiumMovement = netExposurePremium = commissionPercent = netCommission = grossBasePremium = exposurePremium = experiencePremium = netModelPremium = deductible = seletedWeight = netBasePremium = brokerage = 0;
        ilfPremium = ROL = RPM = sharePercent = techPremium = adjustmentTechPremium = uwPremium = adjustment = actualPremium = orcPercent = orcAmount = 0;
        DeductibleRate_Converted = limitAmount = attachment = 0;
        Index = '0';
        //IsPricingGenerated  =  False;
        //price = new VG_Pricing__c();
        otherFactorsList  =  new List<OtherFactors>();
        BIRates  =  new Map<String,  Decimal>();
        PDRates  =  new Map<String,  Decimal>();
        for(Integer i = 0; i<3; i++){
            otherFactorsList.add(new OtherFactors());
        }
        
        VG_Policy_Schedule_Asset__c psa  =  new VG_Policy_Schedule_Asset__c();
        psa.CurrencyISOCode  =  policyCurrency;
        riskRatingList  =  new List<RRWrapper>();
        RRWrapper RRW  =  new RRWrapper();
        RRW.psa  =  psa;
        RRW.counter  =  '0';
        RRW.share = 0;
        riskRatingList.add(RRW);
        RRcounter  =  1;
        LibraryWrapper LW;
        LibraryWrapper LW1;
        Id BridgeLibraryId  =   Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
        LibraryWrapperList  =  new List<LibraryWrapper>();
        LibraryWrapperList1  =  new List<LibraryWrapper>();
        List<String> TerritorialLimitsSplit = Label.Bridge_NonCC_TerritorialLimits.split(';');
        TerritorialLimits_Select = new List<SelectOption>();
        TerritorialLimits_Select.add(new SelectOption('--None--', '--None--'));
        for(String s : TerritorialLimitsSplit){
            TerritorialLimits_Select.add(new SelectOption(s,s));
        }   
        Product_Select.add(new SelectOption('--None--', '--None--'));
        if(policy.Line_Of_Business__c== 'Financial Lines'){
           Product_Select.add(new SelectOption('D&O', 'Directors & Officers Liability'));
           Product_Select.add(new SelectOption('PI', 'Professional Indemnity'));
           Product_Select.add(new SelectOption('FIPI', 'Financial Institutions Professional Indemnity'));
           Product_Select.add(new SelectOption('Crime', 'Crime'));
        }else if(policy.Line_Of_Business__c== 'Liability'){   
           Product_Select.add(new SelectOption('GLPL', 'General and Products Liability'));
           Product_Select.add(new SelectOption('Life Sciences', 'Life Sciences'));
           Product_Select.add(new SelectOption('Clinical Trials', 'Clinical Trials'));
        }else if(policy.Line_Of_Business__c== 'Property'){
           Product_Select.add(new SelectOption('Property', 'Property'));
        }else if(policy.Line_Of_Business__c== 'Commercial Combined'){   
           Product_Select.add(new SelectOption('Commercial Combined', 'Commercial Combined'));
        }  
        splitTypes = new List<SelectOption>();            
        skipSplit = False;
        if(policy.VG_Inception_Date__c.year() <= 2020){
            splitTypes.add(new SelectOption('','--None--'));
            skipSplit = True;
        }
        splitTypes.add(new SelectOption('EEA','EEA'));
         
        EEAVolanteEntity_Select = new List<SelectOption>();
        for(String s : Label.Nordics_EEAVolanteEntity.split(';')){
            EEAVolanteEntity_Select.add(new SelectOption(s,s));
        }
    }
    //Constructor End...
    
    //Helper methods to add remove records begin
    public void addRR(){
        Boolean allOkToTaddNewAsset  =  True;
        RRWrapper waNew = new RRWrapper();
        waNew.Counter = string.valueOf(RRcounter);
        for(RRWrapper temp : riskRatingList){
            /*System.debug('Rate::'+temp.psa.VG_Rate_Per_Vehicle__c +':No.of:'+temp.psa.VG_Number_of_Vehicles__c+':coverage:'+temp.psa.VG_Coverage__c+':type:'+temp.psa.VG_Vehicle_Type__c);
            if(temp.psa.VG_Technical_UW_Rate_Annual__c  !=  null && temp.psa.VG_Rate_Per_Vehicle__c  !=  null && temp.psa.VG_Number_of_Vehicles__c  !=  null && temp.psa.VG_Coverage__c  !=  null && temp.psa.VG_Vehicle_Type__c  !=   null && temp.psa.VG_Use__c  !=  null){
               System.debug('if::');
               temp.psa.VG_Premium__c = (temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Rate_Per_Vehicle__c).setScale(2);
               temp.techPremium = (temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
               totalpre = totalpre+temp.psa.VG_Premium__c;

              }else{
              System.debug('else::');
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
        System.debug('riskRatingList::'+riskRatingList.size()+'::'+riskRatingList);
    }
    
    public void RemoveRR(){
        riskRatingList.remove(integer.valueOf(Index));
        RRcounter = 0;
        System.debug('riskRatingList::'+riskRatingList.size()+'::'+riskRatingList);
        for(RRWrapper temp : riskRatingList){
            temp.Counter = String.valueOf(counter);
            RRcounter++;
        }
        if(riskRatingList.IsEmpty()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one asset to the policy schedule..'));   
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
        System.debug('assetList::'+assetList);
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
    
    Public void setLPList(){
        LP_Select.clear();
        RRCoverage_Select.clear();
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
    
    public void AddCustom(){
        hasEndorsements  =  True;    
        VG_Policy_Schedule_Endorsement__c tempEndsmt  =  new VG_Policy_Schedule_Endorsement__c();
        tempEndsmt.CurrencyISOCode  =  policyCurrency;
        //tempEndsmt.VG_Policy_Schedule__c  =  PSId;
        tempEndsmt.VG_Premium__c  =  0;
        tempEndsmt.VG_Sub_limit__c = 0;
        tempEndsmt.VG_Type__c = 'Endorsements';
        //counterEnd++;
        //tempEndsmt.Name  =  PSName + '/PE/'+counterEnd;
        existingEndorsements.add(tempEndsmt);
    }
    
    //Helper methods to add remove records ends
    
    
    //Redirection Method Begings...
    public PageReference gotostep1A(){
        return new PageReference('/apex/VG_Nordics_Step1');
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
            System.debug('Product selected:'+price.VG_Product__c); 
            layer  =  'Primary';
        }
        System.debug('IsPricingGenerated::'+(!IsPricingGenerated));
        if(!IsPricingGenerated){
            System.debug('Product::'+price.VG_Product__c);
            if(price.VG_Product__c  ==  'GLPL' || price.VG_Product__c  ==  'IPO' || price.VG_Product__c  ==  'Life Sciences' || price.VG_Product__c  ==  'Clinical Trials' || price.VG_Product__c  ==  'PI' || price.VG_Product__c  ==  'D&O' || price.VG_Product__c  ==  'Crime' ||  price.VG_Product__c  ==  'FIPI'){
                if(price.VG_Product__c  ==  'FIPI' ){
                    priceList = new List<VG_Pricing__c>([select id, Name, VG_Product__c, VG_Category__c, VG_Rating_Factor__c, VG_Rate__c from VG_Pricing__c where ((VG_Product__c  =  'PI' AND VG_Category__c  !=   'Type of operation') OR (VG_Product__c  =  'FIPI')) and VG_Level__c  =  'Risk Detail' and VG_Rating_Factor__c  !=   null ORDER BY VG_Order__c]);// ]);
                }else{
                    priceList = new List<VG_Pricing__c>([select id, Name, VG_Product__c, VG_Category__c, VG_Rating_Factor__c, VG_Rate__c from VG_Pricing__c where VG_Product__c = : price.VG_Product__c and VG_Level__c  =  'Risk Detail' and VG_Rating_Factor__c  !=   null ORDER BY VG_Order__c]);// ]);
                }
                pricingMap  =  new Map<String,  PricingWrapper>();
                FIPIpricingMap  =  new Map<String,  PricingWrapper>();
                System.debug('25.4::'+priceList);
                for(VG_Pricing__c price: priceList){
                    if(price.VG_Product__c  !=   'FIPI' || price.VG_Category__c  ==  'Type of operation'){
                        if(pricingMap.get(price.VG_Category__c)  ==  null){
                            pWrapper  =  new PricingWrapper();
                            if(price.VG_Category__c  ==  'Type of operation'){
                                
                            }else{
                                counter++;
                            }
                            pWrapper.order  =  counter;
                            pWrapper.factors.add(new SelectOption('0', '--Select--'));
                            System.debug('price:::'+price);
                        }else{
                            pWrapper  =  pricingMap.get(price.VG_Category__c);
                            System.debug('price:::'+price);
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
                        System.debug('price:::'+price);
                    }
                    tempFactorsList.add(new SelectOption(String.valueOf(price.VG_Rate__c)+'>'+price.VG_Rating_Factor__c,  price.VG_Rating_Factor__c));
                    pWrapper.factorName  =  price.VG_Category__c;
                    pWrapper.factors  =  tempFactorsList;
                    pWrapper.productName  =  price.VG_Product__c;
                    if(price.VG_Product__c  !=   'FIPI' || price.VG_Category__c  ==  'Type of operation' ){
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
                        otherFactors.add(pricingMap.get(s)); 
                    }
                }
                for(String s : FIPIpricingMap.keySet()){
                    System.debug('FIPIFactors:'+FIPIFactors+'; FIPIpricingMap.get(s):'+FIPIpricingMap.get(s));
                    if( s  !=   'Deductible Adjustment')                    
                        FIPIFactors.add(FIPIpricingMap.get(s));
                }
                FIPIpricingMap  =  null;
                pricingMap  =  null;
                IsPricingGenerated  =  True;
                IsProperty  =  False;
            }else if(price.VG_Product__c  ==  'Property'){
                occupanciesList  =  new List<SelectOption>();
                MBCList  =  new List<SelectOption>();
                MBBICList  =  new List<SelectOption>();
                MBCMap  =  new Map<String,  Decimal>();
                MBBICMap  =  new Map<String,  Decimal>();
                occupanciesList.add(new SelectOption('0', '--Select--'));
                pricingMap  =  new Map<String,  PricingWrapper>();
                priceList = new List<VG_Pricing__c>([select id, Name, VG_Product__c, VG_Category__c, VG_Rating_Factor__c, VG_Rate__c,  Sum_Insured_Limit__c from VG_Pricing__c where VG_Product__c  =  'Property' and VG_Level__c  =  'Risk Detail' and VG_Rate__c  !=   null and VG_Rating_Factor__c  !=   null ORDER BY VG_Order__c]);
                Set<String> occupanciesSet  =  new Set<String>();
                System.debug('3.10::'+priceList.size()+'::'+priceList);
                for(VG_Pricing__c price : priceList){
                    System.debug('price:::'+price);
                    if(price.VG_Category__c  ==  'PD Base Rate' || price.VG_Category__c  ==  'BI Base Rate'){
                        if(price.VG_Category__c  ==  'BI Base Rate'){
                            BIRates.put(price.VG_Rating_Factor__c,  price.VG_Rate__c);
                        }else{
                            PDRates.put(price.VG_Rating_Factor__c,  price.VG_Rate__c);
                        }
                        occupanciesList.add(new SelectOption(price.VG_Rating_Factor__c,  price.VG_Rating_Factor__c));
                        System.debug('price:::'+price);
                    }else if(price.VG_Category__c  ==  'Machinery Breakdown Cover'){
                        if(MBCList.IsEmpty()){
                            MBCList.add(new SelectOption('--None--',  '--None--'));
                        }
                        MBCMap.put(price.VG_Rating_Factor__c,  price.VG_Rate__c);
                        MBCList.add(new SelectOption(price.VG_Rating_Factor__c,  price.VG_Rating_Factor__c));
                        System.debug('price:::'+price);
                    }else if(price.VG_Category__c  ==  'Machinery Breakdown BI Cover'){ 
                        if(MBBICList.IsEmpty()){
                            MBBICList.add(new SelectOption('--None--',  '--None--'));
                        }  
                        MBBICMap.put(price.VG_Rating_Factor__c,  price.VG_Rate__c);  
                        MBBICList.add(new SelectOption(price.VG_Rating_Factor__c,  price.VG_Rating_Factor__c));
                        System.debug('price:::'+price);
                    }else{
                        if(pricingMap.get(price.VG_Category__c)  ==  null){
                            pWrapper  =  new PricingWrapper();
                            counter++;
                            pWrapper.order  =  counter;
                            pWrapper.priceDecimal = 0.00;
                            //pWrapper.factors.add(new SelectOption('0', '--Select--'));
                            System.debug('price:::'+price+'::'+pWrapper);
                        }else{
                            pWrapper  =  pricingMap.get(price.VG_Category__c);
                            System.debug('price:::'+price+'::'+pWrapper);
                        }
                        if(pWrapper.factors.IsEmpty()){
                            tempFactorsList  =  new List<SelectOption>();
                        }else{
                            tempFactorsList  =  pWrapper.factors;
                        }
                        tempFactorsList.add(new SelectOption(String.valueOf(price.VG_Rate__c)+'>'+price.VG_Rating_Factor__c,  price.VG_Rating_Factor__c));
                        System.debug('2.10::'+tempFactorsList+'::'+price.VG_Rate__c+'::'+price.VG_Rating_Factor__c);
                        pWrapper.factorName  =  price.VG_Category__c;
                        tempFactorsList.sort();
                        pWrapper.factors  =  tempFactorsList;
                        pWrapper.priceDecimal = price.VG_Rate__c;
                        pricingMap.put(pWrapper.factorName,  pWrapper);
                        System.debug('2.10::'+pricingMap.size()+'::'+pricingMap);
                    }
                }    
                otherFactors  =  pricingMap.values(); 
                for(PricingWrapper pwr : pricingMap.values()){
                    System.debug(pwr.factorName);
                    if(pwr.factorName  ==  'Inflammable or Explosive'){
                        pwr.price  =  '0.00>Yes';
                        pwr.priceDecimal  =  0.00;
                    }
                    if(pwr.factorName  ==  'Pressure over 200 bar and/or temperature over 500 ºC' || pwr.factorName  ==  'Substances susceptible to self-ignition' || pwr.factorName  ==  'Manufacture or use of peroxides' || pwr.factorName  ==  'Explosive substances' ){
                        pwr.price  =  '0.00>No';
                        pwr.priceDecimal  =  0.00;
                    }
                }
                pricingMap  =  new Map<String,  PricingWrapper>();
                priceList = new List<VG_Pricing__c>([select id, Name, VG_Product__c, VG_Category__c, VG_Rating_Factor__c, VG_Rate__c from VG_Pricing__c where VG_Product__c  =  'Property' and VG_Level__c  =  'Risk Rating' and VG_Rate__c  !=   null and VG_Rating_Factor__c  !=   null ORDER BY VG_Order__c ]);
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
                    System.debug(tempFactorsList+',  '+price.VG_Rate__c+',  '+price.VG_Rating_Factor__c);
                    tempFactorsList.add(new SelectOption(String.valueOf(price.VG_Rate__c),  price.VG_Rating_Factor__c));
                    pWrapper.factorName  =  price.VG_Category__c;
                    pWrapper.factors  =  tempFactorsList;
                    pricingMap.put(pWrapper.factorName,  pWrapper);
                }
                IsPricingGenerated  =  True;
                IsProperty  =  True;
                assetList  =  new List<AssetWrapper>();
                RRcounter  =  0;
                allAccountAssets  =  new Map<Id,  Asset__c>([Select Id,  Name, VG_PD_Deductible__c, VG_Waiting_Period__c,   VG_BI_Indemnity_Period__c, VG_MB_PD_Deductible__c, VG_MB_Waiting_Period__c, VG_MB_BI_Indemnity_Period__c,  VG_Total_Property_Damage_SI__c,  VG_Full_Value_Building__c, VG_True_TSI__c,  VG_Total_Business_Interruption_SI__c,  VG_Automatic_Fire_alarm__c,  VG_Water_sprinklers__c,  VG_Smoke_and_heat_venting_system__c,  VG_Foam_supression_system__c,  VG_Machinery_SI__c,  VG_Full_time_public_Fire_Brigade_staff__c from Asset__c where VG_Account__c  = : accountId]);
            }else{
                IsPricingGenerated  =  False;
                IsProperty  =  False;
            }
        }
        UpdateNBP();
        if(price.VG_Product__c == 'Commercial Combined'){
            return new PageReference('/apex/VG_CC_Nordics_Step2?policyId='+policyId);
        }else{
            return new PageReference('/apex/VG_Nordics_Step2');
        }
    }
    
    public PageReference gotostep3(){
        /*If((pricingRate == '' || pricingRate == null || pricingRate == '0') || Turnover_Converted == null ){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please Select Type Of Operation and give value for Turnover...')); 
            return null;       
          }*/
        UpdateNBP();
        return new PageReference('/apex/VG_Nordics_Step3');
    }
    
    public PageReference gotostep4(){
        if(!existingEndorsements.IsEmpty()){
            existingEndorsements.clear();
        }
        for(RRWrapper rr : riskRatingList){
            rr.psa.VG_Coverage__c = rr.CoverageSelected;
            rr.psa.VG_Territorial_Limits__c = rr.TerritorialLimitsSelected;
        }
        ElList = [select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where Type__c = :'Endorsements' AND VG_Product__c = : price.VG_Product__c AND  RecordType.Name  = : 'Bridge' ORDER By Name ASC];
        
        LibraryWrapperList.clear();
        for(Endorsement_Library__c EL : ElList){            
            LW  =  new LibraryWrapper();
            LW.EL  =  EL;            
            LW.isSelected  =  False;                    
            LibraryWrapperList.add(LW); 
        }
        
        if(riskRatingList.IsEmpty()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one asset to the policy schedule..'));    
            return null;  
        }else{
            if(!IsProperty){
                decimal totalShare  =  0;
                for(RRWrapper rr : riskRatingList){
                    System.debug('share::'+rr.share+riskRatingList);
                    totalShare  =  totalShare + rr.share;
                }
                /*if(totalShare  !=   100){
                   ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please ensure share disctribution is equal 100%..'));    
                   return null;  
                }*/ // comment out for JIRA VG - 49
            }
            
            return new PageReference('/apex/VG_Nordics_Step4');
        }
    }
    public PageReference gotostep6(){
        if(!existingEndorsements1.IsEmpty()){
            existingEndorsements1.clear();
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
            LibraryWrapperList1.add(LW1); 
        }
        if(riskRatingList.IsEmpty()){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one asset to the policy schedule..'));    
            return null;  
        }else{
            if(!IsProperty){
                decimal totalShare  =  0;
                for(RRWrapper rr : riskRatingList){
                    System.debug('share::'+rr.share+riskRatingList);
                    totalShare  =  totalShare + rr.share;
                }
                /*if(totalShare  !=   100){
                   ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please ensure share disctribution is equal 100%..'));    
                   return null;  
                 }*/ // comment out for JIRA VG - 49
            }
            
            return new PageReference('/apex/VG_Nordics_Step6');
        }
    }
    
    public PageReference gotostep4b(){
        Set<ID> elid = new Set<ID>();
        Map<Id, VG_Policy_Schedule_Endorsement__c> tmpPSEMap = new Map<Id, VG_Policy_Schedule_Endorsement__c>();
        for(VG_Policy_Schedule_Endorsement__c pe:existingEndorsements){
            tmpPSEMap.put(pe.VG_Endorsement_Library_Id__c, pe);
        }
        existingEndorsements.clear();
        VG_Policy_Schedule_Endorsement__c tempEndsmt;
        for(LibraryWrapper LW:LibraryWrapperList){
            elid.add(LW.EL.Id);
            if(LW.isSelected){
                tempEndsmt  =  new VG_Policy_Schedule_Endorsement__c();
                tempEndsmt.VG_Endorsement_Details__c  =  LW.EL.Text__c;
                tempEndsmt.VG_Endorsement_Library_Id__c  =  LW.EL.Id;
                tempEndsmt.VG_Title__c  =  LW.EL.Endorsement_Title__c;
                tempEndsmt.VG_Premium__c  =  0;
                tempEndsmt.VG_Sub_limit__c  =  0;
                tempEndsmt.CurrencyISOCode  =  policyCurrency;
                //tempEndsmt.Name  =  PSName + '/PE/' + counterEnd;
                tempEndsmt.VG_Endorsement_Number__c  =  LW.EL.Name;
                tempEndsmt.VG_Type__c = LW.EL.Type__c;
                System.debug('Type::'+tempEndsmt.VG_Type__c+'::'+LW.EL.Type__c);
                tempEndsmt.VG_IsTempDelete__c  =  False;
                tempEndsmt.VG_IsTemp__c  =  True;
                counterEnd++;
                existingEndorsements.add(tempEndsmt);
            }
        }
        /*for(VG_Policy_Schedule_Endorsement__c pse:tmpPSEMap.values()){
if(pse.VG_Endorsement_Library_Id__c  ==  null){
existingEndorsements.add(pse);
}
}*/
        for(VG_Policy_Schedule_Endorsement__c pse:existingEndorsements){
            if(tmpPSEMap.containsKey(pse.VG_Endorsement_Library_Id__c)){
                if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c  !=   0){
                    pse.VG_Premium__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c;
                }
                if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c  !=   0){
                    pse.VG_Sub_limit__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c;
                }
            }
        }
        if(existingEndorsements.IsEmpty()){
            hasEndorsements  =  False;
            counterEnd  =  0;
        }else{
            hasEndorsements  =  True;
            counterEnd  =  existingEndorsements.size();    
        }
        return new PageReference('/apex/VG_Nordics_Step4b');
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
                tempEndsmt.VG_Endorsement_Details__c  =  LW.EL.Text__c;
                tempEndsmt.VG_Endorsement_Library_Id__c  =  LW.EL.Id;
                tempEndsmt.VG_Title__c  =  LW.EL.Endorsement_Title__c;
                tempEndsmt.VG_Premium__c  =  0;
                tempEndsmt.VG_Sub_limit__c  =  0;
                tempEndsmt.CurrencyISOCode  =  policyCurrency;
                //tempEndsmt.Name  =  PSName + '/PE/' + counterEnd;
                tempEndsmt.VG_Endorsement_Number__c  =  LW.EL.Name;
                tempEndsmt.VG_Type__c = LW.EL.Type__c;
                System.debug('Type::'+tempEndsmt.VG_Type__c+'::'+LW.EL.Type__c);
                tempEndsmt.VG_IsTempDelete__c  =  False;
                tempEndsmt.VG_IsTemp__c  =  True;
                counterEnd++;
                existingEndorsements1.add(tempEndsmt);
            }
        }
        /*for(VG_Policy_Schedule_Endorsement__c pse:tmpPSEMap.values()){
          if(pse.VG_Endorsement_Library_Id__c  ==  null){
          existingEndorsements.add(pse);
          }
         }*/
        for(VG_Policy_Schedule_Endorsement__c pse:existingEndorsements1){
            if(tmpPSEMap.containsKey(pse.VG_Endorsement_Library_Id__c)){
                if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c  !=   0){
                    pse.VG_Premium__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c;
                }
                if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c  !=   0){
                    pse.VG_Sub_limit__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c;
                }
            }
        }
        if(existingEndorsements1.IsEmpty()){
            hasEndorsements  =  False;
            counterEnd  =  0;
        }else{
            hasEndorsements  =  True;
            counterEnd  =  existingEndorsements1.size();    
        }
        return new PageReference('/apex/VG_Nordics_Step6b');
    }
    
    public PageReference gotostep5(){
        
        if(Math.mod(policy.VG_Inception_Date__c.year(), 4) !=  0){
            if(Math.mod(policy.VG_Expiry_Date__c.year(), 4)  ==  0){
                if(policy.VG_Expiry_Date__c <=  date.newInstance(policy.VG_Expiry_Date__c.year(), 02, 28)){
                    proratingFactor  = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1)/365;
                }else{
                    proratingFactor  = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c))/365;
                }
            }else{
                proratingFactor  = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1)/365;
            }
        }else{
            if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                proratingFactor  = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c))/365;
            }else{
                proratingFactor  = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1)/365;
            }
        } 
           
        endorsementPremium  =  0;
        for(VG_Policy_Schedule_Endorsement__c en : existingEndorsements){
            endorsementPremium  =  endorsementPremium + en.VG_Premium__c;
        }
        endorsementPremium = endorsementPremium *proratingFactor ;
        if(!IsProperty)
            netBasePremium_Converted  =  netBasePremium *proratingFactor ;
        UpdateFinalCalculations();
        return new PageReference('/apex/VG_Nordics_Step5');
    }
    
    public PageReference cancel(){
        return new PageReference('/'+policyId);
    }
    
    public PageReference finish(){
        Decimal totalTSI = 0;
        if(IsProperty){
            sumInsured  =  0;
            for(AssetWrapper AW : assetList){
                sumInsured  = + AW.totalSumInsuredSI ;
            }
            for(AssetWrapper aw : assetList){
                totalTSI = totalTSI + allAccountAssets.get(aw.asset.Asset__c).VG_True_TSI__c;
            }
        }
        Policy__c pol = [select id,Name, VG_Is_Renewal__c,VG_Inception_Date__c, VG_Expiry_Date__c from Policy__c where Id = :policyId limit 1];
        List<VG_Policy_Schedule_Asset__c> assetsToBeInserted  =  new List<VG_Policy_Schedule_Asset__c>();
        List<VG_Policy_Schedule_Endorsement__c> endToBeInserted  =  new List<VG_Policy_Schedule_Endorsement__c>();
        List<VG_Exposure_Premium__c> exposuresToBeInserted  =  new List<VG_Exposure_Premium__c>();
        ps.Policy__c  =  policyId;       
        List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([SELECT Id, Name, Policy__c FROM Policy_Schedule__c WHERE Policy__c = :policyId ORDER BY CreatedDate DESC]);                               
        ps.VG_Lloyds_Product__c = LProduct;
        ps.Risk_Premium_Pro__c  =  netBasePremium_Converted;
        ps.Endorsement_Premium_Pro__c  =  endorsementPremium;
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
        If(RateChange == 0.00 && policy.VG_Is_Renewal__c   == false)       
            ps.VG_Rate_Change__c   =   null;
        else
            ps.VG_Rate_Change__c   =  RateChange;
        ps.Written_share__c  =  writtenShare ;
        ps.Product__c = price.VG_Product__c;
        ps.VG_Deductible__c = DeductibleRate_Converted;
        ps.Technical_Layer_Premium__c  =  techLayerPremium ;
        ps.Gross_Written_Premium__c  =  grossWrittenPremium ;
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
        ps.VG_Is_MTA__c  =  False;
        ps.VG_Base_Policy__c = true;
        ps.VG_Brokerage_Percent__c  =  brokerage;
        //below 3 lines added by Anu 30.8.2018
        ps.Actual_GWP__c = actualPremium;
        ps.VG_Brokerage_Amount__c = brokerageAmount;
        ps.IPT__c = IPTAmount;
        //ps.IPT_Percent__c  =  IPTPercent;
        ps.Levies__c  =  levies;
        ps.VG_Fee_Income__c  =  feeIncome;
        ps.VG_Base_Policy__c  =  True;
        ps.RecordTypeId = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
        List<Integer> psNumList = new List<Integer>();
        if(psList.size()>0){
            for(Policy_Schedule__c psh: psList){
                psh.Name = psh.Name.remove('/EEA');
                if(psh.Name.contains('/PS/'))
                    psNumList.add(Integer.valueOf(psh.Name.split('/PS/')[1]));
                else if(psh.Name.contains('/MTA/'))
                    psNumList.add(Integer.valueOf(psh.Name.split('/MTA/')[1]));
            }
            psNumList.sort();
            if(ps.Split_Type__c == 'EEA')
                ps.Name=pol.Name+'/PS/'+((psNumList[psNumList.size()-1])+1)+'/EEA';  
            else
                ps.Name=pol.Name+'/PS/'+((psNumList[psNumList.size()-1])+1); 
        }else{
            if(ps.Split_Type__c == 'EEA')
                ps.Name=pol.Name+'/PS/0/EEA';   
            else
                ps.Name=pol.Name+'/PS/0'; 
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
            ps.Base_Creation_Start_Date__c  =  pol.VG_Inception_Date__c;
            ps.Base_Creation_End_Date__c  =  pol.VG_Expiry_Date__c;
        }else{
            ps.VG_Turn_Over__c  =  ps.Product__c  !=   'Clinical Trials' ? Turnover_Converted : Decimal.valueOf(numberOfPatients_Converted );
            ps.VG_Type_Of_Operation__c  =  pricingRate;
            ps.VG_CREDIT_Augur_SCORE__c  =  creditScore;
            ps.VG_Deductible__c  =  DeductibleRate_Converted;
            ps.VG_Exposure_Premium__c  =  netExposurePremium_Converted;
            ps.VG_Experience_Premium__c  =  experiencePremium_Converted;
            ps.VG_Selected_Weight__c  =  seletedWeight;
            ps.VG_Net_Base_Premium__c  =  netBasePremium_Converted;
        }
        ps.Base_Creation_Start_Date__c  =  pol.VG_Inception_Date__c;
        ps.Base_Creation_End_Date__c  =  pol.VG_Expiry_Date__c;
        System.debug('Psid::'+ps.id);
        Insert ps;
        if(price.VG_Product__c  == 'FIPI'){
            Risk_Capture__c rc = new Risk_Capture__c();
            rc.Name = ps.Name+'/RD/1';
            rc.Policy_Schedule__c = ps.id;
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
            Insert rc;
        }
        Integer psecount = 1;
        Integer sbpsecount = 1;
        for(VG_Policy_Schedule_Endorsement__c endsmt : existingEndorsements){
            endsmt.VG_Policy_Schedule__c  =  ps.Id;
            endsmt.Name =  ps.Name + '/PE/' + psecount;
            endToBeInserted.add(endsmt);
            psecount++;
        }
        for(VG_Policy_Schedule_Endorsement__c endsmt : existingEndorsements1){
            endsmt.VG_Policy_Schedule__c  =  ps.Id;
            endsmt.Name =  ps.Name + '/PESb/' + sbpsecount;
            endToBeInserted.add(endsmt);
            sbpsecount++;
        }   
        if(IsProperty){
            Integer psacount = 1;
            for(AssetWrapper AW : assetList){
                AW.asset.VG_Policy_Schedule__c  =  ps.Id;
                AW.asset.CurrencyISOCode = policyCurrency;
                AW.asset.Name = ps.Name+'/RR/'+psacount;
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
                AW.asset.VG_Premium__c  =  AW.NetRiskPremium;
                AW.asset.VG_Sum_Insured__c   = totalTSI ;
                assetsToBeInserted.add(AW.asset);
                psacount++;
            }
        }else{
            Integer psacount = 1;
            for(RRWrapper RW : riskRatingList){
                RW.psa.VG_Policy_Schedule__c  =  ps.Id;
                RW.psa.CurrencyISOCode = policyCurrency;
                RW.psa.Name =  ps.Name + '/RR/' + psacount;
                RW.psa.VG_Territorial_Limits__c = RW.TerritorialLimitsSelected;
                RW.psa.VG_Coverage__c = RW.CoverageSelected;
                RW.psa.VG_Share__c  =  RW.share;
                RW.psa.RecordTypeId = Schema.SObjectType.VG_Policy_Schedule_Asset__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();                          
                assetsToBeInserted.add(RW.psa);
                psacount++;
            }
        }
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
        
        if(!endToBeInserted.IsEmpty()){
            Insert endToBeInserted;
        }
        if(!assetsToBeInserted.IsEmpty()){
            Insert assetsToBeInserted;
        }
        if(!exposuresToBeInserted.IsEmpty()){
            Insert exposuresToBeInserted;
        }
        return new PageReference('/'+ps.Id);
    }        
    //Redirection Method End...
    
    //Support Methods Begins... 
    public void updateDeductibleRate(){
        System.debug('Deductible::'+DeductibleRate);
        
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
                System.debug('2.10::'+Decimal.valueOf(PW.price.split('>')[0])+'::'+PW.priceDecimal+'::'+PW.price+'::'+PW);
                adjustmentFactor  =  adjustmentFactor + PW.priceDecimal;
            }
            adjustedPDBaseRate  =  PDBaseRate*adjustmentFactor;
            adjustedBIBaseRate  =  BIBaseRate*adjustmentFactor;
            MBCRate  =  MBCMap.get(MachineryBreakdownCover);
            MBBICRate  =  MBBICMap.get(MachineryBreakdownBICover);
            System.debug('MBCRate'+MBCRate +',  MBBICRate '+MBBICRate );
        }else{
            if(pricingRate  !=   null && Turnover_Converted  !=   0){
                //Turnover_Converted  =  TurnoverValue;
                if(Turnover_Converted  !=   null && currentToSEKRate > 0)
                    TurnoverValue  =  (Turnover_Converted/currentToSEKRate).longValue();
                else
                    TurnoverValue  =  Turnover_Converted;
                System.debug('Turnover_Converted::'+Turnover_Converted+',  currentToSEKRate' + currentToSEKRate);
                TOPRate  =  Decimal.valueOf(pricingRate.split('>')[0]);
                decimal tmp;
                if(price.VG_Product__c  ==  'GLPL')
                    tmp  =  (((155632*(1/(Math.exp(0.778*Math.log(TurnoverValue )))))/1000)*(TurnoverValue))*TOPRate; // Net Base Premium  =  ((155632 x (Revenue)^-0.778)/1000XRevenue)X Type of Operation
                else if(price.VG_Product__c  ==  'Life Sciences')
                    tmp  =  (((155632*(1/(Math.exp(0.778*Math.log(TurnoverValue)))))/1000)*(TurnoverValue ))*TOPRate; // Net Base Premium  =  (155632 X(Revenue)^-.778/1000)X Revenue
                else if(price.VG_Product__c  ==  'Clinical Trials' && numberOfPatients_Converted  !=  0){
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
                if(PW.price  !=   null){
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
                    if(PW.price  !=   null){
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
            if(NBP  !=   null){
                for(OtherFactors ofc :otherFactorsList){
                    if(ofc.rate  !=   null){
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
                if(DeductibleRate_Converted  !=   null){
                    //DeductibleRate_Converted  =  DeductibleRate;
                    DeductibleRate  =  (DeductibleRate_Converted/currentToSEKRate)+1;
                    for(SelectOption s : deductibleFactor.factors){
                        if(s.getLabel()  !=   '--Select--'){
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
        if(experiencePremium  !=   null && seletedWeight  !=   null){
            //experiencePremium_Converted  =  experiencePremium;
            experiencePremium  =  experiencePremium_Converted  ==  0 || experiencePremium_Converted  ==  null? 0 : experiencePremium_Converted/currentToSEKRate;
            netBasePremium  =  ((0.5*(netExposurePremium)) + ((seletedWeight/100)*(experiencePremium)) + ((1 - ((seletedWeight)/100))*(0.5*(netExposurePremium)))).round(System.RoundingMode.CEILING);
            grossBasePremium  =  (netBasePremium/(1-(brokerage/100))).round(System.RoundingMode.CEILING);
            netCommission  =  (grossBasePremium - netBasePremium).round(System.RoundingMode.CEILING);
            netBasePremium_Converted  =  (netBasePremium*currentToSEKRate).setScale(2);
            grossBasePremium_Converted  =  (grossBasePremium*currentToSEKRate).setScale(2);
            netCommission_Converted  =  (netCommission*currentToSEKRate).setScale(2);
            netBasePremium  =  netBasePremium_Converted;
        }
    }
    
    public void UpdateAssetPremium(){
        List<VG_Pricing__c > priceListRiskRating  =  new List<VG_Pricing__c>([select Id, Name, VG_Product__c, VG_Category__c, VG_Rating_Factor__c, VG_Rate__c,  Sum_Insured_Limit__c from VG_Pricing__c where VG_Product__c  =  'Property' and VG_Level__c  =  'Risk Rating' and VG_Rate__c  !=   null and VG_Rating_Factor__c  !=   null ORDER BY VG_Order__c]);
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
                System.debug('TempMap is' + tempMap);
                deductiblesMap.put(pri.Sum_Insured_Limit__c,  tempMap);
            }
        }
        if(allAccountAssets.get(currentAsset.asset.Asset__c)  !=   null){
            showAssetDetails  =  True;
            Asset__c tempAsset  =  allAccountAssets.get(currentAsset.asset.Asset__c);
            currentAsset.name  =  tempAsset.Name;
            //currentAsset.totalPropertyDamageSI  =  adjustedPDBaseRate * tempAsset.VG_Total_Property_Damage_SI__c;
            currentAsset.totalPropertyDamageSI  =  tempAsset.VG_Total_Property_Damage_SI__c;
            currentAsset.fullValue  =  tempAsset.VG_Full_Value_Building__c;
            currentAsset.TrueTSI = tempAsset.VG_True_TSI__c;
            //currentAsset.totalBusinessInterruptionSI  =  adjustedBIBaseRate * tempAsset.VG_Total_Business_Interruption_SI__c;
            currentAsset.totalBusinessInterruptionSI  =  tempAsset.VG_Total_Business_Interruption_SI__c;
            currentAsset.totalSumInsuredSI  =  currentAsset.totalPropertyDamageSI + currentAsset.totalBusinessInterruptionSI;
            currentAsset.totalSumInsuredMBSI  =  tempAsset.VG_Machinery_SI__c;
            if(currentAsset.asset.VG_Deductible__c  !=   null){
                for(SelectOption s : pricingMap.get('PD Deductible').factors){
                    if(currentAsset.asset.VG_Deductible__c < Decimal.valueOf(s.getLabel().split(' - ')[1])){
                        currentAsset.PDDeductible  =  Decimal.valueOf(s.getValue());
                        Break;
                    }
                }
            }else{
                currentAsset.PDDeductible  =  0;
            }
            /*if(currentAsset.asset.VG_Deductible__c  !=   null){
               for(SelectOption s : pricingMap.get('PD Deductible').factors){
              if(currentAsset.asset.VG_Deductible__c < Decimal.valueOf(s.getLabel().split(' - ')[1])){
                 currentAsset.MBPDDeductible  =  Decimal.valueOf(s.getValue());
               Break;
                 }
                }
               }else{
               currentAsset.MBPDDeductible  =  0;
             }*/
            if(tempAsset.VG_Waiting_Period__c  !=   null){
                //currentAsset.WaitingPeriod  =  Decimal.valueOf(currentAsset.waitingPeriodFactors.price);
                for(SelectOption so : currentAsset.waitingPeriodFactors.factors){
                    if(so.getLabel()  ==  tempAsset.VG_Waiting_Period__c){
                        System.debug('Test');
                        currentAsset.WaitingPeriod  =  Decimal.valueOf(so.getValue());
                        Break;
                    }
                }
            }else{
                currentAsset.WaitingPeriod  =  0;
            }
            System.debug('currentAsset.WaitingPeriod '+currentAsset.WaitingPeriod);
            if(tempAsset.VG_MB_Waiting_Period__c  !=   null){
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
            if(tempAsset.VG_BI_Indemnity_Period__c  !=   null){
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
            if(tempAsset.VG_MB_BI_Indemnity_Period__c  !=   null){
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
            if(tempAsset.VG_Automatic_Fire_alarm__c  !=   null){
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
            if(tempAsset.VG_Water_sprinklers__c  !=   null){
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
            if(tempAsset.VG_Smoke_and_heat_venting_system__c  !=   null){
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
            if(tempAsset.VG_Foam_supression_system__c  !=   null){
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
            if(tempAsset.VG_Full_time_public_Fire_Brigade_staff__c  !=   null){
                for(SelectOption s : pricingMap.get('Full time public Fire Brigade staff?').factors){
                    System.debug(tempAsset.VG_Full_time_public_Fire_Brigade_staff__c +'  =  '+s.getLabel());
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
                    if(tempAsset.VG_PD_Deductible__c  !=   null){
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
                            System.debug('PDDeductible exception'+ex.getMessage());
                        }
                    }
                }
                System.debug(currentAsset.totalSumInsuredMBSI + ' > ' + MBSILowerLimit + ' && ' + currentAsset.totalSumInsuredMBSI + ' < =  ' + MBSIUpperLimit);
                if(currentAsset.totalSumInsuredSI > MBSILowerLimit && currentAsset.totalSumInsuredSI < =  MBSIUpperLimit){
                    Decimal proRatingFactor  =  (MBSIUpperLimit  - currentAsset.totalSumInsuredSI)/(MBSIUpperLimit - MBSILowerLimit);
                    if(tempAsset.VG_MB_PD_Deductible__c  !=   null){
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
                            System.debug('MBPDDeductible exception'+ex.getMessage());
                        }
                    }
                }
            }
            currentAsset.AdjustedPDPremium  =  ((adjustedPDBaseRate * (currentAsset.totalPropertyDamageSI*(1+(currentAsset.PDDeductible))))/1000);
            System.debug('currentAsset.totalBusinessInterruptionSI '+currentAsset.totalBusinessInterruptionSI+',  adjustedBIBaseRate '+adjustedBIBaseRate+',  currentAsset.WaitingPeriod '+currentAsset.WaitingPeriod+',  currentAsset.BIIndemnityPeriod '+currentAsset.BIIndemnityPeriod);
            currentAsset.AdjustedBIPremium  =  ((currentAsset.totalBusinessInterruptionSI*adjustedBIBaseRate) + (currentAsset.totalBusinessInterruptionSI*adjustedBIBaseRate* currentAsset.WaitingPeriod)+(currentAsset.totalBusinessInterruptionSI*adjustedBIBaseRate*currentAsset.BIIndemnityPeriod))/1000;
            System.debug('currentAsset.AutomaticFirealarm: '+currentAsset.AutomaticFirealarm+',  currentAsset.FoamSupressionSystem: '+currentAsset.FoamSupressionSystem + ',  currentAsset.WaterSprinklers: ' + currentAsset.WaterSprinklers + ',  currentAsset.SmokeAndHeatVentingSystem: '+currentAsset.SmokeAndHeatVentingSystem + ',  currentAsset.FulltimePublicFireBrigadeStaff: ' + currentAsset.FulltimePublicFireBrigadeStaff);
            currentAsset.TotalDiscountLoading  =  currentAsset.AutomaticFirealarm  + currentAsset.FoamSupressionSystem + currentAsset.WaterSprinklers + currentAsset.SmokeAndHeatVentingSystem + currentAsset.FulltimePublicFireBrigadeStaff;
            if(currentAsset.TotalDiscountLoading < -0.45){
                currentAsset.TotalDiscountLoading  =  - 0.45;
            }
            currentAsset.NetPDPremium  =  currentAsset.AdjustedPDPremium*(1+(currentAsset.TotalDiscountLoading));
            currentAsset.NetBIPremium  =  currentAsset.AdjustedBIPremium*(1+(currentAsset.TotalDiscountLoading));
            try{
                currentAsset.AdjustedMBPremium  =  ((currentAsset.totalSumInsuredMBSI * MBCRate )+(currentAsset.totalSumInsuredMBSI * MBCRate * currentAsset.MBPDDeductible)+(currentAsset.totalSumInsuredMBSI * MBBICRate )+(currentAsset.totalSumInsuredMBSI * MBBICRate * currentAsset.MBWaitingPeriod)+(currentAsset.totalSumInsuredMBSI * MBBICRate * currentAsset.BIIndemnityPeriod))/1000;
            }catch(Exception ex){
                System.debug('currentAsset.AdjustedMBPremium error'+ex.getmessage());
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
    
    public void UpdateFinalCalculations(){
        If(RateChange==0.00 && policy.VG_Is_Renewal__c == false)
            RateChange=null;
        Long attLimit;
        Decimal AttachmentRate;
        Decimal AttLimitRate;
        Long attachment_unrounded,  limitAmount_unrounded,  attachment_rounded,  limitAmount_rounded;
        Integer millionFactor;
        AttLimitRate = 0;
        AttachmentRate = 0;
        if(!IsProperty){
            System.debug('policyCurrency ' + policyCurrency + ',  currentToSEKRate'+currentToSEKRate+',  attachment_Converted '+attachment_Converted +',  limitAmount_Converted '+limitAmount_Converted);
            if(attachment_Converted  !=   null){
                attachment_unrounded  =  (attachment_Converted/currentToSEKRate).LongValue();
            }else{
                attachment_unrounded  =  0;
            }
            if(limitAmount_Converted  !=   null){
                limitAmount_unrounded  =  (limitAmount_Converted/currentToSEKRate).LongValue();
            }else{
                limitAmount_unrounded  =  0;
            }
            attachment_rounded  =  attachment_unrounded - Math.MOD(attachment_unrounded,  10000000L);
            limitAmount_rounded  =  limitAmount_unrounded - Math.MOD(limitAmount_unrounded,  10000000L);
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
            System.Debug(' == >limitAmount_rounded '+limitAmount_rounded );
            List<ILF_Factors__c> ILFFactorLookups  =  new List<ILF_Factors__c>();
            netModelPremium  =  netBasePremium_Converted + endorsementPremium;
            grossBasePremium  =  (netModelPremium/(1-(brokerage/100)));
            try{
                sumInsured  =  limitAmount_Converted * (sharePercent/100);
            }catch(exception ex){
                sumInsured  =  0;
            }
            System.debug('ILFFactor'+ILFFactor+',  layer'+layer);
            if(layer  ==  'Primary'){
                try{
                    System.debug('limitAmount_rounded: '+limitAmount_rounded);
                    ILF_Factors__c ILFFactorLookup  =  [Select Id,  Rate__c,  Limit__c from ILF_Factors__c where Limit__c  = : limitAmount_rounded AND Type__c  = : ILFFactor AND Level__c  =  'Premium' AND Product__c  = : price.VG_Product__c LIMIT 1];
                    ILFRate  =  (ILFFactorLookup.Rate__c-1)+Decimal.valueOf(deductibleFactor.price);
                }catch(exception ex){
                    System.debug(ex.getMessage());
                    ILFRate  =  0;
                }
                attachment_Converted  =  (DeductibleRate_Converted).LongValue();
            }else{
                attLimit  =  attachment_rounded + limitAmount_rounded;
                System.debug('Math.Mod(attLimit,  10000000): '+Math.Mod(attLimit,  10000000L));
                
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
                System.debug(ILFFactorLookups);
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
            System.debug('ILFRate' + ILFRate );
            //Below one line added by siddik on 12-9-18 for JIRA 113 [divide by zero error]
            if(Decimal.valueOf(deductibleFactor.price) > 0 && Decimal.valueOf(deductibleFactor.price)  !=   null)
                ilfPremium  =  (ILFRate * netModelPremium)/Decimal.valueOf(deductibleFactor.price);
            else
                ilfPremium  =  netModelPremium;
            attLimit  =  attachment_unrounded + limitAmount_unrounded;
            attLimit  =  attLimit  - Math.Mod(Decimal.valueOf(attLimit ).longValue(),  10000000L);
            System.Debug(' ==  => attLimit '+attLimit);
            ILFFactorLookups  =  [Select Id,  Rate__c,  Limit__c from ILF_Factors__c where (Limit__c  = : attLimit OR Limit__c  = : attachment_rounded ) AND Type__c  = : ILFFactor AND Level__c  =  'RPM' AND Product__c  = : price.VG_Product__c];
            for(ILF_Factors__c IFactor : ILFFactorLookups){
                if(IFactor.Limit__c  ==  attLimit){
                    AttLimitRate  =  IFactor.Rate__c;
                    System.debug(' == AttLimitRate:'+AttLimitRate);
                }else if(IFactor.Limit__c  ==  attachment_rounded){ 
                    AttachmentRate  =  IFactor.Rate__c;
                    System.debug(' == AttachmentRate:'+AttachmentRate);
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
            techPremium  =  techModelPremium + adjustmentTechPremium;
            uwPremium  =  techModelPremium + adjustmentTechPremium;
            actualPremium  =  uwPremium + adjustment;
            grossWrittenPremium  =  actualPremium/(1-(brokerage/100));
            try{
                grossWrittenPremium2  = actualPremium/(sharePercent/100);
            }catch(exception ex){
                grossWrittenPremium2  = 0;
            }
            brokerageAmount  =  (grossWrittenPremium)*(brokerage/100);
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
                grossWrittenPremium2  = actualPremium/(sharePercent/100);            
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
    
    public Decimal getFLRates(Long currentTurnover,  String Product){
        Decimal FLRate  =  0;
        if(Product  ==  'IPO'){
            if(currentTurnover < =  50000000)
                FLRate  =  2500;
            else if(currentTurnover < =  100000000)
                FLRate  =  3000;
            else if(currentTurnover < =  250000000)
                FLRate  =  3500;
            else if(currentTurnover < =  500000000)
                FLRate  =  5000;
            else if(currentTurnover < =  750000000)
                FLRate  =  5500;
            else if(currentTurnover < =  1000000000)
                FLRate  =  6000;
            else if(currentTurnover < =  1500000000)
                FLRate  =  8000;
            else if(currentTurnover < =  2500000000L)
                FLRate  =  9000;
            else if(currentTurnover < =  5000000000L)
                FLRate  =  10000;
            else if(currentTurnover < =  10000000000L)
                FLRate  =  12000;
            else if(currentTurnover < =  25000000000L)
                FLRate  =  13000;
            else if(currentTurnover < =  50000000000L)
                FLRate  =  14000;
            else if(currentTurnover < =  100000000000L)
                FLRate  =  15000;
            else if(currentTurnover < =  500000000000L)
                FLRate  =  16000;
        }else if(Product  ==  'Crime'){
            if(currentTurnover < =  50000000)
                FLRate  =  7500;
            else if(currentTurnover < =  100000000)
                FLRate  =  9000;
            else if(currentTurnover < =  250000000)
                FLRate  =  10500;
            else if(currentTurnover < =  500000000)
                FLRate  =  15000;
            else if(currentTurnover < =  750000000)
                FLRate  =  16500;
            else if(currentTurnover < =  1000000000)
                FLRate  =  18000;
            else if(currentTurnover < =  1500000000)
                FLRate  =  24000;
            else if(currentTurnover < =  2500000000L)
                FLRate  =  27000;
            else if(currentTurnover < =  5000000000L)
                FLRate  =  30000;
            else if(currentTurnover < =  10000000000L)
                FLRate  =  36000;
            else if(currentTurnover < =  25000000000L)
                FLRate  =  39000;
            else if(currentTurnover < =  50000000000L)
                FLRate  =  42000;
            else if(currentTurnover < =  100000000000L)
                FLRate  =  45000;
            else if(currentTurnover < =  500000000000L)
                FLRate  =  48000;
        }else if(Product  ==  'D&O'){
            if(currentTurnover < =  50000000)
                FLRate  =  2500;
            else if(currentTurnover < =  100000000)
                FLRate  =  3000;
            else if(currentTurnover < =  250000000)
                FLRate  =  3500;
            else if(currentTurnover < =  500000000)
                FLRate  =  5000;
            else if(currentTurnover < =  750000000)
                FLRate  =  5500;
            else if(currentTurnover < =  1000000000)
                FLRate  =  6000;
            else if(currentTurnover < =  1500000000)
                FLRate  =  8000;
            else if(currentTurnover < =  2500000000L)
                FLRate  =  10000;
            else if(currentTurnover < =  5000000000L)
                FLRate  =  12000;
            else if(currentTurnover < =  10000000000L)
                FLRate  =  14000;
            else if(currentTurnover < =  25000000000L)
                FLRate  =  16000;
            else if(currentTurnover < =  50000000000L)
                FLRate  =  18000;
            else if(currentTurnover < =  100000000000L)
                FLRate  =  20000;
            else if(currentTurnover < =  500000000000L)
                FLRate  =  22000;
        }else{
            FLRate  =  0;
        }
        return FLRate; 
    }
    //Support Methods Ends... 
    
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
        Public Decimal TrueTSI{get; set;}
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
    //Sub Classes Ends...
}