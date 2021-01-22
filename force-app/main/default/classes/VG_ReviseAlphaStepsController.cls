Public Class VG_ReviseAlphaStepsController{
    
    Public Policy_Schedule__c ps{get;set;}
    Public Risk_Capture__c rc{get;set;}
    Public VG_Policy_Schedule_Asset__c rr{get;set;}
    Public Policy__c policy{get;set;}
    Public LibraryWrapper LW1{get;set;}
    Public LibraryWrapper LW{get;set;}
    
    Public boolean EnableReinstatement{get;set;}
    Public boolean RD1to4{get;set;}
    Public boolean RD5to6{get;set;}
    Public boolean RD7to8{get;set;}
    Public boolean RR1to4{get;set;}
    Public boolean RR5{get;set;}
    Public boolean RR6{get;set;}
    Public boolean RR7to8{get;set;}
    Public boolean layerlist{get;set;}
    Public boolean enableMList{get;set;}
    Public Boolean stopProcess{get; set;}
    public Boolean skipSplit {get; set;}

    Public string CapacityPaper{get;set;}
    Public String RI_Select{get;set;}
    Public String TT_Select{get;set;}
    Public String Structure_Select{get;set;}
    Public String Product_Select{get;set;}
    Public String SubProduct_Select{get;set;}
    Public String MTAType{get;set;}
    Public String MTAStartDate{get;set;}
    Public String SubStructure_Select{get;set;}
    Public String PolicyDetails{get;set;}
    Public String Insurer{get;set;}
    Public String InsurerPolicyNumber{get;set;}
    Public String InsurerPolicyCurrency{get;set;}
    Public String InsurerPolicyLimit{get;set;}
    Public String InsurerPolicyDedctible{get;set;}
    Public String InsurerPolicyPremium{get;set;}
    Public String InsurerPolicyShare{get;set;}
    Public String seletedProrateoption {get; set;}      
    
    Public ID psId{get;set;}
    Public ID policyId{get;set;}
    
    Public Set<String> actualSelectedSubCoverage{get;set;}
    
    Public List<VG_Policy_Schedule_Endorsement__c> manualList{get;set;}
    Public List<Endorsement_Library__c> ElList1{get;set;}
    Public List<Endorsement_Library__c> ElList{get;set;} 
    Public List<SelectOption> Currency_List{get;set;}
    Public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements1 {get; set;}
    Public List<LibraryWrapper> LibraryWrapperList1 {get; set;}
    Public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements {get; set;}
    Public List<LibraryWrapper> LibraryWrapperList {get; set;}
    Public List<SelectOption> RI_List{get;set;}
    Public List<SelectOption> TT_List{get;set;}
    Public List<SelectOption> SubStructure_List{get;set;}
    Public List<SelectOption> Structure_List{get;set;}
    Public List<SelectOption> Product_List{get;set;}
    Public List<SelectOption> SubProduct_List{get;set;}
    Public List<SelectOption> SubCoverage_List{get;set;}
    Public List<SelectOption> SubCoverage_SelectedList{get;set;}
    public list<SelectOption> NonEEAVolanteEntity_Select {get; set;}
    Public List<SelectOption> splitTypes{get; set;}
    Public list<Integer> createLoop {get; set;}
    Public List<String> ReinstatementValues {get; set;}
    Public List<Integer> NOIList{get;set;}
    Public List<Integer> NOIList2{get;set;}
    
    Map<id, VG_Policy_Schedule_Endorsement__c> pseTempMap{get;set;}
    Map<id, VG_Policy_Schedule_Endorsement__c> pseMap{get;set;}
    
    Public Decimal Overider{get;set;}
    Public Decimal Brokerage{get;set;}
    Public Decimal FeeIncome{get;set;}
    Public Decimal ActualPremium{get;set;}
    Public Decimal Levies{get;set;}
    Public Decimal PremiumAdjustment{get;set;}
    Public Decimal TotalLayerPremium{get;set;}
    Public Decimal SignedShare{get;set;}
    Public Decimal WrittenShare{get;set;}
    Public Decimal GrossWrittenPremium{get;set;}
    Public Decimal GrossWrittenPremium2{get;set;}
    Public Decimal TechnicalPremium{get;set;}
    Public Decimal BrokerageAmount{get;set;}
    Public Decimal OveriderAmount{get;set;}
    Public Decimal RateOnLine{get;set;}
    Public Decimal RateChange {get;set;}
    Public Decimal MinimumPremium{get;set;}
    Public Decimal DepositPremium{get;set;}
    Public Decimal NCBValue{get;set;}
    Public Decimal RiskPremium{get;set;}
    Public Decimal PSRiskPremium{get;set;}
    Public Decimal EndorsementPremium{get;set;}
    Public Decimal TechnicalLossRatio{get;set;}
    Public Decimal Retention{get;set;}
    Public Decimal ExpectedCedingCommission{get;set;}
    Public Decimal ExpectedProfitCommission{get;set;}
    Public Decimal TreatyLimit{get;set;}
    Public Decimal sumInsured{get;set;}
    Public Decimal proRata{get;set;}
    Public Decimal limitperrisk{get;set;}
    Public Decimal deductibleperrisk {get;set;}
    
    Public Integer counterEnd {get; set;}
    
    Public VG_ReviseAlphaStepsController(){
      try{  
        psId = apexpages.currentpage().getparameters().get('Id');
        MTAType = apexpages.currentpage().getparameters().get('MTAType');
        MTAStartDate = apexpages.currentpage().getparameters().get('MTAStartDate');
        seletedProrateoption = apexpages.currentpage().getparameters().get('seletedProrateoption');
        
        ps = [select id, Name, Product__c, Limit__c,Attachment__c,Sum_Insured__c, VG_Rate_Change__c,Split_Type__c, VG_Volante_Entities__c, VG_Capacity_Paper__c, Policy__r.Name, Policy__r.VG_Inception_Date__c, Policy__r.VG_Expiry_Date__c, VG_MTA_Start_Date__c, VG_MTA_Type__c, VG_Is_MTA__c, VG_MTA_End_Date__c, VG_Technical_Loss_Ratio__c, Policy__c, VG_Brokerage_Amount__c, Actual_GWP__c, Transaction_GWP__c, Written_share__c, Share__c, VG_Structure__c, VG_Sub_Structure__c, VG_Reinsurance_Type__c, CurrencyIsoCode, Gross_Written_Premium__c, Technical_UW_Premium__c, VG_Brokerage_Percent__c, VG_Overider_Percent__c, VG_Fee_Income__c, Premium_Adjustment_2__c, Risk_Premium_Pro__c, Endorsement_Premium_Pro__c, Rate_On_Line__c, Levies__c from Policy_Schedule__c where id = :psId];
        policy = [select id, Name, VG_Inception_Date__c,VG_Is_Renewal__c,Type_of_Insurance__c, VG_Expiry_Date__c, CurrencyIsoCode, Insured__r.Name, VG_Aggregate_Limit__c, Deductible_or_Excess_Amount__c, VG_Prospect_Premium__c, Sum_Insured_Share__c from Policy__c where id = : ps.Policy__c];
        rr = [select id, VG_Sub_Coverages__c, VG_Franchise__c, VG_Perils__c, Name, VG_Coverage__c, VG_Expected_Profit_Commission__c, VG_Management_Expenses_for_PC__c , VG_Limit__c, VG_Limit_Precent__c, VG_Deductible__c, VG_Deductible_Precent__c, VG_Aggregate__c, VG_Aggregate_Precent__c, VG_AAD__c, VG_Return_Period_Entry__c, VG_Return_Period_Exit__c, VG_GNPI__c, VG_Risk_Premium__c, VG_Rate_on_Income__c, VG_Provisional_Rate__c, VG_Min_Rate__c, VG_Max_Rate__c, VG_Swing_Load__c, VG_Minimum_Premium__c, VG_Deposit_Premium__c, VG_No_Claims_Bonus__c, VG_Cession__c, VG_Max_Ceding_Commission__c, VG_Loss_Ratio_for_Max__c, VG_Retention_Line__c, VG_No_of_Surplus_Lines__c, VG_Event_Limit__c, VG_Expected_Loss_Ratio__c, VG_Expected_Premium_Income__c, VG_Ceding_Commission__c, VG_Min_Ceding_Commission__c, VG_Loss_Ratio_for_Min__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c = :psId limit 1];
        rc = [select id, Name, VG_Rate_Type__c, VG_Additional_Information__c, VG_Reinstatement_Premiums__c, CurrencyIsoCode, VG_No_of_Reinstatements__c, VG_Territorial_Scope__c, VG_Plan_Loss_Ratio__c, VG_Layer__c, VG_Ceding_Commission_Type__c, VG_Income_Basis__c, VG_Claims_Notification_Threshold__c, VG_Cash_Loss_Limit__c, VG_First_Premium_Payment_Date__c from Risk_Capture__c where Policy_Schedule__c = :psId];
        
        pseTempMap = new Map<id, VG_Policy_Schedule_Endorsement__c>();
        existingEndorsements1 = new List<VG_Policy_Schedule_Endorsement__c>();
        existingEndorsements = new List<VG_Policy_Schedule_Endorsement__c>();
        manualList = new List<VG_Policy_Schedule_Endorsement__c>();
        LibraryWrapperList = new List<LibraryWrapper>();
        LibraryWrapperList1 = new List<LibraryWrapper>();
        createLoop = new List<Integer>();
        NOIList = new List<Integer>();
        NOIList2 = new List<Integer>();
        ReinstatementValues = new List<String>();
        Currency_List = new List<SelectOption>();
        RI_List = new List<SelectOption>();
        TT_List = new List<SelectOption>();
        Structure_List = new List<SelectOption>();
        Product_List = new List<SelectOption>();
        SubProduct_List = new List<SelectOption>();
        SubStructure_List = new List<SelectOption>();
        SubCoverage_List = new List<SelectOption>();
        SubCoverage_SelectedList = new List<SelectOption>();
        actualSelectedSubCoverage = new Set<String>();
        
        pseMap = new Map<id, VG_Policy_Schedule_Endorsement__c>([select id, Name, VG_IsTempDelete__c, VG_Endorsement_Number__c, VG_Endorsement_Library_Id__c, VG_Sub_limit__c, VG_Premium__c, VG_Endorsement_Details__c, VG_Title__c, VG_Type__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c = : PSID]);
        sumInsured = Overider = Brokerage = Retention = TechnicalPremium = ExpectedCedingCommission = ExpectedProfitCommission = TreatyLimit = MinimumPremium = FeeIncome = PSRiskPremium = RiskPremium = Levies = EndorsementPremium = PremiumAdjustment = TotalLayerPremium = SignedShare = WrittenShare = GrossWrittenPremium = GrossWrittenPremium2 = BrokerageAmount = OveriderAmount = RateOnLine = DepositPremium = NCBValue = TechnicalLossRatio = ActualPremium = 0;
        
        splitTypes = new List<SelectOption>();
        skipSplit = False;
        if(policy.VG_Inception_Date__c.year() <= 2020){
            splitTypes.add(new SelectOption('','--None--'));
            skipSplit = True;
        }
        splitTypes.add(new SelectOption('Non EEA','Non EEA'));
        if(MTAType == null && ps.VG_MTA_Type__c == null){
            if(Math.mod(ps.Policy__r.VG_Inception_Date__c.year(), 4) != 0){
                if(Math.mod(ps.Policy__r.VG_Expiry_Date__c.year(), 4) == 0){
                    if(ps.Policy__r.VG_Expiry_Date__c <= date.newInstance(ps.Policy__r.VG_Expiry_Date__c.year(), 02, 28)){
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
            if(Math.mod(ps.Policy__r.VG_Inception_Date__c.year(), 4) != 0){
                if(Math.mod(ps.Policy__r.VG_Expiry_Date__c.year(), 4) == 0){
                    if(ps.Policy__r.VG_Expiry_Date__c <= date.newInstance(ps.Policy__r.VG_Expiry_Date__c.year(), 02, 28)){
                        proRata = MTAStartDate  != null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
                    }else{
                        proRata = MTAStartDate  != null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365;
                    }
                }else{
                    proRata = MTAStartDate  != null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
                }
            }else{
                if(ps.Policy__r.VG_Inception_Date__c < date.newInstance(ps.Policy__r.VG_Inception_Date__c.year(),03,01)){
                    proRata = MTAStartDate  != null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c)))/365;
                }else{
                    proRata = MTAStartDate  != null ? (Decimal.valueOf(Date.valueOf(MTAStartDate).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365 : (Decimal.valueOf(Date.valueOf(ps.VG_MTA_Start_Date__c).daysBetween(ps.Policy__r.VG_Expiry_Date__c))+1)/365;
                }
            }
        }
        for(VG_Policy_Schedule_Endorsement__c pse: pseMap.values()){
            if(pse.VG_Endorsement_Library_Id__c == null)
                manualList.add(pse);
            else
                pseTempMap.put(pse.VG_Endorsement_Library_Id__c, pse);
        }
        counterEnd = 0;
        if(rc.VG_Additional_Information__c != null){
            PolicyDetails = rc.VG_Additional_Information__c;
            String[] tempDetail = PolicyDetails.split('<br>');
            List<String> sList = new List<String>();
            for(Integer i = 0;i<tempDetail.size();i++){
                String[] tmp = tempDetail[i].split(':');
                if(tmp.size() > 1)
                    sList.add(tmp[1]);
                else
                    sList.add('');
            }
            System.debug(sList.size());
            Insurer = sList[0];
            InsurerPolicyNumber = sList[1];
            InsurerPolicyCurrency = sList[2];
            InsurerPolicyLimit = sList[3];
            InsurerPolicyDedctible = sList[4];
            InsurerPolicyPremium = sList[5];
            InsurerPolicyShare = sList[6];
        }else{
            PolicyDetails = '';
            Insurer = '';
            InsurerPolicyNumber = '';
            InsurerPolicyCurrency = '';
            InsurerPolicyLimit = '';
            InsurerPolicyDedctible = '';
            InsurerPolicyPremium = '';
            InsurerPolicyShare = '';
        }
        limitperrisk = deductibleperrisk = 0;
        LibraryWrapper LW;
        LibraryWrapper LW1;
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
        
        Schema.DescribeFieldResult describeResult = Policy__c.CurrencyISOCode.getDescribe();
        List<Schema.PicklistEntry> entries = describeResult.getPicklistValues();
        List<SelectOption> optionsToReturn = new List<SelectOption>();
        for (Schema.PicklistEntry pEntry : entries) {
            if (pEntry.isActive()) {
                Currency_List.add(new SelectOption(pEntry.getValue(),  pEntry.getLabel()));
            }
        }
        
        if(rc.VG_Reinstatement_Premiums__c!= null){
            String[] NOI = rc.VG_Reinstatement_Premiums__c.split('<br>');
            EnableReinstatement = False; 
            for(Integer i = 0; i < NOI.size();i++){
                if(NOI[i].split(':')[0].contains('Per Risk')){
                    createLoop.add(i);
                    NOIList.add(Integer.valueOf(NOI[i].split(':')[1]));
                }else{
                    NOIList2.add(Integer.valueOf(NOI[i].split(':')[1]));
                }
            }
        }
        
        RiskPremium = rr.VG_Risk_Premium__c.setScale(2);
        limitperrisk = (ps.Limit__c!=null?ps.Limit__c:0);
        deductibleperrisk = (ps.Attachment__c!=null?ps.Attachment__c:0);
        RI_Select = policy.Type_of_Insurance__c;

        Structure_Select = ps.VG_Structure__c;
        SubProduct_Select = ps.Product__c;
        setProductList();
        Product_Select = ps.VG_Sub_Structure__c;
        TT_Select = rc.VG_Territorial_Scope__c;
        Product_Select = ps.VG_Sub_Structure__c;
        CapacityPaper = ps.VG_Capacity_Paper__c;
        WrittenShare = ps.Written_share__c;
        SignedShare = ps.Share__c;
        GrossWrittenPremium = ps.Gross_Written_Premium__c;
        TechnicalPremium = ps.Technical_UW_Premium__c;
        Brokerage = ps.VG_Brokerage_Percent__c;
        BrokerageAmount = ps.VG_Brokerage_Amount__c;
        sumInsured = ps.Sum_Insured__c;
        ActualPremium = ps.Actual_GWP__c;
        Overider = ps.VG_Overider_Percent__c;
        FeeIncome = ps.VG_Fee_Income__c;
        PremiumAdjustment = ps.Premium_Adjustment_2__c;
        PSRiskPremium = ps.Risk_Premium_Pro__c.setScale(2);
        EndorsementPremium = ps.Endorsement_Premium_Pro__c;
        RateOnLine = ps.Rate_On_Line__c;
        RateChange = ps.VG_Rate_Change__c;
        Levies = ps.Levies__c;
        TechnicalLossRatio = ps.VG_Technical_Loss_Ratio__c;
        EnableReinstatement = False;
        ExpectedProfitCommission = rr.VG_Expected_Profit_Commission__c;
        setSubCoverageList();
        if(rr.VG_Perils__c!= null){
            String[] actualSubCoverage_SelectList = rr.VG_Perils__c.split(';');
            for(String s : actualSubCoverage_SelectList){
                SubCoverage_SelectedList.add(new SelectOption(s,s));
                actualSelectedSubCoverage.add(s);
            }
        }
        List<SelectOption> tmp= new List<SelectOption>();
        for(SelectOption s : SubCoverage_List){
            if(!actualSelectedSubCoverage.contains(s.getValue())){
                tmp.add(s);
            }
        }
        SubCoverage_List = tmp;
        RD1to4 = false;
        RD5to6 = false;
        RD7to8 = false;
        RR1to4 = false;
        layerlist = false;
        RR5 = false;
        RR6 = false;
        RR7to8 = false;
        enableMList = true;
        RiskRatingCalc();
        RiskRatingCalc2();
        Calc();
        if((rc.VG_Rate_Type__c == 'Rate On Income' || rc.VG_Rate_Type__c == 'Swing Rate' ) && MTAType == null)
            PSRiskPremium = (RiskPremium * proRata).setScale(2);
      }Catch(Exception e){
            stopProcess = true;
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'An error occurred please contact admin'));   
        }
    }

    Public PageReference gotostep1(){
        return new PageReference('/apex/VG_Revise_Alpha_Step1');
    }

    Public PageReference gotostep3(){
        return new PageReference('/apex/VG_Revise_Alpha_Step3');
    }

    Public PageReference gotostep2(){
      try{  
        if(RI_Select != 'Facultative Reinsurance' || RI_Select != 'Treaty Reinsurance'){
            if(Structure_Select != '--None--'){
                if((RI_Select=='Treaty Reinsurance' && (Product_Select == 'Excess of Loss Per Risk' || Product_Select == 'Excess of Loss Per Event' || Product_Select == 'Excess of Loss Per Risk & Event' || Product_Select == 'Aggregate Excess of Loss')) || (RI_Select == 'Facultative Reinsurance' && (Product_Select == 'Loss Limit' || Product_Select == 'Excess of Loss Primary' || Product_Select == 'Excess of Loss Excess' ))){
                    layerlist = True;
                    RD1to4 = false;
                    RD5to6 = false;
                    RD7to8 = false;
                }          
                if((RI_Select=='Treaty Reinsurance' && Product_Select == 'Aggregate Stop Loss')){
                    layerlist = false;
                    RD1to4 = True;
                    RD5to6 = false;
                    RD7to8 = false;                   
                }else if(RI_Select=='Treaty Reinsurance' && (Product_Select == 'Quota Share' || Product_Select == 'Structured Quota Share' || Product_Select == 'Facultative Obligatory' || Product_Select == 'Surplus')){
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
                
                if((RI_Select=='Treaty Reinsurance' && (Product_Select == 'Excess of Loss Per Risk' || Product_Select == 'Aggregate Stop Loss' || Product_Select == 'Excess of Loss Per Event' || Product_Select == 'Excess of Loss Per Risk & Event' || Product_Select == 'Aggregate Excess of Loss')) || (RI_Select == 'Facultative Reinsurance' && (Product_Select == 'Loss Limit' || Product_Select == 'Excess of Loss Primary' || Product_Select == 'Excess of Loss Excess' ))){
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
        return new PageReference('/apex/VG_Revise_Alpha_Step2');
      }Catch(Exception e){
           showError(e);
           return null;
        }
    }

    Public PageReference gotostep4(){
      try{  
        EndorsementPremium = 0;
        for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements){
            if(pse.VG_Premium__c != null)
                EndorsementPremium = EndorsementPremium+pse.VG_Premium__c;
        }
        if(RI_Select =='Facultative Reinsurance'){
            if(Product_Select == 'Excess of Loss Primary' || Product_Select == 'Excess of Loss Excess' || Product_Select == 'Line Slip'){
                rr.VG_Risk_Premium__c = RiskPremium;
            }
            RiskPremium = rr.VG_Risk_Premium__c;
            PSRiskPremium = (RiskPremium * proRata).setScale(2);
        }
        if((Product_Select == 'Quota Share' || Product_Select == 'Surplus' || Product_Select == 'Structured Quota Share'|| Product_Select == 'Facultative Obligatory') && rr.VG_Expected_Premium_Income__c != null){
            RiskPremium = rr.VG_Expected_Premium_Income__c;
            PSRiskPremium = (RiskPremium * proRata).setScale(2);
        }
        rc.VG_Territorial_Scope__c = TT_Select;
        
        if(rc.VG_Rate_Type__c =='Flat Premium')
            PSRiskPremium = (RiskPremium * proRata).setScale(2);
        EndorsementPremium = EndorsementPremium * proRata;
        updatePremiums();
        RiskRatingCalc2();
        Calc();
        return new PageReference('/apex/VG_Revise_Alpha_Step4');
      }Catch(Exception e){
           showError(e);
           return null;
        }
    }

    Public PageReference gotostep5(){
      try{  
        Map<Id, VG_Policy_Schedule_Endorsement__c> tmpPSEMap = new Map<Id, VG_Policy_Schedule_Endorsement__c>();
        for(VG_Policy_Schedule_Endorsement__c pse: existingEndorsements1){
            if(!tmpPSEMap.containsKey(pse.VG_Endorsement_Library_Id__c)){
                tmpPSEMap.put(pse.VG_Endorsement_Library_Id__c, pse);
            }
        }
        if(!existingEndorsements1.IsEmpty()){
            existingEndorsements1.clear();
        }
        ElList1 = [select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where Type__c = :'Sub-limits' AND RecordType.Name = : 'Imara' ORDER By Name ASC];        
        LibraryWrapperList1.clear();  
        for(Endorsement_Library__c EL : ElList1){            
            LW1 = new LibraryWrapper();
            LW1.EL = EL;            
            LW1.isSelected = False; 
            if(pseTempMap.containsKey(EL.id) || tmpPSEMap.containsKey(EL.id)) { 
                LW1.isSelected = True;
            }                
            LibraryWrapperList1.add(LW1); 
        }
        return new PageReference('/apex/VG_Revise_Alpha_Step5');
      }Catch(Exception e){
           showError(e);
           return null;
        }
    }
    

    Public PageReference gotostep5b(){
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
                tempEndsmt = new VG_Policy_Schedule_Endorsement__c();
                tempEndsmt.VG_Endorsement_Details__c = LW.EL.Text__c;
                tempEndsmt.VG_Endorsement_Library_Id__c = LW.EL.Id;
                tempEndsmt.VG_Title__c = LW.EL.Endorsement_Title__c;
                tempEndsmt.VG_Premium__c = 0;
                tempEndsmt.VG_Sub_limit__c = 0;
                tempEndsmt.VG_Endorsement_Number__c = LW.EL.Name;
                tempEndsmt.VG_Type__c = LW.EL.Type__c;
                tempEndsmt.VG_IsTempDelete__c = False;
                tempEndsmt.VG_IsTemp__c = True;
                if(MTAType == 'Revision of Cover'){
                    tempEndsmt.VG_Premium__c = 0;
                    tempEndsmt.VG_Sub_limit__c = 0;
                }
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
            counterEnd = 0;
        }else{
            counterEnd = existingEndorsements1.size();    
        }
        return new PageReference('/apex/VG_Revise_Alpha_Step5b');
      }Catch(Exception e){
           showError(e);
           return null;
        }
    }

    Public PageReference gotostep6(){
      try{  
        Map<Id, VG_Policy_Schedule_Endorsement__c> tmpPSEMap = new Map<Id, VG_Policy_Schedule_Endorsement__c>();
        for(VG_Policy_Schedule_Endorsement__c pe:existingEndorsements){
            if(pe.VG_Endorsement_Library_Id__c != null && !pseTempMap.containsKey(pe.VG_Endorsement_Library_Id__c))
                tmpPSEMap.put(pe.VG_Endorsement_Library_Id__c, pe);
        }
        for(VG_Policy_Schedule_Endorsement__c pse:existingEndorsements){
            if(pse.VG_Endorsement_Library_Id__c == null)
                manualList.add(pse);
        }
        for(VG_Policy_Schedule_Endorsement__c pse:pseTempMap.values()){
            if(manualList.IsEmpty()){
                if(pse.VG_Endorsement_Library_Id__c == null){
                    pse.VG_IsTempDelete__c = false;
                    manualList.add(pse);
                }
            }else{
                for(VG_Policy_Schedule_Endorsement__c pse1:existingEndorsements){
                    if(pse.Name != pse1.Name && pse1.Name != null && !(new Set<VG_Policy_Schedule_Endorsement__c>(manualList)).contains(pse1)){
                        manualList.add(pse);
                    }
                }
            }
        }
        if(!existingEndorsements.IsEmpty()){
            existingEndorsements.clear();
        }
        ElList = [select id, Name, Endorsement_Title__c, Type__c, Text__c from Endorsement_Library__c where  RecordType.Name = : 'Imara' AND Type__c = :'Endorsements' ORDER By Name ASC];
        LibraryWrapperList.clear();
        for(Endorsement_Library__c EL : ElList){            
            LW = new LibraryWrapper();
            LW.EL = EL;            
            LW.isSelected = False;
            if(pseTempMap.containsKey(EL.id)) { 
                LW.isSelected = True;
            }
            if(tmpPSEMap.containsKey(EL.id)) { 
                LW.isSelected = True;
            }                      
            LibraryWrapperList.add(LW); 
        }
        return new PageReference('/apex/VG_Revise_Alpha_Step6');
      }Catch(Exception e){
           showError(e);
           return null;
        }
    }

    Public PageReference gotostep6b(){
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
                tempEndsmt = new VG_Policy_Schedule_Endorsement__c();
                tempEndsmt.VG_Endorsement_Library_Id__c = LW.EL.Id;
                if(tmpPSEMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Endorsement_Details__c = tmpPSEMap.get(LW.EL.Id).VG_Endorsement_Details__c; 
                }else if(pseTempMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Endorsement_Details__c = pseTempMap.get(LW.EL.Id).VG_Endorsement_Details__c; 
                }else{
                    tempEndsmt.VG_Endorsement_Details__c = LW.EL.Text__c;                
                }
                if(tmpPSEMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Title__c = tmpPSEMap.get(LW.EL.Id).VG_Title__c ; 
                    tempEndsmt.VG_Endorsement_Details__c = tmpPSEMap.get(LW.EL.Id).VG_Endorsement_Details__c; 
                }else if(pseTempMap.containsKey(LW.EL.Id)){
                    tempEndsmt.VG_Title__c = pseTempMap.get(LW.EL.Id).VG_Title__c ; 
                    tempEndsmt.VG_Endorsement_Details__c = pseTempMap.get(LW.EL.Id).VG_Endorsement_Details__c; 
                }else{
                    tempEndsmt.VG_Title__c = LW.EL.Endorsement_Title__c;     
                }
                if(pseTempMap.containsKey(LW.EL.Id))
                    tempEndsmt.VG_Premium__c = pseTempMap.get(LW.EL.Id).VG_Premium__c;
                else
                    tempEndsmt.VG_Premium__c = 0;
                if(pseTempMap.containsKey(LW.EL.Id))
                    tempEndsmt.VG_Sub_limit__c = pseTempMap.get(LW.EL.Id).VG_Sub_limit__c;
                else
                    tempEndsmt.VG_Sub_limit__c = 0;
                tempEndsmt.VG_Endorsement_Number__c = LW.EL.Name;
                tempEndsmt.VG_Type__c = LW.EL.Type__c;
                tempEndsmt.VG_IsTempDelete__c = False;
                tempEndsmt.VG_IsTemp__c = True;
                if(MTAType == 'Revision of Cover'){
                    tempEndsmt.VG_Premium__c = 0;
                    tempEndsmt.VG_Sub_limit__c = 0;
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
                    if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c != 0){
                        pse.VG_Premium__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Premium__c;
                    }
                    if(tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c != 0){
                        pse.VG_Sub_limit__c = tmpPSEMap.get(pse.VG_Endorsement_Library_Id__c).VG_Sub_limit__c;
                    }
                }
            }
        }           
        if(existingEndorsements.IsEmpty()){
            counterEnd = 0;
        }else{
            counterEnd = existingEndorsements.size();    
        }       
        return new PageReference('/apex/VG_Revise_Alpha_Step6b');
      }Catch(Exception e){
           showError(e);
           return null;
        }
    }

    Public PageReference cancel(){
        return new PageReference('/'+ps.id);
    }
    

    Public PageReference Finish(){
      try{  
        if(CapacityPaper == '--None--'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select Capacity Paper'));    
            return null;
        }
        ps.VG_Capacity_Paper__c = CapacityPaper;
        ps.Written_share__c = WrittenShare;
        ps.Share__c = SignedShare;
        ps.VG_Structure__c = Structure_Select;
        ps.VG_Sub_Structure__c = Product_Select;
        ps.VG_Reinsurance_Type__c = RI_Select;
        ps.CurrencyIsoCode = policy.CurrencyIsoCode;
        ps.Gross_Written_Premium__c = GrossWrittenPremium;
        ps.VG_Gross_Written_Premium_100__c = GrossWrittenPremium2;
        ps.Technical_UW_Premium__c = TechnicalPremium;
        ps.VG_Brokerage_Percent__c = Brokerage;
        ps.VG_Brokerage_Amount__c = BrokerageAmount;
        ps.Actual_GWP__c = ActualPremium;
        ps.VG_Overider_Percent__c = Overider;
        ps.VG_Fee_Income__c = FeeIncome;
        ps.Premium_Adjustment_2__c = PremiumAdjustment;
        ps.Risk_Premium_Pro__c = PSRiskPremium;
        ps.Endorsement_Premium_Pro__c = EndorsementPremium;
        ps.Rate_On_Line__c = RateOnLine;
        ps.Levies__c = Levies;
        ps.Product__c = SubProduct_Select;
        ps.Sum_Insured__c = sumInsured;
        If(RateChange == 0.00 && policy.VG_Is_Renewal__c == false)       
            ps.VG_Rate_Change__c = null;
        else
            ps.VG_Rate_Change__c = RateChange;
        ps.VG_Technical_Loss_Ratio__c = TechnicalLossRatio;
        ps.Limit__c = limitperrisk ;
        ps.Attachment__c = deductibleperrisk;
        if(!ps.VG_Is_MTA__c){
            ps.Base_Creation_Start_Date__c = ps.Policy__r.VG_Inception_Date__c;
            ps.Base_Creation_End_Date__c = ps.Policy__r.VG_Expiry_Date__c;   
        }  
        ps.Name = ps.Name.remove('/EEA').remove('/NonEEA');
        if(ps.Split_Type__c == 'EEA'){
            ps.Name += '/EEA';
            rc.Name = ps.Name+'/RD/01';
            rr.Name = ps.Name+'/RR/01';
        }else{
            ps.VG_Volante_Entities__c = '';
            rc.Name = rc.Name.remove('/EEA').remove('/NonEEA');
            rr.Name = rr.Name.remove('/EEA').remove('/NonEEA');        
        }      
        if(MTAType != 'Revision of Cover' && !test.isRunningTest())
            Update ps;
        PolicyDetails = 'Insurer :'+Insurer+'<br/>';
        PolicyDetails+= 'Insurer Policy Number :'+InsurerPolicyNumber+'<br/>';
        PolicyDetails+= 'Insurer Policy Currency :'+InsurerPolicyCurrency+'<br/>';
        PolicyDetails+= 'Insurer Policy Limit :'+InsurerPolicyLimit+'<br/>';
        PolicyDetails+= 'Insurer Policy Dedctible :'+InsurerPolicyDedctible+'<br/>';
        PolicyDetails+= 'Insurer Policy Premium :'+InsurerPolicyPremium+'<br/>';
        PolicyDetails+= 'Insurer Policy Share :'+InsurerPolicyShare;
        rc.VG_Additional_Information__c = PolicyDetails;
        rc.VG_Territorial_Scope__c = TT_Select;
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
            i = 1;
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
        if(MTAType != 'Revision of Cover' && !test.isRunningTest())
            Update rc;
        rr.VG_Risk_Premium__c = RiskPremium;
        rr.VG_Retention__c = Retention;
        rr.VG_Expected_Ceding_Commission__c = ExpectedCedingCommission;
        rr.VG_Expected_Profit_Commission__c = ExpectedProfitCommission;
        rr.VG_Treaty_Limit__c = TreatyLimit;
        String subCoverages = '';
        rr.VG_Limit__c= limitperrisk ;
        rr.VG_Deductible__c=deductibleperrisk;
        for ( SelectOption so : SubCoverage_SelectedList) {
            subCoverages += so.getLabel()+';';
        }
        rr.VG_Perils__c = subCoverages ;
        if(MTAType != 'Revision of Cover')
            Update rr;
        List<VG_Policy_Schedule_Endorsement__c> endToBeUpdated = new List<VG_Policy_Schedule_Endorsement__c>();
        List<VG_Policy_Schedule_Endorsement__c> endToBeInserted = new List<VG_Policy_Schedule_Endorsement__c>();
        Set<ID> pseIds = new Set<ID>();
        for(VG_Policy_Schedule_Endorsement__c pse : pseMap.values()){
            pseIds.add(pse.id);
        }
        for(VG_Policy_Schedule_Endorsement__c pse : existingEndorsements){
            if(pse.id == null){
                endToBeInserted.add(pse);
            }else{
                VG_Policy_Schedule_Endorsement__c tmp = new VG_Policy_Schedule_Endorsement__c ();
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
                VG_Policy_Schedule_Endorsement__c tmp = new VG_Policy_Schedule_Endorsement__c ();
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
                if(pse.VG_Type__c == 'Endorsements'){
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
                if(pse.VG_Type__c == 'Endorsements'){
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
        if(MTAType != 'Revision of Cover'){
            if(pseIds.size() > 0){
                List<VG_Policy_Schedule_Endorsement__c> endToBeDeleted = new List<VG_Policy_Schedule_Endorsement__c>([select id from VG_Policy_Schedule_Endorsement__c where id IN: pseIds]);
                Delete endToBeDeleted;
            }
            if(!endToBeUpdated.IsEmpty() && !test.isRunningTest()){
                update endToBeUpdated;
            }
            if(!endToBeInserted.IsEmpty() && !test.isRunningTest()){
                insert endToBeInserted;
            }
            return new PageReference('/'+ps.id);
        }else{
            List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([select id, Name, Policy__r.Name from Policy_Schedule__c where Policy__c = :ps.Policy__c ORDER BY CreatedDate DESC]);
            Policy_Schedule__c rocps = new Policy_Schedule__c();
            rocps = ps;
            rocps.VG_Is_MTA__c = true;
            rocps.VG_Base_Policy__c = true;
            rocps.VG_MTA_Type__c = 'Revision of Cover';
            rocps.id = null;
            rocps.VG_MTA_Start_Date__c = Date.valueOf(MTAStartDate);
            rocps.VG_MTA_End_Date__c = ps.Policy__r.VG_Expiry_Date__c;
            rocps.Base_Creation_Start_Date__c = rocps.VG_MTA_Start_Date__c;
            rocps.Base_Creation_End_Date__c = rocps.VG_MTA_End_Date__c;
            rocps.IPT__c = null;
            rocps.IPT_Percent__c = null;
            rocps.MTA_Parent_Policy_Schedule__c = psId;            
            integer tmp;
            String[] tempDetail;
            if(psList.size()>0){
                List<Integer> nums = new List<Integer>();
                for(Policy_Schedule__c ps : psList){
                    If(ps.Name.contains('/PS/')) 
                        tempDetail = ps.Name.remove('/NonEEA').split('/PS/');
                    else If(ps.Name.contains('/MTA/'))
                        tempDetail = ps.Name.remove('/NonEEA').split('/MTA/');
                    tmp = Integer.valueOf(tempDetail[1]);
                    nums.add(tmp);
                }
                nums.sort();
                rocps.Name = ps.Policy__r.Name+'/PS/'+(nums[nums.size()-1]+1)+'/NonEEA';
            }
            if(!test.isRunningTest())
                Insert rocps;
            List<Policy_Schedule__c> TriggerNew = new List<Policy_Schedule__c>();
            TriggerNew.add(rocps);
            PolicyScheduleTriggerFunction.allowInsertRI = True;
            PolicyScheduleTriggerFunction.createRIRecords(TriggerNew);
            Risk_Capture__c rocrc = new Risk_Capture__c();
            rocrc = rc;
            rocrc.id = null;
            rocrc.Policy_Schedule__c = rocps.id;
            if(!test.isRunningTest())
                insert rocrc;
            VG_Policy_Schedule_Asset__c rocpsa = new VG_Policy_Schedule_Asset__c();
            rocpsa = rr;
            rocpsa.id = null;
            rocpsa.VG_Policy_Schedule__c = rocps.id;
            if(!test.isRunningTest())
                insert rocpsa;
            List<VG_Policy_Schedule_Endorsement__c> rocend = new List<VG_Policy_Schedule_Endorsement__c>();
            rocend.addAll(endToBeUpdated);
            rocend.addAll(endToBeInserted);
            Integer psecounter = 1;
            Integer psesbcounter = 1;
            if(!rocend.IsEmpty()){
                for(VG_Policy_Schedule_Endorsement__c pse : rocend){
                    pse.id = null;
                    pse.VG_Policy_Schedule__c = rocps.id;
                    if(pse.VG_Type__c == 'Endorsements'){
                        pse.Name = rocps.Name+'/PE/'+psecounter;
                        psecounter++;
                    }else{
                        pse.Name = rocps.Name+'/PESB/'+psesbcounter;
                        psesbcounter++;
                    }
                }
                if(!test.isRunningTest())
                    Insert rocend;
            }
            return new PageReference('/'+rocps.id);
        }      
      }Catch(Exception e){
           showError(e);
           return null;
        }
    }
    

    Public void setStructureList(){
        Structure_List.clear();
        SubStructure_List.clear();
        Structure_Select ='';
        Structure_List.add(new SelectOption('--None--','--None--'));
        Structure_List.add(new SelectOption('Proportional','Proportional'));
        Structure_List.add(new SelectOption('Non-Proportional','Non-Proportional'));
    }


    Public void setSubStructureList(){
       try{ 
        SubStructure_List.clear();
        SubStructure_Select='';
        
        if(Product_Select== 'Excess of Loss'){
            if(RI_Select == 'Treaty Reinsurance'){
                SubStructure_List.add(new SelectOption('Per Event','Per Event'));
                SubStructure_List.add(new SelectOption('Per Risk','Per Risk'));
                SubStructure_List.add(new SelectOption('Per Risk & Event','Per Risk & Event'));
            }
            if(RI_Select == 'Facultative Reinsurance'){
                SubStructure_List.add(new SelectOption('Primary','Primary'));
                SubStructure_List.add(new SelectOption('Excess','Excess'));
            }
            
        }
      }Catch(Exception e){
           showError(e);
        }
    }
    

    Public void setProductList(){
      try{  
        Product_List.clear();
        Product_Select='';
        
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
        }Catch(Exception e){
           showError(e);
        }
    }
    

    Public void updatePremiums(){
        try{ 
            RiskRatingCalc();
            if(rc.VG_Rate_Type__c == 'Rate On Income' || rc.VG_Rate_Type__c == 'Swing Rate')
                PSRiskPremium = (RiskPremium * proRata).setScale(2);
            Calc();
        }Catch(Exception e){
           showError(e);
        }
    }
    

    Public void Calc(){
        try{   
            If(RateChange == 0.00 && policy.VG_Is_Renewal__c == false)
                RateChange = null; 
            
            TotalLayerPremium = PremiumAdjustment + PSRiskPremium + EndorsementPremium;
            
            if(SignedShare != null)
                GrossWrittenPremium = TotalLayerPremium * (SignedShare/100);
                    
            if(limitperrisk  != null && SignedShare != null && Product_Select  != 'Aggregate Excess of loss' )
                sumInsured = limitperrisk *(SignedShare/100);
            
            if(Product_Select == 'Aggregate Stop Loss' )
                sumInsured =(((rr.VG_Limit_Precent__c != null ? rr.VG_Limit_Precent__c : 0)  / 100) - ((rr.VG_Deductible_Precent__c != null ? rr.VG_Deductible_Precent__c : 0) / 100)) * GrossWrittenPremium;
                
            if( Product_Select == 'Aggregate Excess of loss' && rr.VG_Aggregate__c != null && SignedShare != null)
                sumInsured = rr.VG_Aggregate__c * (SignedShare/100);
               
            if((Product_Select == 'Quota Share' || Product_Select == 'Structured Quota Share' || Product_Select == 'Facultative Obligatory' ) && SignedShare > 0)
                sumInsured = limitperrisk * (SignedShare/100);
                
            if(Product_Select == 'Quota Share' && SignedShare != null && limitperrisk  != null && RI_Select =='Facultative Reinsurance')
                sumInsured = limitperrisk  * (SignedShare/100);
            
            if(Product_Select == 'Surplus' && SignedShare != null && rr.VG_No_of_Surplus_Lines__c !=null && rr.VG_Retention_Line__c != null)
                sumInsured = rr.VG_Retention_Line__c * rr.VG_No_of_Surplus_Lines__c * (SignedShare / 100);
            
            GrossWrittenPremium2 = TotalLayerPremium;
            
            if(TechnicalLossRatio != null && TechnicalLossRatio > 0)
                TechnicalPremium = GrossWrittenPremium * (TechnicalLossRatio/100);
                
             if(Brokerage != null)
                BrokerageAmount = GrossWrittenPremium * (Brokerage/100);
                
            if(Overider != null)
                OveriderAmount = GrossWrittenPremium*(Overider/100);
                
            if(GrossWrittenPremium > 0  && limitperrisk  != null && limitperrisk  > 0 && deductibleperrisk  != null && deductibleperrisk  > 0 && (limitperrisk - deductibleperrisk ) > 0 && Product_Select != 'Aggregate Stop Loss')
                RateOnLine = GrossWrittenPremium/(limitperrisk -deductibleperrisk );
                
            If(GrossWrittenPremium > 0  && rr.VG_Limit_Precent__c != null && rr.VG_Limit_Precent__c> 0 && rr.VG_Deductible_Precent__c != null && rr.VG_Deductible_Precent__c > 0 && ((rr.VG_Limit_Precent__c/100)-(rr.VG_Deductible_Precent__c/100)) > 0 && Product_Select == 'Aggregate Stop Loss')
                RateOnLine = GrossWrittenPremium/((rr.VG_Limit_Precent__c/100)-(rr.VG_Deductible_Precent__c/100));
                
            ActualPremium = GrossWrittenPremium - BrokerageAmount - OveriderAmount;
        }Catch(Exception e){
           showError(e);
        }
    }

    Public void RiskRatingCalc(){
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


    Public void RiskRatingCalc2(){
        try{ 
            if(rr.VG_Cession__c != null && rr.VG_Cession__c  > 0)
                Retention = 1-(rr.VG_Cession__c/100);
            if(rr.VG_Expected_Premium_Income__c != null && rr.VG_Ceding_Commission__c != null && rr.VG_Ceding_Commission__c > 0)
                ExpectedCedingCommission = rr.VG_Expected_Premium_Income__c * (rr.VG_Ceding_Commission__c/100);
            if(rr.VG_Retention_Line__c != null && rr.VG_No_of_Surplus_Lines__c != null  )
                TreatyLimit = rr.VG_Retention_Line__c * rr.VG_No_of_Surplus_Lines__c;
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
    
    
    Public void showError(Exception e){
        String refId = ErrorTrace.insertLog(e,policyId);
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'An error occurred please contact admin with this reference id '+refId));     
    }
    
    
    Public void AddCustom(){  
        VG_Policy_Schedule_Endorsement__c tempEndsmt = new VG_Policy_Schedule_Endorsement__c();
        tempEndsmt.VG_Premium__c = 0;
        tempEndsmt.VG_Sub_limit__c = 0;
        tempEndsmt.VG_Type__c = 'Endorsements';
        existingEndorsements.add(tempEndsmt);
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