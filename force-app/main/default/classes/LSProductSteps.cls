Public Class LSProductSteps{
    
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
    public String PRRZtext{get;set;}
    public String AERNtext{get;set;}
    public String AERtext{get;set;}
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
    public String policyCurrency {get; set;}
    public String Index{get;set;}
    public String GrossOrNet {get; set;}
    public String rd{get;set;}
    
    public Id policyId {get; set;}
    
    public Boolean skipSplit {get; set;}
    
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
    public Decimal RateChange {get;set;}
    public Decimal endorsementPremium {get; set;} 
    public Decimal TSI {get; set;}  
    public Decimal proRata{get; set;}   
    
    Public Risk_Capture__c rc{get;set;}
    public Policy__c pol{get;set;}
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
    List<VG_Policy_Schedule_Endorsement__c> manualList{get;set;}
    
    Public LSProductSteps(){
        policyId  =  apexpages.currentpage().getparameters().get('Id');
        pol=[select id, Name, VG_Is_Renewal__c ,VG_Inception_Date__c, VG_Expiry_Date__c from Policy__c where Id=:policyId limit 1]; 
        policyCurrency  =  apexpages.currentpage().getparameters().get('Currency');
        //proRata=(Decimal.valueOf(pol.VG_Inception_Date__c.daysBetween(pol.VG_Expiry_Date__c))+1)/365;
        if(Math.mod(pol.VG_Inception_Date__c.year(), 4) !=  0){
            if(Math.mod(pol.VG_Expiry_Date__c.year(), 4)  ==  0){
                if(pol.VG_Expiry_Date__c <=  date.newInstance(pol.VG_Expiry_Date__c.year(), 02, 28)){
                    proRata = Decimal.valueOf(pol.VG_Inception_Date__c.daysBetween(pol.VG_Expiry_Date__c)+1)/365;
                }else{
                    proRata = Decimal.valueOf(pol.VG_Inception_Date__c.daysBetween(pol.VG_Expiry_Date__c))/365;
                }
            }else{
                proRata = Decimal.valueOf(pol.VG_Inception_Date__c.daysBetween(pol.VG_Expiry_Date__c)+1)/365;
            }
        }else{
            if(pol.VG_Inception_Date__c < date.newInstance(pol.VG_Inception_Date__c.year(),03,01)){
                proRata = Decimal.valueOf(pol.VG_Inception_Date__c.daysBetween(pol.VG_Expiry_Date__c))/365;
            }else{
                proRata = Decimal.valueOf(pol.VG_Inception_Date__c.daysBetween(pol.VG_Expiry_Date__c)+1)/365;
            }
        }    
        ps  =  new Policy_Schedule__c();   
        rc = new Risk_Capture__c();
        rc.CurrencyISOCode  =  policyCurrency;
        IVtext='0.00';
        RRcounter  =  1;
        counter = counterEnd = 0;
        netModelPremium = 0;
        RiskPremium = 0;
        sumInsured = adjustment = adjustmentTechPremium = uwPremium = techModelPremium = sharePercent = writtenShare = 0;
        vat = vatamount = IPTPercent = levies = brokerage = brokerageAmount = grossWrittenPremium = grossWrittenPremium2 = IPTAmount = feeIncome = actualPremium = 0;
        Index='0';
        VG_Policy_Schedule_Asset__c psa  =  new VG_Policy_Schedule_Asset__c();
        psa.CurrencyISOCode  =  policyCurrency;
        psa.VG_Base_Premium__c = 0;
        psa.VG_Premium__c = 0;
        psa.VG_Base_Premium_Rate__c = 0;
        riskRatingList  =  new List<RRWrapper>();
        RRWrapper RRW  =  new RRWrapper();
        RRW.psa  =  psa;
        RRW.counter  =  '0';
        RRW.CoverageSelected = '--None--';
        RRW.share = 0;        
        riskRatingList.add(RRW);
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
        if(pol.VG_Inception_Date__c.year() <= 2020){
            splitTypes.add(new SelectOption('','--None--'));
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
        manualList = new List<VG_Policy_Schedule_Endorsement__c>();    
    }
    public void setLPList(){
       RRCoverage_Select.clear();
       if(Product == 'Property'){ 
            RRCoverage_Select.add(new SelectOption('--None--','--None--'));                
            RRCoverage_Select.add(new SelectOption('Property Damage','Property Damage'));
            RRCoverage_Select.add(new SelectOption('Specified Items','Specified Items'));                               
            RRCoverage_Select.add(new SelectOption('Business Interruption','Business Interruption'));
            RRCoverage_Select.add(new SelectOption('Loss of License','Loss of License'));
            RRCoverage_Select.add(new SelectOption('Goods In Transit','Goods In Transit'));
            RRCoverage_Select.add(new SelectOption('Money','Money'));
            RRCoverage_Select.add(new SelectOption('Fidelity','Fidelity'));
        }
        if(Product == 'Liability'){
            RRCoverage_Select.add(new SelectOption('--None--','--None--'));  
            RRCoverage_Select.add(new SelectOption('Employers Liability','Employers Liability'));
            RRCoverage_Select.add(new SelectOption('Public & Product Liability','Public & Product Liability'));
            RRCoverage_Select.add(new SelectOption('Professional Indemnity','Professional Indemnity'));
        }
        if(Product == 'PA'){
            RRCoverage_Select.add(new SelectOption('--None--','--None--'));  
            RRCoverage_Select.add(new SelectOption('Personal Accident','Personal Accident'));
        }
        if(Product == 'D&O'){
            RRCoverage_Select.add(new SelectOption('--None--','--None--'));  
            RRCoverage_Select.add(new SelectOption('D&O','D&O'));
        }
        if(Product == 'Legal'){  
            RRCoverage_Select.add(new SelectOption('--None--','--None--'));               
            RRCoverage_Select.add(new SelectOption('Legal Expenses','Legal Expenses'));
        }                           
    }
    public PageReference cancel(){
         return new PageReference('/'+policyId);
    }
    Public PageReference gotostep1(){
        return new PageReference('/apex/VG_LS_Step_1');
    } 
    Public PageReference gotostep2(){  
        if(Product == '' || Product == null || Product == '--None--'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please Select Product..'));   
            return null;
        }      
        return new PageReference('/apex/VG_LS_Step_2');
    }   
    public PageReference gotostep3(){
         /*If((PRRZtext==null || PRRZtext=='') && Product=='Property'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please give value for Pool Re Rating Zone..'));   
            return null;
        } 
        If(((APtext==null || APtext=='') || (AERNtext==null || AERNtext=='') || (AERtext==null || AERtext=='')) && Product=='Liability'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please give value for "Additional Insured,  policy type", "Additional Insured,  employer,  ERN exempt flag", "Additional Insured,  employer reference number"..'));   
            return null;
        } */
        return new PageReference('/apex/VG_LS_Step_3');
    }
     public PageReference gotostep4(){
        if(riskRatingList.IsEmpty()){
           ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please add atleast one Risk Rating to the policy schedule..'));   
           return null;
        }
         if(!existingEndorsements1.IsEmpty()){
            existingEndorsements1.clear();
        }
        for(RRWrapper rr : riskRatingList){
            rr.psa.VG_Coverage__c = rr.CoverageSelected;
            rr.psa.VG_Perils__c = rr.PerilsSelected;
        }
        ElList1=[select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where Type__c=:'Sub-limits' AND VG_Product__c=:Product AND RecordType.Name =: 'Affinity' ORDER By Name ASC];        
        LibraryWrapperList1.clear();       
        for(Endorsement_Library__c EL1 : ElList1){            
            LW1  =  new LibraryWrapper();
            LW1.EL  =  EL1;            
            LW1.isSelected  =  False;                    
            LibraryWrapperList1.add(LW1); 
        }
        return new PageReference('/apex/VG_LS_Step_4');
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
       return new PageReference('/apex/VG_LS_Step_4b');
    }
    public PageReference gotostep5(){
        for(VG_Policy_Schedule_Endorsement__c pse:existingEndorsements){
            if(pse.VG_Endorsement_Library_Id__c == null)
                manualList.add(pse);
        }
        if(!existingEndorsements.IsEmpty()){
            existingEndorsements.clear();
        } 
        If(!manualList.IsEmpty())
            manualList.clear(); 
        for(RRWrapper rr : riskRatingList){
            rr.psa.VG_Coverage__c = rr.CoverageSelected;
            rr.psa.VG_Perils__c = rr.PerilsSelected;
        }
        ElList = [select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where Type__c=:'Endorsements'  AND VG_Product__c=:Product  AND RecordType.Name =: 'Affinity' ORDER By Name ASC];
        
        LibraryWrapperList.clear();
        for(Endorsement_Library__c EL : ElList){            
            LW  =  new LibraryWrapper();
            LW.EL  =  EL;            
            LW.isSelected  =  False;                    
            LibraryWrapperList.add(LW); 
        }  
        return new PageReference('/apex/VG_LS_Step_5');
    }
     
    public PageReference gotostep5b(){
        EndorsementPremium = 0;
        Set<ID> elid = new Set<ID>();
        List<VG_Policy_Schedule_Endorsement__c> tmpPSEList = new List<VG_Policy_Schedule_Endorsement__c>();
        Map<Id, VG_Policy_Schedule_Endorsement__c> tmpPSEMap = new Map<Id, VG_Policy_Schedule_Endorsement__c>();
        for(VG_Policy_Schedule_Endorsement__c pe:existingEndorsements){
            tmpPSEMap.put(pe.VG_Endorsement_Library_Id__c, pe);
            if(pe.VG_Endorsement_Library_Id__c==null)tmpPSEList.add(pe);
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
                if(tmpPSEMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Title__c  =  tmpPSEMap.get(LW.EL.Id).VG_Title__c ;                
                    tempEndsmt.VG_Endorsement_Details__c  =  tmpPSEMap.get(LW.EL.Id).VG_Endorsement_Details__c ;
                }
                tempEndsmt.VG_Premium__c  =  0;
                tempEndsmt.VG_Sub_limit__c  =  0;
                tempEndsmt.CurrencyISOCode  =  policyCurrency ;
                tempEndsmt.VG_Endorsement_Number__c  =  LW.EL.Name;
                tempEndsmt.VG_Type__c = LW.EL.Type__c;
                System.debug('Type::'+tempEndsmt.VG_Type__c+'::'+LW.EL.Type__c);
                tempEndsmt.VG_IsTempDelete__c  =  False;
                tempEndsmt.VG_IsTemp__c  =  True;
                counterEnd++;
                existingEndorsements.add(tempEndsmt);
            }
        }
        for(VG_Policy_Schedule_Endorsement__c pse:tmpPSEList){
            existingEndorsements.add(pse);
        }
        tmpPSEList.clear();
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
       return new PageReference('/apex/VG_LS_Step_5b');
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
        RiskPremium  =  RiskPremium  * proRata;
        EndorsementPremium  =  EndorsementPremium * proRata;
        netModelPremium  =  RiskPremium + EndorsementPremium;
        UpdateFinalCalculations();
        return new PageReference('/apex/VG_LS_Step_6');
    }
    public PageReference finish(){
        Savepoint sp = Database.setSavepoint();
        try{
            List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([SELECT Id, Name, Policy__c FROM Policy_Schedule__c WHERE Policy__c=:policyId ORDER BY CreatedDate DESC]);                         
            List<VG_Policy_Schedule_Asset__c> assetsToBeInserted  =  new List<VG_Policy_Schedule_Asset__c>();
            List<VG_Policy_Schedule_Endorsement__c> endToBeInserted  =  new List<VG_Policy_Schedule_Endorsement__c>();
            List<VG_Policy_Schedule_Endorsement__c> subendToBeInserted  =  new List<VG_Policy_Schedule_Endorsement__c>();       
            List<Integer> psNumList = new List<Integer>();
            System.debug('pol.Name::'+pol.Name);
            if(psList.size() > 0){
                String bsname;
                for(Policy_Schedule__c psh: psList){
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
            ps.CurrencyISOCode  =  policyCurrency;
            ps.Policy__c  =  policyId;
            ps.Product__c = Product;
            ps.Net_Premium__c  =  netModelPremium;
            ps.Endorsement_Premium_Pro__c = endorsementPremium;
            ps.Risk_Premium_Pro__c  =  RiskPremium;
            ps.Written_share__c  =  writtenShare ;
            ps.Share__c = sharePercent;
            ps.Actual_GWP__c = actualPremium;
            ps.VG_Brokerage_Percent__c  =  brokerage;
            ps.VG_Brokerage_Amount__c = brokerageAmount;
            ps.Gross_Written_Premium__c  =  grossWrittenPremium2 ;
            If(RateChange == 0.00 && pol.VG_Is_Renewal__c   == false)       
                ps.VG_Rate_Change__c   =   null;
            else
                ps.VG_Rate_Change__c   =  RateChange;
            ps.VG_Gross_Written_Premium_100__c  =  grossWrittenPremium;
            //ps.Transaction_GWP__c  =  transactionPremium;
            ps.Premium_Adjustment__c  =  adjustmentTechPremium;
            ps.Premium_Adjustment_2__c  =  adjustment;
            ps.IPT__c = IPTAmount;
            ps.IPT_Percent__c  =  IPTPercent;
            ps.VG_Fee_Income__c  =  feeIncome;
            ps.Levies__c  =  levies;
            ps.Gross_or_Net_Premium__c  =  GrossOrNet ;
            ps.Sum_Insured__c  =  sumInsured;
            ps.VG_VAT__c = vat;
            ps.VG_Capacity_Paper__c  =  CapacityPaper;
            ps.VG_VAT_Amount__c = vatamount;
            ps.VG_Witholding_Tax_Amount__c = taxamount;
            ps.Technical_UW_Premium__c  =  uwPremium;
            ps.VG_Technical_Model_Premium__c  =  techModelPremium;
            ps.Base_Creation_Start_Date__c  =  pol.VG_Inception_Date__c;
            ps.Base_Creation_End_Date__c  =  pol.VG_Expiry_Date__c;
            ps.VG_Base_Policy__c = true;
            ps.RecordTypeId = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();       
            Insert ps;
            RC.Policy_Schedule__c = ps.id;
            RC.Name = ps.Name+'/RD/1';
            IVtext = IVtext.remove('%');
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
               
            }else if(Product == 'D&O'){
                rd='Directors & Officers Liability :'+DOtext+'<br/>';
            }else if(Product == 'Legal'){
                rd='Legal Expenses :'+LEtext+'<br/>';
            }
            System.debug('Test::'+rd);
            RC.VG_Additional_Information__c = rd;
            insert RC;
            Integer psecount = 1;
            Integer sbpsecount = 1;
            for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements){
                pse.VG_Policy_Schedule__c  =  ps.Id;
                pse.Name =  ps.Name + '/PE/' + psecount;
                endToBeInserted.add(pse);
                psecount++;
            }
            for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements1){
                pse.VG_Policy_Schedule__c  =  ps.Id;
                pse.Name =  ps.Name + '/PESb/' + sbpsecount;
                endToBeInserted.add(pse);
                sbpsecount++;
            }
                   
            if(!endToBeInserted.IsEmpty()){
                System.debug('endToBeInserted::'+endToBeInserted+endToBeInserted.size());
                Insert endToBeInserted;
            }
            Integer psacount = 1;
            for(RRWrapper rrw : riskRatingList){
                rrw.psa.Name  =  ps.Name + '/RR/' + psacount;
                rrw.psa.VG_Policy_Schedule__c = ps.id;
                rrw.psa.RecordTypeId = Schema.SObjectType.VG_Policy_Schedule_Asset__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();           
                assetsToBeInserted.add(rrw.psa);
                psacount++;
            }
            if(!assetsToBeInserted.IsEmpty()){
                Insert assetsToBeInserted;
            }
             return new PageReference('/'+ps.Id);
         }Catch(Exception e){
            showError(e);
            Database.rollback(sp);
            return null;
        }
    }
    
    Public void showError(Exception e){
        String refId = ErrorTrace.insertLog(e , policyId);
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'An error occurred please contact admin with this reference id '+refId));     
    }
    
    public void UpdateFinalCalculations(){
        If(RateChange==0.00 && pol.VG_Is_Renewal__c == false)
            RateChange=null;
        sumInsured = TSI*(sharePercent/100)  ;
        uwPremium = netModelPremium+adjustmentTechPremium;
        grossWrittenPremium  = uwPremium+adjustment;
        If(sharePercent != 0 && sharePercent != null)
            grossWrittenPremium2  = grossWrittenPremium*(sharePercent/100); 
        brokerageAmount  =  grossWrittenPremium2 *(brokerage/100);
        actualPremium = grossWrittenPremium2 -brokerageAmount;
        techModelPremium = (sharePercent/100)*netModelPremium;
        vatamount = (vat/100)*feeIncome;
        /*If(IPTPercent != null){
            IPTAmount = grossWrittenPremium*(IPTPercent/100);
        }
        If(GrossOrNet == 'Gross'){
            transactionPremium = grossWrittenPremium+((IPTPercent/100)*grossWrittenPremium)+feeIncome;
        }else{
            transactionPremium = actualPremium+((IPTPercent/100)*grossWrittenPremium)+feeIncome;
        }*/
    }
     public void AddCustom(){
        VG_Policy_Schedule_Endorsement__c tempEndsmt  =  new VG_Policy_Schedule_Endorsement__c();
        tempEndsmt.CurrencyISOCode  =  policyCurrency;
        tempEndsmt.VG_Premium__c  =  0;
        tempEndsmt.VG_Sub_limit__c = 0;
        tempEndsmt.VG_Type__c = 'Endorsements';
        existingEndorsements.add(tempEndsmt);
    }
    public void addRR(){
        Boolean allOkToTaddNewAsset  =  True;
        RRWrapper waNew = new RRWrapper();
        waNew.Counter = string.valueOf(RRcounter);            
        if(allOkToTaddNewAsset){
            VG_Policy_Schedule_Asset__c psaNew = new VG_Policy_Schedule_Asset__c();
            psaNew.CurrencyISOCode  =  policyCurrency;
            psaNew.VG_Base_Premium__c = 0;
            psaNew.VG_Base_Premium_Rate__c = 0;
            psaNew.VG_Premium__c = 0;
            psaNew.CurrencyISOCode  =  policyCurrency;
            waNew.psa = psaNew;
            riskRatingList.add(waNew);
            RRcounter++;
        }
        System.debug('riskRatingList::'+riskRatingList.size()+'::'+riskRatingList);
    }
    public void RRCalc(){           
        for(RRWrapper rrw:riskRatingList){
          If(Product != 'PA'){               
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
        public String CoverageSelected{get;set;}
        public String PerilsSelected{get;set;}
        //public Decimal techPremium{get;set;}
       
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