Public Class VG_AesirStepsController{
    
    public Policy_Schedule__c  ps { get; set; }
    public string CapacityPaper{get;set;}
    
    Public Risk_Capture__c RC {get;set;}
    Public Policy__c policy {get;set;}
    public RRWrapper rrw{get;set;}
    
    public Integer counterEnd {get; set;}
    public Integer counter {get; set;}
    public Integer RRSize{get; set;}
    
    public Id policyId {get; set;}
    public Id accId {get; set;}
    
    public Boolean pmsg {get; set;}
    public Boolean errmsg {get; set;}
    public Boolean addRRMode {get; set;}
    Public Boolean EnableReinstatement{get;set;}
    Public Boolean skipSplit {get; set;}
    
    public Map<id, Asset__c> assetMap{get; set;}
    public Map<String, CurrencyType> currencyRateMap{get;set;}
    
    public list<SelectOption> CapacityPaperList {get; set;}
    Public List<SelectOption> splitTypes{get; set;}
    public List<RRWrapper> addedRRList {get; set;}
    Public list<Integer> createLoop {get; set;}
    Public list<VG_Policy_Schedule_Asset__c> assetValues{get; set;}
    public List < SelectOption > coverageOptions {get;set;}
    public list<SelectOption> NonEEAVolanteEntity_Select {get; set;}
    public list<SelectOption> EEAVolanteEntity_Select {get; set;}
    
    Public Set<String> assetLookups{get;set;}
    Public Set<String> addedassetLookups{get;set;}
    
    public Blob fileBody {get;set;}
    
    public String fileName {get;set;}
    public string nameFile{get;set;}
    public String[] filelines  =  new String[]{};
    public  String   Index{get;set;}
    public  String   policyCurrency {get; set;}
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
    
    public Decimal RiskPremium {get;set;}
    public Decimal EndorsementPremium  {get;set;}
    public Decimal NetModelPremium {get;set;}
    public Decimal SumInsured  {get;set;}
    public Decimal TechnicalModelPremium   {get;set;}
    public Decimal UWAdjustment    {get;set;}
    public Decimal TechnicalUnderwritingPremium    {get;set;}
    public Decimal CommercialAdjustment    {get;set;}
    public Decimal ActualPremium   {get;set;}
    public Decimal BrokeragePrecent    {get;set;}
    public Decimal BrokerageAmount {get;set;}
    public Decimal GWP {get;set;}
    public Decimal TransactionalPremium    {get;set;}
    public Decimal TotalsumInsured  {get;set;}
    public Decimal TotalPremium{get;set;}
    public Decimal TotalSI{get;set;}
    public Decimal GWP100 {get;set;}
    public Decimal limitAmt {get;set;}
    public Decimal RateChange {get;set;}
    public Decimal attachment {get;set;}
    public Decimal writtenShare {get;set;}
    public Decimal signedShare {get;set;}
    
    
    //Constructor Start
    public VG_AesirStepsController(){
        policyId  =  apexpages.currentpage().getparameters().get('Id');
        policyCurrency  =  apexpages.currentpage().getparameters().get('Currency');
        System.debug('policyId::'+policyId);
        policy=[select id, Insured__c,VG_Is_Renewal__c,VG_Expiry_Date__c, VG_Inception_Date__c from Policy__c where id=:policyId limit 1];
        ps = new Policy_Schedule__c();  
        List<CurrencyType> exchangeRates  =  [Select Id,  ConversionRate,  IsoCode from CurrencyType where IsoCode  =  'USD' or IsoCode =: policyCurrency];
        currencyRateMap = new Map<String, CurrencyType>();
        for(CurrencyType cr: exchangeRates){
            currencyRateMap.put(cr.IsoCode, cr);
        }
        accId = policy.Insured__c;
        RC = new Risk_Capture__c();
        fileBody = blob.valueOf('');
        RC.CurrencyISOCode  =  policyCurrency;
        coverageOptions  =  new List <SelectOption>();
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
        
        /*Schema.DescribeFieldResult statusFieldDescription  =  Schema.VG_Policy_Schedule_Asset__c.VG_Coverage__c.getDescribe();
        for (Schema.Picklistentry picklistEntry: statusFieldDescription.getPicklistValues()) {
           coverageOptions.add(new SelectOption(pickListEntry.getValue(), pickListEntry.getLabel())); 
         if (picklistEntry.isDefaultValue()) {
           RR.VG_Coverage__c  =  picklistEntry.getValue();
         }             

        }*/        
        coverageOptions.add(new SelectOption('--None--','--None--'));
        coverageOptions.add(new SelectOption('Combined Flight-Launch Vehicle Flight','Combined Flight-Launch Vehicle Flight'));
        coverageOptions.add(new SelectOption('Combined Flight-Post Separation','Combined Flight-Post Separation'));
        coverageOptions.add(new SelectOption('Comined Flight-In-Orbit','Comined Flight-In-Orbit'));
        coverageOptions.add(new SelectOption('In-Orbit','In-Orbit'));
        coverageOptions.add(new SelectOption('Launch Vehicle Flight Only','Launch Vehicle Flight Only'));
        coverageOptions.add(new SelectOption('Assembly, Intetgratio and Testing','Assembly, Intetgratio and Testing'));
        coverageOptions.add(new SelectOption('Transit','Transit'));
        coverageOptions.add(new SelectOption('Pre-Launch','Pre-Launch'));
        coverageOptions.add(new SelectOption('Engine Testing','Engine Testing'));
        coverageOptions.add(new SelectOption('Launch Third Party Liabilities','Launch Third Party Liabilities'));
        coverageOptions.add(new SelectOption('In-Orbit Third Party Liabilities','In-Orbit Third Party Liabilities'));
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
        
        VG_Policy_Schedule_Asset__c psa  =  new VG_Policy_Schedule_Asset__c();
        psa.CurrencyISOCode  =  policyCurrency;
        psa.VG_Coverage_Type__c='';
        psa.VG_Base_Premium__c = 0;
        psa.VG_Premium__c = 0;
        psa.VG_Base_Premium_Rate__c = 0;
        psa.VG_Fee_Amounts__c = 0;
        addedRRList  =  new List<RRWrapper>();
        RRWrapper RRW  =  new RRWrapper();
        RRW.CoverageType='';
        RRW.techPremium = 0;
        RRW.sumInsured = 0;
        RRW.psa  =  psa;
        RRW.assName = psa.Name;
        RRW.counter  =  '0';
        RRW.sumInsured = 0;
        addedRRList.add(RRW);
        addedRRList = new List<RRWrapper>();
        createLoop = new List<Integer>();
        assetValues = new List<VG_Policy_Schedule_Asset__c>();
        assetLookups = new Set<String>();
        addedassetLookups = new Set<String>();
        assetMap  =  new Map<Id, Asset__c>([select id, Name, VG_Asset_Type__c, VG_Account__c from Asset__c where (VG_Asset_Type__c=:'Satellite' OR VG_Asset_Type__c=:'Launcher')]);
        counterEnd = counter = 0;
        addRRMode = False;
        Index='0';
        errmsg = false;
        EnableReinstatement = False;
        TotalPremium = TotalSI = TotalsumInsured = RiskPremium = EndorsementPremium = NetModelPremium = SumInsured = TechnicalModelPremium = UWAdjustment = TechnicalUnderwritingPremium = CommercialAdjustment = ActualPremium = BrokeragePrecent = BrokerageAmount = GWP = GWP100  = TransactionalPremium = 0;
        GNP='';
        Layer='';
        NoticeofEventLimit='';
        ProofofLossLimit='';
        PaymentafterPOLlimit='';
        SunsetClause='';
        SalvageProvisions='';
        CTLProvisions='';
        LossMinimisation='';
        PowerMargin='';
        PropellantMargin='';
        LossFormula='';
        AVN4121='';
    }
    //Constructor End...
    
    //Redirection Methods Start
    Public PageReference Cancel(){
        return new PageReference('/'+policyId);
    }
    
    public PageReference gotostep1(){
        return new PageReference('/apex/VG_Aesir_Step1');
    }
    
    public PageReference gotostep2(){
        return new PageReference('/apex/VG_Aesir_Step2');      
    }
    
    public PageReference gotostep2a(){
       
        addedRRList.clear();           
        return new PageReference('/apex/VG_Aesir_Step2a');      
    }
    
    public PageReference gotostep2b(){
        if(fileBody == null || fileBody == blob.valueOf('')){
            System.debug('fileBody::'+fileBody); 
            pmsg = true;
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'Must select file.'));
            return null;
        }else{
            pmsg = false;
        }
        try{  
            nameFile = fileBody.toString();
            RRWrapper rrw;
            fileBody = blob.valueOf('');
            filelines  =  nameFile.split('\n'); 
            System.debug('lines::'+filelines.size());
            Set<String> assNames  =  new Set<String>();   
            
            for (Integer j = 1;j<filelines.size();j++){
                String[] inputvalues  =  new String[]{};
                inputvalues  =  filelines[j].split(',');                  
                If(inputvalues[0].trim()!=null && inputvalues[0].trim()!='')
                    assNames.add(inputvalues[0].trim());
            }
            System.debug('assNames ::'+assNames );
            List<Asset__c> listOfAllAssets  =  [select id,  LS_AccName_with_Ass_Name__c,  Name from Asset__c where LS_AccName_with_Ass_Name__c IN :assNames]; 
            Map<String, Asset__c> assNameMap =  new Map<String, Asset__c>();
            for(Asset__c ass: listOfAllAssets){
                System.debug('Adding asset: '+ass.LS_AccName_with_Ass_Name__c);
                assNameMap.put(ass.LS_AccName_with_Ass_Name__c,  ass);
            }  
            for (Integer j = 1;j<filelines.size();j++){
                String[] inputvalues  =  new String[]{};
                inputvalues  =  filelines[j].split(',');
                System.debug(assNameMap.containsKey(inputvalues[0]));                    
                If(inputvalues[0].trim() != null && inputvalues[0].trim()!='' && !assNameMap.containsKey(inputvalues[0])){
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
                System.debug(headervalues);
                inputvalues  =  filelines[i].split(',');              
                if(!('Asset External id'== headervalues[0].trim() &&'Risk Start Date'== headervalues[1].trim() &&'Risk End Date'== headervalues[2].trim() &&'Coverage'== headervalues[3].trim() &&'Coverage Type'== headervalues[4].trim() &&'Limit'== headervalues[5].trim() &&  'Attachment'== headervalues[6].trim() &&'AVG SI'== headervalues[7].trim() && 'Rate(%)'== headervalues[8].trim() && 'Signed Shared(%)'==headervalues[9].trim()  && 'Annual Premium'== headervalues[10].trim() )){
                    pmsg = True;                    
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
                if(inputvalues[1] !=null && inputvalues[1] !='' ){
                    inputvalues[1] = inputvalues[1].trim().replace('-','/');                    
                    rrw.psa.VG_Risk_start__c = Date.parse(inputvalues[1].trim());
                }
                if(inputvalues[2] !=null && inputvalues[2] !='' ){
                    inputvalues[2] = inputvalues[2].trim().replace('-','/');                                       
                    rrw.psa.VG_Risk_End__c = Date.parse(inputvalues[2].trim());
                }
                if(inputvalues[3] != null && inputvalues[3] !='' )
                    rrw.psa.VG_Coverage__c = inputvalues[3].trim();
                else
                    rrw.psa.VG_Coverage__c='--None--';
                if(inputvalues[4] != null && inputvalues[4] !='' )
                    rrw.psa.VG_Coverage_Type__c = inputvalues[4].trim();
                else
                    rrw.psa.VG_Coverage_Type__c='--None--';
                if(inputvalues[5] != null && inputvalues[5] !='' )
                    rrw.psa.VG_Limit__c = Decimal.valueOf(inputvalues[5].trim());
                else
                    rrw.psa.VG_Limit__c = 0;
                if(inputvalues[6] != null && inputvalues[6] !='' )
                    rrw.psa.VG_Attachment__c = Decimal.valueOf(inputvalues[6].trim());
                else
                    rrw.psa.VG_Attachment__c = 0;
                if(inputvalues[7] != null && inputvalues[7] !='' )
                    rrw.psa.VG_Avg_SI__c = Decimal.valueOf(inputvalues[7].trim());  
                else
                    rrw.psa.VG_Avg_SI__c = 0;                                                   
                if(inputvalues[8] != null && inputvalues[8] !='' )
                    rrw.psa.VG_Base_Premium_Rate__c = Decimal.valueOf(inputvalues[8].trim().remove('%'));
                else
                    rrw.psa.VG_Base_Premium_Rate__c = 0;
                if(inputvalues[9] != null && inputvalues[9] !='' )
                    rrw.psa.VG_Signed_Share__c = Decimal.valueOf(inputvalues[9].trim().remove('%'));
                else
                    rrw.psa.VG_Signed_Share__c = 0;
                //rrw.psa.VG_Premium__c = Decimal.valueOf(inputvalues[10].trim());
                //rrw.psa.VG_Sum_Insured__c = Decimal.valueOf(inputvalues[11].trim()); 
                if(rrw.psa.VG_Avg_SI__c != null && rrw.psa.VG_Base_Premium_Rate__c != null)
                    rrw.psa.VG_Premium__c  =  rrw.psa.VG_Avg_SI__c * (rrw.psa.VG_Base_Premium_Rate__c/100);
                else
                    rrw.psa.VG_Premium__c  =  0;
                rrw.counter = String.valueOf(i-1);
                addedRRList.add(rrw);
            }
        }catch(Exception e){       
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Error ::'+e));
            return null;
        }
        RRCalc();
        return new PageReference('/apex/VG_Aesir_Step2b');
    }
    
    public PageReference gotostep5(){
        EndorsementPremium = 0;
        TotalsumInsured = 0;
        /*for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements){
            EndorsementPremium  =  EndorsementPremium + pse.VG_Premium__c;
        }*/
        RiskPremium = 0;
        for(RRWrapper rrw: addedRRList){
            RiskPremium  =  RiskPremium + rrw.techPremium;
            System.debug('assetMap::'+assetMap.values()+'::'+assetMap.get(rrw.psa.Asset__c));
            rrw.assName = assetMap.get(rrw.psa.Asset__c).Name;               
            //rrw.assName = assetMap.get(rrw.psa.Asset__c).LS_AccName_with_Ass_Name__c;                        
            if(TotalsumInsured < rrw.sumInsured){
                TotalsumInsured = rrw.sumInsured;
            }
        }
        SummaryCalc();
        return new PageReference('/apex/VG_Aesir_Step5');
    }
    
    public PageReference finish(){
        if(CapacityPaper == '--None--'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select Capacity Paper'));    
            return null;
        }
        Policy__c pol=[select id, Name,VG_Is_Renewal__c from Policy__c where Id=:policyId limit 1];
        List<Policy_Schedule__c> psList2 = new List<Policy_Schedule__c>([SELECT Id, Name, Policy__c, VG_Rate_Change__c FROM Policy_Schedule__c WHERE Policy__c=:policyId ORDER BY CreatedDate DESC]);        
        List<VG_Policy_Schedule_Endorsement__c> endToBeInserted  =  new List<VG_Policy_Schedule_Endorsement__c>();
        List<VG_Policy_Schedule_Asset__c> assetsToBeInserted  =  new List<VG_Policy_Schedule_Asset__c>();
        ps.Policy__c  =  policyId;
        ps.CurrencyISOCode  =  policyCurrency;
        ps.Risk_Premium_Pro__c  =  RiskPremium;
        ps.Endorsement_Premium_Pro__c  =  EndorsementPremium;
        ps.Net_Premium__c  =  netModelPremium;
        ps.Transaction_GWP__c  =  TransactionalPremium;
        ps.Sum_Insured__c = TotalsumInsured;
        ps.Gross_Written_Premium__c  =  GWP ;
        ps.VG_Gross_Written_Premium_100__c  =  GWP100 ;
        ps.Gross_or_Net_Premium__c  =  GNP ;
        ps.Written_share__c  =  writtenShare;
        ps.Share__c  =  signedShare;
        ps.Limit__c  =  limitAmt;
        If(RateChange == 0.00 && policy.VG_Is_Renewal__c   == false)       
            ps.VG_Rate_Change__c   =   null;
        else
            ps.VG_Rate_Change__c   =  RateChange;
        ps.Attachment__c  =  attachment;
        ps.ILF_Layer__c  =  'Primary';
        ps.Technical_UW_Premium__c  =  TechnicalUnderwritingPremium;
        ps.VG_Technical_Model_Premium__c  =  TechnicalModelPremium;
        ps.VG_Is_MTA__c  =  False;
        ps.VG_Base_Policy__c = true;
        ps.Base_Creation_Start_Date__c  =  policy.VG_Inception_Date__c;
        ps.Base_Creation_End_Date__c  =  policy.VG_Expiry_Date__c;
        ps.VG_Brokerage_Percent__c  =  BrokeragePrecent;
        ps.Actual_GWP__c = actualPremium;
        ps.VG_Brokerage_Amount__c = brokerageAmount;
        ps.Premium_Adjustment__c = UWAdjustment;
        ps.Premium_Adjustment_2__c = CommercialAdjustment;
        ps.VG_Capacity_Paper__c = CapacityPaper ;       
        ps.VG_Base_Policy__c  =  True;
        String tmp;
        List<Integer> psNumList = new List<Integer>();                    
        if(psList2.size() > 0){
            String bsname;
            for(Policy_Schedule__c psh: psList2){
                if(psh.Name.contains('/EEA'))
                    bsname = psh.Name.remove('/EEA');
                if(psh.Name.contains('/NonEEA'))
                    bsname = psh.Name.remove('/NonEEA');
                if(!psh.Name.contains('/NonEEA') && !psh.Name.contains('/EEA')){
                    bsname = psh.Name;
                    System.debug('bsname2::'+bsname );
                }
                if(bsname.contains('/PS/'))
                    psNumList.add(Integer.valueOf(bsname.split('/PS/')[1]));
                else if(bsname.contains('/MTA/'))
                    psNumList.add(Integer.valueOf(bsname.split('/MTA/')[1]));
            }
            psNumList.sort();
            ps.Name  =  pol.Name+'/PS/'+((psNumList[psNumList.size()-1])+1);        
        }else{
            ps.Name  =  pol.Name+'/PS/0';    
        }  
        if(ps.Split_Type__c == 'EEA'){
            ps.Name += '/EEA';
        }else if(ps.Split_Type__c == 'Non EEA'){
            ps.Name += '/NonEEA';
        } 
        Insert ps;
        RC.Policy_Schedule__c = ps.id;
        RC.Name = ps.Name+'/RD/1';
        RDInfo='Notice of Event Limit :'+NoticeofEventLimit+'<br/>';
        RDInfo+='Proof of Loss Limit :'+ProofofLossLimit+'<br/>';
        RDInfo+='Payment after POL limit :'+PaymentafterPOLlimit+'<br/>';
        RDInfo+='Sunset Clause :'+SunsetClause+'<br/>';
        RDInfo+='Salvage Provisions :'+SalvageProvisions+'<br/>';
        RDInfo+='CTL Provisions :'+CTLProvisions+'<br/>';
        RDInfo+='Loss Minimisation :'+LossMinimisation+'<br/>';
        RDInfo+='Power Margin :'+PowerMargin+'<br/>';
        RDInfo+='Propellant Margin :'+PropellantMargin+'<br/>';
        RDInfo+='Loss Formula :'+LossFormula+'<br/>';
        RDInfo+='AVN 41/21:'+AVN4121;
        rc.VG_Additional_Information__c = RDInfo;
        insert RC;
        Integer psacount = 1;
        for(RRWrapper rrw : addedRRList){
            rrw.psa.Name  =  ps.Name + '/RR/' + psacount;
            rrw.psa.VG_Policy_Schedule__c = ps.id;
            rrw.psa.Annual_Rate_100__c = rrw.techPremium;
            assetsToBeInserted.add(rrw.psa);
            psacount++;
        }
        if(!assetsToBeInserted.IsEmpty()){
            Insert assetsToBeInserted;
        }
        return new PageReference('/'+ps.id);
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
            GWP  =  GWP + temp.psa.Annual_Rate_100__c;
            RiskPremium  =  RiskPremium + temp.psa.VG_Premium__c;
        }     
        netModelPremium = RiskPremium + EndorsementPremium;
        TechnicalUnderwritingPremium  =  netModelPremium + UWAdjustment;   
        GWP100  =  TechnicalUnderwritingPremium + CommercialAdjustment;
        try{
            signedShare  =  (GWP/GWP100)*100;
        }catch(Exception ex){
            signedShare  =  0;
        }
        TechnicalModelPremium  =  netModelPremium * (signedShare/100);
        if(BrokeragePrecent != null && BrokeragePrecent != 0)
            BrokerageAmount  =  GWP *(BrokeragePrecent/100);
        ActualPremium  =  GWP - BrokerageAmount;
        if(GNP == 'Gross')
            TransactionalPremium  =  GWP;
        else if(GNP == 'Net')
            TransactionalPremium  =  GWP- BrokerageAmount;       
    }
    
    
    public void RRCalc(){
        TotalSI = 0;
        TotalPremium = 0;
        for(RRWrapper temp : addedRRList){
            System.debug('temp::'+addedRRList);
            If(temp.psa.VG_AVG_SI__c!=null && temp.psa.VG_Base_Premium_Rate__c!=null && temp.psa.VG_Signed_Share__c!=null){
                temp.techPremium  =  temp.psa.VG_AVG_SI__c * (temp.psa.VG_Base_Premium_Rate__c/100)*(temp.psa.VG_Signed_Share__c/100);
                temp.psa.Annual_Rate_100__c = temp.techPremium;
                temp.psa.VG_Premium__c  =  temp.psa.VG_Avg_SI__c * (temp.psa.VG_Base_Premium_Rate__c/100);
                if(policyCurrency != 'USD'){
                    System.debug('10-1-2018::' +policyCurrency+'::'+(temp.psa.VG_Premium__c/currencyRateMap.get(policyCurrency).ConversionRate).setScale(2));
                    temp.PremiumUSD = (temp.psa.VG_Premium__c/currencyRateMap.get(policyCurrency).ConversionRate).setScale(2);
                }else{
                    temp.PremiumUSD = temp.psa.VG_Premium__c.setScale(2);
                }
                If(temp.psa.VG_AVG_SI__c>0 && temp.psa.VG_Base_Premium_Rate__c>0 && temp.psa.VG_Signed_Share__c>0){
                    TotalPremium = (TotalPremium+temp.psa.VG_Premium__c).setScale(2);
                }
                System.debug('5.12::'+addedRRList+'premium::'+temp.psa.VG_Premium__c+'::AvgSI::'+temp.psa.VG_AVG_SI__c);
            }
            If(temp.psa.VG_Signed_Share__c!=null && temp.psa.VG_Limit__c!=null){
                temp.sumInsured = temp.psa.VG_Limit__c*(temp.psa.VG_Signed_Share__c/100);
                temp.psa.VG_Sum_Insured__c = temp.sumInsured;
                if(temp.sumInsured > TotalSI){
                    TotalSI = temp.sumInsured;
                }
                if(policyCurrency != 'USD'){
                    temp.SIUSD = (temp.psa.VG_Sum_Insured__c/currencyRateMap.get(policyCurrency).ConversionRate).setScale(2);
                }else{
                    temp.SIUSD = temp.psa.VG_Sum_Insured__c.setScale(2);
                }
                /*If(temp.psa.VG_Signed_Share__c>0  && temp.psa.VG_Limit__c>0){
                    TotalSI = temp.psa.VG_Sum_Insured__c.setScale(2);
                }*/
                System.debug('5.12::'+temp.psa.VG_Limit__c+'sign::'+(temp.psa.VG_Signed_Share__c/100));                               
            }  
        }
        if(policyCurrency != 'USD'){
            TotalPremium = (TotalPremium/currencyRateMap.get(policyCurrency).ConversionRate).setScale(2);
        }else{
            TotalPremium = TotalPremium.setScale(2);
        }
        if(policyCurrency != 'USD'){
            TotalSI = (TotalSI/currencyRateMap.get(policyCurrency).ConversionRate).setScale(2);
        }else{
            TotalSI = TotalSI.setScale(2);
        }
        
    }
    
    
    public class RRWrapper{
        public VG_Policy_Schedule_Asset__c psa{get;set;}
        public String assName{get;set;}
        public String Counter{get;set;}
        public Boolean IsSelected{get;set;}
        public String Coverage{get;set;}
        public String CoverageType{get;set;}
        public Decimal techPremium{get;set;}
        public Decimal PremiumUSD{get;set;}
        public Decimal SIUSD{get;set;}
        public Decimal sumInsured{get;set;}
        public RRWrapper(){
            psa = new VG_Policy_Schedule_Asset__c ();
        }
    }
    //SubClasses Ends
}