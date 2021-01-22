Public Class VG_AlphaStepsController{
    
    public Policy_Schedule__c ps{get;set;}
    public Risk_Capture__c rc{get;set;}
    public VG_Policy_Schedule_Asset__c rr{get;set;}
    public Policy__c policy{get;set;}
    public LibraryWrapper LW1{get;set;}
    public LibraryWrapper LW{get;set;}
    
    public boolean EnableReinstatement{get;set;}
    public boolean RD1to4{get;set;}
    public boolean RD5to6{get;set;}
    public boolean RD7to8{get;set;}
    public boolean RR1to4{get;set;}
    public boolean RR5{get;set;}
    public boolean RR6{get;set;}
    public boolean RR7to8{get;set;}
    public boolean layerlist{get;set;}
    public Boolean stopProcess{get; set;}
    public Boolean skipSplit {get; set;}
    
    public string CapacityPaper{get;set;}
    public String RI_Select{get;set;}
    public String TT_Select{get;set;}
    public String Structure_Select{get;set;}
    public String Product_Select{get;set;}
    public String SubProduct_Select{get;set;}
    public String PolicyDetails{get;set;}
    Public String Insurer{get;set;}
    Public String InsurerPolicyNumber{get;set;}
    Public String InsurerPolicyCurrency{get;set;}
    Public String InsurerPolicyLimit{get;set;}
    Public String InsurerPolicyDedctible{get;set;}
    Public String InsurerPolicyPremium{get;set;}
    Public String InsurerPolicyShare{get;set;}
    
    public ID policyId{get;set;}
    
    public List<VG_Policy_Schedule_Endorsement__c> manualList{get;set;}
    public List<Endorsement_Library__c> ElList1{get;set;}
    public List<Endorsement_Library__c> ElList{get;set;} 
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements1 {get; set;}
    public List<LibraryWrapper> LibraryWrapperList1 {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements {get; set;}
    public List<LibraryWrapper> LibraryWrapperList {get; set;}
    public List<SelectOption> Currency_List{get;set;}
    public List<SelectOption> TT_List{get;set;}
    public List<SelectOption> SubCoverage_List{get;set;}
    public List<SelectOption> SubCoverage_SelectedList{get;set;}
    public List<SelectOption> Structure_List{get;set;}
    public List<SelectOption> Product_List{get;set;}
    public List<SelectOption> SubProduct_List{get;set;}
    public list<SelectOption> NonEEAVolanteEntity_Select {get; set;}
    Public List<SelectOption> splitTypes{get; set;}
    Public list<Integer> createLoop {get; set;}
    Public List<String> ReinstatementValues {get; set;}
    public List<Integer> NOIList{get;set;}
    public List<Integer> NOIList2{get;set;}
    
    public Integer counterEnd {get; set;}
    
    public Decimal Overider{get;set;}
    public Decimal Brokerage{get;set;}
    public Decimal FeeIncome{get;set;}
    public Decimal ActualPremium{get;set;}
    public Decimal Levies{get;set;}
    public Decimal PremiumAdjustment{get;set;}
    public Decimal TotalLayerPremium{get;set;}
    public Decimal SignedShare{get;set;}
    public Decimal WrittenShare{get;set;}
    public Decimal GrossWrittenPremium{get;set;}
    public Decimal GrossWrittenPremium2{get;set;}
    public Decimal TechnicalPremium{get;set;}
    public Decimal BrokerageAmount{get;set;}
    public Decimal OveriderAmount{get;set;}
    public Decimal RateOnLine{get;set;}
    public Decimal RateChange {get;set;}
    public Decimal MinimumPremium{get;set;}
    public Decimal DepositPremium{get;set;}
    public Decimal NCBValue{get;set;}
    public Decimal RiskPremium{get;set;}
    public Decimal PSRiskPremium{get;set;}
    public Decimal EndorsementPremium{get;set;}
    public Decimal TechnicalLossRatio{get;set;}
    public Decimal Retention{get;set;}
    public Decimal ExpectedCedingCommission{get;set;}
    public Decimal ExpectedProfitCommission{get;set;}
    public Decimal TreatyLimit{get;set;}
    public Decimal sumInsured{get;set;}
    public Decimal proRata{get;set;}
    public Decimal limitperrisk{get;set;}
    public Decimal deductibleperrisk {get;set;}
    
    //Constructor 
    public VG_AlphaStepsController(){
        try{
            policyId = apexpages.currentpage().getparameters().get('Id');
            policy=[select id, Name,VG_Is_Renewal__c, CurrencyIsoCode, Type_of_Insurance__c, Insured__r.Name, VG_Inception_Date__c, VG_Expiry_Date__c, VG_Aggregate_Limit__c, Deductible_or_Excess_Amount__c, VG_Prospect_Premium__c, Sum_Insured_Share__c from Policy__c where id=: policyId];
            splitTypes = new List<SelectOption>();
            skipSplit = False;
            if(policy.VG_Inception_Date__c.year() <= 2020){
                splitTypes.add(new SelectOption('','--None--'));
                skipSplit = True;
            }
            splitTypes.add(new SelectOption('Non EEA','Non EEA'));
            if(Math.mod(policy.VG_Inception_Date__c.year(), 4) !=  0){
                if(Math.mod(policy.VG_Expiry_Date__c.year(), 4)  ==  0){
                    if(policy.VG_Expiry_Date__c <=  date.newInstance(policy.VG_Expiry_Date__c.year(), 02, 28)){
                        proRata = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1)/365;
                    }else{
                        proRata = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c))/365;
                    }
                }else{
                    proRata = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1)/365;
                }
            }else{
                if(policy.VG_Inception_Date__c < date.newInstance(policy.VG_Inception_Date__c.year(),03,01)){
                    proRata = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c))/365;
                }else{
                    proRata = Decimal.valueOf(policy.VG_Inception_Date__c.daysBetween(policy.VG_Expiry_Date__c)+1)/365;
                }
            }    
            ps =  new Policy_Schedule__c();
            rr =  new VG_Policy_Schedule_Asset__c();
            rc = new Risk_Capture__c();
            rr.RecordTypeId = Schema.SObjectType.VG_Policy_Schedule_Asset__c.getRecordTypeInfosByName().get('Imara').getRecordTypeId();
            LibraryWrapper LW;
            LibraryWrapper LW1;
            
            createLoop = new List<Integer>();
            ReinstatementValues = new List<String>();
            NOIList = new List<Integer>();
            NOIList2 = new List<Integer>();
            TT_List  =  new List<SelectOption>();
            Currency_List  =  new List<SelectOption>();
            Structure_List  =  new List<SelectOption>();
            Product_List  =  new List<SelectOption>();
            SubProduct_List  =  new List<SelectOption>();
            SubCoverage_List  =  new List<SelectOption>();
            SubCoverage_SelectedList =  new List<SelectOption>();
            existingEndorsements1  =  new List<VG_Policy_Schedule_Endorsement__c>();
            existingEndorsements  =  new List<VG_Policy_Schedule_Endorsement__c>();
            manualList = new List<VG_Policy_Schedule_Endorsement__c>();
            LibraryWrapperList1  =  new List<LibraryWrapper >();
            LibraryWrapperList  =  new List<LibraryWrapper >();
            
            Insurer='';
            InsurerPolicyNumber='';
            InsurerPolicyCurrency='';
            InsurerPolicyLimit='';
            InsurerPolicyDedctible='';
            InsurerPolicyPremium='';
            InsurerPolicyShare='';
            Structure_Select='';
            Product_Select='';
            NonEEAVolanteEntity_Select = new List<SelectOption>();
            for(String s : Label.Imara_NonEEAVolanteEntity.split(';')){
                NonEEAVolanteEntity_Select.add(new SelectOption(s,s));
            }
            if(policy.Type_of_Insurance__c!= null){
                RI_Select = policy.Type_of_Insurance__c;
                Structure_List.add(new SelectOption('--None--','--None--'));
                Structure_List.add(new SelectOption('Proportional','Proportional'));
                Structure_List.add(new SelectOption('Non-Proportional','Non-Proportional'));
                SubProduct_List.add(new SelectOption('Property Risk','Property Risk'));
                SubProduct_List.add(new SelectOption('Property CAT','Property CAT'));
                SubProduct_List.add(new SelectOption('Property','Property'));
                SubProduct_List.add(new SelectOption('Motor','Motor'));
                SubProduct_List.add(new SelectOption('Engineering','Engineering'));
                SubProduct_List.add(new SelectOption('Credit','Credit'));
                SubProduct_List.add(new SelectOption('Liability','Liability'));
                SubProduct_List.add(new SelectOption('Marine','Marine'));
                SubProduct_List.add(new SelectOption('PVT','PVT'));
                SubProduct_List.add(new SelectOption('Aviation','Aviation'));
                SubProduct_List.add(new SelectOption('Energy','Energy'));
                SubProduct_List.add(new SelectOption('Agriculture','Agriculture'));
                SubProduct_List.add(new SelectOption('Health','Health'));
                SubProduct_List.add(new SelectOption('Travel','Travel'));
            }else{
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please fill Type in Policy ...')); 
            }
            
            
            for(String s : Label.Alpha_Territories.split(';')){
                TT_List.add(new SelectOption(s,s));
            }
            TT_List.sort();
            
            Schema.DescribeFieldResult describeResult  =  Policy__c.CurrencyISOCode.getDescribe();
            List<Schema.PicklistEntry> entries  =  describeResult.getPicklistValues();
            List<SelectOption> optionsToReturn  =  new List<SelectOption>();
            for (Schema.PicklistEntry pEntry : entries) {
                if (pEntry.isActive()) {
                    Currency_List.add(new SelectOption(pEntry.getValue(), pEntry.getLabel()));
                }
            }
            
            EnableReinstatement = False;
            RD1to4 = false;
            RD5to6 = false;
            RD7to8 = false;
            RR1to4 = false;
            RR5 = false;
            RR6 = false;
            RR7to8 = false;
            layerlist = false;
            Overider = Brokerage = Retention = PSRiskPremium = TechnicalPremium = ExpectedCedingCommission = ExpectedProfitCommission = TreatyLimit = MinimumPremium = FeeIncome = RiskPremium = Levies = EndorsementPremium = PremiumAdjustment = TotalLayerPremium = SignedShare = WrittenShare = GrossWrittenPremium = GrossWrittenPremium2 = BrokerageAmount = OveriderAmount = RateOnLine = DepositPremium = NCBValue = TechnicalLossRatio = ActualPremium = sumInsured = limitperrisk = deductibleperrisk = 0;
            counterEnd = 0;
        }Catch(Exception e){
            stopProcess = true;
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'An error occurred please contact admin'));   
        }
    }
    
    //Steps
    public PageReference gotostep1(){
        return new PageReference('/apex/VG_Alpha_Step1');
    }
    
    public PageReference gotostep2(){
        try{
            if(CapacityPaper == '--None--'){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select Capacity Paper'));    
                return null;
            }
            if(RI_Select != 'Facultative Reinsurance' || RI_Select != 'Treaty Reinsurance'){
                if(Structure_Select != '--None--'){
                    if((RI_Select=='Treaty Reinsurance' && (Product_Select == 'Excess of Loss Per Risk' || Product_Select == 'Excess of Loss Per Event' || Product_Select == 'Excess of Loss Per Risk & Event' || Product_Select == 'Aggregate Excess of Loss')) || (RI_Select == 'Facultative Reinsurance' && (Product_Select == 'Loss Limit' || Product_Select == 'Excess of Loss Primary' || Product_Select == 'Excess of Loss Excess' ))){
                        layerlist = True;
                        RD1to4 = false;
                        RD5to6 = false;
                        RD7to8 = false;
                    }          
                    if((RI_Select=='Treaty Reinsurance' && Product_Select  == 'Aggregate Stop Loss')){
                        layerlist = false;
                        RD1to4 = True;
                        RD5to6 = false;
                        RD7to8 = false;                   
                    }else if(RI_Select=='Treaty Reinsurance' && (Product_Select  == 'Quota Share' || Product_Select == 'Structured Quota Share' || Product_Select == 'Facultative Obligatory' || Product_Select == 'Surplus')){
                        layerlist = false;
                        RD1to4 = false;
                        RD5to6 = True;
                        RD7to8 = false;
                    }else if(RI_Select == 'Facultative Reinsurance' && (Product_Select == 'Quota Share' || Product_Select == 'Line Slip')){
                        layerlist = false;
                        RD1to4 = false;
                        RD5to6 = false;
                        RD7to8 = True;
                    }else{
                        System.debug('here:'+RI_Select+':'+Product_Select );
                    }
                    
                    if((RI_Select=='Treaty Reinsurance' && (Product_Select == 'Excess of Loss Per Risk' || Product_Select  == 'Aggregate Stop Loss' || Product_Select == 'Excess of Loss Per Event' || Product_Select == 'Excess of Loss Per Risk & Event' || Product_Select == 'Aggregate Excess of Loss')) || (RI_Select == 'Facultative Reinsurance' && (Product_Select == 'Loss Limit' || Product_Select == 'Excess of Loss Primary' || Product_Select == 'Excess of Loss Excess' ))){
                        RR1to4 = True;
                        RR5 = false;
                        RR6 = false;
                        RR7to8 = false;
                    }else if(RI_Select=='Treaty Reinsurance' && (Product_Select == 'Quota Share' || Product_Select == 'Structured Quota Share' || Product_Select == 'Facultative Obligatory')){
                        RR1to4 = false;
                        RR5 = True;
                        RR6 = false;
                        RR7to8 = false;
                    }else if(RI_Select=='Treaty Reinsurance' && Product_Select == 'Surplus'){
                        RR1to4 = false;
                        RR5 = false;
                        RR6 = True;
                        RR7to8 = false;
                    }else if(RI_Select=='Facultative Reinsurance' && (Product_Select == 'Quota Share' || Product_Select == 'Line Slip')){
                        RR1to4 = false;
                        RR5 = false;
                        RR6 = False;
                        RR7to8 = True;
                    }
                }else{
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select structure ...')); 
                    return null;
                }
            }else{
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select Type of Insurance any one from Treaty or Facultative...')); 
                return null;
            }
            return new PageReference('/apex/VG_Alpha_Step2');
        }Catch(Exception e){
            showError(e);
            return null;
        }
    }
    
    public PageReference gotostep3(){
        return new PageReference('/apex/VG_Alpha_Step3');
    }
    
    public PageReference gotostep4(){
        try{
            for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements){
                if(pse.VG_Premium__c != null)
                    EndorsementPremium = EndorsementPremium+pse.VG_Premium__c;
            }
            if(RI_Select =='Facultative Reinsurance' && rr.VG_Risk_Premium__c != null){
                RiskPremium = rr.VG_Risk_Premium__c;
                PSRiskPremium  =  (RiskPremium * proRata).setScale(2);
            }
            if((Product_Select == 'Quota Share' || Product_Select == 'Surplus' || Product_Select == 'Structured Quota Share'|| Product_Select == 'Facultative Obligatory') && rr.VG_Expected_Premium_Income__c != null){
                RiskPremium = rr.VG_Expected_Premium_Income__c;
                PSRiskPremium =  (RiskPremium * proRata).setScale(2);
            }
            rc.VG_Territorial_Scope__c = TT_Select;
            
            if(rc.VG_Rate_Type__c =='Flat Premium')
                PSRiskPremium =  (RiskPremium * proRata).setScale(2);
            EndorsementPremium  =  EndorsementPremium * proRata;
            updatePremiums();
            RiskRatingCalc2();
            Calc();
            return new PageReference('/apex/VG_Alpha_Step4');
        }Catch(Exception e){
            showError(e);
            return null;
        }
    }
    
    public PageReference gotostep5(){
        
        if(!existingEndorsements1.IsEmpty()){
            existingEndorsements1.clear();
        }
        ElList1=[select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where Type__c=:'Sub-limits' AND RecordType.Name =: 'Imara' ORDER By Name ASC];        
        LibraryWrapperList1.clear();       
        for(Endorsement_Library__c EL1 : ElList1){            
            LW1  =  new LibraryWrapper();
            LW1.EL  =  EL1;            
            LW1.isSelected  =  False;                    
            LibraryWrapperList1.add(LW1); 
        }
        return new PageReference('/apex/VG_Alpha_Step5');
    }
    public PageReference gotostep5b(){
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
                    if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c != 0){
                        pse.VG_Premium__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c;
                    }
                    if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c != 0){
                        pse.VG_Sub_limit__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c;
                    }
                }
            }
            if(existingEndorsements1.IsEmpty()){
                counterEnd  =  0;
            }else{
                counterEnd  =  existingEndorsements1.size();    
            }
            return new PageReference('/apex/VG_Alpha_Step5b');
        }Catch(Exception e){
            showError(e);
            return null;
        }
    }
    public PageReference gotostep6(){
        for(VG_Policy_Schedule_Endorsement__c pse:existingEndorsements){
            if(pse.VG_Endorsement_Library_Id__c == null)
                manualList.add(pse);
        }
        if(!existingEndorsements.IsEmpty()){
            existingEndorsements.clear();
        }
        ElList=[select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where  RecordType.Name =: 'Imara' AND Type__c=:'Endorsements' ORDER By Name ASC];
        LibraryWrapperList.clear();
        for(Endorsement_Library__c EL : ElList){            
            LW  =  new LibraryWrapper();
            LW.EL  =  EL;            
            LW.isSelected  =  False;                    
            LibraryWrapperList.add(LW); 
        }
        return new PageReference('/apex/VG_Alpha_Step6');
    }
    public PageReference gotostep6b(){
        try{  
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
                    //tempEndsmt.CurrencyISOCode  =  policyCurrency ;
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
                        System.debug('tempend::'+tmpPSEMap.containsKey(pse.VG_Endorsement_Library_Id__c)+'::'+tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c);
                        if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c != 0){
                            System.debug('tempend2::'+tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c);
                            pse.VG_Premium__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c;
                        }
                        if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c != 0){
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
            return new PageReference('/apex/VG_Alpha_Step6b');
        }Catch(Exception e){
            showError(e);
            return null;
        }
    }
    public PageReference cancel(){
        return new PageReference('/'+policy.id);
    }
    
    
    Public PageReference Finish(){
        try{  
            List<VG_Policy_Schedule_Endorsement__c> endToBeInserted  =  new List<VG_Policy_Schedule_Endorsement__c>();        
            Policy__c pol=[select id, Name, VG_Inception_Date__c, VG_Expiry_Date__c from Policy__c where Id=:policyId limit 1];
            List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([SELECT Id, Name, Policy__c FROM Policy_Schedule__c WHERE Policy__c=:policyId ORDER BY CreatedDate DESC]);                         
            List<Integer> psNumList = new List<Integer>();
            if(psList.size()>0){
                for(Policy_Schedule__c ps: psList){
                    if(ps.Name.contains('PS')){
                        psNumList.add(Integer.valueOf(ps.Name.remove('/NonEEA').split('/PS/')[1]));
                    }else if(ps.Name.contains('MTA')){
                        psNumList.add(Integer.valueOf(ps.Name.remove('/NonEEA').split('/MTA/')[1]));
                    }
                }
                psNumList.sort();
                ps.Name = pol.Name+'/PS/'+((psNumList[psNumList.size()-1])+1);        
            }else{
                ps.Name = pol.Name+'/PS/0';       
            }  
            if(ps.Split_Type__c == 'Non EEA')      
                ps.Name = ps.Name + '/NonEEA';
            
            ps.RecordTypeId = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Imara').getRecordTypeId();
            ps.Policy__c = policy.id;
            ps.Written_share__c = WrittenShare;
            ps.Share__c = SignedShare;
            ps.VG_Capacity_Paper__c = CapacityPaper;
            ps.VG_Reinsurance_Type__c = RI_Select;
            ps.VG_Structure__c = Structure_Select;
            ps.VG_Sub_Structure__c = Product_Select;
            ps.CurrencyIsoCode = policy.CurrencyIsoCode;
            ps.Gross_Written_Premium__c = GrossWrittenPremium;
            ps.VG_Gross_Written_Premium_100__c = GrossWrittenPremium2;
            ps.Technical_UW_Premium__c = TechnicalPremium;
            ps.VG_Brokerage_Percent__c = Brokerage;
            ps.VG_Brokerage_Amount__c = BrokerageAmount;
            ps.Actual_GWP__c = ActualPremium;
            ps.VG_Overider_Percent__c = Overider;
            ps.VG_Fee_Income__c = FeeIncome;
            ps.Product__c = SubProduct_Select;
            ps.Premium_Adjustment_2__c = PremiumAdjustment;
            ps.Risk_Premium_Pro__c = PSRiskPremium;
            ps.Endorsement_Premium_Pro__c = EndorsementPremium;
            ps.Rate_On_Line__c = RateOnLine;
            If(RateChange == 0.00 && policy.VG_Is_Renewal__c   == false)       
                ps.VG_Rate_Change__c   =   null;
            else
                ps.VG_Rate_Change__c   =  RateChange;
            ps.Sum_Insured__c = sumInsured;
            ps.VG_Base_Policy__c = true;
            ps.Levies__c = Levies;
            ps.VG_Technical_Loss_Ratio__c = TechnicalLossRatio;
            ps.Limit__c = limitperrisk ;
            ps.Attachment__c = deductibleperrisk;
            ps.Base_Creation_Start_Date__c  =  pol.VG_Inception_Date__c;
            ps.Base_Creation_End_Date__c  =  pol.VG_Expiry_Date__c;
            ps.RecordTypeId = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Imara').getRecordTypeId();
            Insert ps;
            rc.Name = ps.Name+'/RD/01';
            rc.CurrencyIsoCode = policy.CurrencyIsoCode;
            rc.Policy_Schedule__c = ps.id;
            rc.VG_Territorial_Scope__c = TT_Select;
            PolicyDetails='Insurer :'+Insurer+'<br/>';
            PolicyDetails+='Insurer Policy Number :'+InsurerPolicyNumber+'<br/>';
            PolicyDetails+='Insurer Policy Currency :'+InsurerPolicyCurrency+'<br/>';
            PolicyDetails+='Insurer Policy Limit :'+InsurerPolicyLimit+'<br/>';
            PolicyDetails+='Insurer Policy Dedctible :'+InsurerPolicyDedctible+'<br/>';
            PolicyDetails+='Insurer Policy Premium :'+InsurerPolicyPremium+'<br/>';
            PolicyDetails+='Insurer Policy Share :'+InsurerPolicyShare;
            rc.VG_Additional_Information__c = PolicyDetails;
            if(NOIList.size() > 0){
                Integer i = 1;
                for(Integer noi : NOIList){
                    if(i==1)
                        rc.VG_Reinstatement_Premiums__c='Per Risk 1st Reinstatement :'+noi+'<br/>';
                    if(i==2)
                        rc.VG_Reinstatement_Premiums__c+='Per Risk 2nd Reinstatement :'+noi+'<br/>';
                    if(i==3)
                        rc.VG_Reinstatement_Premiums__c+='Per Risk 3rd Reinstatement :'+noi+'<br/>';
                    if(i>3)
                        rc.VG_Reinstatement_Premiums__c+='Per Risk '+i+'th Reinstatement :'+noi+'<br/>';
                    
                    i++;
                }
                i=1;
                for(Integer noi : NOIList2){
                    if(i==1)
                        rc.VG_Reinstatement_Premiums__c+='Per Event 1st Reinstatement :'+noi+'<br/>';
                    if(i==2)
                        rc.VG_Reinstatement_Premiums__c+='Per Event 2nd Reinstatement :'+noi+'<br/>';
                    if(i==3)
                        rc.VG_Reinstatement_Premiums__c+='Per Event 3rd Reinstatement :'+noi+'<br/>';
                    if(i>3)
                        rc.VG_Reinstatement_Premiums__c+='Per Event '+i+'th Reinstatement :'+noi+'<br/>';
                    
                    i++;
                }
                rc.VG_Reinstatement_Premiums__c = rc.VG_Reinstatement_Premiums__c.removeEnd('<br/>');
            }
            Insert rc;
            rr.Name = ps.Name+'/RR/01';
            rr.CurrencyIsoCode = policy.CurrencyIsoCode;
            rr.VG_Policy_Schedule__c = ps.id;
            rr.VG_Risk_Premium__c = RiskPremium;
            //if(RI_Select !='Facultative Reinsurance' && (Product_Select == 'Quota Share' || Product_Select == 'Facultative Obligatory' || Product_Select == 'Structured Quota Share'))
            rr.VG_Limit__c= limitperrisk ;
            rr.VG_Deductible__c=deductibleperrisk;
            rr.VG_Retention__c = Retention;
            rr.VG_Expected_Ceding_Commission__c = ExpectedCedingCommission;
            rr.VG_Expected_Profit_Commission__c = ExpectedProfitCommission;
            rr.VG_Treaty_Limit__c = TreatyLimit;
            String subCoverages = '';
            for ( SelectOption so : SubCoverage_SelectedList) {
                subCoverages += so.getLabel()+';';
            }
            rr.VG_Perils__c = subCoverages ;
            Insert rr;
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
                Insert endToBeInserted;
            }
            return new PageReference('/'+ps.id);
        }Catch(Exception e){
            showError(e);
            return null;
        }
    }
    
    
    public void setProductList(){
        try{ 
            Product_List.clear();
            Product_Select='';
            System.debug('RI_Select ::'+RI_Select);
            System.debug('Structure_Select ::'+Structure_Select );
            if(RI_Select == 'Treaty Reinsurance' && Structure_Select == 'Proportional'){
                Product_List.add(new SelectOption('Quota Share','Quota Share'));
                Product_List.add(new SelectOption('Facultative Obligatory','Facultative Obligatory'));
                Product_List.add(new SelectOption('Surplus','Surplus'));
                Product_List.add(new SelectOption('Structured Quota Share','Structured Quota Share'));
            }else if(RI_Select == 'Treaty Reinsurance' && Structure_Select == 'Non-Proportional'){
                Product_List.add(new SelectOption('Excess of Loss Per Risk','Excess of Loss Per Risk'));
                Product_List.add(new SelectOption('Excess of Loss Per Event','Excess of Loss Per Event'));
                Product_List.add(new SelectOption('Excess of Loss Per Risk & Event','Excess of Loss Per Risk & Event'));
                Product_List.add(new SelectOption('Aggregate Excess of Loss','Aggregate Excess of Loss'));
                Product_List.add(new SelectOption('Aggregate Stop Loss','Aggregate Stop Loss'));
            }else if( RI_Select == 'Facultative Reinsurance' && Structure_Select == 'Proportional'){
                Product_List.add(new SelectOption('Quota Share','Quota Share'));
                Product_List.add(new SelectOption('Loss Limit','Loss Limit'));
            }else if(RI_Select == 'Facultative Reinsurance' && Structure_Select == 'Non-Proportional'){
                Product_List.add(new SelectOption('Excess of Loss Primary','Excess of Loss Primary'));
                Product_List.add(new SelectOption('Excess of Loss Excess','Excess of Loss Excess'));
                Product_List.add(new SelectOption('Line Slip','Line Slip'));
            }
            System.debug('SubProduct_List ::'+SubProduct_List.size());
        }Catch(Exception e){
            showError(e);
        }
    }
    
    Public void setSubCoverageList(){
        try{  
            SubCoverage_List.clear();
            SubCoverage_SelectedList.clear();
            if(rr.VG_Coverage__c != null){
                String[] coverages = rr.VG_Coverage__c.split(';');
                boolean restrictFlag = true;
                for(String cov : coverages){
                    if(cov == 'Motor'){
                        SubCoverage_List.add(new SelectOption('Motor Third Party','Motor Third Party'));
                        SubCoverage_List.add(new SelectOption('Motor Physical Damage','Motor Physical Damage'));
                        SubCoverage_List.add(new SelectOption('Motor Passenger Liability','Motor Passenger Liability'));
                    }else if(cov == 'Liability'){
                        SubCoverage_List.add(new SelectOption('Bankers Blanket Bond','Bankers Blanket Bond'));
                        SubCoverage_List.add(new SelectOption('General Third Party','General Third Party'));
                        SubCoverage_List.add(new SelectOption('Cash in transit','Cash in transit'));
                        SubCoverage_List.add(new SelectOption('Cash in Safe','Cash in Safe'));
                        SubCoverage_List.add(new SelectOption('Products Liability','Products Liability'));
                        SubCoverage_List.add(new SelectOption('Professional Indemnity','Professional Indemnity'));
                        SubCoverage_List.add(new SelectOption('Workmens Compensation','Workmens Compensation'));
                        SubCoverage_List.add(new SelectOption('Employers Liability','Employers Liability'));
                        SubCoverage_List.add(new SelectOption('Personal Accident','Personal Accident'));
                        SubCoverage_List.add(new SelectOption('Cyber Liability','Cyber Liability'));
                    }else if(cov == 'PVT'){
                        SubCoverage_List.add(new SelectOption('Political Violence','Political Violence'));
                        SubCoverage_List.add(new SelectOption('Terrorism','Terrorism'));
                    }else if(cov == 'Marine'){
                        SubCoverage_List.add(new SelectOption('Specie ','Specie '));
                        SubCoverage_List.add(new SelectOption('Marine Hull','Marine Hull'));
                        SubCoverage_List.add(new SelectOption('Marine Cargo','Marine Cargo'));
                        SubCoverage_List.add(new SelectOption('Merchandise','Merchandise'));
                        SubCoverage_List.add(new SelectOption('Stock Throughput','Stock Throughput'));
                        SubCoverage_List.add(new SelectOption('Good in Transit','Good in Transit'));
                        SubCoverage_List.add(new SelectOption('War','War'));
                        SubCoverage_List.add(new SelectOption('Inland Transit','Inland Transit'));
                    }else if(cov == 'Property Risk' || cov == 'Property CAT'){
                        if(restrictFlag){
                            restrictFlag = false;
                            SubCoverage_List.add(new SelectOption('Fidelity','Fidelity'));
                            SubCoverage_List.add(new SelectOption('Theft','Theft'));
                            SubCoverage_List.add(new SelectOption('Fire & Allied Perils','Fire & Allied Perils'));
                            SubCoverage_List.add(new SelectOption('PML Error','PML Error'));
                            SubCoverage_List.add(new SelectOption('Consequential Loss','Consequential Loss'));
                            SubCoverage_List.add(new SelectOption('Electronic Equipment ','Electronic Equipment '));
                            SubCoverage_List.add(new SelectOption('All Risks','All Risks'));
                            SubCoverage_List.add(new SelectOption('Money ','Money '));
                            SubCoverage_List.add(new SelectOption('Glass','Glass'));
                            SubCoverage_List.add(new SelectOption('Business Interruption','Business Interruption'));
                        }
                    }else if(cov == 'Agriculture'){
                        SubCoverage_List.add(new SelectOption('Agriculture Livestock','Agriculture Livestock'));
                        SubCoverage_List.add(new SelectOption('Agriculture Crop','Agriculture Crop'));
                    }else if(cov == 'Energy'){
                        SubCoverage_List.add(new SelectOption('Onshore Energy','Onshore Energy'));
                        SubCoverage_List.add(new SelectOption('Offshore Energy','Offshore Energy'));
                    }else if(cov == 'Travel'){
                        SubCoverage_List.add(new SelectOption('Personal Travel ','Personal Travel '));
                        SubCoverage_List.add(new SelectOption('Group Travel','Group Travel'));
                    }else if(cov == 'Health'){
                        SubCoverage_List.add(new SelectOption('Personal Health','Personal Health'));
                        SubCoverage_List.add(new SelectOption('Group Health','Group Health'));
                    }else if(cov == 'Credit'){
                        SubCoverage_List.add(new SelectOption('Bonds','Bonds'));
                        SubCoverage_List.add(new SelectOption('Trade Credit','Trade Credit'));
                    }else if(cov == 'Engineering'){
                        SubCoverage_List.add(new SelectOption('Machinery Breakdown','Machinery Breakdown'));
                        SubCoverage_List.add(new SelectOption('Constuction All Risks','Constuction All Risks'));
                        SubCoverage_List.add(new SelectOption('Erection all Risks','Erection all Risks'));
                    }else if(cov == 'Aviation'){
                        SubCoverage_List.add(new SelectOption('Aviation Hull','Aviation Hull'));
                        SubCoverage_List.add(new SelectOption('Aviation Cargo','Aviation Cargo'));
                        SubCoverage_List.add(new SelectOption('Aviation Spares','Aviation Spares'));
                    }
                }
            }
        }Catch(Exception e){
           showError(e);
        }
    }
    
    Public Void generateReinstatement(){
        try{ 
            EnableReinstatement = True;
            createLoop.clear();
            NOIList.clear();
            NOIList2.clear();
            if(rc.VG_No_of_Reinstatements__c.isNumeric()){
                for(integer i = 0 ; i < Integer.valueOf(rc.VG_No_of_Reinstatements__c) ; i++){
                    createLoop.add(i);
                    NOIList.add(0);
                    NOIList2.add(0);
                    ReinstatementValues.add('0');
                }
            }
            
            System.debug('Test::'+createLoop+'::'+ReinstatementValues);
        }Catch(Exception e){
            showError(e);
        }
    }
    
    public void updatePremiums(){
        try{ 
            RiskRatingCalc();
            if(rc.VG_Rate_Type__c =='Rate On Income' || rc.VG_Rate_Type__c =='Swing Rate')
                PSRiskPremium =  (RiskPremium * proRata).setScale(2);
            Calc();
        }Catch(Exception e){
            showError(e);
        }
    }
    
    public void Calc(){
        try{ 
            If(RateChange == 0.00 && policy.VG_Is_Renewal__c == false)
                RateChange = null; 
            
            TotalLayerPremium = PremiumAdjustment + PSRiskPremium + EndorsementPremium;
            
            if(SignedShare != null)
                GrossWrittenPremium = TotalLayerPremium * (SignedShare/100);
            
            if(limitperrisk != null && SignedShare != null && Product_Select  != 'Aggregate Excess of loss' )
                sumInsured = limitperrisk*(SignedShare/100);
            
            if(Product_Select  == 'Aggregate Stop Loss' )
                sumInsured =(((rr.VG_Limit_Precent__c != null ? rr.VG_Limit_Precent__c : 0)  / 100) - ((rr.VG_Deductible_Precent__c != null ? rr.VG_Deductible_Precent__c : 0) / 100)) * GrossWrittenPremium;
            
            if( Product_Select  == 'Aggregate Excess of loss' && rr.VG_Aggregate__c != null && SignedShare != null)
                sumInsured = rr.VG_Aggregate__c * (SignedShare/100);
            
            if((Product_Select == 'Quota Share' || Product_Select == 'Structured Quota Share' || Product_Select == 'Facultative Obligatory' ) && SignedShare > 0)
                sumInsured = limitperrisk * (SignedShare/100);
            if(Product_Select == 'Quota Share' && SignedShare != null && limitperrisk != null && RI_Select =='Facultative Reinsurance')
                sumInsured = limitperrisk * (SignedShare/100);
            
            if(Product_Select == 'Surplus' && SignedShare != null && rr.VG_No_of_Surplus_Lines__c !=null && rr.VG_Retention_Line__c != null)
                sumInsured = rr.VG_Retention_Line__c * rr.VG_No_of_Surplus_Lines__c * (SignedShare / 100);
            
            GrossWrittenPremium2 = TotalLayerPremium;
            
            if(TechnicalLossRatio != null && TechnicalLossRatio > 0)
                TechnicalPremium = GrossWrittenPremium * (TechnicalLossRatio/100);
            
            if(Brokerage != null)
                BrokerageAmount = GrossWrittenPremium * (Brokerage/100);
            
            if(Overider != null)
                OveriderAmount = GrossWrittenPremium*(Overider/100);
            if(GrossWrittenPremium > 0  && limitperrisk != null && limitperrisk > 0 && deductibleperrisk  != null && deductibleperrisk  > 0 && (limitperrisk- deductibleperrisk ) > 0 && Product_Select != 'Aggregate Stop Loss')
                RateOnLine = GrossWrittenPremium/(limitperrisk-deductibleperrisk );
            
            If(GrossWrittenPremium > 0  && rr.VG_Limit_Precent__c != null && rr.VG_Limit_Precent__c> 0 && rr.VG_Deductible_Precent__c != null && rr.VG_Deductible_Precent__c > 0 && ((rr.VG_Limit_Precent__c/100)-(rr.VG_Deductible_Precent__c/100)) > 0 && Product_Select == 'Aggregate Stop Loss')
                RateOnLine = GrossWrittenPremium/((rr.VG_Limit_Precent__c/100)-(rr.VG_Deductible_Precent__c/100));
            
            ActualPremium  =  GrossWrittenPremium - BrokerageAmount - OveriderAmount;
        }Catch(Exception e){
            showError(e);
        }
    }
    
    public void RiskRatingCalc(){
        try{ 
            if((rr.VG_Rate_on_Income__c != null && rr.VG_Rate_on_Income__c  > 0 )&&(rr.VG_GNPI__c != null && rr.VG_GNPI__c > 0)){
                RiskPremium = rr.VG_GNPI__c*(rr.VG_Rate_on_Income__c/100);
            }else if((rr.VG_Provisional_Rate__c != null && rr.VG_Provisional_Rate__c  > 0 )&&(rr.VG_GNPI__c != null && rr.VG_GNPI__c > 0)){
                RiskPremium = rr.VG_Provisional_Rate__c*(rr.VG_GNPI__c/100);
            }
            
            if(rr.VG_Minimum_Premium__c != null && rr.VG_Minimum_Premium__c > 0){
                MinimumPremium = RiskPremium*(rr.VG_Minimum_Premium__c/100);
            }
            if(rr.VG_Deposit_Premium__c != null && rr.VG_Deposit_Premium__c > 0){
                DepositPremium = RiskPremium*(rr.VG_Deposit_Premium__c/100);
            }
            if(rr.VG_No_Claims_Bonus__c != null && rr.VG_No_Claims_Bonus__c > 0){
                NCBValue = RiskPremium*(rr.VG_No_Claims_Bonus__c/100);
            }
        }Catch(Exception e){
            showError(e);
        }
    }
    
    public void RiskRatingCalc2(){
        try{ 
            if(rr.VG_Cession__c != null && rr.VG_Cession__c  > 0)
                Retention = 1-(rr.VG_Cession__c/100);
            if(rr.VG_Expected_Premium_Income__c != null && rr.VG_Ceding_Commission__c !=null && rr.VG_Ceding_Commission__c > 0)
                ExpectedCedingCommission = rr.VG_Expected_Premium_Income__c * (rr.VG_Ceding_Commission__c/100);
            if(rr.VG_Retention_Line__c != null && rr.VG_No_of_Surplus_Lines__c !=null  )
                TreatyLimit = rr.VG_Retention_Line__c * rr.VG_No_of_Surplus_Lines__c;
        }Catch(Exception e){
            showError(e);
        }
    }
    
    public void showError(Exception e){
        String refId = ErrorTrace.insertLog(e,policyId);
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'An error occurred please contact admin with this reference id '+refId));     
    }
    
    Public Class LibraryWrapper{
        Public Endorsement_Library__c EL {get; set;}
        Public Boolean isSelected {get; set;} 
        
        Public LibraryWrapper(){
            EL  =  new Endorsement_Library__c();
            isSelected  =  False;
        }
    }
    public void AddCustom(){   
        VG_Policy_Schedule_Endorsement__c tempEndsmt  =  new VG_Policy_Schedule_Endorsement__c();
        //tempEndsmt.VG_Policy_Schedule__c  =  PSId;
        tempEndsmt.VG_Premium__c  =  0;
        tempEndsmt.VG_Sub_limit__c = 0;
        tempEndsmt.VG_Type__c='Endorsements';
        tempEndsmt.CurrencyISOCode  =  policy.CurrencyIsoCode;
        //counterEnd++;
        //tempEndsmt.Name  =  PSName + '/PE/'+counterEnd;
        existingEndorsements.add(tempEndsmt);
    }
}