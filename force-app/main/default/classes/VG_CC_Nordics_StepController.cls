public without sharing class VG_CC_Nordics_StepController {
    public Decimal totalSI{get;set;}     
    public String GLPL_Coverage{get;set;}
    
    Public Static Map<String,  Boolean> coveragesMap {get; set;}
    Public Map<String,  PricingWrapper> pricingMap {get; set;}
    Public Map<String,  CoverageWrapper> coverages {get; set;}
    Public Map<String,  String> occupanciesMap {get;set;}
    
    Public List<Asset__c> assetsList {get; set;}
    Public List<AssetWrapper> assetWrapperList {get; set;}
    Public List<AssetWrapperList> awlList {get; set;}
    Public List<SelectOption> municipalitiesList {get; set;}
    Public List<SelectOption> occupanciesList {get; set;}
    Public List<SelectOption> occupanciesList2 {get; set;}
    public list<SelectOption> EEAVolanteEntity_Select {get; set;}
    Public List<SOWrapper> soWrapperList {get; set;}
    public List<LibraryWrapper> LibraryWrapperList {get; set;}
    public List<LibraryWrapper> LibraryWrapperList1 {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements1 {get; set;}
    public List<Endorsement_Library__c> ElList{get;set;}
    public List<Endorsement_Library__c> ElList1{get;set;} 
    public List<SelectOption> selectedCoveragesList {get; set;}
    Public List<SelectOption> splitTypes{get; set;}
    
    public AssetWrapperList awl{get;set;}
    public LibraryWrapper LW{get;set;}
    public LibraryWrapper LW1{get;set;} 
    Public Policy__c policy {get; set;}
    Public Policy_Schedule__c ps {get; set;}
    Public CoverageWrapper currentCW {get; set;}
    
    Public Id policyId {get; set;}
    
    Public String addCoverageMode {get; set;}
    Public String selectedMunicipality {get; set;}
    Public String selectedOccupancy {get; set;}
    public String GrossOrNet {get; set;}
    public String policyCurrency {get; set;}
    
    Public Boolean hasAssets {get; set;}
    Public Boolean skipSplit {get; set;}
    
    public Long TurnoverValue{get;set;}
    public Long Turnover_Converted{get;set;}
    public Long limitAmount {get; set;}
    public Long attachment {get; set;}
    public Long limitAmount_Converted {get; set;}
    public Long attachment_Converted {get; set;}
    
    Public Decimal AnnualTurnover {get; set;}
    Public Decimal PBARate {get; set;}
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
    public Decimal netBasePremium_Converted_Pro {get; set;}
    public Decimal brokerage {get; set;}
    public Decimal brokerageAmount {get; set;}
    public Decimal sumInsured {get; set;}
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
    public Decimal IPTPercent {get; set;}
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
    public Decimal endorsementPremium_Pro {get; set;}
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
    public Decimal totalpre{get;set;}
    
    public Integer ExtReportingPeriod{get;set;}
    public Integer RDYear{get;set;}
    public Integer RDAP{get;set;}
    public Integer counter{get;set;}
    public Integer counterEnd {get; set;}
    public Integer orderIndex {get; set;}
    public Integer RRcounter {get; set;}
    public Integer numberOfPatients {get; set;}
    public Integer numberOfPatients_Converted {get; set;}
    public VG_CC_Nordics_StepController(){
        policyId  =  ApexPages.currentPage().getParameters().get('policyId');
        ps = new Policy_Schedule__c();
        assetWrapperList  =  new List<AssetWrapper>();
        awlList = new List<AssetWrapperList>();
        coverages  =  new Map<String,  CoverageWrapper>();
        LibraryWrapperList  =  new List<LibraryWrapper>();
        LibraryWrapperList1  =  new List<LibraryWrapper>();
        existingEndorsements  =  new List<VG_Policy_Schedule_Endorsement__c>();
        existingEndorsements1  =  new List<VG_Policy_Schedule_Endorsement__c>();
        coveragesMap  =  createCoveragesList();
        LibraryWrapper LW;
        LibraryWrapper LW1;
        occupanciesList  =  new List<SelectOption>();
        occupanciesList2  =  new List<SelectOption>();
        municipalitiesList  =  createMunicipalitiesList();
        occupanciesMap  =  createOccupanciesList();
        EEAVolanteEntity_Select = new List<SelectOption>();
        for(String s : Label.Nordics_EEAVolanteEntity.split(';')){
            EEAVolanteEntity_Select.add(new SelectOption(s,s));
        }
        for(Integer so  =  0; so < occupanciesMap.values().size(); so++){
            if(so < 999){
                occupanciesList.add(new SelectOption(occupanciesMap.values()[so], occupanciesMap.values()[so]));
            }else{
                occupanciesList2.add(new SelectOption(occupanciesMap.values()[so], occupanciesMap.values()[so]));
            }
        }
        addCoverageMode  =  '';
        CreditScore = TOPRate = totalpre = NBP = totalPremiumMovement = netExposurePremium = commissionPercent = netCommission = grossBasePremium = exposurePremium = experiencePremium = netModelPremium = deductible = seletedWeight = netBasePremium = brokerage = 0;
        ROL = RPM = sharePercent = techPremium = adjustmentTechPremium = uwPremium = adjustment = actualPremium = orcPercent = orcAmount = 0;
        limitAmount = attachment = 0;
        netBasePremium_Converted = attachment_Converted = 0;
        techLayerPremium = 0.0;        
        policy  =  [Select Id,  Insured__c, VG_Is_Renewal__c ,CurrencyISOCode,  VG_Inception_Date__c,  VG_Expiry_Date__c from Policy__c where Id =: policyId];
        policyCurrency  =  policy.CurrencyISOCode;
        if(Math.mod(policy.VG_Inception_Date__c.year(), 4) !=  0){
            if(Math.mod(policy.VG_Expiry_Date__c.year(), 4)  ==  0){
                if(policy.VG_Expiry_Date__c <=  date.newInstance(policy.VG_Expiry_Date__c.year(), 02, 28)){
                    proratingFactor = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1)/365;
                }else{
                    proratingFactor = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c))/365;
                }
            }else{
                proratingFactor = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1)/365;
            }
        }else{
            if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                proratingFactor = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c))/365;
            }else{
                proratingFactor = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1)/365;
            }
        }  
        sekToUSDRate  =  currentToUSDRate  =  1;
        List<CurrencyType> exchangeRates  =  [Select Id,  ConversionRate,  IsoCode from CurrencyType where IsoCode  =  'SEK' or IsoCode =: policy.CurrencyISOCode];
        for(CurrencyType rt : exchangeRates){
            if(rt.IsoCode  ==  'SEK' ){
                System.debug('SEK if::'+rt.ConversionRate);
                sekToUSDRate  =  rt.ConversionRate;
            }
            if(rt.IsoCode  ==  policy.CurrencyISOCode){
                System.debug('PolicyCurrency if::'+rt.ConversionRate);
                currentToUSDRate  =  rt.ConversionRate;
            }
        }
        currentToSEKRate  =  (currentToUSDRate/sekToUSDRate).setScale(3);
        assetsList  =  [Select Id,  Name,  VG_Street__c,  VG_Total_Property_Damage_SI__c, VG_True_TSI__c,  VG_Building_SI__c,  VG_Machinery_SI__c from Asset__c where VG_Account__c=:policy.Insured__c];    
        System.debug('assetsList::'+assetsList.size());
        createCoveragesList();
        PBARate  =  Integer.ValueOf(Label.Nordics_Commercial_Combined_PBA_Rate);
        splitTypes = new List<SelectOption>();            
        skipSplit = False;
        if(policy.VG_Inception_Date__c.year() <= 2020){
            splitTypes.add(new SelectOption('','--None--'));
            skipSplit = True;
        }
        splitTypes.add(new SelectOption('EEA','EEA'));
                
        
        if(assetsList.IsEmpty()){
            hasAssets  =  False;
        }else{
            if(assetsList.size()>999){
                System.debug('here');
                awl = new AssetWrapperList();
                while(assetsList.size()!=0){
                    AssetWrapper tempAssetWrapper  =  new AssetWrapper();
                    tempAssetWrapper.asset  =  assetsList[0];
                    tempAssetWrapper.isSelected  =  False;
                    if(awl.assetWrapperList.size()<999){
                        awl.assetWrapperList.add(tempAssetWrapper );
                        assetsList.remove(0);
                    }
                    if(awl.assetWrapperList.size()== 999){
                        awlList.add(awl);
                        awl = new AssetWrapperList();
                        awl.assetWrapperList.add(tempAssetWrapper );
                        assetsList.remove(0);
                    }
                    if(assetsList.size()  ==  1){
                        awlList.add(awl);
                    }
                }
                System.debug(awlList);
            }else{
                awl = new AssetWrapperList();
                for(Asset__c a : assetsList){
                    AssetWrapper tempAssetWrapper  =  new AssetWrapper();
                    tempAssetWrapper.asset  =  a;
                    tempAssetWrapper.isSelected  =  False;
                    if(ps.VG_Bridge_Selected_Asset__c  != null && ps.VG_Bridge_Selected_Asset__c !='' && ps.VG_Bridge_Selected_Asset__c.contains(a.id))
                        tempAssetWrapper.isSelected  =  true;
                    //assetWrapperList.add(tempAssetWrapper);
                    awl.assetWrapperList.add(tempAssetWrapper);
                }
                awlList.add(awl);
            }
            hasAssets  =  True;
        }    
    }
    
    Public void addRiskRating(){
        addCoverageMode  =  'Select Coverage';
        currentCW  =  new CoverageWrapper();
    }
    
    Public void setCoverageContext(){
        switch on currentCW.selectedCoverage{
            when 'Fire'{
                setFireContext();
            }
            when 'Burglary'{
                setBurglaryContext();
            }
            when 'Water'{
                setWaterContext();
            }
            when 'All Risk'{
                setARContext();
            }
            when 'Machinery Breakdown'{
                setMBContext();
            }
            when 'CAR/EAR'{
                setCARContext();
            }
            when 'Escaping Liquid'{
                setELContext();
            }
            when 'Cistern'{
                setCisternContext();
            }
            when 'Freeze & Refrigerator'{
                setFARContext();
            }
            when 'Robbery'{
                setRobberyContext();
            }
            when 'Special Objects'{
                setSOContext();
            }
            when 'Business Interruption'{
                setBIContext();
            }
            when 'Machinery BI'{
                setMBIContext();
            }
            when 'Extra Costs'{
                setECContext();
            }
            when 'Loss of Rent'{
                setLORContext();
            }
            when 'Epidemic Disease'{
                setEpidemicContext();
            }
            when 'Liability GL/PL'{
                setGLPLContext();
            }
            when 'Legal Aid'{
                setLAContext();
            }
            when 'Crime'{
                setCrimeContext();
            }
            when 'Crisis'{
                setCrisisContext();
            }
            when 'Personal Accident (visitor)'{
                setPAContext();
            }
            when 'Assault'{
                setAssaultContext();
            }
            when 'Tools'{
                setToolsContext();
            }
            when 'Lift'{
                setLiftContext();
            }
            when 'Forklift'{
                setForkliftContext();
            }
            when 'Business Sample'{
                setBSContext();
            }
            when 'Professional Indemnity'{
                setPIContext();
            }
            when 'Business Interruption due to Health Problems'{
                setBIHContext();
            }
            when else {
                System.debug('Coverage Context Not Found');
            }            
        }
        System.debug('28.2.2019::');
    }
    
    Public void setEpidemicContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            price.showOnUI  =  False;
            if(price.factorName  ==  'Epidemic Disease Indemnity Period Factor'){
                currentCW.variable.IPFactor  =  price;
            }
            if(price.factorName  ==  'Risk Quality'){
                price.showOnUI  =  True;
                currentCW.variable.RQFactor  =  price;
            }
            if(price.factorName  ==  'Epidemic Disease Waiting Period Factor'){
                currentCW.variable.WPFactor  =  price;
            }
        }
    }
    
    Public Void refreshView(){
        
    }
    
    Public void setMBIContext(){
        setPricingVariables();
        System.debug('28.2.2019');
        for(PricingWrapper price : currentCW.factors){
            price.showOnUI  =  False;
            if(price.factorName  ==  'Indeminity Period Rate'){
                currentCW.variable.IPFactor  =  price;
            }
            if(price.factorName  ==  'Waiting Time Rate'){
                currentCW.variable.WPFactor  =  price;
            }
        }
    }
    
    Public void setECContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            price.showOnUI  =  False;
            if(price.factorName  ==  'Indemnity Period Rate'){
                currentCW.variable.IPFactor  =  price;
            }
        }
    }
    
    Public void setLAContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            price.showOnUI  =  False;
            if(price.factorName  ==  'Envormental Coverage Factor'){
                price.showOnUI  =  True;
            }
        }
    }
    
    Public void setLORContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            price.showOnUI  =  False;
            if(price.factorName  ==  'Indemnity Factor'){
                currentCW.variable.IPFactor  =  price;
            }
        }
    }
    
    Public void setGLPLContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            price.showOnUI  =  False;
            System.debug('price.factorName: '+price.factorName);
            if(price.factorName  ==  'Risk Quality'){
                System.debug('Here');
                currentCW.variable.RQFactor  =  price;
            }
        }
    }
    
    Public void setCrimeContext(){
        setPricingVariables();
    }
    
    Public void setToolsContext(){
        setPricingVariables();
    }
    
    Public void setLiftContext(){
        setPricingVariables();
    }
    
    Public void setForkliftContext(){
        setPricingVariables();
    }
    
    Public void setARContext(){
        setPricingVariables();
    }
    
    Public void setBIContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            price.showOnUI  =  False;
            if(price.factorName  ==  'Indemnity Period Rate'){
                price.showOnUI  =  True;
                currentCW.variable.IPFactor  =  price;
            }
            if(price.factorName  ==  'Risk Quality'){
                price.showOnUI  =  True;
                currentCW.variable.RQFactor  =  price;
            }
            if(price.factorName  ==  'Waiting Period Rate'){
                price.showOnUI  =  True;
                currentCW.variable.WPFactor  =  price;
            }
        }
    }
    
    Public void setBSContext(){
        setPricingVariables();
    }
    
    Public void setPIContext(){
        setPricingVariables();
    }
    
    Public void setCrisisContext(){
        setPricingVariables();
    }
    
    Public void setPAContext(){
        setPricingVariables();
    }
    
    Public void setAssaultContext(){
        setPricingVariables();
    }
    
    Public void setBIHContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            price.showOnUI  =  False;
            if(price.factorName  ==  'BIH Indemnity Factor'){
                currentCW.variable.IPFactor  =  price;
            }
            if(price.factorName  ==  'BIH Waiting Period Factor'){
                currentCW.variable.WPFactor  =  price;
            }
        }        
    }
    
    Public void setFireContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            System.debug('price.factorName is: '+price.factorName);
            if(price.factorName  !=  'Occupancy Rate' && price.factorName  !=  'Location factor'){
                price.showOnUI  =  True;
            }else{
                price.showOnUI  =  False;
            }
        }
    }
    
    Public void setMBContext(){
        setPricingVariables();
        System.debug('28.2.2019::');
        for(PricingWrapper price : currentCW.factors){
            System.debug('price.factorName is: '+price.factorName);
            if(price.factorName  ==  'Building Heat Supply' || price.factorName  ==  'Risk Quality'){
                price.showOnUI  =  True;
            }
        }
        System.debug('28.2.2019::');
    }
    
    Public void setCARContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            System.debug('price.factorName is: '+price.factorName);
            if(price.factorName  ==  'Contractor BI Indemnity Period'){
                currentCW.variable.IPFactor  =  price;
            }
            if(price.factorName  ==  'Contractor BI Waiting Period'){
                currentCW.variable.WPFactor  =  price;
            }
            if(price.factorName  ==  'Construction Risk Quality' || price.factorName  ==  'Share of Subcontractor' ){
                price.showOnUI  =  True;
            }
        }
    }
    
    Public void setWaterContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            System.debug('price.factorName is: '+price.factorName);
            if(price.factorName  ==  'Risk Quality'){
                price.showOnUI  =  True;
            }
        }
    }
    
    Public void setELContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            System.debug('price.factorName is: '+price.factorName);
            if(price.factorName  ==  'Storage Capacity'){
                price.showOnUI  =  True;
            }
        }
    }
    
    Public void setCisternContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            System.debug('price.factorName is: '+price.factorName);
            if(price.factorName  ==  'Coverage Factor'){
                price.showOnUI  =  True;
            }
        }
    }
    
    Public void setFARContext(){
        setPricingVariables();
    }
    
    Public void setRobberyContext(){
        setPricingVariables();
    }
    
    Public void setSOContext(){
        setPricingVariables();
        soWrapperList  =  new List<SOWrapper>();
        for(Integer i  =  0; i<= 6; i++){
            SOWrapper SOW  =  new SOWrapper();
            soWrapperList.add(SOW);
        }
    }
    
    Public void setBurglaryContext(){
        setPricingVariables();
        for(PricingWrapper price : currentCW.factors){
            System.debug('price.factorName is: '+price.factorName);
            if(price.factorName  ==  'Intruder Alarm' || price.factorName  ==  'Risk Quality'){
                price.showOnUI  =  True;
            }
        }
    }
    
    Public void setCoveragePricings(){
        switch on currentCW.selectedCoverage{
            when 'Fire'{
                setFirePricings();
            }
            when 'Burglary'{
                setBurglaryPricings();
            }
            when 'Water'{
                setWaterPricings();
            }
            when 'All Risk'{
                setARPricings();
            }
            when 'Machinery Breakdown'{
                setMBPricings();
            }
            when 'CAR/EAR'{
                setCARPricings();
            }
            when 'Escaping Liquid'{
                setELPricings();
            }
            when 'Cistern'{
                setCisternPricings();
            }
            when 'Freeze & Refrigerator'{
                setFARPricings();
            }
            when 'Robbery'{
                setRobberyPricings();
            }
            when 'Special Objects'{
                setSOPricings();
            }
            when 'Business Interruption'{
                setBIPricings();
            }
            when 'Machinery BI'{
                setMBIPricings();
            }
            when 'Extra Costs'{
                setECPricings();
            }
            when 'Loss of Rent'{
                setLORPricings();
            }
            when 'Epidemic Disease'{
                setEpidemicPricings();
            }
            when 'Liability GL/PL'{
                setGLPLPricings();
            }
            when 'Legal Aid'{
                setLAPricings();
            }
            when 'Crime'{
                setCrimePricings();
            }
            when 'Crisis'{
                setCrisisPricings();
            }
            when 'Personal Accident (visitor)'{
                setPAPricings();
            }
            when 'Assault'{
                setAssaultPricings();
            }
            when 'Tools'{
                setToolsPricings();
            }
            when 'Lift'{
                setLiftPricings();
            }
            when 'Forklift'{
                setForkliftPricings();
            }
            when 'Business Sample'{
                setBSPricings();
            }
            when 'Professional Indemnity'{
                setPIPricings();
            }
            when 'Business Interruption due to Health Problems'{
                setBIHPricings();
            }
            when else {
                System.debug('Coverage Context Not Found');
            }            
        }
        if(currentCW.selectedCoverage  !=  '--None--')
            coverages.put(currentCW.selectedCoverage,  currentCW);   
        addCoverageMode  =  '';  
        
        totalpre = 0;
        for(CoverageWrapper CW : coverages.values()){                                                                                                                                                                               
            totalpre = (totalpre + CW.Premium).setScale(0);
        }
    }
    
    Public void setFirePricings(){
        Decimal BR,  LF,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TPDSI,  TAF,  PFP,  NBP,  FANP,  BCF,  MFWF,  FA,  AWS,  SF,  TSI,  BSI,  OSI,  FRF,  RQF;
        String selectedBCF;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Occupancy Rate'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel().right(7) is: '+s.getLabel() );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            BR  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'Location factor'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedMunicipality is: '+selectedMunicipality+', s.getLabel() is: '+s.getLabel() );
                        if(s.getLabel()  ==  selectedMunicipality){
                            price.price  =  s.getValue().split('>')[0];
                            LF  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'Building construction factor'){
                    BCF  =  Decimal.valueOf(price.price.split('>')[0]);
                    selectedBCF  =  price.price.split('>')[1];
                }
                if(price.factorName  ==  'Municipal Fire Water'){
                    MFWF  =  Decimal.valueOf(price.price.split('>')[0]);
                }
                if(price.factorName  ==  'Fire alarm'){
                    FA  =  Decimal.valueOf(price.price.split('>')[0]);
                }
                if(price.factorName  ==  'Automatic water sprinkler'){
                    AWS  =  Decimal.valueOf(price.price.split('>')[0]);
                }
                if(price.factorName  ==  'Risk Quality'){
                    RQF  =  Decimal.valueOf(price.price.split('>')[0]);
                }
            }
            TPDSI  =  0;
            BSI  =  0;
            for(AssetWrapperList awl:awlList){
                for(AssetWrapper AW : awl.assetWrapperList){
                    if(AW.IsSelected  ==  True){
                        TPDSI  =  TPDSI + AW.Asset.VG_Total_Property_Damage_SI__c;
                        BSI  =  BSI + AW.Asset.VG_Building_SI__c;
                    }
                }
            }
            SF  =  Math.Min(1,  11.59527 * getExp((TPDSI), -0.15723));
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(selectedBCF  ==  '1' || selectedBCF  ==  '2'){
                dedFactor  =  0.002071 * (deductible * deductible) - 0.050093 * deductible + 1.009936;
            }else{
                dedFactor  =  -0.000085 * (deductible * deductible) - 0.008312 * deductible + 1.001666;
            }
            TSI  =  TPDSI;
            OSI  =  TPDSI - BSI;
            Decimal FRFFac;
            try{
                FRFFac  =  currentCW.variable.RFRSI/currentCW.variable.FVSI  ==  0 ? 1 : currentCW.variable.RFRSI/currentCW.variable.FVSI;
            }Catch(Exception ex){
                FRFFac  =  1;
            }
            FRF  =  ((1.2759 * getExp(FRFFac,  3)) - (1.626 * getExp(FRFFac,  2)) + ((0.6593*(FRFFac)) + 0.9051));
            FRF  =  FRF > 1 ? 1 : FRF;
            System.debug('BCF: '+BCF+', MFWF: '+MFWF);
            NBP  =   ((BR*LF*BCF*MFWF*FA*AWS*SF*dedFactor*FRF*BSI/1000)*(1+RQF)) + ((BR*LF*BCF*MFWF*FA*AWS*SF*dedFactor*OSI/1000)*(1+RQF));
            currentCW.Premium  =  NBP;
            currentCW.otherRiskFactors  =  BR * LF * BCF * MFWF * FA * AWS * SF * dedFactor;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setLAPricings(){
        Decimal SNI,  ECF,  LASIF,  BTAF,  deductible,  dedNBA,  dedFactor,  NBPR,  NBBP,  RAT,  BPNBPR,  TPDSI,  PFP,  NBP,  BPPFP,  BPNBP,  BPNBBP,  FANP,  AWS,  SF,  TSI,  BSI,  OSI,  FRF,  RQF;
        String selectedBCF;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Legal Aid SNI Turover Adjustment Factor'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            SNI  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'Envormental Coverage Factor'){
                    ECF  =  Decimal.valueOf(price.price.split('>')[0]);
                }
            }
            BSI  =  0;
            for(AssetWrapperList awl:awlList){
                for(AssetWrapper AW : awl.assetWrapperList){
                    if(AW.IsSelected  ==  True){
                        BSI  =  BSI + AW.Asset.VG_Building_SI__c;
                    }
                }
            }
            //BSI  =  BSI * 1000;
            if(currentCW.variable.SI >= 500000){
                PFP  =  0;
            }else{
                PFP  =  260;
            }
            if(currentCW.variable.SI >= 1000000){
                NBPR  =  0.005;
            }else if(currentCW.variable.SI >= 500000){
                NBPR  =  0.01;
            }else{
                NBPR  =  0.035;
            }
            NBP  =  ((BSI * NBPR)/1000) + PFP;
            if(currentCW.variable.SI >= 1000000){
                LASIF  =  2.2;
            }else if(currentCW.variable.SI >= 500000){
                LASIF  =  1.8;
            }else if(currentCW.variable.SI >= 250000){
                LASIF  =  1;
            }else{
                LASIF  =  1;
            }
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible >= 1){
                dedFactor  =  1.5;
            }else if(deductible >= 0.5){
                dedFactor  =  1.3;
            }else{
                dedFactor  =  1;
            }
            BTAF  =  LASIF * dedFactor;
            NBBP  =  NBP * BTAF;
            
            RAT  =  annualTurnover * SNI;
            BPNBPR  =  Math.Min(0.504,  509.517741 * getExp((RAT - 0.000057), -0.485458));
            BPPFP  =  Math.Min(10000,  Math.Max(97,  0.208999 * getExp((RAT - 0.000022), 0.517322)));
            BPNBP  =  Math.Max(1000,  ((RAT * BPNBPR)/1000)+BPPFP);
            BPNBBP  =  BPNBP * (BTAF * ECF);
            FANP  =  BPNBBP + NBBP;
            currentCW.Premium  =  FANP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setCARPricings(){
        Decimal BR,  EPOF,  SOSF,  CRQF,  SIT,  AT,  SIF,  SITF,  dedNBA,  deductible,  dedFactor,  NWP,  MMF,  MMP,  ECF,  PLdeductible,  PLdedFactor,  ECP,  RJBR,  rdeductible,  rdedFactor,  RJP,  mdeductible,  mdedFactor,  EqP,  CTR,  epdeductible,  epdedFactor,  EPF,  EPP,  ATR,  AOF,  ABF,  apdeductible,  adedFactor,  AP,  CBIF,  IPFactor,  WPFactor,  CBIP,  TCP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Occupancy Rate'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            BR  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'Existing Property Occupancy Rate'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            EPOF =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'Share of Subcontractor'){
                    SOSF  =  Decimal.valueOf(price.price.split('>')[0]);
                }
                if(price.factorName  ==  'Construction Risk Quality'){
                    CRQF  =  Decimal.valueOf(price.price.split('>')[0]);
                }
            }
            SIT  =  currentCW.variable.SI/currentCW.variable.AnnualContstructionTurnover;
            if(SIT < 0.51){
                SITF  =  0.8;
            }else if(SIT < 0.7){
                SITF  =  0.85;
            }else if(SIT < 1){
                SITF  =  0.9;
            }else if(SIT < 1.51){
                SITF  =  1;
            }else{
                SITF  =  1.15;
            }
            SIF  =  Math.Max(0.2,   0.024842 * getExp((currentCW.variable.SI + 0.00000037396), 0.136637));
            AT  =  ((currentCW.variable.AnnualContstructionTurnover / 1000) * BR * SOSF * SITF ) + ((currentCW.variable.SI/1000) * SIF);
            
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.5){
                dedFactor  =  1 + (0.9*(0.5 - deductible)/0.4);
            }else{ 
                dedFactor  =  1.211835 * getExp((deductible + 1.055331), -0.435003);
            }
            NWP  =  (AT * dedFactor);
            if(currentCW.variable.MajorMaterialValue < 10000001){
                MMF  =  0.08;
            }else{
                MMF  =  0.1;
            }
            MMP  =  (currentCW.variable.MajorMaterialValue * MMF)/1000;
            if(currentCW.variable.ExtraCostSI >= 3000001){
                ECF  =  0.9;
            }else if(currentCW.variable.ExtraCostSI >= 1000001){
                ECF  =  0.8;
            }else if(currentCW.variable.ExtraCostSI >= 500001){
                ECF  =  0.7;
            }else{
                ECF  =  0.6;
            }
            if(currentCW.variable.PLdeductibleAmount > 0){
                dedNBA  =  currentCW.variable.PLdeductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PLPBA;
            }
            PLdeductible  =  dedNBA;
            if(PLdeductible < 0.5){
                PLdedFactor  =  1 + (0.9*(0.5 - PLdeductible)/0.4);
            }else{ 
                PLdedFactor  =  1.211835 * getExp((PLdeductible + 1.055331), -0.435003);
            }
            ECP  =  (BR * ECF * PLdedFactor * currentCW.variable.ExtraCostSI)/1000;
            if(currentCW.variable.RiskyJobSI >= 10000001){
                RJBR  =  1.3;
            }else if(currentCW.variable.RiskyJobSI >= 1000001){
                RJBR  =  1.2;
            }else{
                RJBR  =  0.8;
            }
            if(currentCW.variable.RiskyJobDeductible > 0){
                dedNBA  =  currentCW.variable.RiskyJobDeductible / PBARate;
            }else{
                dedNBA  =  currentCW.variable.RiskyJobPBA;
            }
            rdeductible  =  dedNBA;
            if(rdeductible < 0.5){
                rdedFactor  =  1 + (0.9*(0.5 - rdeductible)/0.4);
            }else{ 
                rdedFactor  =  1.211835 * getExp((rdeductible + 1.055331), -0.435003);
            }
            RJP  =  Math.Max(currentCW.variable.RiskyJobSI - 1000000,  0)*(RJBR * rdedFactor)/1000;
            if(currentCW.variable.MCDeductible > 0){
                dedNBA  =  currentCW.variable.MCDeductible / PBARate;
            }else{
                dedNBA  =  currentCW.variable.MCPBA;
            }
            mdeductible  =  dedNBA;
            if(mdeductible < 0.5){
                mdedFactor  =  1 + (0.9*(0.5 - mdeductible)/0.4);
            }else{ 
                mdedFactor  =  1.211835 * getExp((mdeductible + 1.055331), -0.435003);
            }
            EqP  =  (((currentCW.variable.MobileCraneSI * 13.84775) + (currentCW.variable.EAPM * 8.14875) + (currentCW.variable.OtherAids * 3.7028)) * mdedFactor)/1000;
            if(currentCW.variable.AnnualContstructionTurnover >= 50000000){
                CTR  =  0.08;
            }else if(currentCW.variable.AnnualContstructionTurnover >= 10000000){
                CTR  =  0.085;
            }else if(currentCW.variable.AnnualContstructionTurnover >= 5000000){
                CTR  =  0.09;
            }else{
                CTR  =  0.095;
            }
            if(currentCW.variable.EPDeductible > 0){
                dedNBA  =  currentCW.variable.EPDeductible / PBARate;
            }else{
                dedNBA  =  currentCW.variable.EPPBA;
            }
            epdeductible  =  dedNBA;
            if(epdeductible < 0.5){
                epdedFactor  =  1 + (0.9*(0.5 - epdeductible)/0.4);
            }else{ 
                epdedFactor  =  1.211835 * getExp((epdeductible + 1.055331), -0.435003);
            }
            EPF  =  Math.Max(0.8,  0.031206 * getExp((currentCW.variable.EPSI + 0.000002), 0.247212));
            EPP  =  (epdedFactor * EPF * EPOF * CTR * currentCW.variable.AnnualContstructionTurnover)/1000;
            if(currentCW.variable.AnnualContstructionTurnover >= 50000000){
                ATR  =  0.35;
            }else if(currentCW.variable.AnnualContstructionTurnover >= 10000000){
                ATR  =  0.0434;
            }else if(currentCW.variable.AnnualContstructionTurnover >= 5000000){
                ATR  =  0.0578;
            }else{
                ATR  =  0.0723;
            }
            AOF  =  BR;
            ABF  =  Math.Max(0.8,  0.287925 * getExp((currentCW.variable.AccessSI + 0.000003), 0.077876));
            if(currentCW.variable.AccessDeductible > 0){
                dedNBA  =  currentCW.variable.AccessDeductible / PBARate;
            }else{
                dedNBA  =  currentCW.variable.AccessPBA;
            }
            apdeductible  =  dedNBA;
            if(apdeductible < 0.5){
                adedFactor  =  1 + (0.9*(0.5 - apdeductible)/0.4);
            }else{ 
                adedFactor  =  1.211835 * getExp((apdeductible + 1.055331), -0.435003);
            }
            AP  =  (ATR * AOF * ABF * adedFactor * currentCW.variable.AnnualContstructionTurnover)/1000;
            CBIF  =  currentCW.variable.ContractorSI  ==  0 ? 1.35 : Math.Min(1.35,  11.721834 * getExp((currentCW.variable.ContractorSI - 0.000017),-0.173525));
            IPFactor  =  Decimal.valueOf(currentCW.variable.IPFactor.price.split('>')[0]);
            WPFactor  =  Decimal.valueOf(currentCW.variable.WPFactor.price.split('>')[0]);
            CBIP  =  (((currentCW.variable.AnnualContstructionTurnover * 0.25) + currentCW.variable.ContractorSI) * CBIF * IPFactor * WPFactor)/1000;
            TCP  =  (NWP + MMP + ECP + RJP + EqP + EPP + AP + CBIP) * (1 + CRQF);
            currentCW.Premium  =  TCP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setMBPricings(){
        Decimal MBR,  BHSF,  MSI,  BSI,  BP,  MP,  CDBR,  dedNBA,  deductible,  dedFactor,  CBP,  PLdeductible,  PLdedFactor,  RQF,  TMBP,  MCdeductible,  MCdedFactor,  RJP,  mdeductible,  mdedFactor,  EqP,  CTR,  epdeductible,  epdedFactor,  EPF,  EPP,  ATR,  AOF,  ABF,  apdeductible,  adedFactor,  AP,  CBIF,  IPFactor,  WPFactor,  CBIP,  TCP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Occupancy Rate'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            MBR  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'Building Heat Supply'){
                    BHSF  =  Decimal.valueOf(price.price.split('>')[0]);
                }
                if(price.factorName  ==  'Risk Quality'){
                    RQF  =  Decimal.valueOf(price.price.split('>')[0]);
                }
            }
            MBR  =  MBR * (0.15);
            MSI  =  0;
            BSI  =  0;
            for(AssetWrapperList awl:awlList){
                for(AssetWrapper AW : awl.assetWrapperList){
                    if(AW.IsSelected  ==  True){
                        MSI  =  MSI + AW.Asset.VG_Machinery_SI__c;
                        BSI  =  BSI + AW.Asset.VG_Building_SI__c;
                    }
                }
            }
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  (1.364844419 + (0.55* (0.2 - deductible)))/0.2;
            }else{ 
                dedFactor  =  0.80424 * getExp((deductible - 0.074067), -0.255259);
            }
            
            BP  =  (BHSF * dedFactor * BSI)/1000;
            
            if(currentCW.variable.PLdeductibleAmount > 0){
                dedNBA  =  currentCW.variable.PLdeductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PLPBA;
            }
            PLdeductible  =  dedNBA;
            if(PLdeductible < 0.2){
                PLdedFactor  =  (1.417674232 + 0.55 * (0.2 - PLdeductible))/0.2;
            }else{ 
                PLdedFactor  =  0.774158 * getExp((PLdeductible + 0.105409),- 0.510071);
            }
            
            MP  =  (MBR * PLdedFactor * MSI)/1000;
            
            CDBR  =  1.1;
            
            if(currentCW.variable.MCDeductible > 0){
                dedNBA  =  currentCW.variable.MCDeductible / PBARate;
            }else{
                dedNBA  =  currentCW.variable.MCPBA;
            }
            MCdeductible  =  dedNBA;
            if(MCdeductible < 0.2){
                MCdedFactor  =  (1.417674232 + 0.55 * (0.2 - MCdeductible))/0.2;
            }else{ 
                MCdedFactor  =  0.774158 * getExp((MCdeductible + 0.105409),- 0.510071);
            }
            CBP  =  (CDBR * MCdedFactor * currentCW.variable.SI)/1000;
            TMBP  =  (BP + MP + CBP) * (1+RQF);
            currentCW.Premium  =  TMBP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setMBIPricings(){
        Decimal MBIF,  GPF,  AT,  FP,  BP,  MP,  NMP,  FPR,  dedNBA,  deductible,  dedFactor,  CBP,  PLdeductible,  PLdedFactor,  RQF,  TMBP,  MCdeductible,  MCdedFactor,  MBIBR,  mdeductible,  mdedFactor,  EqP,  CTR,  epdeductible,  epdedFactor,  EPF,  EPP,  ATR,  AOF,  ABF,  apdeductible,  adedFactor,  AP,  CBIF,  IPFactor,  WPFactor,  CBIP,  TCP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Occupancy Rate'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            MBIF  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'GP Occupancy Rate'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            GPF  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
            }
            AT  =  MBIF * GPF * currentCW.variable.SI;
            IPFactor  =  Decimal.valueOf(currentCW.variable.IPFactor.price.split('>')[0]);
            WPFactor  =  Decimal.valueOf(currentCW.variable.WPFactor.price.split('>')[0]);
            if(currentCW.variable.FVSI > 0){
                FP  =  currentCW.variable.FVSI;
            }else{
                FP  =  AT;
            }
            if(FP > 50000000){
                MBIBR  =  0.2;
                FPR  =  0;
            }else if(FP > 5000000){
                MBIBR  =  0.25;
                FPR  =  200;
            }else{
                MBIBR  =  0.30;
                FPR  =  150;
            }
            NMP   =  (((((MBIBR * IPFactor * WPFactor ) *(FP))/1000) + FPR)* Decimal.valueOf(currentCW.variable.IPFactor.price.split('>')[1]))/12;
            currentCW.Premium  =  NMP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setARPricings(){
        Decimal FR,  BR,  WR,  ARR;
        currentCW.pricingMap  =  null;
        try{
            FR  =  coverages.get('Fire').Premium;
            BR  =  coverages.get('Burglary').Premium;
            WR  =  coverages.get('Water').Premium;
            ARR  =  (FR + BR + WR) * 0.1;
            currentCW.Premium  =  ARR;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setBIPricings(){
        Decimal GPF,  OBIF,  IPFactor,  WPFactor,  RQF,  RT,  BINP,  FR,  BR,  WR,  ARR;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Gross Profit Factor'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            GPF  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'Occupancy BI Factor'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedMunicipality is: '+selectedMunicipality.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            OBIF  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
            }
            
            RQF  =  Decimal.valueOf(currentCW.variable.RQFactor.price.split('>')[0]);
            FR  =  coverages.get('Fire')  != null ? coverages.get('Fire').otherRiskFactors : 0;
            BR  =  coverages.get('Burglary')  != null ? coverages.get('Burglary').otherRiskFactors: 0;
            WR  =  coverages.get('Water')  != null ? coverages.get('Water').otherRiskFactors: 0;
            RT  =  annualTurnover * GPF;
            IPFactor  =  Decimal.valueOf(currentCW.variable.IPFactor.price.split('>')[0]);
            WPFactor  =  Decimal.valueOf(currentCW.variable.WPFactor.price.split('>')[0]);
            BINP  =  (((FR + BR + WR) * OBIF * WPFactor * IPFactor)*(currentCW.variable.GrossProfit  ==  null || currentCW.variable.GrossProfit  ==  0 ? RT : currentCW.variable.GrossProfit) * (Decimal.valueOf(currentCW.variable.IPFactor.price.split('>')[1])/12))/1000;
            System.debug('currentCW.Premium::'+BINP+'::'+(RQF > 0 ? RQF : (1+RQF)));
            currentCW.Premium  =  BINP*(RQF > 0 ? RQF : (1+RQF));
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setBurglaryPricings(){
        Decimal BSI,  BSR,  TASR,  SR,  GR,  ER,  AR,  WR,  PCR,  MASR,  CBR,  TPDSI,  CSI,  CBF,  LF,  IA,  bdedFactor,  bDeductible,  sdedFactor,  cdedFactor,  cDeductible,  RQF,  NBP,  NCP,  NVP,  TRP,  TSI,  dedNBA;
        currentCW.pricingMap  =  null;
        String selectedBCF;
        try{
            TPDSI  =  0;
            BSI  =  0;
            for(AssetWrapperList awl:awlList){
                for(AssetWrapper AW : awl.assetWrapperList){
                    if(AW.IsSelected  ==  True){
                        TPDSI  =  TPDSI + AW.Asset.VG_Total_Property_Damage_SI__c;
                        BSI  =  BSI + AW.Asset.VG_Building_SI__c;
                    }
                }
            }
            TSI  =  TPDSI;
            CSI  =  TPDSI - BSI;
            BSR  =  Math.Max(0.02,  Math.Min(0.0566,  1.953566 * getExp((BSI + 0.000009), -0.23737)));
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Occupancy Rate'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            CBR  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'Location factor'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedMunicipality is: '+selectedMunicipality+', s.getLabel() is: '+s.getLabel() );
                        if(s.getLabel()  ==  selectedMunicipality){
                            price.price  =  s.getValue().split('>')[0];
                            LF  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'Intruder Alarm'){
                    IA  =  Decimal.valueOf(price.price.split('>')[0]);
                }
                if(price.factorName  ==  'Tobacco & Spirits'){
                    if(currentCW.variable.TAS > 120000){
                        TASR  =  4.77 * currentCW.variable.TAS;
                    }else{
                        TASR  =  14.31 * currentCW.variable.TAS;
                    }
                }
                if(price.factorName  ==  'Silver'){
                    if(currentCW.variable.Silver > 120000){
                        SR  =  3.18 * currentCW.variable.Silver;
                    }else{
                        SR  =  8.7 * currentCW.variable.Silver;
                    }
                }
                if(price.factorName  ==  'Gold'){
                    if(currentCW.variable.Gold > 120000){
                        GR  =  17.48 * currentCW.variable.Gold;
                    }else{
                        GR  =  17.48 * currentCW.variable.Gold;
                    }
                }
                if(price.factorName  ==  'Electronics'){
                    if(currentCW.variable.Electronics > 120000){
                        ER  =  3.97 * currentCW.variable.Electronics;
                    }else{
                        ER  =  11.36 * currentCW.variable.Electronics;
                    }
                }
                if(price.factorName  ==  'Antiques'){
                    if(currentCW.variable.Antiques > 120000){
                        AR  =  6.36 * currentCW.variable.Antiques;
                    }else{
                        AR  =  19.23 * currentCW.variable.Antiques;
                    }
                }
                if(price.factorName  ==  'Weapons'){
                    if(currentCW.variable.Weapons > 120000){
                        WR  =  5.80 * currentCW.variable.Weapons;
                    }else{
                        WR  =  17.48 * currentCW.variable.Weapons;
                    }
                }
                if(price.factorName  ==  'Personal Computers'){
                    if(currentCW.variable.PC > 120000){
                        PCR  =  7.95 * currentCW.variable.PC;
                    }else{
                        PCR  =  21.86 * currentCW.variable.PC;
                    }
                }
                if(price.factorName  ==  'Money & Stamps'){
                    MASR  =  3.61;
                }
                if(price.factorName  ==  'Risk Quality'){
                    RQF  =  Decimal.valueOf(price.price.split('>')[0]);
                }
            }
            MASR  =  3.61 * currentCW.variable.MAS;
            //CBF  =  Math.Min(0.267,  75.59813 * getExp((CSI - 0.000073), -0.430253));
            try{
                CBF  =  Math.Max(0,  Math.Min(1,  75.59813 * getExp((CSI - 7000 - 5), -0.430253)));
            }catch(Exception ex){
                CBF  =  0.267;
            }
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            bdeductible  =  dedNBA;
            if(bdeductible < 0.2){
                bdedFactor  =  1 + 0.5 * (0.2 - bdeductible)/0.2;
            }else{
                bdedFactor  =  1.529688 * getExp((bdeductible + 1.478801), -0.82046);
            }
            if(currentCW.variable.PLdeductibleAmount > 0){
                dedNBA  =  currentCW.variable.PLdeductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PLPBA;
            }
            cdeductible  =  dedNBA;
            if(cdeductible < 0.2){
                sdedFactor  =  1 + 0.4 * (0.2 - cdeductible)/0.2;
                cdedFactor  =  sdedFactor;
            }else{
                sdedFactor  =  1.189786 * getExp((cdeductible + 1.340523), -0.402139);
                cdedFactor  =  2.00712 * getExp((cdeductible + 2.146061), -0.817017);
            }
            NBP   =  (BSR * LF * IA * bdedFactor) * BSI * (1+RQF)/1000 ;
            NCP  =  (CBR * CBF * LF * IA * cdedFactor) * CSI *  (1+RQF)/1000;
            NVP  =  ((TASR + SR + GR + ER + AR + WR + PCR + MASR)/1000) * (LF * IA * sdedFactor) *  (1+RQF);
            TRP  =  NBP + NCP + NVP;
            currentCW.Premium  =  TRP;
            currentCW.otherRiskFactors  =  (BSR * LF * IA * bdedFactor) + (CBR * LF * IA * cdedFactor * CBF);
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setWaterPricings(){
        Decimal WCBR,  WCSI,  WCR,  BSI,  BR,  YBR,  deductible,  PLdeductible,  dedNBA,  wDedFactor,  wcDedFactor,  RQF,  WBP,  WCP,  TRP,  TPDSI,  TSI,  year;
        String selectedBCF;
        currentCW.pricingMap  =  null;
        try{
            TPDSI  =  0;
            BSI  =  0;
            for(AssetWrapperList awl:awlList){
                for(AssetWrapper AW : awl.assetWrapperList){
                    if(AW.IsSelected  ==  True){
                        TPDSI  =  TPDSI + AW.Asset.VG_Total_Property_Damage_SI__c;
                        BSI  =  BSI + AW.Asset.VG_Building_SI__c;
                    }
                }
            }
            TSI  =  TPDSI;
            WCSI  =  TPDSI - BSI;
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Water Contents Base Rate'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            WCBR  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'Risk Quality'){
                    RQF  =  Decimal.valueOf(price.price.split('>')[0]);
                }
            }
            if(currentCW.variable.Year > 2004){
                YBR  =  1;
            }else if(currentCW.variable.Year > 1978){
                YBR  =  1.5;
            }else if(currentCW.variable.Year > 1945){
                YBR  =  2.5;
            }else if(currentCW.variable.Year > 1899){
                YBR  =  4.6;
            }else{
                YBR  =  999;
            }
            try{
                WCR  =  Math.Max(0.025,  Math.Min(0.1698,  39.316636* getExp((WCSI - 0.000129), -0.416169)));
            }catch(Exception ex){
                WCR  =  0.1698;
            }
            BR  =  Math.Max(0.03,  Math.Min(0.0853,  (4.894232 * getExp((BSI + 0.000009), -0.270933))));
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                wDedFactor  =  1 + ((0.44 * (0.2 - deductible))/0.2);
            }else{
                wDedFactor  =  4.622801 * getExp((deductible + 3.627758), - 1.140598);
            }
            if(currentCW.variable.PLdeductibleAmount > 0){
                dedNBA  =  currentCW.variable.PLdeductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PLPBA;
            }
            PLdeductible  =  dedNBA;
            if(PLdeductible < 0.2){
                wcDedFactor  =  1 + ((0.44 * (0.2 - PLdeductible))/0.2);
            }else{
                wcDedFactor  =  2.006952 * getExp((PLdeductible + 2.145959), - 0.816959);
            }
            WBP  =  ((BR * YBR * wDedFactor)  * BSI * (1 + RQF))/1000;
            WCP  =  ((WCR * wcDedFactor * WCBR) * WCSI * (1 + RQF))/1000;
            TRP  =  WBP + WCP;
            currentCW.Premium  =  TRP;
            currentCW.otherRiskFactors  =  (BR * YBR * wDedFactor) + (WCBR * WCR * wcDedFactor);
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setELPricings(){
        Decimal ODOPP,  ODTPP,  deductible,  dedFactor,  SCR,  NELP,  dedNBA;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Storage Capacity'){
                    SCR  =  Decimal.valueOf(price.price.split('>')[0]);
                }
            }
            ODOPP  =  Math.Max(490,  49.689992* getExp((currentCW.variable.ODOP - 0.000314), 0.172924));
            ODTPP  =  Math.Max(((0.00008 * currentCW.variable.ODTP) + 586.44), (2.3202 * getExp(currentCW.variable.ODTP,  0.409)));
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  1 + ((0.4 * (0.2 - deductible))/0.2);
            }else{
                dedFactor  =  0.871568 * getExp((deductible + 0.429999),- 0.297513);
            }
            NELP  =  (ODOPP + ODTPP) * dedFactor * SCR * currentCW.variable.Consumption;
            currentCW.Premium  =  NELP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setCisternPricings(){
        Decimal CFR,  CNP,  deductible,  dedFactor,  dedNBA;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Coverage Factor'){
                    CFR  =  Decimal.valueOf(price.price.split('>')[0]);
                }
            }
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  1 + ((0.4 * (0.2 - deductible))/0.2);
            }else{
                dedFactor  =  1.049618 * getExp((deductible + 0.952024), -0.342183);
            }
            CNP  =  (currentCW.variable.SI * CFR * dedFactor)/1000;
            currentCW.Premium  =  CNP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setLORPricings(){
        Decimal FR,  BR,  WR,  AR,  MBR,  IPFactor,  LORP,  deductible,  dedFactor,  dedNBA;
        currentCW.pricingMap  =  null;
        try{
            FR  =  coverages.get('Fire').Premium;
            BR  =  coverages.get('Burglary').Premium;
            WR  =  coverages.get('Water').Premium;
            AR  =  coverages.get('All Risk').Premium;
            MBR  =  coverages.get('Machinery Breakdown').Premium;
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  1 + ((0.3 * (0.2 - deductible))/0.2);
            }else{
                dedFactor  =  1.596199 * getExp((deductible + 3.56409), -0.35279);
            }
            IPFactor  =  Decimal.valueOf(currentCW.variable.IPFactor.price.split('>')[0]);
            LORP  =  (FR + BR + WR + AR + MBR) * 0.15 * dedFactor * IPFactor;
            currentCW.Premium  =  LORP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
        //System.debug('19.8.2019::'+currentCW);
        //System.debug('19.8.2019::'+currentCW);
        //System.debug('19.8.2019::'+ currentCW.variable.IPFactor.price.split('>')[1]);
    }
    
    Public void setECPricings(){
        Decimal MBR,  FBWR,  IPFactor,  FBWP,  MP,  ECP,  deductible,  dedFactor,  dedNBA;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Occupancy Rate'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            MBR  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName  ==  'FWB Occupancy Rate'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            FBWR  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
            }
            IPFactor  =  Decimal.valueOf(currentCW.variable.IPFactor.price.split('>')[0]);
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  1 + ((0.36 * (0.2 - deductible))/0.2);
            }else{
                dedFactor  =  1.135621 * getExp((deductible + 1.108493), -0.473005);
            }
            FBWP  =  1.2*((FBWR * currentCW.variable.SI * IPFactor * dedFactor)/1000);
            MP  =  0.1* ((MBR * currentCW.variable.FVSI * IPFactor * dedFactor)/1000);
            ECP  =  ((FBWP + MP) * Decimal.valueOf(currentCW.variable.IPFactor.price.split('>')[1]))/12;
            currentCW.Premium  =  ECP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setFARPricings(){
        Decimal FBR,  FFP,  FP,  deductible,  dedFactor,  dedNBA;
        currentCW.pricingMap  =  null;
        try{
            FBR  =  Math.Max(2,  Math.Min(44.80315,  141056 * getExp((currentCW.variable.SI + 0.000319), -0.814174)));
            FFP  =  Math.Max(47,  Math.Min(5000,  0.477549 * getExp((currentCW.variable.SI + 0.223286), 0.665578)));
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  1 + ((0.24 * (0.2 - deductible))/0.2);
            }else{
                dedFactor  =  0.906028 * getExp((deductible + 0.566745), -0.371557);
            }
            FP  =  ((currentCW.variable.SI * FBR/1000) + FFP)*dedFactor;
            currentCW.Premium  =  FP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setRobberyPricings(){
        Decimal RBR,  RP,  deductible,  dedFactor,  dedNBA;
        currentCW.pricingMap  =  null;
        try{
            RBR  =  1.445;
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  1 + ((0.34 * (0.2 - deductible))/0.2);
            }else{
                dedFactor  =  1.466348 * getExp((deductible + 2.047137), -0.472761);
            }
            RP  =  ((currentCW.variable.SI * RBR) / 1000) * dedFactor;
            currentCW.Premium  =  RP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setSOPricings(){
        Decimal NBOP,  RP,  deductible,  dedFactor,  dedNBA,  TBP;
        currentCW.pricingMap  =  null;
        try{
            TBP  =  0;
            for(SOWrapper SOW : soWrapperList){
                if(SOW.selectedLocation  ==  'Norden (Nordics)'){
                    SOW.locFactor  =  1.0;
                }else if(SOW.selectedLocation  ==  'Europa (Europé)'){
                    SOW.locFactor  =  1.5;
                }else if(SOW.selectedLocation  ==  'Hela Världen (WW)'){
                    SOW.locFactor  =  2.0;
                }
                if(SOW.selectedObject  ==  'Annat'){
                    SOW.SOBaseRate  =  SOW.UWBaseRate;
                }else{
                    if(SOW.selectedObject  ==  'Bärbar Dator' || SOW.selectedObject  ==  'Kamera,  TV,  Video inkl utrust' || SOW.selectedObject  ==  'Kommunikationsradio'){
                        SOW.SOBaseRate  =  9.0;
                    }else if(SOW.selectedObject  ==  'Piano,  Flygel,  Orgel' || SOW.selectedObject  ==  'Övriga musikinstrument'){
                        SOW.SOBaseRate  =  6.0;
                    }else if(SOW.selectedObject  ==  'Elinstrument inkl högtalare,  förstärkare etc'){
                        SOW.SOBaseRate  =  15.0;
                    }
                }
                SOW.basePremium  =  (SOW.SOBaseRate * SOW.SI /1000) * SOW.locFactor;
                TBP  =  TBP + SOW.basePremium;
            }
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  2 + (2 * (0.2 - deductible )/0.2);
            }else if(deductible < 0.5){
                dedFactor  =  0.8 + (1.2 * (0.5 - deductible )/0.3);
            }else{
                dedFactor  =  1.672473 * getExp((deductible + 2.173764), - 0.749829);
            }
            NBOP  =  TBP * dedFactor;
            currentCW.Premium  =  NBOP;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setEpidemicPricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  RQF,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName =='SNI Turnover Adjustment Factor'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            SNI  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
            }
            RQF  =  Decimal.valueOf(currentCW.variable.RQFactor.price.split('>')[0]);
            RAT  =  annualTurnover * SNI;
            NBPR  =  Math.min(0.7225,(17.589835)*getExp(RAT+0.000002,  -0.216532));
            If(currentCW.variable.dedOrWP  ==  'Deductible'){
                if(currentCW.variable.deductibleAmount > 0){
                    dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
                }else{
                    dedNBA  =  currentCW.variable.PBA;
                }
                deductible  =  dedNBA;
                if(deductible < 0.5){
                    dedFactor  =  1 + (0.2*(0.5 - deductible)/0.3);
                }else{
                    dedFactor  =  (0.779755) * getExp((deductible - 0.249796), -0.179559);
                }
            }else{
                WPFactor  =  Decimal.valueOf(currentCW.variable.WPFactor.price.split('>')[0]);
            }
            IPFactor  =  Decimal.valueOf(currentCW.variable.IPFactor.price.split('>')[0]);
            SIFactor  =  Math.max(0.4,  0.0039 * getExp((currentCW.variable.SI + 0), 0.4224));
            If(currentCW.variable.dedOrWP  ==  'Deductible'){
                TAF  =  SIFactor * IPFactor * dedFactor;
            }else{
                TAF  =  SIFactor * IPFactor * WPFactor;
            }
            System.debug('TAF: '+TAF);
            PFP  =  RAT  ==  0 ? 145 : Math.Max(145,  (0.00000003 * getExp((RAT + 0),- 1.5102)));
            NBP  =  (((RAT / 1000)*NBPR)+PFP)*TAF;
            FANP  =  (NBP * Decimal.valueOf(currentCW.variable.IPFactor.price.split('>')[1])) / 12;
            currentCW.Premium  =  FANP * (RQF > 0 ? RQF : (1+RQF));
            currentCW.SI  =  currentCW.variable.SI;
            currentCW.Deductible  =  dedNBA;
            System.debug('FANP: '+FANP);
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setGLPLPricings(){
        Decimal GLPLSNI,  PLSNI,  GLPLRAT,  PLRAT,  GLPLNBPR,  PLNBPR,  GLPLdeductible,  PLdeductible,  ATSWW,  ATSWWFactor,  ATSNordicsFactor,  ATSEUFactor,  WP,  GLPLdedNBA,  PLdedNBA,  GLPLPBAFactor,  PLPBAFactor,  GLPLSIFactor,  PLSIFactor,  GLPLTAF,  PLTAF,  GLPLPFP,  PLPFP,  GLPLNBP,  PLNBP,  TNBP,  RQFactor,  FANP;
        currentCW.pricingMap  =  null;
        try{
            ATSWW  =  annualTurnover - (currentCW.variable.ATSNordics + currentCW.variable.ATSEU);
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName =='SNI Turnover Adjustment Factor GL/PL'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7));
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            GLPLSNI  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName =='SNI Turnover Adjustment Factor PL'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7));
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            PLSNI  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
                if(price.factorName =='Annual Turnover Split Noridcs Factor'){
                    for(SelectOption s : price.factors){
                        price.price  =  s.getValue().split('>')[0];
                        ATSNordicsFactor  =  Decimal.valueOf(price.price);
                        Break;
                    }
                }
                if(price.factorName =='Annual Turnover Split EU Factor'){
                    for(SelectOption s : price.factors){
                        price.price  =  s.getValue().split('>')[0];
                        ATSEUFactor  =  Decimal.valueOf(price.price);
                        Break;
                    }
                }
                if(price.factorName =='Annual Turnover Split Worldwide Factor'){
                    for(SelectOption s : price.factors){
                        price.price  =  s.getValue().split('>')[0];
                        ATSWWFactor  =  Decimal.valueOf(price.price);
                        Break;
                    }
                }
            }
            GLPLRAT  =  annualTurnover * GLPLSNI;
            GLPLNBPR  =  Math.Min(1.445, 44.800363 * getExp((GLPLRAT -2356),- 0.295351));
            GLPLPFP  =  Math.Min(10000,  Math.Max(61,  0.137022 * getExp((GLPLRAT -0.000025), 0.569864)));
            if(currentCW.variable.deductibleAmount > 0){
                GLPLdedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                GLPLdedNBA  =  currentCW.variable.PBA;
            }
            GLPLdeductible  =  GLPLdedNBA;
            GLPLSIFactor  =  0.003577 * getExp((currentCW.variable.SI + 0), 0.349504);
            IF(GLPLdeductible <= 0.2){
                GLPLPBAFactor  =  1 + 0.6*((0.2 - GLPLdeductible)/0.2); 
            }else{
                GLPLPBAFactor  =  0.841674 * getExp((GLPLdeductible + 0.388609), - 0.325217);
            }
            GLPLTAF  =  GLPLSIFactor * GLPLPBAFactor;
            GLPLNBP  =  ((GLPLRAT * GLPLNBPR / 1000) + GLPLPFP) * GLPLTAF;
            
            ATSNordicsFactor  =  1;
            ATSEUFactor  =  1.5;
            ATSWWFactor  =  1.5;
            
            WP  =  ((ATSNordicsFactor * currentCW.variable.ATSNordics) + (ATSEUFactor * currentCW.variable.ATSEU) + (ATSWWFactor * ATSWW))/(currentCW.variable.ATSNordics + currentCW.variable.ATSEU + ATSWW);
            PLRAT  =  annualTurnover * PLSNI * WP;
            PLNBPR  =  Math.Min(0.3324,  106.585536 * getExp((PLRAT + 0), - 0.368057));
            PLPFP  =  Math.Min(10000,  Math.Max(72,  0.177738 * getExp((PLRAT - 0.002214), 0.543096)));
            if(currentCW.variable.PLdeductibleAmount > 0){
                PLdedNBA  =  currentCW.variable.PLdeductibleAmount / PBARate;
            }else{
                PLdedNBA  =  currentCW.variable.PLPBA;
            }
            PLdeductible  =  PLdedNBA;
            PLSIFactor  =  0.003577 * getExp((currentCW.variable.PLSI + 0), 0.349504);
            IF(PLdeductible <= 0.2){
                PLPBAFactor  =  1 + 0.6*((0.2 - PLdeductible)/0.2); 
            }else{
                PLPBAFactor  =  0.841674 * getExp((PLdeductible + 0.388609), - 0.325217);
            }
            PLTAF  =  PLSIFactor * PLPBAFactor;
            System.debug('PLRAT: '+PLRAT +', GLPLNBPR: '+GLPLNBPR +', PLPFP: '+PLPFP+', PLTAF: '+PLTAF);
            PLNBP  =  ((PLRAT * PLNBPR / 1000) + PLPFP) * PLTAF;
            TNBP  =  GLPLNBP + PLNBP;
            RQFactor  =  Decimal.valueOf(currentCW.variable.RQFactor.price.split('>')[0]);
            FANP  =  TNBP * (1 + RQFactor);
            currentCW.Premium  =  FANP;
            currentCW.SI  =  currentCW.variable.SI;
            currentCW.Deductible  =  GLPLdeductible;
            currentCW.PLDeductible  =  PLdeductible;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setCrimePricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Crime SNI Turnover Adjustment Factor'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            SNI  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
            }
            RAT  =  annualTurnover * SNI;
            NBPR  =  Math.min(1.2138,  2.719768 * getExp((RAT + 0.000005), - 0.101158));
            PFP  =  Math.min(20000,  Math.Max(250,  0.050043 * getExp((RAT - 0.000025), 0.640892)));
            NBP  =  ((RAT * NBPR)/1000)+PFP;
            NBP  =  NBP < 500 ? 500 : NBP;
            SIFactor  =  0.03577 * getExp((currentCW.variable.SI + 0.000023), 0.253814);
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.5){
                dedFactor  =  1 + (0.2*(0.5 - deductible)/0.3);
            }else{
                dedFactor  =   (4.189789) * getExp((deductible + 4.402343), -0.9012);
            }
            TAF  =  SIFactor * dedFactor;
            FANP  =  (NBP * TAF);
            currentCW.Premium  =  FANP;
            currentCW.SI  =  currentCW.variable.SI;
            currentCW.Deductible  =  dedNBA;
            System.debug('FANP: '+FANP);
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setCrisisPricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'Crisis SNI Turnover Adjustment Factor'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            SNI  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
            }
            RAT  =  annualTurnover * SNI;
            NBPR  =  Math.Min(0.1806,  1.826489 * getExp((RAT - 0.000005), - 0.17726));
            PFP  =  Math.Min(5000,  Math.Max(61,  0.002395 * getExp((RAT + 0.000061), 0.719296)));
            NBP  =  ((NBPR *RAT)/1000)+ PFP;
            NBP  =  NBP < 150 ? 150 : NBP;
            FANP  =  NBP;
            currentCW.Premium  =  FANP;
            currentCW.SI  =  0;
            currentCW.Deductible  =  0;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setPAPricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'PA SNI Turnover Adjustment Factor'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            SNI  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
            }
            RAT  =  annualTurnover * SNI;
            NBPR  =  Math.Min(0.1806,  1.082206 * getExp((RAT - 0.000013), - 0.143137));
            PFP  =  Math.Min(400,  Math.Max(54.0,  0.044833 * getExp((RAT + 0.000037), 0.529966)));
            NBP  =  ((NBPR *RAT)/1000)+ PFP;
            NBP  =  NBP < 150 ? 150 : NBP;
            FANP  =  NBP;
            currentCW.Premium  =  FANP;
            currentCW.SI  =  0;
            currentCW.Deductible  =  0;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setAssaultPricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'As SNI Turnover Adjustment Factor'){
                    for(SelectOption s : price.factors){
                        System.debug('selectedOccupancy is: '+selectedOccupancy.right(7)+', s.getLabel() is: '+s.getLabel().right(7) );
                        if(s.getLabel().right(7)  ==  selectedOccupancy.right(7)){
                            price.price  =  s.getValue().split('>')[0];
                            SNI  =  Decimal.valueOf(price.price);
                            Break;
                        }
                    }
                }
            }
            RAT  =  annualTurnover * SNI;
            NBPR  =  Math.Min(0.1806,  1.082206 * getExp((RAT - 0.000013), - 0.143137));
            PFP  =  Math.Min(400,  Math.Max(54,  0.044833 * getExp((RAT + 0.000037), 0.529966)));
            NBP  =  ((NBPR *RAT)/1000)+ PFP;
            NBP  =  NBP < 150 ? 150 : NBP;
            FANP  =  NBP;
            currentCW.Premium  =  FANP;
            currentCW.SI  =  0;
            currentCW.Deductible  =  0;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setToolsPricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                
            }
            NBP  =  27.090 * (currentCW.variable.SI/1000) * currentCW.variable.noOfVehicles;
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  1 + (0.3*(0.2 - deductible)/0.1);
            }else{
                dedFactor  =   0.875616 * getExp((deductible + 0.446443), - 0.304461);
            }
            FANP  =  (NBP * dedFactor);
            currentCW.Premium  =  FANP;
            currentCW.SI  =  currentCW.variable.SI;
            currentCW.Deductible  =  dedNBA;
            System.debug('FANP: '+FANP);
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setLiftPricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                
            }
            NBP  =  Math.Min(5000, Math.Max(1750,  80.569262 * getExp((currentCW.variable.SI + 0.001026), 0.319499)));
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  1 + (0.2*(0.2 - deductible)/0.1);
            }else{
                dedFactor  =   0.875616 * getExp((deductible + 0.446443), - 0.304461);
            }
            FANP  =  (NBP * dedFactor);
            currentCW.Premium  =  FANP;
            currentCW.SI  =  currentCW.variable.SI;
            currentCW.Deductible  =  dedNBA;
            System.debug('FANP: '+FANP);
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setForkliftPricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                
            }
            NBP  =  Math.Min(3500, Math.Max(1000,  51.619831 * getExp((currentCW.variable.SI + 0.009483), 0.301619)));
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 0.2){
                dedFactor  =  1 + (0.2*(0.2 - deductible)/0.1);
            }else{
                dedFactor  =   0.875616 * getExp((deductible + 0.446443), - 0.304461);
            }
            FANP  =  (NBP * dedFactor);
            currentCW.Premium  =  FANP;
            currentCW.SI  =  currentCW.variable.SI;
            currentCW.Deductible  =  dedNBA;
            System.debug('FANP: '+FANP);
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setBSPricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        try{
            for(PricingWrapper price : currentCW.factors){
                
            }
            NBP  =  36.1250 * currentCW.variable.SI/1000;
            if(currentCW.variable.deductibleAmount > 0){
                dedNBA  =  currentCW.variable.deductibleAmount / PBARate;
            }else{
                dedNBA  =  currentCW.variable.PBA;
            }
            deductible  =  dedNBA;
            if(deductible < 2000/PBARate){
                dedFactor  =  1 + (0.1*((2000/PBARate) - deductible))/0.05;
            }else{ 
                dedFactor  =   0.695512 * getExp((deductible + 0.393834), - 0.439589);
            }
            FANP  =  (NBP * dedFactor);
            currentCW.Premium  =  FANP;
            currentCW.SI  =  currentCW.variable.SI;
            currentCW.Deductible  =  dedNBA;
            System.debug('FANP: '+FANP);
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    public void setPIPricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        try{
            currentCW.Premium  =  currentCW.variable.PBA;
            currentCW.SI  =  currentCW.variable.SI;
            currentCW.Deductible  =  currentCW.variable.deductibleAmount;
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
    }
    
    Public void setBIHPricings(){
        Decimal SNI,  RAT,  NBPR,  deductible,  dedNBA,  dedFactor,  IPFactor,  WPFactor,  SIFactor,  TAF,  PFP,  NBP,  FANP;
        currentCW.pricingMap  =  null;
        Map<Integer,  Decimal> ageMap  =  new Map<Integer,  Decimal>();
        Policy__c pol  =  [Select Id,  VG_Inception_Date__c from Policy__c where Id =: policyId];
        try{
            for(PricingWrapper price : currentCW.factors){
                if(price.factorName  ==  'BI Health Age Rate'){
                    for(SelectOption s : price.factors){
                        if(s.getValue()  !=  '0'){
                            System.debug(s.getValue());
                            price.price  =  s.getValue().split('>')[0];
                            String age  =  s.getValue().split('>')[1];
                            ageMap.put(Integer.valueOf(age), Decimal.valueOf(price.price));
                        }
                    }
                }
            }
            NBP  =  0;
            for(BIHWrapper BH : currentCW.variable.BIHList){
                if(BH.Individual  !=  null && BH.Individual  !=  ''){
                    if(pol.VG_Inception_Date__c  !=  null){
                        System.Debug('BH.DOB.daysBetween(pol.VG_Inception_Date__c): ' + BH.DOB.daysBetween(pol.VG_Inception_Date__c));
                        Integer days  =  BH.DOB.daysBetween(pol.VG_Inception_Date__c);
                        BH.Age  =  Integer.valueOf(days/365);
                    }else{
                        BH.Age  =  0;
                    }
                    if(ageMap.get(BH.Age)  ==  null){
                        BH.Premium  =  0;
                    }else{
                        BH.Premium  =  (ageMap.get(BH.Age) * BH.SI)/1000;
                    }
                    NBP  =  NBP + BH.Premium;
                }
            }
            IPFactor  =  1;
            WPFactor  =  1;
            TAF  =  IPFactor * WPFactor;
            FANP  =  (NBP * TAF);
            currentCW.Premium  =  FANP;
            currentCW.SI  =  currentCW.variable.SI;
            currentCW.Deductible  =  dedNBA;
            System.debug('FANP: '+FANP);
        }Catch(Exception ex){
            System.debug('Exception is: '+ex.getMessage());
        }
        for(PricingWrapper price:currentCW.factors){
            price.factors  =  null;
        }
        
    }
    
    public void setPricingVariables(){
        PricingWrapper pWrapper;
        List<SelectOption> tempFactorsList;
        String currenctCoverageselection  =  'CC - '+currentCW.selectedCoverage;
        addCoverageMode  =  currentCW.selectedCoverage;
        List<VG_Pricing__c> priceList;
        if(currenctCoverageselection  ==  'CC - Liability GL/PL'){
            priceList  =  [Select Id,  Name,  VG_Product__c,  VG_Category__c,  VG_Rating_Factor__c,  VG_Rate__c from VG_Pricing__c where (VG_Product__c =: currenctCoverageselection OR VG_Product__c  =  'CC - Liability PL') and VG_Level__c  =  'Risk Rating' and VG_Rating_Factor__c  !=  null and VG_Record_Type__c  =  'Bridge' ORDER BY VG_Order__c];
            System.debug('priceList1::'+priceList);
        }else{
            priceList  =  [Select Id,  Name,  VG_Product__c,  VG_Category__c,  VG_Rating_Factor__c,  VG_Rate__c from VG_Pricing__c where VG_Product__c =: currenctCoverageselection and VG_Level__c  =  'Risk Rating' and VG_Rating_Factor__c  !=  null and VG_Record_Type__c  =  'Bridge' ORDER BY VG_Order__c];
            System.debug('priceList::'+priceList);
        }
        pricingMap  =  new Map<String,  PricingWrapper>();
        for(VG_Pricing__c price: priceList){
            if(pricingMap.get(price.VG_Category__c)  ==  null){
                pWrapper  =  new PricingWrapper();
                pWrapper.factors.add(new SelectOption('0','--Select--'));
                System.debug('price:::'+price);
            }else{
                pWrapper  =  pricingMap.get(price.VG_Category__c);
                System.debug('price:::'+price);
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
            pricingMap.put(pWrapper.factorName,  pWrapper);
        }
        currentCW.pricingMap  =  pricingMap;
        currentCW.factors.addAll(pricingMap.values());      
    }
    
    public boolean getCoverageIsEmpty() {
        return coverages.IsEmpty();
    }
    
    public Decimal getExp(decimal base,  decimal power){
        Decimal expValue ;
        Double expDoubleValue;
        System.debug('(Math.exp(power*Math.log(base))): '+(Math.exp(power*Math.log(base))));
        /*if(power > 0){
expDoubleValue  =  ((Math.exp(power*Math.log(base))));
}else{
expDoubleValue  =  (1/(Math.exp(power*Math.log(base))));
}*/
        expDoubleValue  =  (Math.exp(power*Math.log(base)));
        System.debug('Exponenet is: '+expDoubleValue);
        return expDoubleValue;
    }
    
    public PageReference gotostep2(){
        //return new PageReference('/apex/VG_CC_Nordics_Step2?PolicyId='+policyId);
        PageReference reference = new PageReference('/apex/VG_CC_Nordics_Step2?PolicyId='+policyId);
        reference.setRedirect(false);
        return reference;
    }
    
    public PageReference gotostep3(){
        /*If((selectedOccupancy == null || selectedOccupancy=='0' || selectedOccupancy=='') || annualTurnover == null){
ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select Occupancy code and give value for Annual Turnover.'));    
return null;
}*/
        PageReference reference = new PageReference('/apex/VG_CC_Nordics_Step3?PolicyId='+policyId);
        reference.setRedirect(false);
        return reference;       
    }
    
    public PageReference gotostep4(){
        if(!existingEndorsements1.IsEmpty()){
            existingEndorsements1.clear();
        }
        List<String> coveragelist = new List<String>();
        for(CoverageWrapper CW : coverages.values()){                                                                                                                                                                               
            If(CW.selectedCoverage=='Fire' || CW.selectedCoverage=='Burglary' || CW.selectedCoverage=='Water' || CW.selectedCoverage=='All Risk' || CW.selectedCoverage=='Business Interruption' || CW.selectedCoverage=='Machinery Breakdown' || CW.selectedCoverage=='Loss of Rent'){
                coveragelist.add('All Risk');
            }else if(CW.selectedCoverage=='Crime'){
                coveragelist.add('CC_Crime');
            }else{
                coveragelist.add(CW.selectedCoverage);
            }
            System.debug('currenctCoverageselection1::'+coveragelist);
        }
        
        ElList1=[select id, Name, Endorsement_Title__c, Type__c, Text__c, VG_Product__c from Endorsement_Library__c where Type__c=:'Sub-limits' AND VG_Product__c =: coveragelist AND RecordType.Name =: 'Bridge' ORDER By Name ASC];        
        LibraryWrapperList1.clear();       
        for(Endorsement_Library__c EL1 : ElList1){            
            LW1  =  new LibraryWrapper();
            LW1.EL  =  EL1;            
            LW1.isSelected  =  False;                    
            LibraryWrapperList1.add(LW1); 
        }
        //return new PageReference('/apex/VG_CC_Nordics_Step4?PolicyId='+policyId);
        PageReference reference = new PageReference('/apex/VG_CC_Nordics_Step4?PolicyId='+policyId);
        reference.setRedirect(false);
        return reference;
    }
    
    public PageReference gotostep4b(){
        Set<ID> elid = new Set<ID>();
        selectedCoveragesList  =  new List<SelectOption>();
        for(CoverageWrapper cv : coverages.values()){
            selectedCoveragesList.add(new SelectOption(cv.SelectedCoverage,  cv.SelectedCoverage)); 
        }
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
                if(tmpPSEMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Product__c =  tmpPSEMap.get(LW.EL.Id).VG_Product__c; 
                }
                System.debug('Type::'+tempEndsmt.VG_Type__c+'::'+LW.EL.Type__c);
                tempEndsmt.VG_IsTempDelete__c  =  False;
                tempEndsmt.VG_IsTemp__c  =  True;
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
        //return new PageReference('/apex/VG_CC_Nordics_Step4b?PolicyId='+policyId);
        PageReference reference = new PageReference('/apex/VG_CC_Nordics_Step4b?PolicyId='+policyId);
        reference.setRedirect(false);
        return reference;
    }
    
    public PageReference gotostep5(){
        if(!existingEndorsements.IsEmpty()){
            existingEndorsements.clear();
        }
        List<String> coveragelist = new List<String>();
        for(CoverageWrapper CW : coverages.values()){
            If(CW.selectedCoverage=='Fire' || CW.selectedCoverage=='Burglary' || CW.selectedCoverage=='Water' || CW.selectedCoverage=='All Risk' || CW.selectedCoverage=='Business Interruption' || CW.selectedCoverage=='Escaping Liquid' || CW.selectedCoverage=='Cistern' || CW.selectedCoverage=='Freeze & Refrigerator' || CW.selectedCoverage=='Machinery BI'|| CW.selectedCoverage=='Loss of Rent' || CW.selectedCoverage=='Epidemic Disease' || CW.selectedCoverage=='Crisis' || CW.selectedCoverage=='Assault'|| CW.selectedCoverage=='Tools' || CW.selectedCoverage=='Lift' || CW.selectedCoverage=='Forklift'|| CW.selectedCoverage=='Business Sample' || CW.selectedCoverage=='Machinery Breakdown' ){
                coveragelist.add('All Risk');
            }else if(CW.selectedCoverage=='Crime'){
                coveragelist.add('CC_Crime');
            }else{
                coveragelist.add(CW.selectedCoverage);
            }
            System.debug('currenctCoverageselection1::'+coveragelist);
        }
        
        ElList=[select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where  Type__c=:'Endorsements' AND VG_Product__c =: coveragelist AND  RecordType.Name =: 'Bridge' ORDER By Name ASC];
        LibraryWrapperList.clear();
        for(Endorsement_Library__c EL : ElList){            
            LW  =  new LibraryWrapper();
            LW.EL  =  EL;            
            LW.isSelected  =  False;                    
            LibraryWrapperList.add(LW); 
        }
        //return new PageReference('/apex/VG_CC_Nordics_Step5?PolicyId='+policyId);
        PageReference reference = new PageReference('/apex/VG_CC_Nordics_Step5?PolicyId='+policyId);
        reference.setRedirect(false);
        return reference;
    }
    
    public PageReference gotostep5b(){
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
                tempEndsmt.VG_Endorsement_Number__c  =  LW.EL.Name;
                tempEndsmt.VG_Type__c = LW.EL.Type__c;
                if(tmpPSEMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Product__c =  tmpPSEMap.get(LW.EL.Id).VG_Product__c; 
                }
                System.debug('Type::'+tempEndsmt.VG_Type__c+'::'+LW.EL.Type__c);
                tempEndsmt.VG_IsTempDelete__c  =  False;
                tempEndsmt.VG_IsTemp__c  =  True;
                existingEndorsements.add(tempEndsmt);
            }
        }
        for(VG_Policy_Schedule_Endorsement__c pse:existingEndorsements){
            if(tmpPSEMap.containsKey(pse.VG_Endorsement_Library_Id__c)){
                if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c  !=  0){
                    pse.VG_Premium__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c;
                }
                if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c  !=  0){
                    pse.VG_Sub_limit__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c;
                }
            }
        }
        //return new PageReference('/apex/VG_CC_Nordics_Step5b?PolicyId='+policyId);
        PageReference reference = new PageReference('/apex/VG_CC_Nordics_Step5b?PolicyId='+policyId);
        reference.setRedirect(false);
        return reference;
    }
    
    public PageReference gotostep6(){
        
        endorsementPremium  =  0;
        for(VG_Policy_Schedule_Endorsement__c en : existingEndorsements){
            endorsementPremium  =  endorsementPremium + en.VG_Premium__c;
        }
        System.debug('endorsementPremium::'+endorsementPremium);
        
        for(VG_Policy_Schedule_Endorsement__c en1 : existingEndorsements1){
            endorsementPremium  =  endorsementPremium + en1.VG_Premium__c;
        } 
        System.debug('endorsementPremium::'+endorsementPremium);
        
        UpdateFinalCalculations();
        //return new PageReference('/apex/VG_CC_Nordics_Step6?PolicyId='+policyId);
        PageReference reference = new PageReference('/apex/VG_CC_Nordics_Step6?PolicyId='+policyId);
        reference.setRedirect(false);
        return reference;
    }
    public void cancelCoverage(){
        addCoverageMode='';
    }
    public PageReference cancel(){
        return new PageReference('/'+policyId);
    }
    
    public void AddCustom(){   
        VG_Policy_Schedule_Endorsement__c tempEndsmt  =  new VG_Policy_Schedule_Endorsement__c();
        tempEndsmt.VG_Premium__c  =  0;
        tempEndsmt.VG_Sub_limit__c = 0;
        tempEndsmt.VG_Type__c = 'Endorsements';
        existingEndorsements.add(tempEndsmt);
    }
    
    public PageReference finish(){
        Policy__c pol=[select id, Name, VG_Inception_Date__c, VG_Expiry_Date__c  from Policy__c where Id=:policyId limit 1];
        List<VG_Policy_Schedule_Asset__c> assetsToBeInserted  =  new List<VG_Policy_Schedule_Asset__c>();
        List<VG_Policy_Schedule_Endorsement__c> endToBeInserted  =  new List<VG_Policy_Schedule_Endorsement__c>();
        ps.VG_Bridge_Selected_Asset__c='';
        
        Decimal totalTSI = 0;
        for(AssetWrapperList awl:awlList){
            for(AssetWrapper asw : awl.assetWrapperList){
                if(asw.IsSelected){
                    ps.VG_Bridge_Selected_Asset__c+=asw.asset.id+';';
                    totalTSI = totalTSI + asw.asset.VG_True_TSI__c ;
                }
            }
        }
        List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([SELECT Id, Name, Policy__c FROM Policy_Schedule__c WHERE Policy__c=:policyId ORDER BY CreatedDate DESC]);                         
        ps.VG_Lloyds_Product__c='Mixed';
        ps.Policy__c  =  policyId;
        ps.CurrencyISOCode  =  policy.CurrencyISOCode;
        ps.Risk_Premium_Pro__c  =  netBasePremium_Converted_Pro;
        ps.Endorsement_Premium_Pro__c  = endorsementPremium_Pro;
        ps.Net_Premium__c  =  netModelPremium;
        ps.Commission__c  =  commissionPercent;
        ps.Gross_Base_Premium__c  =  grossBasePremium;
        ps.Transaction_GWP__c  =  transactionPremium;
        ps.Limit__c  =  limitAmount_Converted;
        ps.Attachment__c  =  attachment_Converted;
        ps.Sum_Insured__c  =  sumInsured;
        ps.Written_share__c  =  writtenShare ;
        ps.Product__c='Commercial Combined';
        ps.VG_Deductible__c = DeductibleRate_Converted;
        ps.Technical_Layer_Premium__c  =  techLayerPremium ;
        ps.Gross_Written_Premium__c  =  grossWrittenPremium ;
        ps.VG_Gross_Written_Premium_100__c = grossWrittenPremium2;
        ps.Gross_or_Net_Premium__c  =  GrossOrNet ;
        ps.Rate_On_Line__c  =  ROL;
        ps.VG_Turn_Over__c = annualTurnover;
        ps.VG_Occupancy__c = selectedOccupancy;
        ps.VG_Municipality_Code__c = selectedMunicipality;
        ps.VG_Auto_acquisition_Threshold__c = AutoacqThreshold;
        ps.VG_Retired_Directors_Additional_Premium__c = RDAP;
        ps.VG_Retired_Directors_Year__c = RDYear;
        ps.VG_Extended_Reporting_Period_AP__c = ExtReportingPeriod_AP;
        ps.Rate_Per_Mil__c  =  RPM;
        ps.Share__c  =  sharePercent;
        If(RateChange == 0.00 && policy.VG_Is_Renewal__c   == false)       
            ps.VG_Rate_Change__c   =   null;
        else
            ps.VG_Rate_Change__c   =  RateChange;
        ps.Technical_UW_Premium__c  =  uwPremium ;
        ps.Premium_Adjustment__c  =  adjustmentTechPremium;
        ps.Underwriting_Premium__c  =  uwPremium;
        ps.Premium_Adjustment_2__c  =  adjustment;
        ps.VG_Technical_Model_Premium__c  =  techModelPremium;
        ps.ORC__c  =  orcPercent;
        ps.ORC_Amount__c  =  orcAmount;
        ps.VG_Is_MTA__c  =  False;
        ps.Base_Creation_Start_Date__c  = pol.VG_Inception_Date__c;
        ps.Base_Creation_End_Date__c  =  pol.VG_Expiry_Date__c;
        ps.VG_Brokerage_Percent__c  =  brokerage;
        //below 3 lines added by Anu 30.8.2018
        ps.Actual_GWP__c = actualPremium;
        ps.VG_Brokerage_Amount__c = brokerageAmount;
        ps.IPT__c = IPTAmount;
        //ps.IPT_Percent__c  =  IPTPercent;
        ps.Levies__c  =  levies;
        ps.VG_Fee_Income__c  =  feeIncome;
        ps.VG_Base_Policy__c  =  True;
        ps.VG_CREDIT_Augur_SCORE__c  =  creditScore;
        ps.VG_Deductible__c  =  DeductibleRate_Converted;
        ps.VG_Exposure_Premium__c  =  netExposurePremium_Converted;
        ps.VG_Experience_Premium__c  =  experiencePremium_Converted;
        ps.VG_Selected_Weight__c  =  seletedWeight;
        ps.VG_Net_Base_Premium__c  =  netBasePremium_Converted;
        ps.VG_Base_Policy__c = true;
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
        Insert ps;
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
        Integer psacount = 1;
        for(CoverageWrapper CW : coverages.values()){
            try{    
                VG_Policy_Schedule_Asset__c psa  =  new VG_Policy_Schedule_Asset__c();
                psa.VG_Policy_Schedule__c  =  ps.Id;
                psa.VG_OtherRisk__c = CW.otherRiskFactors;
                psa.Name =  ps.Name + '/RR/' + psacount;
                psa.CurrencyISOCode  =  policyCurrency;
                psa.VG_Coverage__c  =  CW.SelectedCoverage;
                if(psa.VG_Coverage__c == 'Fire' || psa.VG_Coverage__c == 'Water')
                    psa.VG_Sum_Insured__c = totalTSI ;
                psa.VG_Risk_Premium__c  =  CW.Premium ;
                psa.RecordTypeId = Schema.SObjectType.VG_Policy_Schedule_Asset__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();                
                GLPL_Coverage='';
                System.debug('Coverage::'+psa.VG_Coverage__c);
                System.debug('CW.factors::'+CW.factors);
                If(psa.VG_Coverage__c=='Fire'){
                    System.debug('CW.factors::'+CW.factors);
                    for(PricingWrapper price:CW.factors){ 
                        If(price.factorName=='Building construction factor'){  
                            If(price.price!='0')         
                                GLPL_Coverage='Building construction factor:'+price.price.split('>')[1]+'<br/>';
                            else
                                GLPL_Coverage='Building construction factor:'+'None'+'<br/>';
                        }else if(price.factorName=='Municipal Fire Water'){
                            If(price.price!='0')
                                GLPL_Coverage+='Municipal Fire Water:'+price.price.split('>')[1]+'<br/>';
                            else
                                GLPL_Coverage+='Municipal Fire Water:'+'None'+'<br/>';
                        }else if(price.factorName=='Fire alarm'){
                            If(price.price!='0')  
                                GLPL_Coverage+='Fire alarm:'+price.price.split('>')[1]+'<br/>';
                            else
                                GLPL_Coverage+='Fire alarm:'+'None'+'<br/>';
                        }else if(price.factorName=='Automatic water sprinkler'){
                            If(price.price!='0')
                                GLPL_Coverage+='Automatic water sprinkler:'+price.price.split('>')[1]+'<br/>';
                            else
                                GLPL_Coverage+='Automatic water sprinkler:'+'None'+'<br/>';
                        }else if(price.factorName=='Risk Quality'){
                            If(price.price!='0')
                                GLPL_Coverage+='Risk Quality:'+price.price.split('>')[1]+'<br/>';
                            else
                                GLPL_Coverage+='Risk Quality:'+'None'+'<br/>';
                        }                                               
                        
                    }
                    GLPL_Coverage+='Norwegian Nat Cat Pool Premium (Curr):'+currentCW.variable.fireNatCatPoolPremium+'<br/>';  
                    GLPL_Coverage+='Loss Limit (Curr):'+currentCW.variable.Losslimit+'<br/>';                                            
                    GLPL_Coverage+='Fire Deducitble (Curr):'+CW.variable.deductibleAmount+'<br/>';
                    GLPL_Coverage+='Fire Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    GLPL_Coverage+='Requested First risk SI:'+CW.variable.RFRSI+'<br/>';
                    GLPL_Coverage+='Full Value SI:'+CW.variable.FVSI+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Burglary'){
                    If(CW.factors != null){
                        for(PricingWrapper price:CW.factors){  
                            If(price.factorName=='Intruder Alarm'){
                                If(price.price!='0')   
                                    GLPL_Coverage+='Intruder Alarm:'+price.price.split('>')[1]+'<br/>';
                                else
                                    GLPL_Coverage+='Intruder Alarm:'+'None'+'<br/>';
                            }else if(price.factorName=='Risk Quality'){
                                If(price.price!='0')  
                                    GLPL_Coverage+='Risk Quality:'+price.price.split('>')[1]+'<br/>';
                                else
                                    GLPL_Coverage+='Risk Quality:'+'None'+'<br/>';  
                            } 
                        }    
                    }
                    GLPL_Coverage+='Tobacco and Spirits SI:'+CW.variable.TAS+'<br/>';
                    GLPL_Coverage+='Silver SI:'+CW.variable.Silver+'<br/>';
                    GLPL_Coverage+='Gold SI:'+CW.variable.Gold+'<br/>';
                    GLPL_Coverage+='Electronics SI:'+CW.variable.Electronics+'<br/>';
                    GLPL_Coverage+='Antiques SI:'+CW.variable.Antiques+'<br/>';
                    GLPL_Coverage+='Weapons SI:'+CW.variable.Weapons+'<br/>';
                    GLPL_Coverage+='Personal Computers SI:'+CW.variable.PC+'<br/>';
                    GLPL_Coverage+='Money and Stamps SI:'+CW.variable.MAS+'<br/>';
                    GLPL_Coverage+='Burglary Deductible (Curr):'+CW.variable.deductibleAmount+'<br/>';
                    GLPL_Coverage+='Burglary Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    GLPL_Coverage+='Contents Deducible (Curr):'+CW.variable.PLdeductibleAmount+'<br/>';
                    GLPL_Coverage+='Contents Deductible (PBA):'+CW.variable.PLPBA+'<br/>'; 
                    psa.VG_CC_Information__c = GLPL_Coverage;                        
                }else If(psa.VG_Coverage__C=='Water'){
                    If(CW.factors != null){
                        for(PricingWrapper price:CW.factors){  
                            if(price.factorName=='Risk Quality'){
                                If(price.price!='0')   
                                    GLPL_Coverage+='Risk Quality:'+price.price.split('>')[1]+'<br/>';
                                else
                                    GLPL_Coverage+='Risk Quality:'+'None'+'<br/>'; 
                            } 
                        }
                    }
                    GLPL_Coverage+=' Year Built:'+currentCW.variable.Year+'<br/>';
                    GLPL_Coverage+=' Water Buildings Deductible (Curr):'+CW.variable.deductibleAmount +'<br/>';
                    GLPL_Coverage+=' Water Buildings Deductible (PBA:'+ CW.variable.PBA+'<br/>';               
                    GLPL_Coverage+=' Water Contents Deductible (Curr):'+ CW.variable.PLdeductibleAmount+'<br/>';
                    GLPL_Coverage+=' Water Contents Deductible (PBA):'+ CW.variable.PLPBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Escaping Liquid'){
                    If(CW.factors != null){
                        for(PricingWrapper price:CW.factors){  
                            if(price.factorName=='Storage Capacity'){
                                If(price.price!='0') 
                                    GLPL_Coverage+='Storage Capacity:'+price.price.split('>')[1]+'<br/>';
                                else
                                    GLPL_Coverage+='Storage Capacity:'+'None' +'<br/>';  
                            } 
                        }
                    }
                    GLPL_Coverage+='Oil Damage Own Property SI:'+CW.variable.ODOP+'<br/>';
                    GLPL_Coverage+='Oil Damage Third Property SI:'+CW.variable.ODTP +'<br/>';
                    GLPL_Coverage+='Oil Damage Deductible (Curr):'+CW.variable.deductibleAmount +'<br/>';
                    GLPL_Coverage+='Oil Damage Deductible (PBA):'+ CW.variable.PBA+'<br/>';
                    GLPL_Coverage+='Consumption (1000 m^3):'+CW.variable.Consumption+'<br/>'; 
                    psa.VG_CC_Information__c = GLPL_Coverage;              
                }else If(psa.VG_Coverage__C=='Cistern'){             
                    If(CW.factors != null){
                        for(PricingWrapper price:CW.factors){  
                            if(price.factorName=='Coverage Factor'){
                                If(price.price!='0') 
                                    GLPL_Coverage+='Coverage Factor:'+price.price.split('>')[1]+'<br/>';
                                else
                                    GLPL_Coverage+='Coverage Factor:'+'None'+'<br/>'; 
                            } 
                        }
                    }
                    GLPL_Coverage+='Cistern SI:'+CW.variable.SI +'<br/>';
                    GLPL_Coverage+='Cistern Deductible (Curr):'+CW.variable.deductibleAmount +'<br/>';
                    GLPL_Coverage+='Cistern Deductible (PBA):'+ CW.variable.PBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;              
                }else If(psa.VG_Coverage__C=='Freeze & Refrigerator'){
                    GLPL_Coverage+='Freezer SI:'+CW.variable.SI+'<br/>';
                    GLPL_Coverage+='Freezer Deductible (Curr):'+CW.variable.deductibleAmount+'<br/>';
                    GLPL_Coverage+='Freezer Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Robbery'){
                    GLPL_Coverage+='Robbery SI:'+CW.variable.SI+'<br/>';
                    GLPL_Coverage+='Robbery Deductible (Curr):'+CW.variable.deductibleAmount+'<br/>';
                    GLPL_Coverage+='Robbery Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Machinery BI'){
                    GLPL_Coverage+='Annual Gross Profit:'+CW.variable.FVSI +'<br/>';
                    If(CW.variable.IPFactor.price!='0'){
                        GLPL_Coverage+='Indeminity Period:'+CW.variable.IPFactor.price.split('>')[1]+'<br/>';
                    }else{  
                        GLPL_Coverage+='Indeminity Period:'+'None'+'<br/>';                  
                    } 
                    If(CW.variable.WPFactor.price!='0'){
                        GLPL_Coverage+='Waiting Time:'+CW.variable.WPFactor.price.split('>')[1]+'<br/>';                     
                    }else{
                        GLPL_Coverage+='Waiting Time:'+'None'+'<br/>'; 
                    }      
                    psa.VG_CC_Information__c = GLPL_Coverage;         
                }else If(psa.VG_Coverage__C=='Extra Costs'){
                    GLPL_Coverage+='Fire,  Burglary and Water SI:'+CW.variable.SI +'<br/>';
                    If(CW.variable.IPFactor.price!='0'){
                        GLPL_Coverage+='Indeminity Period(Months):'+CW.variable.IPFactor.price.split('>')[1]+'<br/>';                         
                    }else{
                        GLPL_Coverage+='Indeminity Period(Months):'+'None'+'<br/>';            
                    }  
                    GLPL_Coverage+='Extra Costs Deductible (Curr):'+ CW.variable.deductibleAmount+'<br/>';
                    GLPL_Coverage+='Extra Costs Deductible (PBA):'+ CW.variable.PBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Loss of Rent'){
                    GLPL_Coverage+='Rental Income:'+CW.variable.PLSI+'<br/>';
                    GLPL_Coverage+='Loss of Rent SI:'+CW.variable.SI+'<br/>';
                    if(CW.variable.IPFactor !=  null){ 
                        If(CW.variable.IPFactor.price!='0'){
                            GLPL_Coverage+='Indeminity Period (Months):'+CW.variable.IPFactor.price.split('>')[1]+'<br/>';
                        }else{
                            GLPL_Coverage+='Waiting Time:'+'None'+'<br/>'; 
                        }  
                    }    
                    GLPL_Coverage+='Loss of Rent (Curr): '+CW.variable.deductibleAmount+'<br/>';
                    GLPL_Coverage+='Loss of Rent Deductible (PBA): '+CW.variable.PBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Epidemic Disease'){
                    GLPL_Coverage+='Epidemic Disease SI:'+ CW.variable.SI+'<br/>';
                    If(CW.variable.WPFactor.price!='0'){
                        GLPL_Coverage+='Deductible or waiting Period?:'+CW.variable.WPFactor.price.split('>')[1]+'<br/>';                     
                    }else{
                        GLPL_Coverage+='Deductible or waiting Period?:'+CW.variable.deductibleAmount+'<br/>';
                    }                 
                    If(CW.variable.IPFactor.price!='0'){
                        GLPL_Coverage+='Epidemic Disease Indemnity Period:'+ CW.variable.IPFactor.price.split('>')[1]+'<br/>';                                 
                    }else{
                        GLPL_Coverage+='Epidemic Disease Indemnity Period:'+'None' +'<br/>';   
                    }  
                    psa.VG_CC_Information__c = GLPL_Coverage;                
                }else If(psa.VG_Coverage__C=='Lift'){
                    GLPL_Coverage+='Lift SI:'+ CW.variable.SI+'<br/>';
                    GLPL_Coverage+='Lift Deductible (Curr):'+CW.variable.deductibleAmount +'<br/>';
                    GLPL_Coverage+='Lift Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Tools'){
                    GLPL_Coverage+='Tools SI (per vehicle):'+ CW.variable.SI+'<br/>';
                    GLPL_Coverage+='No of vehicles:'+CW.variable.noOfVehicles+'<br/>';
                    GLPL_Coverage+='Tools Deductible (Curr):'+CW.variable.deductibleAmount +'<br/>';
                    GLPL_Coverage+='Tools Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Forklift'){
                    GLPL_Coverage+='Forklift SI:'+ CW.variable.SI+'<br/>';
                    GLPL_Coverage+='Forklift Deductible (Curr):'+CW.variable.deductibleAmount +'<br/>';
                    GLPL_Coverage+='Forklift Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Business Sample'){
                    GLPL_Coverage+='Business Sample SI:'+ CW.variable.SI+'<br/>';
                    GLPL_Coverage+='Business Sample Deductible (Curr):'+CW.variable.deductibleAmount +'<br/>';
                    GLPL_Coverage+='Business Sample Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Machinery Breakdown'){
                    If(CW.factors != null){
                        for(PricingWrapper price:CW.factors){  
                            if(price.factorName=='Building Heat Supply'){
                                If(price.price!='0') 
                                    GLPL_Coverage+='Building Heat Supply:'+price.price.split('>')[1]+'<br/>';
                                else
                                    GLPL_Coverage+='Building Heat Supply:'+'None'+'<br/>';
                            }else if(price.factorName=='Risk Quality'){
                                If(price.price!='0') 
                                    GLPL_Coverage+='Risk Quality:'+price.price.split('>')[1]+'<br/>';
                                else
                                    GLPL_Coverage+='Risk Quality:'+'None'+'<br/>';
                            }  
                        }
                    }
                    GLPL_Coverage+='MB Buildings Deductible (Curr):'+CW.variable.deductibleAmount+'<br/>';
                    GLPL_Coverage+='MB Buildings Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    GLPL_Coverage+='MB Machinery Deductible (Curr):'+CW.variable.PLdeductibleAmount+'<br/>';
                    GLPL_Coverage+='MB MachineryDeductible (PBA):'+CW.variable.PLPBA+'<br/>';
                    GLPL_Coverage+='Computer SI:'+CW.variable.SI+'<br/>';
                    GLPL_Coverage+='MB Computer and Data Deductible (Curr):'+CW.variable.MCDeductible+'<br/>';
                    GLPL_Coverage+='MB Computer and Data Deductible (PBA):'+CW.variable.MCPBA+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;                
                }else If(psa.VG_Coverage__C=='Business Interruption'){
                    If(CW.variable.IPFactor.price=='0'){
                        GLPL_Coverage+='Indemnity Period Rate:'+'None'+'<br/>';                   
                    }else{
                        GLPL_Coverage+='Indemnity Period Rate:'+CW.variable.IPFactor.price.split('>')[1]+'<br/>';
                    }  
                    If(CW.variable.WPFactor.price=='0'){
                        GLPL_Coverage+='Waiting Period Rate:'+'None'+'<br/>';
                    }else{
                        GLPL_Coverage+='Waiting Period Rate:'+CW.variable.WPFactor.price.split('>')[1]+'<br/>';
                    }
                    GLPL_Coverage+='BI Gross Profit:'+CW.variable.GrossProfit+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else If(psa.VG_Coverage__C=='Liability GL/PL'){
                    GLPL_Coverage='GL SI:'+CW.variable.SI+'<br/>';
                    GLPL_Coverage+='GL Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    GLPL_Coverage+='GL Deductible (Curr):'+CW.variable.deductibleAmount+'<br/>';
                    GLPL_Coverage+='Annual Turnover Split (Nordics):'+CW.variable.ATSNordics+'<br/>';
                    GLPL_Coverage+='Annual Turnover Split (EU):'+CW.variable.ATSEU+'<br/>';
                    GLPL_Coverage+='PL SI:'+CW.variable.PLSI+'<br/>';
                    GLPL_Coverage+='PL Deductible (PBA):'+CW.variable.PLPBA+'<br/>';
                    GLPL_Coverage+='PL Deductible (Curr):'+CW.variable.PLdeductibleAmount+'<br/>';
                    If(CW.variable.RQFactor.price!='0'){
                        GLPL_Coverage+='Risk Quality:'+CW.variable.RQFactor.price.split('>')[1]+'<br/>';
                    }else{
                        GLPL_Coverage+='Risk Quality:'+'None'+'<br/>';               
                    }
                    GLPL_Coverage+='Description of Risk Quality:'+CW.variable.description+'<br/>';
                    psa.VG_CC_Information__c = GLPL_Coverage;
                }else if(psa.VG_Coverage__C=='Legal Aid'){
                    If(CW.factors != null){
                        for(PricingWrapper price:CW.factors){  
                            if(price.factorName=='Envormental Coverage Factor'){
                                If(price.price!='0') 
                                    GLPL_Coverage+='Envormental Coverage Factor:'+price.price.split('>')[1]+'<br/>';
                                else
                                    GLPL_Coverage='Envormental Coverage Factor:'+'None'+'<br/>';
                            } 
                        }
                    }
                    GLPL_Coverage+='Legal Aid SI:'+CW.variable.SI+'<br/>';
                    GLPL_Coverage+='Legal Aid Deductible (Curr):'+CW.variable.deductibleAmount+'<br/>';
                    GLPL_Coverage+='Legal Aid Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    GLPL_Coverage+='Legal Aid SI Agg:'+CW.variable.SIAgg+'<br/>'; //Added by anu on 23.01.2020                                     
                    psa.VG_CC_Information__c = GLPL_Coverage;              
                }else if(psa.VG_Coverage__C=='CAR/EAR'){
                    for(PricingWrapper price:CW.factors){  
                        if(price.factorName=='Share of Subcontractor'){  
                            If(price.price!='0'){
                                GLPL_Coverage='Share of Subcontractor:'+price.price.split('>')[1]+'<br/>';
                            }else{    
                                GLPL_Coverage='Share of Subcontractor:'+'None'+'<br/>';
                            }
                        }
                        if(price.factorName=='Construction Risk Quality'){ 
                            If(price.price=='0'){                    
                                GLPL_Coverage+='Construction Risk Quality  :'+'None'+'<br/>';
                            }else{
                                GLPL_Coverage+='Construction Risk Quality  :'+price.price.split('>')[1]+'<br/>';
                            } 
                        }   
                    }
                    
                    GLPL_Coverage+='Annual Construction Turnover:'+CW.variable.AnnualContstructionTurnover+'<br/>';
                    GLPL_Coverage+='Works SI:'+CW.variable.SI+'<br/>';
                    GLPL_Coverage+='Works Deductible (Curr):'+CW.variable.deductibleAmount+'<br/>';
                    GLPL_Coverage+='Works Deductible (PBA):'+CW.variable.PBA +'<br/>';
                    GLPL_Coverage+='Major Material Value SI:'+CW.variable.MajorMaterialValue+'<br/>';
                    GLPL_Coverage+='Extra Costs SI:'+CW.variable.ExtraCostSI+'<br/>';
                    GLPL_Coverage+='Extra Costs Deductible (Curr):'+CW.variable.PLdeductibleAmount+'<br/>';
                    GLPL_Coverage+='Extra Costs Deductible (PBA):'+CW.variable.PLPBA +'<br/>';
                    GLPL_Coverage+='Risky Jobs SI:'+CW.variable.RiskyJobSI+'<br/>';
                    GLPL_Coverage+='Risky Jobs Deductible (Curr):'+CW.variable.RiskyJobDeductible+'<br/>';
                    GLPL_Coverage+='Risky Jobs Deductible (PBA):'+CW.variable.RiskyJobPBA +'<br/>';
                    GLPL_Coverage+='Equip Mobile Crane SI:'+CW.variable.MobileCraneSI+'<br/>';
                    GLPL_Coverage+='Equip Excavator and Piling SI:'+CW.variable.EAPM+'<br/>';
                    GLPL_Coverage+='Equip Other Aids SI:'+CW.variable.OtherAids+'<br/>';
                    GLPL_Coverage+='Equip Deductible (Curr):'+CW.variable.MCDeductible+'<br/>';
                    GLPL_Coverage+='Equip Deductible (PBA):'+CW.variable.MCPBA+'<br/>';
                    GLPL_Coverage+='Existing Property SI:'+CW.variable.EPSI+'<br/>';
                    GLPL_Coverage+='Existing Property SI Deductible (Curr):'+CW.variable.EPDeductible +'<br/>';
                    GLPL_Coverage+='Existing Property SI Deductible (PBA):'+CW.variable.EPPBA +'<br/>';
                    GLPL_Coverage+='Access and Rest SI:'+ CW.variable.AccessSI+'<br/>';
                    GLPL_Coverage+='Access and Rest Deductible (Curr):'+CW.variable.AccessDeductible+'<br/>';
                    GLPL_Coverage+='Access and Rest Deductible (PBA):'+CW.variable.AccessPBA +'<br/>';
                    GLPL_Coverage+='Contractor BI SI:'+CW.variable.ContractorSI +'<br/>';
                    If(CW.variable.IPFactor.price=='0'){
                        GLPL_Coverage+='Contractor BI Indemnity Period:'+'None'+'<br/>';                   
                    }else{
                        GLPL_Coverage+='Contractor BI Indemnity Period:'+CW.variable.IPFactor.price.split('>')[1]+'<br/>';
                    }  
                    If(CW.variable.WPFactor.price=='0'){
                        GLPL_Coverage+='Contractor BI Waiting Period:'+'None'+'<br/>';
                    }else{
                        GLPL_Coverage+='Contractor BI Waiting Period:'+CW.variable.WPFactor.price.split('>')[1]+'<br/>';
                    }
                    psa.VG_CC_Information__c = GLPL_Coverage;             
                }else if(psa.VG_Coverage__C=='Crime'){
                    GLPL_Coverage='Crime SI:'+CW.variable.SI+'<br/>';
                    GLPL_Coverage+='Crime Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    GLPL_Coverage+='Crime Deductible (Curr):'+CW.variable.deductibleAmount+'<br/>';                
                    psa.VG_CC_Information__c = GLPL_Coverage;                 
                }else if(psa.VG_Coverage__C=='Special Objects'){
                    if(soWrapperList != null && !soWrapperList.isEmpty()){
                        for(SOWrapper SO: soWrapperList){                   
                            System.debug('soWrapperList::'+soWrapperList);
                            GLPL_Coverage='Object:'+SO.SelectedObject+'<br/>';
                            totalSI = 0;
                            for(SOWrapper SO1: soWrapperList){ 
                                totalSI = totalSI+SO1.SI; 
                            }
                            System.debug('totalSI::'+totalSI);
                            GLPL_Coverage+='SumInsured:'+totalSI+'<br/>';
                            GLPL_Coverage+='Location Covered:'+SO.selectedLocation +'<br/>';
                            GLPL_Coverage+='UW base rate:'+SO.UWBaseRate+'<br/>';
                        }
                        GLPL_Coverage+='Sp Obj Deductible (Curr):'+CW.variable.deductibleAmount +'<br/>';
                        GLPL_Coverage+='Sp Obj Deductible (PBA):'+CW.variable.PBA+'<br/>';
                    }else{
                        GLPL_Coverage+='Object:'+'Bärbar Dator'+'<br/>';
                        totalSI = 0;
                        GLPL_Coverage+='SumInsured:'+totalSI+'<br/>';
                        GLPL_Coverage+='Location Covered:'+'Norden (Nordics)'+'<br/>';
                        GLPL_Coverage+='UW base rate:'+0+'<br/>';
                        GLPL_Coverage+='Sp Obj Deductible (Curr):'+0+'<br/>';
                        GLPL_Coverage+='Sp Obj Deductible (PBA):'+0+'<br/>';
                        
                    }
                    psa.VG_CC_Information__c = GLPL_Coverage;                 
                }else if(psa.VG_Coverage__C=='Business Interruption due to Health Problems'){
                    if(CW.variable.BIHList != null && !CW.variable.BIHList.isEmpty()){
                        for(BIHWrapper BIH : CW.variable.BIHList){                   
                            System.debug('BIHWrapper::'+CW.variable.BIHList);
                            GLPL_Coverage+='Individual:'+BIH.Individual+'<br/>';
                            GLPL_Coverage+='Date of birth:'+BIH.DOB+'<br/>';
                            totalSI = 0;
                            for(BIHWrapper BH : CW.variable.BIHList){   
                                totalSI = totalSI+BH.SI;
                            }
                            GLPL_Coverage+='Total SI:'+totalSI+'<br/>';                     
                        }
                    }else{
                        GLPL_Coverage+='Individual:'+0+'<br/>';
                        GLPL_Coverage+='Date of birth:'+''+'<br/>';
                        totalSI = 0;
                        GLPL_Coverage+='Total SI:'+totalSI+'<br/>';
                    }
                    psa.VG_CC_Information__c = GLPL_Coverage;                   
                }else if(psa.VG_Coverage__C=='Crisis'){
                    GLPL_Coverage+='No Additional Information required:-'+''+'<br/>';    
                    psa.VG_CC_Information__c = GLPL_Coverage;         
                }else if(psa.VG_Coverage__C=='Assault'){
                    GLPL_Coverage+='No Additional Information required:-'+''+'<br/>'; 
                    psa.VG_CC_Information__c = GLPL_Coverage;            
                }else if(psa.VG_Coverage__C=='Personal Accident(visitor)'){
                    GLPL_Coverage+='No Additional Information required:-'+''+'<br/>'; 
                    psa.VG_CC_Information__c = GLPL_Coverage;            
                }              
                System.debug('Coverage2::'+psa.VG_CC_Information__c);
                System.debug('Liability::'+psa.VG_Coverage__C+GLPL_Coverage);
                psa.VG_CC_Information__c = GLPL_Coverage; 
                System.debug('Coverage3::'+psa.VG_CC_Information__c);
                System.debug('Liability::'+psa.VG_Coverage__C+GLPL_Coverage);
                assetsToBeInserted.add(psa);
                psacount++;
            }Catch(Exception ex){
            
            }
        }        
        if(!endToBeInserted.IsEmpty()){
            Insert endToBeInserted;
        }
        if(!assetsToBeInserted.IsEmpty()){
            Insert assetsToBeInserted;
        }
        return new PageReference('/'+ps.Id);
    }        
    
    public void UpdateFinalCalculations(){
        If(RateChange==0.00 && policy.VG_Is_Renewal__c == false)
            RateChange=null;
        netBasePremium_Converted   =  0;
        for(CoverageWrapper CW : coverages.values()){
            netBasePremium_Converted  =  netBasePremium_Converted + CW.Premium ;
        }
        netBasePremium_Converted_Pro  =  netBasePremium_Converted * proratingFactor;
        endorsementPremium  =  0;
        for(VG_Policy_Schedule_Endorsement__c PE : existingEndorsements1){
            endorsementPremium  =  endorsementPremium + PE.VG_Premium__c;
        }
        for(VG_Policy_Schedule_Endorsement__c PE : existingEndorsements){
            endorsementPremium  =  endorsementPremium + PE.VG_Premium__c;
        }
        endorsementPremium_Pro  =  endorsementPremium * proratingFactor;
        try{
            netModelPremium  =  netBasePremium_Converted_Pro  + endorsementPremium_Pro;
        }catch(exception ex){
            netModelPremium  =  0;
        }
        try{
            techModelPremium  =  netModelPremium * (sharePercent/100);
        }catch(exception ex){
            techModelPremium  =  0;
        }
        try{
            uwPremium  =  techModelPremium + adjustmentTechPremium;
        }catch(exception ex){
            uwPremium  =  0;
        }
        try{
            actualPremium  =  uwPremium + adjustment;
        }catch(exception ex){
            actualPremium  =  0;
        }
        try{
            grossWrittenPremium  =  actualPremium/(1-(brokerage/100));
        }catch(exception ex){
            grossWrittenPremium  =  0;
        }
        try{
            grossWrittenPremium2  = grossWrittenPremium /(sharePercent/100);
        }catch(exception ex){
            grossWrittenPremium2  = 0;
        }
        try{
            brokerageAmount  =  grossWrittenPremium  ==  actualPremium ? 0 : grossWrittenPremium - actualPremium;
        }catch(exception ex){
            brokerageAmount  =  0;
        }
        try{
            IPTAmount  =  IPTPercent  ==  0 ? 0 : grossWrittenPremium * (IPTPercent/100);
        }catch(exception ex){
            IPTAmount  =  0;
        }
        try{
            if(GrossOrNet  ==  'Gross'){
                transactionPremium  =  grossWrittenPremium + brokerageAmount + levies + feeIncome;
            }else{
                transactionPremium  =  actualPremium + brokerageAmount + levies + feeIncome;
            }
        }catch(exception ex){
            transactionPremium  =  0;
        }
    }
    
    Public Static Map<String,  Boolean> createCoveragesList(){
        Map<String,  Boolean> cMap  =  new Map<String,  Boolean>();
        cMap.put('Fire', True);
        cMap.put('Burglary', True);
        cMap.put('Water', True);
        cMap.put('All Risk', False);
        cMap.put('Machinery Breakdown', True);
        cMap.put('CAR/EAR', False);
        cMap.put('Escaping Liquid', False);
        cMap.put('Cistern', False);
        cMap.put('Freeze & Refrigerator', False);
        cMap.put('Robbery', False);
        cMap.put('Special Objects', False);
        cMap.put('Business Interruption', False);
        cMap.put('Machinery BI', False);
        cMap.put('Extra Costs', False);
        cMap.put('Loss of Rent', False);
        cMap.put('Epidemic Disease', False);
        cMap.put('Liability GL/PL', False);
        cMap.put('Legal Aid', True);
        cMap.put('Crime', False);
        cMap.put('Crisis', False);
        cMap.put('Personal Accident (visitor)', False);
        cMap.put('Assault', False);
        cMap.put('Tools', False);
        cMap.put('Lift', False);
        cMap.put('Forklift', False);
        cMap.put('Business Sample', False);
        cMap.put('Professional Indemnity', False);
        cMap.put('Business Interruption due to Health Problems', False);
        return cMap;
    }
    
    Public List<SelectOption> createMunicipalitiesList(){
        List<SelectOption> mList  =  new List<SelectOption>();
        List<VG_Pricing__c> priList  =  [Select Id,  VG_Category__c,  VG_Product__c,  VG_Rating_Factor__c,  VG_Level__c,  VG_Order__c,  Sum_Insured_Limit__c,  VG_Rate__c from VG_Pricing__c where VG_Category__c  =  'Location factor' AND VG_Product__c  =  'CC - Fire' ORDER BY VG_Rating_Factor__c ASC];
        for(VG_Pricing__c pri : priList){
            mList.add(new SelectOption(pri.VG_Rating_Factor__c,  pri.VG_Rating_Factor__c));
        }
        return mList;
    }
    
    Public Map<String,  String> createOccupanciesList(){
        Map<String,  String> mList  =  new Map<String,  String>();
        Map<Id,  VG_Pricing__c> priList  =  new Map<Id,  VG_Pricing__c>([Select Id,  VG_Category__c, VG_Product__c,  VG_Rating_Factor__c,  VG_Level__c,  VG_Order__c,  Sum_Insured_Limit__c,  VG_Rate__c from VG_Pricing__c where VG_Category__c  =  'SNI Turnover Adjustment Factor' AND VG_Product__c  =  'CC - Epidemic Disease' ORDER BY VG_Rating_Factor__c ASC]);
        for(VG_Pricing__c pri : priList.values()){
            mList.put(pri.VG_Rating_Factor__c,  pri.VG_Rating_Factor__c);
        }
        return mList;
    }
    
    Public Class AssetWrapper{
        Public Asset__c asset {get; set;}
        Public Boolean isSelected {get; set;}
    }
    
    public Class AssetWrapperList{
        public List<AssetWrapper> assetWrapperList{get;set;}
        public AssetWrapperList(){
            assetWrapperList = new List<AssetWrapper>();
        }
    }
    
    public Class CoverageWrapper{
        Public List<SelectOption> coveragesList {get; set;}
        Public String selectedCoverage {get; set;}
        Public Map<String,  PricingWrapper> pricingMap {get; set;}
        Public List<PricingWrapper> factors {get; set;}
        Public Variables variable {get; set;}
        Public Decimal SI {get; set;}
        Public Decimal Premium {get; set;}
        Public Decimal Deductible {get; set;}
        Public Decimal PLDeductible {get; set;}
        Public Decimal otherRiskFactors {get; set;}
        
        Public CoverageWrapper(){
            coveragesList  =  new List<SelectOption>();
            factors  =  new List<PricingWrapper>();
            pricingMap  =  new Map<String,  PricingWrapper>();
            variable  =  new Variables();
            
            SI  =  Premium  =  Deductible  =  PLDeductible  =  otherRiskFactors  =  0;
            
            System.debug('VG_CC_Nordics_StepController.coveragesMap.keySet() is'+VG_CC_Nordics_StepController.coveragesMap);
            for(String coverage : VG_CC_Nordics_StepController.createCoveragesList().keySet()){
                coveragesList.add(new SelectOption(coverage,  coverage));
            }
            selectedCoverage  =  '';
        }
    }
    
    public Class PricingWrapper{
        Public String factorName {get; set;}
        Public List<SelectOption> factors {get; set;}
        Public String price {get; set;}
        Public String selectedFactor {get; set;}
        Public Decimal priceDecimal {get; set;}
        Public Boolean showOnUI {get; set;}
        
        Public PricingWrapper(){
            factorName  =  '';
            factors  =  new List<SelectOption>();
            price  =  '0';
            priceDecimal  =  0;
            selectedFactor  =  '';
            showOnUI  =  False;
        }
    }
    
    Public Class Variables{
        Public List<BIHWrapper> BIHList {get; set;}
        Public Decimal SI {get; set;}
        Public Decimal SIAgg {get; set;}
        Public Decimal deductibleAmount {get; set;}
        Public Decimal fireNatCatPoolPremium {get; set;}
        Public Decimal Losslimit {get; set;}
        Public Decimal PBA {get; set;}
        Public Decimal PLSI {get; set;}
        Public Decimal PLdeductibleAmount {get; set;}
        Public Decimal PLPBA {get; set;}
        Public Decimal ATSNordics {get; set;}
        Public Decimal ATSEU {get; set;}
        Public Decimal noOfVehicles {get;set;}
        Public Decimal RFRSI {get; set;}
        Public Decimal FVSI {get;set;}
        Public Decimal TAS {get; set;}
        Public Decimal Silver {get; set;}
        Public Decimal Gold {get; set;}
        Public Decimal Electronics {get; set;}
        Public Decimal Antiques {get; set;}
        Public Decimal Weapons {get;set;}
        Public Decimal PC {get; set;}
        Public Decimal MAS {get;set;}
        Public Decimal ODOP {get; set;}
        Public Decimal ODTP {get;set;}
        Public Decimal StorageCapacity {get; set;}
        Public Decimal Consumption {get;set;}
        Public Decimal GrossProfit {get; set;}
        Public Decimal AnnualContstructionTurnover {get; set;}
        Public Decimal MajorMaterialValue {get; set;}
        Public Decimal ExtraCostSI {get; set;}
        Public Decimal RiskyJobSI {get; set;}
        Public Decimal RiskyJobDeductible {get; set;}
        Public Decimal RiskyJobPBA {get; set;}
        Public Decimal MobileCraneSI {get; set;}
        Public Decimal EAPM {get; set;}
        Public Decimal OtherAids {get; set;}
        Public Decimal MCDeductible {get; set;}
        Public Decimal MCPBA {get; set;}
        Public Decimal EPSI {get; set;}
        Public Decimal EPDeductible {get; set;}
        Public Decimal EPPBA {get; set;}
        Public Decimal AccessSI {get; set;}
        Public Decimal AccessDeductible {get; set;}
        Public Decimal AccessPBA {get; set;}
        Public Decimal ContractorSI {get; set;}
        
        Public Integer Year {get; set;}
        
        Public String dedOrWP {get; set;}
        Public String description {get; set;}
        
        Public PricingWrapper IPFactor {get; set;}
        Public PricingWrapper WPFactor {get; set;}
        Public PricingWrapper RQFactor {get; set;}
        
        Public Variables(){
            BIHList  =  new List<BIHWrapper>();
            SI  =  0;
            SIAgg=0;
            deductibleAmount  =  0;
            fireNatCatPoolPremium  =  0;
            Losslimit  =  0;
            PBA  =  0;
            PLSI  =  0;
            PLdeductibleAmount  =  0;
            PLPBA  =  0;
            ATSEU  =  0;
            ATSNordics  =  0;
            noOfVehicles  =  0;
            GrossProfit  =  0;
            dedOrWP  =  '';
            description  =  '';
            for(Integer i = 0; i<5; i++){
                BIHWrapper BH  =  new BIHWrapper();
                BIHList.add(BH);
            }
        }
    }
    
    Public Class BIHWrapper{
        Public Date DOB {get; set;}
        Public String Individual {get; set;}
        Public Decimal SI {get; set;}
        Public Integer age {get; set;}
        Public Decimal Premium {get; set;}
        
        Public BIHWrapper(){
            //DOB  =  System.Today();
            Individual  =  '';
            SI  =  Premium  =  0;
            age  =  0;
        }        
    }
    
    Public Class SOWrapper{
        Public List<SelectOption> obj {get; set;}
        Public Decimal SI {get; set;}
        Public List<SelectOption> location {get; set;}
        Public Decimal SOBaseRate {get; set;}
        Public Decimal UWBaseRate {get; set;}
        Public Decimal locFactor {get; set;}
        Public Decimal basePremium {get; set;}
        Public String SelectedObject {get; set;}
        Public String selectedLocation {get; set;}
        
        Public SOWrapper(){ 
            obj  =  new List<SelectOption>();
            obj.add(new SelectOption('Bärbar Dator','Bärbar Dator'));
            obj.add(new SelectOption('Kamera,  TV,  Video inkl utrust','Kamera,  TV,  Video inkl utrust'));
            obj.add(new SelectOption('Kommunikationsradio','Kommunikationsradio'));
            obj.add(new SelectOption('Piano,  Flygel,  Orgel','Piano,  Flygel,  Orgel'));
            obj.add(new SelectOption('Elinstrument inkl högtalare,  förstärkare etc','Elinstrument inkl högtalare,  förstärkare etc'));
            obj.add(new SelectOption('Övriga musikinstrument','Övriga musikinstrument'));
            obj.add(new SelectOption('Annat','Annat'));
            location  =  new List<SelectOption>();
            location.add(new SelectOption('Norden (Nordics)','Norden (Nordics)'));
            location.add(new SelectOption('Europa (Europé)','Europa (Europé)'));
            location.add(new SelectOption('Hela Världen (WW)','Hela Världen (WW)'));
        }
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