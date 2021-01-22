Public Class VG_ReviseAesirStepsController{
    
    Public Risk_Capture__c RC {get;set;}
    public RRWrapper rrw{get;set;}
    public Policy_Schedule__c ps{get;set;}
    public Policy__c policy{get;set;}
    
    public Blob fileBody {get;set;}
    
    public Integer counterEnd {get; set;}
    public Integer counter {get; set;}
    public Integer RRSize{get; set;}
    
    public Id PSID {get; set;}
    public Id accId {get; set;}
    
    public Boolean pmsg {get; set;}
    public Boolean errmsg {get; set;}
    public Boolean addRRMode {get; set;}
    public Boolean hasEndorsements {get; set;}
    Public Boolean EnableReinstatement{get;set;}
    public Boolean DMLAlert{get;set;}
    public Boolean hasRRChanged {get; set;}
    public Boolean skipSplit {get; set;}

    public List<RRWrapper> addedRRList {get; set;}
    Public list<VG_Policy_Schedule_Asset__c> assetValues{get; set;}
    public List < SelectOption > coverageOptions {get;set;}
    public list<SelectOption> CapacityPaperList {get; set;}
    Public List<SelectOption> splitTypes{get; set;}
    public list<SelectOption> NonEEAVolanteEntity_Select {get; set;}
    public list<SelectOption> EEAVolanteEntity_Select {get; set;}
     
    public Map<id, Asset__c> assetMap{get; set;}
    public Map<id, VG_Policy_Schedule_Endorsement__c> pseTempMap{get;set;}
    public Map<id, VG_Policy_Schedule_Endorsement__c> pseMap{get;set;}
    public Map<id, VG_Policy_Schedule_Asset__c> psaMap{get;set;}
    public Map<String, CurrencyType> currencyRateMap{get;set;}
    
    Public Set<String> addedassetLookups{get;set;}
    
    public string CapacityPaper{get;set;}
    public String MTAType{get;set;}
    public String MTAStartDate{get;set;}
    public String fileName {get;set;}
    public string nameFile{get;set;}
    public String[] filelines  =  new String[]{};   
    Public  String   NoticeofEventLimit{get;set;}
    Public  String   ProofofLossLimit{get;set;}
    Public  String   PaymentafterPOLlimit{get;set;}
    Public  String   SunsetClause{get;set;}
    Public  String   SalvageProvisions{get;set;}
    Public  String   CTLProvisions{get;set;}
    Public  String   LossMinimisation{get;set;}
    Public  String   PowerMargin{get;set;}
    Public  String   PropellantMargin{get;set;}
    Public  String   LossFormula{get;set;}
    Public  String   AVN4121{get;set;}
    public  String   GNP{get;set;}
    public  String   Layer{get;set;}
    public  String   RDInfo{get;set;}
    public  String   Index{get;set;}
    public String bsname{get;set;}
    
    public  Decimal RiskPremium {get;set;}
    public  Decimal EndorsementPremium  {get;set;}
    public  Decimal NetModelPremium {get;set;}
    public  Decimal Lim{get;set;}
    public  Decimal Attachment  {get;set;}
    public  Decimal WrittenShare    {get;set;}
    public  Decimal SignedShare {get;set;}
    public  Decimal SumInsured  {get;set;}
    public  Decimal TechnicalModelPremium   {get;set;}
    public  Decimal UWAdjustment    {get;set;}
    public  Decimal TechnicalUnderwritingPremium    {get;set;}
    public  Decimal CommercialAdjustment    {get;set;}
    public  Decimal ActualPremium   {get;set;}
    public  Decimal BrokeragePrecent    {get;set;}
    public  Decimal BrokerageAmount {get;set;}
    public  Decimal GWP {get;set;}
    public  Decimal FeeIncome {get;set;}
    public  Decimal Levies  {get;set;}
    public  Decimal TransactionalPremium    {get;set;}
    public  Decimal VATPrecent  {get;set;}
    public  Decimal VATAmount   {get;set;}
    public  Decimal RateChange {get;set;}
    public  Decimal WitholdingTax   {get;set;}
    public  Decimal TotalsumInsured  {get;set;}
    public  Decimal TotalPremium{get;set;}
    public  Decimal TotalSI{get;set;}
    public Decimal GWP100 {get;set;}
    public Decimal limitAmt {get;set;}
    
    //Constructor Start
    public VG_ReviseAesirStepsController(){
        PSID  =  apexpages.currentpage().getparameters().get('Id');
        MTAType = apexpages.currentpage().getparameters().get('MTAType');
        MTAStartDate = apexpages.currentpage().getparameters().get('MTAStartDate');       
        ps = [select id, Name, Policy__c, VG_Entity_Share__c,VG_Capacity_Paper__c,VG_Volante_Entities__c,Split_Type__c,VG_Rate_Change__c, Policy__r.Name, Policy__r.VG_Expiry_Date__c, Policy__r.VG_Inception_Date__c, VG_Gross_Written_Premium_100__c, VG_MTA_Start_Date__c, VG_MTA_Type__c, VG_Is_MTA__c, VG_MTA_End_Date__c, Risk_Premium_Pro__c, CurrencyISOCode, Endorsement_Premium_Pro__c, Net_Premium__c, Transaction_GWP__c, Limit__c , Attachment__c, Sum_Insured__c, ILF_Layer__c, Written_share__c, Gross_Written_Premium__c, Gross_or_Net_Premium__c, Technical_UW_Premium__c, VG_Technical_Model_Premium__c, VG_Brokerage_Percent__c, Actual_GWP__c, VG_Brokerage_Amount__c, IPT__c, IPT_Percent__c, Levies__c, VG_Fee_Income__c, Share__c, Premium_Adjustment_2__c, Premium_Adjustment__c, VG_VAT__c, VG_VAT_Amount__c, VG_Witholding_Tax_Amount__c from Policy_Schedule__c where id = : PSID limit 1];
        policy = [select id, Name, Insured__c,VG_Is_Renewal__c,CurrencyIsoCode, VG_Expiry_Date__c, VG_Inception_Date__c from Policy__c where id = :ps.Policy__c limit 1];       
        accId = policy.Insured__c;
        List<CurrencyType> exchangeRates  =  [Select Id,  ConversionRate,  IsoCode from CurrencyType where IsoCode  =  'USD' or IsoCode  = : policy.CurrencyIsoCode];
        currencyRateMap = new Map<String, CurrencyType>();
        for(CurrencyType cr: exchangeRates){
            currencyRateMap.put(cr.IsoCode, cr);
        }
        RC = [select id,  Name, VG_Risk_start__c, VG_Risk_End__c, VG_Additional_Information__c from Risk_Capture__c where Policy_Schedule__c = :PSID limit 1];
        TotalPremium = TotalSI = 0;
        addedassetLookups = new Set<String>();
        if(rc.VG_Additional_Information__c !=  null){
            RDInfo = rc.VG_Additional_Information__c;
            String[] tempDetail = RDInfo.split('<br>');
            List<String> sList = new List<String>();
            for(Integer i = 0;i<tempDetail.size();i++){
                String[] tmp = tempDetail[i].split(':');
                if(tmp.size() > 1)
                    sList.add(tmp[1]);
                else
                    sList.add('');
            }
            NoticeofEventLimit = sList[0];
            ProofofLossLimit = sList[1];
            PaymentafterPOLlimit = sList[2];
            SunsetClause = sList[3];
            SalvageProvisions = sList[4];
            CTLProvisions = sList[5];
            LossMinimisation = sList[6];
            PowerMargin = sList[7];
            PropellantMargin = sList[8];
            LossFormula = sList[9];
            AVN4121 = sList[10];
        }else{
            RDInfo = '';
            NoticeofEventLimit = '';
            ProofofLossLimit = '';
            PaymentafterPOLlimit = '';
            SunsetClause = '';
            SalvageProvisions = '';
            CTLProvisions = '';
            LossMinimisation = '';
            PowerMargin = '';
            PropellantMargin = '';
            LossFormula = '';
            AVN4121 = '';
        }
        psaMap = new Map<id, VG_Policy_Schedule_Asset__c>([select id, Name, Asset__c, VG_Risk_start__c, VG_Risk_End__c, VG_Limit__c, VG_Attachment__c, VG_Written_Share__c, VG_Signed_Share__c, VG_Sum_Insured__c, VG_Coverage__c , VG_Coverage_Type__c, VG_Max_SI__c, VG_Base_Premium_Rate__c, VG_Avg_SI__c, VG_Premium__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c  = : PSID]);
        /*if(MTAType!=  null && MTAType!= ''){
            psaMap.clear();
        }*/
        addedRRList = new List<RRWrapper>();
        counter = 0;
        TotalSI = 0;
        DMLAlert = false;
        for(VG_Policy_Schedule_Asset__c psa : psaMap.values()){
            RRWrapper tmp = new RRWrapper();
            tmp.psa = psa;
            if(MTAType!=  null && MTAType!= '')
                tmp.psa.id=null;
            //tmp.ass = assMap.get(psa.Asset__c);
            tmp.Counter = String.valueOf(counter);
            tmp.Coverage = psa.VG_Coverage__c;
            tmp.techPremium = psa.VG_Premium__c;
            tmp.SumInsured  = psa.VG_Sum_Insured__c;            
            if(tmp.techPremium != null ){
                if(policy.CurrencyIsoCode !=  'USD'){
                    tmp.PremiumUSD = (tmp.psa.VG_Premium__c/currencyRateMap.get(policy.CurrencyIsoCode).ConversionRate).setScale(2);
                }else{
                    tmp.PremiumUSD = tmp.psa.VG_Premium__c.setScale(2);
                }
                If(tmp.psa.VG_Premium__c > 0 && tmp.psa.VG_Premium__c != null){
                    TotalPremium = (TotalPremium+tmp.psa.VG_Premium__c).setScale(2);
                }
            }else{
                tmp.PremiumUSD = 0;
            }
            
            if(tmp.SumInsured != null){
                if(policy.CurrencyIsoCode !=  'USD'){
                    System.debug('10-1-2018::'+policy.CurrencyIsoCode );
                    tmp.SIUSD = (tmp.psa.VG_Sum_Insured__c/currencyRateMap.get(policy.CurrencyIsoCode).ConversionRate).setScale(2);
                }else{
                    tmp.SIUSD = tmp.psa.VG_Sum_Insured__c.setScale(2);
                }
                if(tmp.sumInsured > TotalSI){
                    TotalSI = tmp.sumInsured;
                }
            }else{
                tmp.SIUSD = 0;
            }
            addedRRList.add(tmp);
            counter++;
        }
        System.debug('addedRRList::'+addedRRList);
        fileBody = blob.valueOf('');
        if(policy.CurrencyISOCode !=  'USD'){
            System.debug('18.1.2019::'+currencyRateMap.get(policy.CurrencyISOCode).ConversionRate+TotalPremium+(TotalPremium/currencyRateMap.get(policy.CurrencyISOCode).ConversionRate).setScale(2));
            TotalPremium = (TotalPremium/currencyRateMap.get(policy.CurrencyISOCode).ConversionRate).setScale(2);
        }else{
            TotalPremium = TotalPremium.setScale(2);
        }
        if(policy.CurrencyISOCode !=  'USD'){
            TotalSI = (TotalSI/currencyRateMap.get(policy.CurrencyISOCode).ConversionRate).setScale(2);
        }else{
            TotalSI = TotalSI.setScale(2);
        }
        System.debug('addedRRList::'+addedRRList);
        assetValues = new List<VG_Policy_Schedule_Asset__c>();
        assetMap  =  new Map<id, Asset__c>([select id, Name, VG_Asset_Type__c, VG_Account__c from Asset__c where (VG_Asset_Type__c = :'Satellite' OR VG_Asset_Type__c = :'Launcher')]);
        counterEnd = counter = 0;
        splitTypes = new List<SelectOption>();
        skipSplit = False;
        if(policy.VG_Inception_Date__c.year() <= 2020){
            splitTypes.add(new SelectOption('','--None--'));
            skipSplit = True;
        }
        splitTypes.add(new SelectOption('EEA','EEA'));
        splitTypes.add(new SelectOption('Non EEA','Non EEA'));
        NonEEAVolanteEntity_Select = new List<SelectOption>();
        for(String s : Label.Aesir_NonEEAVolanteEntity.split(';')){
            NonEEAVolanteEntity_Select.add(new SelectOption(s,s));
        }
        EEAVolanteEntity_Select = new List<SelectOption>();
        for(String s : Label.Aesir_EEAVolanteEntity.split(';')){
            EEAVolanteEntity_Select.add(new SelectOption(s,s));
        }

        CapacityPaperList = new List<SelectOption>();
        CapacityPaperList.add(new SelectOption('--None--', '--None--'));
        CapacityPaperList.add(new SelectOption('Written in 2020', 'Written in 2020'));
        CapacityPaperList.add(new SelectOption('PT into 2020', 'PT into 2020'));
        CapacityPaperList.add(new SelectOption('2018 Liberty Company Stamp - 2018 year', '2018 Liberty Company Stamp - 2018 year'));
        CapacityPaperList.add(new SelectOption('2019 - 2019 YOA - 10 MUSD - 60% Liberty, 10% Swiss, 30% Everest', '2019 - 2019 YOA - 10 MUSD - 60% Liberty, 10% Swiss, 30% Everest'));
        CapacityPaperList.add(new SelectOption('2019 - 2020 YOA - 10 MUSD - 60% Liberty, 10% Swiss, 30% Everest', '2019 - 2020 YOA - 10 MUSD - 60% Liberty, 10% Swiss, 30% Everest'));
        CapacityPaperList.add(new SelectOption('2019 - 2020 YOA - after Partner PT', '2019 - 2020 YOA - after Partner PT'));
        CapacityPaperList.add(new SelectOption('2020 - 4 MUSD (Liberty 3 + Swiss 1)', '2020 - 4 MUSD (Liberty 3 + Swiss 1)'));
        CapacityPaperList.add(new SelectOption('2020 - 5.5 MUSD (Liberty 3 + Swiss 1, Fidelis 0+Partner 1.5)', '2020 - 5.5 MUSD (Liberty 3 + Swiss 1, Fidelis 0+Partner 1.5)'));
        CapacityPaperList.add(new SelectOption('Special - Inmarsat PT Stamp', 'Special - Inmarsat PT Stamp'));
        CapacityPaperList.add(new SelectOption('Special - Measat PT Stamp', 'Special - Measat PT Stamp'));
        CapacityPaperList.add(new SelectOption('Special - Ovzon PT Stamp', 'Special - Ovzon PT Stamp'));
        CapacityPaperList.add(new SelectOption('Special - Resurs PT Stamp', 'Special - Resurs PT Stamp'));
        CapacityPaperList.add(new SelectOption('Special - Express PT Stamp', 'Special - Express PT Stamp'));
        CapacityPaperList.add(new SelectOption('2019 - 2020 YOA - 10 MUSD - 90% Liberty, 10% Swiss','2019 - 2020 YOA - 10 MUSD - 90% Liberty, 10% Swiss'));
        CapacityPaperList.add(new SelectOption('2020 - 13.5 MUSD (3+1, 1.5, 2.5+2.5+0.5+2.5)','2020 - 13.5 MUSD (3+1, 1.5, 2.5+2.5+0.5+2.5)'));
        CapacityPaperList.add(new SelectOption('2020 - Liberty and Lineslip (Argentina)', '2020 - Liberty and Lineslip (Argentina)'));
        CapacityPaperList.add(new SelectOption('2020 - Lineslip + Partner Re 9.5', '2020 - Lineslip + Partner Re 9.5'));
        CapacityPaperList.add(new SelectOption('2020 Post lineslip PT (Ovzon)', '2020 Post lineslip PT (Ovzon)'));
        CapacityPaperList.add(new SelectOption('2020 Post lineslip PT (Resurs)', '2020 Post lineslip PT (Resurs)'));
        CapacityPaperList.add(new SelectOption('2020 Post Lineslip PT 1 (CAS 500-2)', '2020 Post Lineslip PT 1 (CAS 500-2)'));
        CapacityPaperList.add(new SelectOption('2020 Post Lineslip PT 2 (CAS 500-1)', '2020 Post Lineslip PT 2 (CAS 500-1)'));
        CapacityPaperList.add(new SelectOption('2020 Post Lineslip PT 3 (S17, MP)', '2020 Post Lineslip PT 3 (S17, MP)'));
        CapacityPaperList.add(new SelectOption('2020 Post Lineslip PT 4 (Legion I)', '2020 Post Lineslip PT 4 (Legion I)'));
        CapacityPaperList.add(new SelectOption('2020 Post lineslip PT 6 (Roscosmos + ELSA)', '2020 Post lineslip PT 6 (Roscosmos + ELSA)'));
        CapacityPaperList.add(new SelectOption('2021 - Lineslip + Partner Re 11.5', '2021 - Lineslip + Partner Re 11.5'));
        CapacityPaperList.add(new SelectOption('2021 - 15.5 MUSD (3+1, 1.5, 2.5+2.5+2.5+2.5)', '2021 - 15.5 MUSD (3+1, 1.5, 2.5+2.5+2.5+2.5)'));
        CapacityPaperList.add(new SelectOption('2021 - Special - Legion Top-up 2', '2021 - Special - Legion Top-up 2'));
        
        coverageOptions  =  new List <SelectOption>();
        coverageOptions.add(new SelectOption('--None--', '--None--'));
        coverageOptions.add(new SelectOption('Combined Flight-Launch Vehicle Flight', 'Combined Flight-Launch Vehicle Flight'));
        coverageOptions.add(new SelectOption('Combined Flight-Post Separation', 'Combined Flight-Post Separation'));
        coverageOptions.add(new SelectOption('Comined Flight-In-Orbit', 'Comined Flight-In-Orbit'));
        coverageOptions.add(new SelectOption('In-Orbit', 'In-Orbit'));
        coverageOptions.add(new SelectOption('Launch Vehicle Flight Only', 'Launch Vehicle Flight Only'));
        coverageOptions.add(new SelectOption('Assembly, Intetgratio and Testing', 'Assembly, Intetgratio and Testing'));
        coverageOptions.add(new SelectOption('Transit', 'Transit'));
        coverageOptions.add(new SelectOption('Pre-Launch', 'Pre-Launch'));
        coverageOptions.add(new SelectOption('Engine Testing', 'Engine Testing'));
        coverageOptions.add(new SelectOption('Launch Third Party Liabilities', 'Launch Third Party Liabilities'));
        coverageOptions.add(new SelectOption('In-Orbit Third Party Liabilities', 'In-Orbit Third Party Liabilities'));
        addRRMode = False;
        Index = '0';
        errmsg = false;
        RiskPremium = EndorsementPremium = NetModelPremium;
        TransactionalPremium  =  ps.Transaction_GWP__c;
        SumInsured  =  (ps.Sum_Insured__c!= null?ps.Sum_Insured__c :0) ;
        GWP  =  (ps.Gross_Written_Premium__c!= null?ps.Gross_Written_Premium__c:0) ;
        GWP100 = (ps.VG_Gross_Written_Premium_100__c!= null?ps.VG_Gross_Written_Premium_100__c:0);
        GNP  =  ps.Gross_or_Net_Premium__c;
        TechnicalUnderwritingPremium  =  (ps.Technical_UW_Premium__c != null?ps.Technical_UW_Premium__c:0) ;
        TechnicalModelPremium  =  (ps.VG_Technical_Model_Premium__c != null?ps.VG_Technical_Model_Premium__c:0);
        NetModelPremium = (ps.Net_Premium__c  != null?ps.Net_Premium__c:0);
        BrokeragePrecent  = (ps.VG_Brokerage_Percent__c!= null?ps.VG_Brokerage_Percent__c:0);
        actualPremium  =  (ps.Actual_GWP__c != null?ps.Actual_GWP__c:0);
        limitAmt = (ps.Limit__c != null?ps.Limit__c:0);
        RateChange = ps.VG_Rate_Change__c;
        attachment = (ps.Attachment__c != null?ps.Attachment__c:0);
        writtenShare =  (ps.Written_share__c != null?ps.Written_share__c:0);
        brokerageAmount  =  (ps.VG_Brokerage_Amount__c != null?ps.VG_Brokerage_Amount__c:0);
        CommercialAdjustment = (ps.Premium_Adjustment_2__c != null?ps.Premium_Adjustment_2__c:0);
        UWAdjustment = (ps.Premium_Adjustment__c != null?ps.Premium_Adjustment__c:0);
        CapacityPaper = ps.VG_Capacity_Paper__c;
        
    }
    //Constructor End...
    
    //Redirection Methods Start
    Public PageReference Cancel(){
        return new PageReference('/'+PSID);
    }
    public PageReference gotostep1(){
        return new PageReference('/apex/VG_Revise_Aesir_Step1');
    }
    public PageReference gotostep2(){
         return new PageReference('/apex/VG_Revise_Aesir_Step2');
    }
    
    public PageReference gotostep2a(){
        
        return new PageReference('/apex/VG_Revise_Aesir_Step2a');      
    }
    
    public PageReference gotostep2b(){
        try{ 
            DMLAlert = false;
            if(fileBody !=  blob.valueOf('')){
                addedRRList.clear();
                DMLAlert = True;               
            }
            if(DMLAlert){
                nameFile = PaymentDetailsController.decode(fileBody, 'ISO-8859-1'); //fileBody.toString();
                RRWrapper rrw;
                fileBody = blob.valueOf('');
                filelines  =  nameFile.split('\n'); 
                System.debug('lines::'+filelines.size());
                Set<String> assNames  =  new Set<String>();   
                
                for (Integer j = 1;j<filelines.size();j++){
                    String[] inputvalues  =  new String[]{};
                    inputvalues  =  filelines[j].split(',');                   
                    If(inputvalues[0].trim()!= null && inputvalues[0].trim()!= '')
                        assNames.add(inputvalues[0].trim());
                }
                System.debug('assNames ::'+assNames );
                List<Asset__c> listOfAllAssets  =  [select id,  Name,  LS_AccName_with_Ass_Name__c from Asset__c where LS_AccName_with_Ass_Name__c IN :assNames]; 
                Map<String, Asset__c> assNameMap =  new Map<String, Asset__c>();
                for(Asset__c ass: listOfAllAssets){
                    assNameMap.put(ass.LS_AccName_with_Ass_Name__c, ass);
                }  
                for (Integer j = 1;j<filelines.size();j++){
                    String[] inputvalues  =  new String[]{};
                    inputvalues  =  filelines[j].split(',');                   
                    If(inputvalues[0].trim()!= null && inputvalues[0].trim()!= '' && !assNameMap.containsKey(inputvalues[0])){
                        pmsg = True;
                        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'Asset match not found for '+inputvalues[0]));  
                        return null; 
                    }
                    
                } 
                for (Integer i = 1;i<filelines.size();i++){
                    String[] inputvalues  =  new String[]{};
                    String[] headervalues  =  new String[]{};
                    rrw = new RRWrapper();
                    headervalues  =  filelines[0].split(',');
                    inputvalues  =  filelines[i].split(',');              
                    if(!('Asset External id' ==  headervalues[0] &&'Risk Start Date' ==  headervalues[1] &&'Risk End Date' ==  headervalues[2] &&'Coverage' ==  headervalues[3] &&'Coverage Type' ==  headervalues[4] &&'Limit' ==  headervalues[5] &&  'Attachment' ==  headervalues[6] &&'AVG SI' ==  headervalues[7] && 'Rate(%)' ==  headervalues[8] && 'Signed Shared(%)' == headervalues[9]  && 'Annual Premium' ==  headervalues[10] )){
                        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'file header mis match please check the file.'));
                        return null;
                    }
                    
                    If(assNameMap.containsKey(inputvalues[0])){               
                        rrw.psa.Asset__c =  assNameMap.get(inputvalues[0]).Id;
                    }else{
                        pmsg = True;
                        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'Please select a valid Asset.'));  
                        return null; 
                    }
                    if(inputvalues[1] != null && inputvalues[1] != '' ){
                        inputvalues[1] = inputvalues[1].trim().replace('-', '/');                    
                        rrw.psa.VG_Risk_start__c = Date.parse(inputvalues[1].trim());
                    }
                    if(inputvalues[2] != null && inputvalues[2] != '' ){
                        inputvalues[2] = inputvalues[2].trim().replace('-', '/');                                       
                        rrw.psa.VG_Risk_End__c = Date.parse(inputvalues[2].trim());
                    }
                    if(inputvalues[3] != null && inputvalues[3] != '' )
                        rrw.psa.VG_Coverage__c = inputvalues[3].trim();
                    else
                        rrw.psa.VG_Coverage__c = '--None--';
                    if(inputvalues[4] != null && inputvalues[4] != '' )
                        rrw.psa.VG_Coverage_Type__c = inputvalues[4].trim();
                    else
                        rrw.psa.VG_Coverage_Type__c = '--None--';
                    if(inputvalues[5] != null && inputvalues[5] != '' )
                        rrw.psa.VG_Limit__c = Decimal.valueOf(inputvalues[5].trim());
                    else
                        rrw.psa.VG_Limit__c = 0;
                    if(inputvalues[6] != null && inputvalues[6] != '' )
                        rrw.psa.VG_Attachment__c = Decimal.valueOf(inputvalues[6].trim());
                    else
                        rrw.psa.VG_Attachment__c = 0;
                    if(inputvalues[7] != null && inputvalues[7] != '' )
                        rrw.psa.VG_Avg_SI__c = Decimal.valueOf(inputvalues[7].trim());  
                    else
                        rrw.psa.VG_Avg_SI__c = 0;                                                   
                    if(inputvalues[8] != null && inputvalues[8] != '' )
                        rrw.psa.VG_Base_Premium_Rate__c = Decimal.valueOf(inputvalues[8].trim());
                    else
                        rrw.psa.VG_Base_Premium_Rate__c = 0;
                    if(inputvalues[9] != null && inputvalues[9] != '' )
                        rrw.psa.VG_Signed_Share__c = Decimal.valueOf(inputvalues[9].trim());
                    else
                        rrw.psa.VG_Signed_Share__c = 0;
                    //rrw.psa.VG_Premium__c = Decimal.valueOf(inputvalues[10].trim());
                    //rrw.psa.VG_Sum_Insured__c = Decimal.valueOf(inputvalues[11].trim());  
                    if(rrw.psa.VG_Avg_SI__c !=  null && rrw.psa.VG_Base_Premium_Rate__c !=  null)
                        rrw.psa.VG_Premium__c  =  rrw.psa.VG_Avg_SI__c * (rrw.psa.VG_Base_Premium_Rate__c/100);
                    else
                        rrw.psa.VG_Premium__c  =  0;               
                    rrw.counter = String.valueOf(i-1);
                    addedRRList.add(rrw);
                    System.debug('addedRRList::'+addedRRList.size()+'::'+addedRRList);
                }
            }
            DMLAlert = True;
        }catch(Exception e){       
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Error ::'+e));
            return null;
        }
        RRCalc();
        return new PageReference('/apex/VG_Revise_Aesir_Step2b');
    }
    public PageReference gotostep5(){
        EndorsementPremium = 0;
        TotalsumInsured = 0;
        /*for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements){
           EndorsementPremium  =  EndorsementPremium + pse.VG_Premium__c;
        }*/
        System.debug('addedRRList::'+addedRRList.size()+'::'+addedRRList);
        RiskPremium = 0;
        for(RRWrapper rrw: addedRRList){
            System.debug('wx::'+rrw.psa.Asset__c);  
            rrw.assName = assetMap.get(rrw.psa.Asset__c).Name;            
            RiskPremium  =  RiskPremium + rrw.techPremium;
            if(TotalsumInsured < rrw.sumInsured){
                TotalsumInsured = rrw.sumInsured;
            }
        }
        NetModelPremium = RiskPremium + EndorsementPremium;
        summaryCalc();
        return new PageReference('/apex/VG_Revise_Aesir_Step5');
    }
    public PageReference finish(){
        if(CapacityPaper == '--None--'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select Capacity Paper'));    
            return null;
        }
        ps.Risk_Premium_Pro__c  =  RiskPremium;
        ps.Endorsement_Premium_Pro__c  =  EndorsementPremium;
        ps.Net_Premium__c  =  netModelPremium;
        ps.Transaction_GWP__c  =  TransactionalPremium;
        ps.Technical_UW_Premium__c  =  TechnicalUnderwritingPremium;
        ps.VG_Technical_Model_Premium__c  =  TechnicalModelPremium;       
        ps.Sum_Insured__c  =  TotalsumInsured;
        ps.Gross_Written_Premium__c  =  GWP ;
        ps.VG_Gross_Written_Premium_100__c  = GWP100;
        ps.Gross_or_Net_Premium__c  =  GNP ;
        ps.Written_share__c  =  writtenShare;
        ps.Share__c  =  signedShare;
        If(RateChange == 0.00 && policy.VG_Is_Renewal__c   == false)       
            ps.VG_Rate_Change__c   =   null;
        else
            ps.VG_Rate_Change__c   =  RateChange;
        ps.VG_Brokerage_Percent__c  =  BrokeragePrecent;
        ps.Actual_GWP__c = actualPremium;
        ps.VG_Brokerage_Amount__c = brokerageAmount;
        ps.Levies__c  =  Levies;
        ps.Limit__c = limitAmt;
        ps.Attachment__c = attachment;
        ps.VG_Fee_Income__c  =  FeeIncome;
        ps.Premium_Adjustment_2__c = CommercialAdjustment;
        ps.Premium_Adjustment__c = UWAdjustment;
        ps.VG_Capacity_Paper__c = CapacityPaper ;
        if(ps.VG_MTA_Type__c != 'Revision of Cover'){
            ps.Base_Creation_Start_Date__c  =  ps.Policy__r.VG_Inception_Date__c;
            ps.Base_Creation_End_Date__c  =  ps.Policy__r.VG_Expiry_Date__c;   
        }
        if(ps.VG_MTA_Type__c == 'Revision of Cover'){
            ps.Base_Creation_Start_Date__c = ps.VG_MTA_Start_Date__c;
            ps.Base_Creation_End_Date__c = ps.VG_MTA_End_Date__c;    
        }
        if(MTAType !=  'Revision of Cover'){
            ps.Name = ps.Name.remove('/EEA').remove('/NonEEA');
            if(ps.Split_Type__c == 'EEA'){
                ps.Name += '/EEA';
            }else if(ps.Split_Type__c == 'Non EEA'){
                ps.Name += '/NonEEA';            
            } 
            update ps;                                
        }
        RDInfo = 'Notice of Event Limit :'+NoticeofEventLimit+'<br/>';
        RDInfo+= 'Proof of Loss Limit :'+ProofofLossLimit+'<br/>';
        RDInfo+= 'Payment after POL limit :'+PaymentafterPOLlimit+'<br/>';
        RDInfo+= 'Sunset Clause :'+SunsetClause+'<br/>';
        RDInfo+= 'Salvage Provisions :'+SalvageProvisions+'<br/>';
        RDInfo+= 'CTL Provisions :'+CTLProvisions+'<br/>';
        RDInfo+= 'Loss Minimisation :'+LossMinimisation+'<br/>';
        RDInfo+= 'Power Margin :'+PowerMargin+'<br/>';
        RDInfo+= 'Propellant Margin :'+PropellantMargin+'<br/>';
        RDInfo+= 'Loss Formula :'+LossFormula+'<br/>';
        RDInfo+= 'AVN 41/21:'+AVN4121;
        rc.VG_Additional_Information__c = RDInfo;
        if(MTAType !=  'Revision of Cover'){
            RC.Name =  ps.Name+'/RD/1';
            Update rc; 
        }
        List<VG_Policy_Schedule_Asset__c> assetToBeInserted  =  new List<VG_Policy_Schedule_Asset__c>();
        List<VG_Policy_Schedule_Asset__c> assetToBeUpdated  =  new List<VG_Policy_Schedule_Asset__c>();        
        Set<ID> psaIds = new Set<ID>();
        for(VG_Policy_Schedule_Asset__c psa: psaMap.values()){
            psaIds.add(psa.id);
        }
        System.debug('addedRRList::'+addedRRList.size()+'::'+addedRRList);
        for(RRWrapper rrw : addedRRList){
            if(rrw.psa.id == null){
                assetToBeInserted.add(rrw.psa);
            }else{
                assetToBeUpdated.add(rrw.psa);
                System.debug('assetToBeUpdated::'+assetToBeUpdated);
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
            for(VG_Policy_Schedule_Asset__c psa  : assetToBeInserted){
                psa.Name  =  ps.Name + '/RR/' + psacount;
                psa.CurrencyIsoCode = policy.CurrencyIsoCode;
                psa.VG_Policy_Schedule__c = ps.id; 
                psacount++;
            }
        }
        System.debug('Lists::'+assetToBeInserted.size()+'::'+assetToBeUpdated.size());
        if(MTAType !=  'Revision of Cover'){
            System.debug('DMLAlert::'+DMLAlert);
            if(DMLAlert){
                if(!psaMap.IsEmpty() && !assetToBeInserted.IsEmpty()){
                    delete psaMap.values();
                }
                if(!assetToBeInserted.IsEmpty()){
                    insert assetToBeInserted;
                }else if(!assetToBeUpdated.IsEmpty()){
                    Update assetToBeUpdated;
                }
                
            }  
            return new PageReference('/'+ps.id);
        }else{   
            System.debug('psid::'+ps.id);     
            List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([select id, Name, Policy__r.Name from Policy_Schedule__c where Policy__c = :ps.Policy__c]);
            Policy_Schedule__c rocps = new Policy_Schedule__c();
            rocps = ps;
            rocps.VG_Is_MTA__c = true;
            rocps.VG_MTA_Type__c = 'Revision of Cover';
            rocps.id = null;
            rocps.VG_Base_Policy__c = true;
            rocps.VG_MTA_Start_Date__c = Date.valueOf(MTAStartDate);
            rocps.VG_MTA_End_Date__c = ps.Policy__r.VG_Expiry_Date__c;
            rocps.Base_Creation_Start_Date__c = rocps.VG_MTA_Start_Date__c;
            rocps.Base_Creation_End_Date__c = rocps.VG_MTA_End_Date__c;
            System.debug('psid::'+ps.id);
            rocps.IPT__c = null;
            rocps.IPT_Percent__c = null;
            rocps.MTA_Parent_Policy_Schedule__c = PSID;
            rocps.VG_Capacity_Paper__c = CapacityPaper ;
            System.debug('psid::'+rocps.id+'::'+PSID+'::'+rocps.MTA_Parent_Policy_Schedule__c);           
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
            if(ps.Split_Type__c == 'EEA'){
                rocps.Name += '/EEA';
            }else if(ps.Split_Type__c == 'Non EEA'){
                rocps.Name += '/NonEEA';
            }else{
                rocps.VG_Volante_Entities__c='';
            }
            Insert rocps;
            System.debug('rocps'+rocps.id+ps.id);
            List<Policy_Schedule__c> TriggerNew  =  new List<Policy_Schedule__c>();
            TriggerNew.add(rocps);
            PolicyScheduleTriggerFunction.allowInsertRI  =  True;
            PolicyScheduleTriggerFunction.createRIRecords(TriggerNew);
            Risk_Capture__c rocrc = new Risk_Capture__c();
            rocrc = rc;
            rocrc.id = null;
            rocrc.Name = rocps.Name+'/RD/'+1;
            rocrc.Policy_Schedule__c = rocps.id;
            insert rocrc;
            List<VG_Policy_Schedule_Asset__c > rocpsa =  new List<VG_Policy_Schedule_Asset__c >();
            rocpsa.addAll(assetToBeInserted);
            Integer psacounter = 1;
            if(!rocpsa.IsEmpty()){
                for(VG_Policy_Schedule_Asset__c psa : rocpsa){
                    psa.id = null;
                    psa.VG_Policy_Schedule__c = rocps.id;
                    psa.Name = rocps.Name+'/RR/'+psacounter;
                    psacounter++;                                      
                }
                Insert rocpsa;
            }
            return new PageReference('/'+rocps.id);
        }            
    }
    //Redirection Methods End
    
    //Support Methods Start     
    public void SummaryCalc(){      
        GWP100  =  0;
        GWP  =  0;
        RiskPremium  =  0;
        If(RateChange==0.00 && policy.VG_Is_Renewal__c == false)
            RateChange=null;
        for(RRWrapper temp : addedRRList){
            GWP  =  GWP + (temp.psa.Annual_Rate_100__c!= null?temp.psa.Annual_Rate_100__c:0);
            RiskPremium  =  RiskPremium + (temp.psa.VG_Premium__c!= null?temp.psa.VG_Premium__c:0);
        }     
        NetModelPremium  = RiskPremium + EndorsementPremium;
        TechnicalUnderwritingPremium  =  NetModelPremium + (UWAdjustment!= null?UWAdjustment:0);   
        GWP100  =  (TechnicalUnderwritingPremium!= null?TechnicalUnderwritingPremium:0) + (CommercialAdjustment!= null?CommercialAdjustment:0);
        try{
            signedShare  =  (GWP/GWP100)*100;
        }catch(Exception ex){
            signedShare  =  0;
        }
        TechnicalModelPremium  =  netModelPremium * (signedShare/100);
        if(BrokeragePrecent !=  null && BrokeragePrecent !=  0)
            BrokerageAmount  =  GWP *(BrokeragePrecent/100);
        ActualPremium  =  (GWP!= null?GWP:0) - BrokerageAmount;
        if(GNP  ==  'Gross')
            TransactionalPremium  =  GWP;
        else if(GNP  ==  'Net')
            TransactionalPremium  =  GWP- BrokerageAmount;         
    }
    
    public void RRCalc(){
        TotalSI = 0;
        TotalPremium = 0;
        for(RRWrapper temp : addedRRList){
            System.debug('temp::'+addedRRList);
            If(temp.psa.VG_AVG_SI__c!= null && temp.psa.VG_Base_Premium_Rate__c!= null && temp.psa.VG_Signed_Share__c!= null){
                temp.techPremium = temp.psa.VG_AVG_SI__c * (temp.psa.VG_Base_Premium_Rate__c/100)*(temp.psa.VG_Signed_Share__c/100);
                temp.psa.Annual_Rate_100__c = temp.techPremium;
                temp.psa.VG_Premium__c  =  temp.psa.VG_Avg_SI__c * (temp.psa.VG_Base_Premium_Rate__c/100);                
                if(policy.CurrencyIsoCode!=  'USD'){
                    System.debug('10-1-2018::'+policy.CurrencyIsoCode+'::'+(temp.psa.VG_Premium__c/currencyRateMap.get(policy.CurrencyIsoCode).ConversionRate).setScale(2));
                    temp.PremiumUSD = (temp.psa.VG_Premium__c/currencyRateMap.get(policy.CurrencyIsoCode).ConversionRate).setScale(2);
                }else{
                    temp.PremiumUSD = temp.psa.VG_Premium__c.setScale(2);
                }
                If(temp.psa.VG_Premium__c > 0 && temp.psa.VG_Premium__c != null){
                    TotalPremium = (TotalPremium+temp.psa.VG_Premium__c).setScale(2);
                }
                System.debug('5.12::'+addedRRList+'premium::'+temp.psa.VG_Premium__c+'::AvgSI::'+temp.psa.VG_AVG_SI__c);
            }
            If(temp.psa.VG_Signed_Share__c!= null && temp.psa.VG_Limit__c!= null){
                temp.sumInsured = temp.psa.VG_Limit__c*(temp.psa.VG_Signed_Share__c/100);
                temp.psa.VG_Sum_Insured__c = temp.sumInsured;
                if(temp.sumInsured > TotalSI){
                    TotalSI = temp.sumInsured;
                }
                if(policy.CurrencyIsoCode!=  'USD'){
                    temp.SIUSD = (temp.psa.VG_Sum_Insured__c/currencyRateMap.get(policy.CurrencyIsoCode).ConversionRate).setScale(2);
                }else{
                    temp.SIUSD = temp.psa.VG_Sum_Insured__c.setScale(2);
                }
                /*If(temp.psa.VG_Sum_Insured__c>0 && temp.psa.VG_Sum_Insured__c != 0){
                    TotalSI = temp.psa.VG_Sum_Insured__c.setScale(2);
                }*/
                System.debug('5.12::'+temp.psa.VG_Limit__c+'sign::'+(temp.psa.VG_Signed_Share__c/100));                               
            }  
        }
        if(policy.CurrencyIsoCode!=  'USD'){
            TotalPremium = (TotalPremium/currencyRateMap.get(policy.CurrencyIsoCode).ConversionRate).setScale(2);
        }else{
            TotalPremium = TotalPremium.setScale(2);
        }
        if(policy.CurrencyIsoCode!=  'USD'){
            TotalSI = (TotalSI/currencyRateMap.get(policy.CurrencyIsoCode).ConversionRate).setScale(2);
        }else{
            TotalSI = TotalSI.setScale(2);
        }
    }
    
    //Support Methods End
    
    //Sub Classes Start
    public class RRWrapper{
        public VG_Policy_Schedule_Asset__c psa{get;set;}
        public Asset__c ass{get;set;}
        public String assName{get;set;}        
        public String Counter{get;set;}
        public Boolean IsSelected{get;set;}
        public String Coverage{get;set;}
        public String CoverageType{get;set;}
        public Decimal techPremium{get;set;}
        public Decimal sumInsured{get;set;}
        public Decimal PremiumUSD{get;set;}
        public Decimal SIUSD{get;set;}
        public String MTAStart{get;set;}
        public String MTAEnd{get;set;}
        public RRWrapper(){
            psa = new VG_Policy_Schedule_Asset__c();
            ass = new Asset__c();
            counter = '0';
            IsSelected = false;
            Coverage  = '';
            CoverageType = '';
            techPremium = 0;
            sumInsured = 0;
        }
    }
    //SubClasses Ends
}