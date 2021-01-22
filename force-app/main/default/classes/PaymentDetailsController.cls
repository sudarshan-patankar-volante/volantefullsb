Public Class PaymentDetailsController{
    
    Public Policy_Schedule__c ps{get;set;}
    Public VG_Policy_Schedule_Asset__c rr{get;set;}
    Public PFWrapper pfw{get;set;}
    Public TaxWrapper taxw{get;set;}
    Public Document PFTemplateFile {get; set;}
    Public Document taxTemplateFile {get; set;}
    
    Public ID psId{get;set;}
    Public ID HozId{get;set;}
    Public ID VFPId{get;set;}
    Public ID EDMId{get;set;}
    public ID BridgeRecordTypeId{get;set;}
    public ID AlphaId {get;set;}
    
    Public Decimal totalPercent{get;set;}
    Public Decimal totalTaxGWP{get;set;}
    Public Decimal totalTaxableAmount{get;set;}
    Public Decimal totalPFPercent{get;set;}
    Public Decimal totalPFGWP{get;set;}
    public Decimal InvoiceNumberUpdate{get;set;} 
    
    Public Integer pfcounter{get;set;}
    Public Integer taxcounter{get;set;}
    
    Public String Index{get;set;}
    Public String RecordType {get; set;}
    Public String nameFile{get;set;}
    Public String URL {get;set;}
    
    Public String[] filelines = new String[]{};
        
    Public List<PFWrapper> pfwList{get;set;}
    Public List<TaxWrapper> taxwList{get;set;}
    Public List<VG_Payment_Frequency__c > InsertedpfList{get;set;}
    Public List<VG_Taxes__c > InsertedtaxList{get;set;}
    Public List < SelectOption > taxJurisdictionList{get;set;}
    Public List<VG_Taxes__c > TaxTobeDeleted{get;set;}
    
    Public Map<String, CurrencyType> currencyRateMap{get;set;}
    
    Public Boolean uploadTax{get;set;}
    Public Boolean uploadPF{get;set;}
    Public Boolean IsDownload{get;set;}
    Public Boolean addTax{get;set;}
    
    Public Blob fileBody{get;set;}
    
    Public PaymentDetailsController(){ 
        
        psId = apexpages.currentpage().getparameters().get('Id');
        
        pfwList = new List<PFWrapper>();
        taxwList = new List<TaxWrapper>();
        TaxTobeDeleted = new List<VG_Taxes__c >();
        taxJurisdictionList = new List < SelectOption >();
        Index='0';
        pfcounter = taxcounter = 0;
        totalPercent = totalTaxGWP = totalTaxableAmount = totalPFPercent = totalPFGWP = 0;
        uploadTax = uploadPF = IsDownload = false;
        addTax = True;
        
        HozId = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Horizon').getRecordTypeId();
        AlphaId = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Imara').getRecordTypeId();
        BridgeRecordTypeId = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
        VFPId = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
        EDMId = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        
        PFTemplateFile = [Select Id from Document where Name = 'Payment Frequency Upload Template'];
        ps=[select id, Name, IsDeleted,RecordType.Name, VG_Tax_Not_Applicable__c, Split_Type__c, CurrencyIsoCode, policy__r.CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastViewedDate, LastReferencedDate, VG_IsTemp__c, VG_IsTempDelete__c, VG_Financials_Created__c, VG_Risk_Premium__c, Insured_Id__c, Declaration_Date__c, Product__c, Policy__c, Policy__r.VG_Inception_Date__c, Policy__r.Broker_Name__r.Terms__c, Policy__r.Terms_of_Trade_Days__c, VG_Plan_Rate__c, IPT_Percent__c, Premium_Adjustment__c, Endorsement_GWP__c, Levies__c, VG_Is_MTA__c, VG_MTA_Type__c, VG_MTA_Status__c, VG_MTA_Start_Date__c, VG_MTA_End_Date__c, VG_Current_Plan_Rate__c, VG_MTA_Cancellation_Date__c, MTA_Reason_for_Cancellation__c, VG_Declaration_Type__c, VG_Status__c, Net_Premium__c, VG_Declaration_Type_percent__c, VG_Fee_Income__c, VG_Adjustment_Reason__c, VG_Brokerage_Percent__c, VG_Net_Premium_Due__c, VG_Pre_MTA_Expiry_Date__c, VG_Base_Policy__c, Base_Creation_Start_Date__c, Base_Creation_End_Date__c, Commission__c, Gross_Base_Premium__c, VG_MGA_Commission_Amount__c, VG_Technical_Model_Premium__c, Technical_UW_Premium__c, Risk_Premium_Pro__c, Endorsement_Premium_Pro__c, Limit__c, Attachment__c, Sum_Insured__c, ILF_Factor__c, ILF_Premium__c, Rate_On_Line__c, Rate_Per_Mil__c, Share__c, Underwriting_Premium__c, Premium_Adjustment_2__c, ORC__c, ORC_Amount__c, Account_Id__c, VG_VAT__c, VG_VAT_Amount__c, VG_Lloyds_Product__c, VG_Net_Premium_Receivable__c, VG_Auto_acquisition_Threshold__c, VG_Extended_Reporting_Period_AP__c, ILF_Layer__c, VG_Retired_Directors_Additional_Premium__c, VG_Retired_Directors_Year__c, VG_Extended_Reporting_Period__c, Technical_Layer_Premium__c, Written_share__c, Gross_Written_Premium__c, VG_Non_Taxable_Premium__c, Gross_or_Net_Premium__c, VG_Overider_Amount__c, VG_Overider_Percent__c, VG_Total_Layer_Premium__c, Transaction_GWP__c, Actual_GWP__c, IPT__c, VG_Brokerage_Amount__c, VG_Deductible__c, VG_Booked_Time__c, VG_Coverages__c, VG_Number_Of_vehicle__c, VG_Turn_Over__c, VG_Type_Of_Operation__c, VG_CREDIT_Augur_SCORE__c, VG_Exposure_Premium__c, VG_Experience_Premium__c, VG_Selected_Weight__c, VG_Net_Base_Premium__c, VG_Occupancy__c, VG_PD_Base_Rate__c, VG_BI_Base_Rate__c, VG_Machinery_Breakdown_Cover__c, VG_Machinery_Breakdown_BI_Cover__c, VG_Adjustment_Factor__c, VG_Adjusted_PD_Base_Rate__c, VG_Adjusted_BI_Base_Rate__c, VG_Witholding_Tax_Amount__c, VG_Net_Premium_Received__c, VG_Reinsurance_Type__c, VG_Structure__c, VG_Sub_Structure__c, VG_Technical_Loss_Ratio__c, MID_Check_Box__c, VG_Capacity_Paper__c, VG_Payment_Due_Date__c, VG_Wording__c from Policy_Schedule__c where id=: psId];
        InsertedpfList = new List<VG_Payment_Frequency__c >([select id, Name, VG_Broker__c,VG_Comment__c, VG_Is_Temp_Delete__c, VG_GWP_This_Time__c, CurrencyIsoCode, VG_Payment_Percent__c, VG_Due_Date__c, VG_Outstanding_taxes__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.Policy__r.Policy_Status__c from VG_Payment_Frequency__c where VG_Policy_Schedule__c =: psid AND VG_Payment_Percent__c  != null ORDER BY VG_Due_Date__c ASC ]);
        InsertedtaxList = new List<VG_Taxes__c >([select id, Name, VG_Override__c, CurrencyIsoCode, VG_Tax_Type__c, VG_Is_Temp_Delete__c, VG_Taxable_Amount__c, VG_Tax_Amount__c, VG_Tax_Paid_By__c, VG_Comment__c, VG_Tax_Percent__c, VG_Tax_Administered_By__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.Policy__r.Policy_Status__c, VG_Tax_Jurisdiction__c,VG_Tax_Amount_GWP_100__c from VG_Taxes__c where VG_Policy_Schedule__c =: psid ]);
        
        String u = '/apex/VG_Download_All_Taxes?id='+ps.id;
        URL = System.URL.getSalesforceBaseUrl().toExternalForm()+'/s/sfdcpage/'+EncodingUtil.urlEncode(u, 'UTF-8');
        URL = System.URL.getSalesforceBaseUrl().toExternalForm();
        if(ps.RecordType.Name == 'VFP'){
            URL = '/VFP/s/sfdcpage/'+EncodingUtil.urlEncode(u, 'UTF-8');
        }else if(ps.RecordType.Name == 'Edison Motor' ){
            URL = '/Edison/s/sfdcpage/'+EncodingUtil.urlEncode(u, 'UTF-8');
        }else if(ps.RecordType.Name == 'Aesir' ){
            URL = '/Aesir/s/sfdcpage/'+EncodingUtil.urlEncode(u, 'UTF-8');
        }else if(ps.RecordType.Name == 'Imara' ){
            URL = '/Imara/s/sfdcpage/'+EncodingUtil.urlEncode(u, 'UTF-8');
        }else if(ps.RecordType.Name == 'Horizon' ){
            URL = '/Horizon/s/sfdcpage/'+EncodingUtil.urlEncode(u, 'UTF-8');
        }else if(ps.RecordType.Name == 'Bridge' ){
            URL = '/Bridge/s/sfdcpage/'+EncodingUtil.urlEncode(u, 'UTF-8');
        }else if(ps.RecordType.Name == 'Affinity' ){
            URL = '/LS/s/sfdcpage/'+EncodingUtil.urlEncode(u, 'UTF-8');
        }else if(ps.RecordType.Name == 'VCL' ){
            URL = '/VCL/s/sfdcpage/'+EncodingUtil.urlEncode(u, 'UTF-8');
        }else if(ps.RecordType.Name == 'Gentium' ){
            URL = '/Gentium/s/sfdcpage/'+EncodingUtil.urlEncode(u, 'UTF-8');
        }
        if(ps.RecordType.Name != 'VFP'){
            taxTemplateFile = [Select Id from Document where Name = 'Tax Upload Template'];
        }else{
            taxTemplateFile = [Select Id from Document where Name = 'Tax Upload Template VFP'];
        }
        List<CurrencyType> exchangeRates = [Select Id,  ConversionRate,  IsoCode from CurrencyType];
        currencyRateMap = new Map<String, CurrencyType>();
        for(CurrencyType cr : exchangeRates){
            currencyRateMap.put(cr.IsoCode, cr);
        }
        if(ps.RecordTypeId == BridgeRecordTypeId)
            RecordType='Bridge';
        if(ps.RecordTypeId == VFPId)
            RecordType='VFP';
        if(ps.RecordTypeId == EDMId)
            RecordType='Edison Motor';
        If(ps.RecordTypeId == HozId)
            rr=[Select id, Name, VG_Deposit_Premium__c From VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =: psId];
        If(ps.RecordTypeId == AlphaId)
            RecordType = apexpages.currentpage().getparameters().get('RecordType');
            
        if(InsertedpfList.size()>0){
            totalPFPercent = totalPFGWP = 0;
            for(VG_Payment_Frequency__c pf:InsertedpfList){
                pfw = new PFWrapper();
                pfw.pf = pf;
                if(pf.VG_Due_Date__c <= system.today())
                    pfw.show = false;
                pfw.counter = String.valueOf(pfcounter);
                if(pfw.pf.VG_Payment_Percent__c  != null){
                    pfw.currenctCurrencyGWP = ps.Gross_Written_Premium__c*(pfw.pf.VG_Payment_Percent__c/100);
                    pfw.currenctCurrencyGWP = ( pfw.currenctCurrencyGWP / currencyRateMap.get(ps.CurrencyIsoCode).ConversionRate ) * currencyRateMap.get(pfw.pf.CurrencyIsoCode).ConversionRate ;
                }
                If(ps.RecordTypeId == HozId){
                    if(pfw.pf.VG_Payment_Percent__c  != null && rr.VG_Deposit_Premium__c  != null){
                        pfw.currenctCurrencyGWP = ps.Gross_Written_Premium__c*(pfw.pf.VG_Payment_Percent__c/100)*(rr.VG_Deposit_Premium__c/100);
                        pfw.currenctCurrencyGWP = ( pfw.currenctCurrencyGWP / currencyRateMap.get(ps.CurrencyIsoCode).ConversionRate ) * currencyRateMap.get(pfw.pf.CurrencyIsoCode).ConversionRate ;
                    }else if(pfw.pf.VG_Payment_Percent__c  != null && rr.VG_Deposit_Premium__c == null){
                        rr.VG_Deposit_Premium__c = 0;
                        pfw.currenctCurrencyGWP = ps.Gross_Written_Premium__c*(pfw.pf.VG_Payment_Percent__c/100);
                        pfw.currenctCurrencyGWP = ( pfw.currenctCurrencyGWP / currencyRateMap.get(ps.CurrencyIsoCode).ConversionRate ) * currencyRateMap.get(pfw.pf.CurrencyIsoCode).ConversionRate ;
                    }
                } 
                pfw.GWP = (pfw.currenctCurrencyGWP / currencyRateMap.get(pfw.pf.CurrencyIsoCode).ConversionRate) * currencyRateMap.get(ps.CurrencyIsoCode).ConversionRate;
                If(pfw.pf.VG_Payment_Percent__c != null)
                    totalPFPercent = (totalPFPercent + pfw.pf.VG_Payment_Percent__c).setScale(6);
                totalPFGWP = (totalPFGWP + pfw.GWP).setScale(2); 
                pfwList.add(pfw);
                pfcounter++;
            }
        }
        
        if(InsertedtaxList.size() > 0 ){
            totalTaxGWP = 0;
            for(VG_Taxes__c tax:InsertedtaxList){
                taxw = new TaxWrapper();
                taxw.tax = tax;
                taxw.show = true;
                if(taxw.tax.VG_Override__c){
                    taxw.GWP = tax.VG_Tax_Amount__c;
                }else {
                    taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Taxable_Amount__c*(taxw.tax.VG_Tax_Percent__c/100);
                    if(VFPId == ps.RecordTypeId){
                        taxw.GWP = taxw.tax.VG_Taxable_Amount__c*(ps.Share__c/100)*(taxw.tax.VG_Tax_Percent__c/100);                   
                    }else if(EDMId == ps.RecordTypeId){
                        taxw.GWP = ps.Gross_Written_Premium__c*(taxw.tax.VG_Tax_Percent__c/100);
                    }else{
                        taxw.GWP = taxw.tax.VG_Taxable_Amount__c*(taxw.tax.VG_Tax_Percent__c/100);
                    }
                    taxw.tax.VG_Tax_Amount__c = taxw.GWP;
                }
                if(taxw.tax.VG_Tax_Administered_By__c=='Insured' && taxw.tax.VG_Tax_Paid_By__c=='Insurer' && !taxw.tax.VG_Override__c){
                    taxw.GWP = taxw.GWP*(-1);
                    taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Tax_Amount_GWP_100__c*(-1);
                }else if(taxw.tax.VG_Tax_Administered_By__c=='Broker' && taxw.tax.VG_Tax_Paid_By__c=='Insurer' && !taxw.tax.VG_Override__c){
                    taxw.GWP = taxw.GWP*(-1);
                    taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Tax_Amount_GWP_100__c*(-1);
                }else if(taxw.tax.VG_Tax_Administered_By__c=='Insurer' && taxw.tax.VG_Tax_Paid_By__c=='Insured' && !taxw.tax.VG_Override__c){
                    taxw.GWP = taxw.GWP*(1);
                    taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Tax_Amount_GWP_100__c*(1);
                }
                if((taxw.tax.VG_Tax_Administered_By__c=='Insured' && taxw.tax.VG_Tax_Paid_By__c=='Insurer') || (taxw.tax.VG_Tax_Administered_By__c=='Broker' && taxw.tax.VG_Tax_Paid_By__c=='Insurer') || (taxw.tax.VG_Tax_Administered_By__c=='Insurer' && taxw.tax.VG_Tax_Paid_By__c=='Insured')){
                    totalTaxGWP = (totalTaxGWP + taxw.GWP).setScale(2); 
                } 
                totalTaxableAmount = (totalTaxableAmount + taxw.tax.VG_Taxable_Amount__c).setScale(2) ;
                taxw.counter = String.valueOf(taxcounter);
                taxwList.add(taxw);
                taxcounter++;
            }
        } 
        
        if(InsertedtaxList.size()  > 0 )
            IsDownload = True;
        else
            IsDownload = false; 
             
        taxJurisdictionList.add(new SelectOption('--None--','--None--'));                
         if(ps.RecordType.Name=='Imara'){
            for(String s : Label.Tax_Jurisdiction5.split(';')){
                taxJurisdictionList.add(new SelectOption(s,s));
            }
            for(String s : Label.Tax_Jurisdiction6.split(';')){
                taxJurisdictionList.add(new SelectOption(s,s));
            }
        }else{                
            for(String s : Label.Tax_Jurisdiction1.split(';')){
                taxJurisdictionList.add(new SelectOption(s,s));
            }
            for(String s : Label.Tax_Jurisdiction2.split(';')){
                taxJurisdictionList.add(new SelectOption(s,s));
            }
            for(String s : Label.Tax_Jurisdiction3.split(';')){
                taxJurisdictionList.add(new SelectOption(s,s));
            } 
        }
    }
    
    Public PageReference addPaymentFrequency(){
        totalPercent = 0;
        for(PFWrapper pfw:pfwList){                  
            if((pfw.pf.VG_Payment_Percent__c == null || pfw.pf.VG_Due_Date__c == null) && !pfw.pf.VG_Is_Temp_Delete__c){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Due date and Payment Frequency field must be filled all Payment Frequencies...'));   
                return null;
            }
            If(!pfw.pf.VG_Is_Temp_Delete__c)
                totalPercent = totalPercent+pfw.pf.VG_Payment_Percent__c;
        }
        if(totalPercent >= 100  && ps.RecordType.Name !='Horizon'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Cant add new Payment Frequency because sum of Payment (%) reached 100 ..'));   
            return null;
        }else{
            pfw = new PFWrapper();
            pfw.pf.CurrencyIsoCode = ps.CurrencyIsoCode;
            pfw.show = true;
            If(ps.RecordType.Name=='Edison Motor'){
                pfw.pf.VG_Payment_Percent__c=100;      
                pfw.pf.CurrencyIsoCode = 'GBP';                        
            }
            If(pfcounter == 0){
                If(ps.VG_MTA_Type__c ==null){
                    if(ps.Policy__r.VG_Inception_Date__c  != null && ps.Policy__r.Terms_of_Trade_Days__c  != null){
                        pfw.pf.VG_Due_Date__c = ps.Policy__r.VG_Inception_Date__c.addDays(Integer.valueOf(ps.Policy__r.Terms_of_Trade_Days__c));
                    }else{
                        If(ps.Policy__r.VG_Inception_Date__c != null && ps.Policy__r.Broker_Name__r.Terms__c != null){
                            pfw.pf.VG_Due_Date__c = ps.Policy__r.VG_Inception_Date__c.addDays(Integer.valueOf(ps.Policy__r.Broker_Name__r.Terms__c));
                        }else If(ps.Policy__r.VG_Inception_Date__c != null){
                            pfw.pf.VG_Due_Date__c = ps.Policy__r.VG_Inception_Date__c.addDays(0);
                        }    
                    }
                }
                If(ps.VG_MTA_Type__c !=null){
                    If(ps.VG_MTA_Type__c == 'Extension' || ps.VG_MTA_Type__c == 'Revision of Cover' || ps.VG_MTA_Type__c == 'Declaration' || ps.VG_MTA_Type__c == 'Run-Off' ){
                        if(ps.VG_MTA_Start_Date__c != null && ps.Policy__r.Terms_of_Trade_Days__c  != null){    
                            pfw.pf.VG_Due_Date__c = ps.VG_MTA_Start_Date__c.addDays(Integer.valueOf(ps.Policy__r.Terms_of_Trade_Days__c));
                        }else{
                            If(ps.VG_MTA_Start_Date__c != null && ps.Policy__r.Broker_Name__r.Terms__c != null){
                                pfw.pf.VG_Due_Date__c = ps.VG_MTA_Start_Date__c.addDays(Integer.valueOf(ps.Policy__r.Broker_Name__r.Terms__c));
                            }else If(ps.VG_MTA_Start_Date__c != null){                              
                                pfw.pf.VG_Due_Date__c = ps.VG_MTA_Start_Date__c;                              
                            }    
                        } 
                    }else if(ps.VG_MTA_Type__c == 'Reduction'){
                        if(ps.VG_MTA_Reduction_Date__c != null && ps.Policy__r.Terms_of_Trade_Days__c  != null){    
                            pfw.pf.VG_Due_Date__c = ps.VG_MTA_Reduction_Date__c.addDays(Integer.valueOf(ps.Policy__r.Terms_of_Trade_Days__c));
                        }else{
                            If(ps.VG_MTA_Reduction_Date__c != null && ps.Policy__r.Broker_Name__r.Terms__c != null){
                                pfw.pf.VG_Due_Date__c = ps.VG_MTA_Reduction_Date__c.addDays(Integer.valueOf(ps.Policy__r.Broker_Name__r.Terms__c));
                            }else If(ps.VG_MTA_Reduction_Date__c != null){                              
                                pfw.pf.VG_Due_Date__c = ps.VG_MTA_Reduction_Date__c;                              
                            }    
                        }                        
                    }else if(ps.VG_MTA_Type__c == 'Cancellation'){
                        if(ps.VG_MTA_Cancellation_Date__c != null && ps.Policy__r.Terms_of_Trade_Days__c  != null){    
                            pfw.pf.VG_Due_Date__c = ps.VG_MTA_Cancellation_Date__c.addDays(Integer.valueOf(ps.Policy__r.Terms_of_Trade_Days__c));
                        }else{
                            If(ps.VG_MTA_Cancellation_Date__c != null && ps.Policy__r.Broker_Name__r.Terms__c != null){
                                pfw.pf.VG_Due_Date__c = ps.VG_MTA_Cancellation_Date__c.addDays(Integer.valueOf(ps.Policy__r.Broker_Name__r.Terms__c));
                            }else If(ps.VG_MTA_Cancellation_Date__c != null){                              
                                pfw.pf.VG_Due_Date__c = ps.VG_MTA_Cancellation_Date__c;                              
                            }    
                        }                          
                    }                  
                }              
            }    
            pfw.counter = String.valueOf(pfcounter);
            pfwList.add(pfw);
            If(ps.RecordType.Name=='Edison Motor')
                thisTimeGWP();  
            pfcounter++;
        }
        return null;
    }
    
    
    Public void addTax(){
        If(ps.RecordType.Name=='Edison Motor'){
            ps.VG_Tax_Not_Applicable__c = false;
            taxw = new TaxWrapper();
            taxw.counter = String.valueOf(taxcounter);
            taxw.tax.VG_Tax_Jurisdiction__c='UK';
            taxw.tax.VG_Tax_Type__c = 'Insurance Premium Tax';
            taxw.tax.CurrencyIsoCode = ps.CurrencyIsoCode;
            taxw.tax.VG_Tax_Administered_By__c='Insurer';
            taxw.tax.VG_Tax_Paid_By__c='Insured';
            taxw.tax.VG_Override__c = false;
            taxw.tax.VG_Tax_Percent__c = 12;
            taxw.tax.VG_Taxable_Amount__c=(ps.Gross_Written_Premium__c).setScale(2);
            taxw.show = false;            
            taxcounter++;
            taxwList.add(taxw);
            thisTimeGWP(); 
        }else{
            ps.VG_Tax_Not_Applicable__c = false;
            taxw = new TaxWrapper();
            taxw.counter = String.valueOf(taxcounter);
            taxw.tax.CurrencyIsoCode = ps.CurrencyIsoCode;
            taxw.tax.VG_Override__c = false;
            taxw.tax.VG_Tax_Percent__c = 0;
            taxw.tax.VG_Taxable_Amount__c = 0;
            taxw.tax.VG_Tax_Amount_GWP_100__c=0;
            taxw.show = false;
            taxcounter++;
            taxwList.add(taxw);
        }
        if(taxwList.size()  > 0)
            IsDownload = True;
        else
            IsDownload = false;
        for(TaxWrapper taxw:taxwList){
            if(taxw.tax.VG_Tax_Administered_By__c == '--None--' || taxw.tax.VG_Tax_Paid_By__c == '--None--' || taxw.tax.VG_Tax_Administered_By__c == null || taxw.tax.VG_Tax_Paid_By__c == null ){
                IsDownload = false;
            }
        }
    }
    
    
    Public void NotApplicableTax(){
        ps.VG_Tax_Not_Applicable__c = True;      
    }
    
    
    Public void RemovePF(){
        pfcounter = 0;
        totalPercent = 0;
        totalPFPercent = totalPFGWP = 0;
        for(PFwrapper pfw: pfwList){
            pfw.counter = string.valueOf(pfcounter);
            if(pfcounter == integer.valueOf(Index)){
                pfw.pf.VG_Is_Temp_Delete__c = True;                      
            }
            if(!pfw.pf.VG_Is_Temp_Delete__c){ 
                totalPercent = totalPercent + (pfw.pf.VG_Payment_Percent__c != null ? pfw.pf.VG_Payment_Percent__c : 0);
                totalPFPercent = (totalPFPercent + (pfw.pf.VG_Payment_Percent__c != null ? pfw.pf.VG_Payment_Percent__c : 0)).setScale(6);
                totalPFGWP = (totalPFGWP + pfw.GWP).setScale(2); 
            } 
            pfcounter++;
        }         
    }
    
    
    Public void thisTimeGWPOR(){
        taxcounter = 0;
        totalTaxGWP = 0;
        totalTaxableAmount = 0;
        for(TaxWrapper taxw:taxwList){
            if(taxcounter == integer.valueOf(Index)){
                if(!taxw.tax.VG_Is_Temp_Delete__c){
                    System.debug('check::'+taxw.tax.VG_Tax_Administered_By__c+taxw.tax.VG_Tax_Paid_By__c);
                    if(taxw.tax.VG_Tax_Administered_By__c=='Insured' && taxw.tax.VG_Tax_Paid_By__c=='Insurer' ){
                        taxw.GWP = taxw.GWP*(-1);
                        taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Tax_Amount_GWP_100__c*(-1);
                    }else if(taxw.tax.VG_Tax_Administered_By__c=='Broker' && taxw.tax.VG_Tax_Paid_By__c=='Insurer' ){
                        taxw.GWP = taxw.GWP*(-1);
                        taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Tax_Amount_GWP_100__c*(-1);
                    }else if(taxw.tax.VG_Tax_Administered_By__c=='Insurer' && taxw.tax.VG_Tax_Paid_By__c=='Insured'){
                        taxw.GWP = taxw.GWP*(1);
                        taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Tax_Amount_GWP_100__c*(1);
                    }
                }
            }  
            if(!taxw.tax.VG_Is_Temp_Delete__c){
                totalTaxableAmount = (totalTaxableAmount + taxw.tax.VG_Taxable_Amount__c ).setScale(2);
                if((taxw.tax.VG_Tax_Administered_By__c=='Insured' && taxw.tax.VG_Tax_Paid_By__c=='Insurer') || (taxw.tax.VG_Tax_Administered_By__c=='Broker' && taxw.tax.VG_Tax_Paid_By__c=='Insurer') || (taxw.tax.VG_Tax_Administered_By__c=='Insurer' && taxw.tax.VG_Tax_Paid_By__c=='Insured')){
                    totalTaxGWP = (totalTaxGWP + taxw.GWP).setScale(2); 
                }          
            }
            taxcounter++;                    
        }
    }
    
    
    Public void thisTimeGWP(){
        totalPercent = 0;
        totalPFPercent = totalPFGWP = 0;
        for(PFwrapper pfw: pfwList){
            If(!pfw.pf.VG_Is_Temp_Delete__c && pfw.pf.VG_Payment_Percent__c != null)
                totalPercent = totalPercent+pfw.pf.VG_Payment_Percent__c;
            if(pfw.pf.VG_Payment_Percent__c  != null){
                pfw.currenctCurrencyGWP = ps.Gross_Written_Premium__c*(pfw.pf.VG_Payment_Percent__c/100);
                pfw.currenctCurrencyGWP = ( pfw.currenctCurrencyGWP / currencyRateMap.get(ps.CurrencyIsoCode).ConversionRate ) * currencyRateMap.get(pfw.pf.CurrencyIsoCode).ConversionRate ;
            }
            If(ps.RecordTypeId == HozId){
                if(pfw.pf.VG_Payment_Percent__c  != null && rr.VG_Deposit_Premium__c  != null){
                    pfw.currenctCurrencyGWP = ps.Gross_Written_Premium__c*(pfw.pf.VG_Payment_Percent__c/100)*(rr.VG_Deposit_Premium__c/100);
                    pfw.currenctCurrencyGWP = ( pfw.currenctCurrencyGWP / currencyRateMap.get(ps.CurrencyIsoCode).ConversionRate ) * currencyRateMap.get(pfw.pf.CurrencyIsoCode).ConversionRate ;
                }else if(pfw.pf.VG_Payment_Percent__c  != null && rr.VG_Deposit_Premium__c == null){
                    rr.VG_Deposit_Premium__c = 0;
                    pfw.currenctCurrencyGWP = ps.Gross_Written_Premium__c*(pfw.pf.VG_Payment_Percent__c/100);
                    pfw.currenctCurrencyGWP = ( pfw.currenctCurrencyGWP / currencyRateMap.get(ps.CurrencyIsoCode).ConversionRate ) * currencyRateMap.get(pfw.pf.CurrencyIsoCode).ConversionRate ;
                }
            } 
            pfw.GWP = (pfw.currenctCurrencyGWP / currencyRateMap.get(pfw.pf.CurrencyIsoCode).ConversionRate) * currencyRateMap.get(ps.CurrencyIsoCode).ConversionRate;
            if(!pfw.pf.VG_Is_Temp_Delete__c){
                If(pfw.pf.VG_Payment_Percent__c != null)
                    totalPFPercent = (totalPFPercent + pfw.pf.VG_Payment_Percent__c).setScale(6);
                totalPFGWP = (totalPFGWP + pfw.GWP).setScale(2); 
            } 
        }
        
        totalTaxGWP = 0;
        totalTaxableAmount = 0;
        
        if(taxwList.size()  > 0)
            IsDownload = True;
        else
            IsDownload = false;
        for(TaxWrapper taxw:taxwList){
            if(taxw.tax.VG_Tax_Administered_By__c == '--None--' || taxw.tax.VG_Tax_Paid_By__c == '--None--' || taxw.tax.VG_Tax_Administered_By__c == null || taxw.tax.VG_Tax_Paid_By__c == null ){
                IsDownload = false;
            }
            if(taxw.tax.VG_Override__c){
                
            }else{                    
                taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Taxable_Amount__c*(taxw.tax.VG_Tax_Percent__c/100);
                if(ps.RecordTypeId != VFPId){
                    if(taxw.tax.VG_Taxable_Amount__c  != null && taxw.tax.VG_Tax_Percent__c  != null)
                        taxw.GWP = taxw.tax.VG_Taxable_Amount__c*(taxw.tax.VG_Tax_Percent__c/100);
                }else{
                    taxw.GWP = taxw.tax.VG_Taxable_Amount__c*(ps.Share__c/100)*(taxw.tax.VG_Tax_Percent__c/100);
                }
                taxw.tax.VG_Tax_Amount__c = taxw.GWP;
            }
            
            if(!taxw.tax.VG_Is_Temp_Delete__c){
                if(taxw.tax.VG_Tax_Administered_By__c=='Insured' && taxw.tax.VG_Tax_Paid_By__c=='Insurer' && !taxw.tax.VG_Override__c){
                    taxw.GWP = taxw.GWP*(-1);
                    taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Tax_Amount_GWP_100__c*(-1);
                }else if(taxw.tax.VG_Tax_Administered_By__c=='Broker' && taxw.tax.VG_Tax_Paid_By__c=='Insurer' && !taxw.tax.VG_Override__c){
                    taxw.GWP = taxw.GWP*(-1);
                    taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Tax_Amount_GWP_100__c*(-1);
                }else if(taxw.tax.VG_Tax_Administered_By__c=='Insurer' && taxw.tax.VG_Tax_Paid_By__c=='Insured' && !taxw.tax.VG_Override__c){
                    taxw.GWP = taxw.GWP*(1);
                    taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.tax.VG_Tax_Amount_GWP_100__c*(1);
                }
                if((taxw.tax.VG_Tax_Administered_By__c=='Insured' && taxw.tax.VG_Tax_Paid_By__c=='Insurer') || (taxw.tax.VG_Tax_Administered_By__c=='Broker' && taxw.tax.VG_Tax_Paid_By__c=='Insurer') || (taxw.tax.VG_Tax_Administered_By__c=='Insurer' && taxw.tax.VG_Tax_Paid_By__c=='Insured')){
                    totalTaxGWP = (totalTaxGWP + taxw.GWP).setScale(2); 
                }               
                totalTaxableAmount = (totalTaxableAmount + taxw.tax.VG_Taxable_Amount__c ).setScale(2);
            }
        }
    }
    
    
    Public void RemoveTax(){
        taxcounter = 0;
        totalTaxGWP = 0;
        totalTaxableAmount = 0;
        for(TaxWrapper taxw:taxwList){
            taxw.counter = String.valueOf(taxcounter);
            if(taxcounter == integer.valueOf(Index)){
                taxw.tax.VG_Is_Temp_Delete__c = True;   
            }  
            if(!taxw.tax.VG_Is_Temp_Delete__c){
                totalTaxableAmount = (totalTaxableAmount + taxw.tax.VG_Taxable_Amount__c ).setScale(2);
                if((taxw.tax.VG_Tax_Administered_By__c=='Insured' && taxw.tax.VG_Tax_Paid_By__c=='Insurer') || (taxw.tax.VG_Tax_Administered_By__c=='Broker' && taxw.tax.VG_Tax_Paid_By__c=='Insurer') || (taxw.tax.VG_Tax_Administered_By__c=='Insurer' && taxw.tax.VG_Tax_Paid_By__c=='Insured')){
                    totalTaxGWP = (totalTaxGWP + taxw.GWP).setScale(2); 
                }          
            }
            taxcounter++;                    
        }
        for(TaxWrapper taxw:taxwList){
            if(taxw.tax.VG_Tax_Administered_By__c != 'None' && taxw.tax.VG_Tax_Paid_By__c != '--None--'){
                IsDownload = True;
            }else{
                IsDownload = false;
            }
        }
    }
    
    
    Public PageReference finish(){
        List<VG_Payment_Frequency__c > toInsertpfList = new List<VG_Payment_Frequency__c >();
        List<VG_Payment_Frequency__c > toUpdatepfList = new List<VG_Payment_Frequency__c >();
        List<VG_Payment_Frequency__c > PFTobeDeleted = new List<VG_Payment_Frequency__c >();
        List<PFWrapper > newPFWList= new List<PFWrapper >();
        List<VG_Taxes__c > toInserttaxList = new List<VG_Taxes__c >();
        List<VG_Taxes__c > toUpdatetaxList = new List<VG_Taxes__c >();
        Decimal totalPercent = 0;
        Set<Date> pfDates = new Set<Date>();
        SystemConstants__c InvoiceNumber = [Select Id, DocumentId__c from SystemConstants__c where Name = 'Invoice Number' FOR UPDATE];           
        ps.VG_Non_Taxable_Premium__c = ps.Gross_Written_Premium__c - totalTaxableAmount;
        for(PFWrapper pfw: pfwList){
            if(pfw.pf.id != null && pfw.pf.VG_Is_Temp_Delete__c)
                PFTobeDeleted.add(pfw.pf);
            If(!pfw.pf.VG_Is_Temp_Delete__c)
                newPFWList.add(pfw);
            if(!pfw.pf.VG_Is_Temp_Delete__c && pfw.pf.VG_Due_Date__c <= ps.Policy__r.VG_Inception_Date__c){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Cant add new Payment Frequency because due date must come after inception date.please check payment frequency no.'+(Integer.valueOf(pfw.counter)+1)));   
                return null;
            }
            if(!pfw.pf.VG_Is_Temp_Delete__c && !pfDates.contains(pfw.pf.VG_Due_Date__c)){
                pfDates.add(pfw.pf.VG_Due_Date__c);
            }
            if(!pfw.pf.VG_Is_Temp_Delete__c && (pfw.pf.VG_Payment_Percent__c == null || pfw.pf.VG_Due_Date__c == null)){
                if(totalPercent  != 100){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Due date and Payment Frequency field must be filled all Payment Frequencies...'));   
                    return null;
                }
            }
            If(!pfw.pf.VG_Is_Temp_Delete__c && pfw.pf.VG_Payment_Percent__c  != null)
                totalPercent = totalPercent+pfw.pf.VG_Payment_Percent__c;
        }
        if(!PFTobeDeleted.IsEmpty()){
            Delete PFTobeDeleted;
        }
        pfwList=newPFWList;
        if(totalPercent  != 100 && !pfwList.IsEmpty()  && ps.RecordType.Name !='Horizon'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'total of Payment(%) must be 100 ..'));   
            return null;
        }
        Integer pfc = 0;
        for(PFWrapper pfw:pfwList){
            thisTimeGWP();
            If(pfw.pf.VG_Policy_Schedule__c == null)           
                pfw.pf.VG_Policy_Schedule__c = ps.id;               
            if(!pfw.pf.VG_Is_Temp_Delete__c) {
                pfw.pf.Name = ps.Name+'/PF/'+pfc;
                pfw.pf.VG_GWP_This_Time__c = pfw.currenctCurrencyGWP;                  
                pfc++;
            }
            if(pfw.pf.id == null && !pfw.pf.VG_Is_Temp_Delete__c){
                if(ps.RecordTypeId == BridgeRecordTypeId){
                    InvoiceNumberUpdate = Decimal.valueOf(InvoiceNumber.DocumentId__c)+1;
                    InvoiceNumber.DocumentId__c  =  String.valueOf(InvoiceNumberUpdate);             
                    pfw.pf.VG_Invoice_Number__c = String.valueOf(InvoiceNumberUpdate);
                }
                toInsertpfList.add(pfw.pf);
            }
            if(pfw.pf.id != null && pfw.pf.VG_Outstanding_taxes__c == null)
                toUpdatepfList.add(pfw.pf);            
        }
        
        Set<String> eeaCountries = new Set<String>();
        eeaCountries.addAll(Label.EEA_Countries.split(';'));
           
        for(TaxWrapper taxw:taxwList){
            if(!taxw.tax.VG_Is_Temp_Delete__c && (taxw.tax.VG_Tax_Administered_By__c=='--None--' || taxw.tax.VG_Tax_Administered_By__c == null || taxw.tax.VG_Tax_Paid_By__c =='--None--' || taxw.tax.VG_Tax_Paid_By__c == null)){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Tax Paid By and Tax Administered By must fill in all Tax...'));   
                return null;
            }
            if(!taxw.tax.VG_Is_Temp_Delete__c && ps.RecordTypeId == VFPId && ps.Split_Type__c == 'EEA' && (!eeaCountries.contains(taxw.tax.VG_Tax_Jurisdiction__c))){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please check tax jurisdiction as policy schedule split is for EEA and tax jurisdiction is Non EEA for '+taxw.tax.VG_Tax_Type__c));
                return null;
            }else if(!taxw.tax.VG_Is_Temp_Delete__c && ps.RecordTypeId == VFPId && ps.Split_Type__c == 'Non EEA' && (eeaCountries.contains(taxw.tax.VG_Tax_Jurisdiction__c))){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please check tax jurisdiction as policy schedule split is for Non EEA and tax jurisdiction is EEA for '+taxw.tax.VG_Tax_Type__c));
                return null;
            }
            
            taxw.tax.Name = taxw.tax.VG_Tax_Type__c ;
            If(taxw.tax.VG_Policy_Schedule__c == null)
                taxw.tax.VG_Policy_Schedule__c = ps.id;
                
            taxw.tax.CurrencyISOCode = ps.policy__r.CurrencyIsoCode;
            taxw.tax.VG_Tax_Amount__c = taxw.GWP;
            
            If(taxw.tax.VG_Is_Temp_Delete__c && taxw.tax.id != null){               
                TaxTobeDeleted.add(taxw.tax); 
            }      
                       
            if(taxw.tax.id == null && !taxw.tax.VG_Is_Temp_Delete__c){
                toInserttaxList.add(taxw.tax);
            }
            
            if(taxw.tax.id != null){
                If(taxw.GWP != taxw.tax.VG_Tax_Amount__c)
                    taxw.tax.VG_Tax_Amount__c = taxw.GWP;  
                toUpdatetaxList.add(taxw.tax);
            }                        
        }
        Utilities.SkipMethods('Bridge Child Context'); 
        Utilities.SkipMethods('Payment Frequency Context');
        if(ps.VG_Tax_Not_Applicable__c == True && toInserttaxList.size()==0)
            ps.VG_Tax_Not_Applicable__c = True;
        else if(toInserttaxList.size()>0)
            ps.VG_Tax_Not_Applicable__c = false;
        update ps;
        
        if(toInsertpfList.size()>0)
            insert toInsertpfList;
        if(toUpdatepfList.size()>0)
            update toUpdatepfList;
        if(toInserttaxList.size()>0)
            insert toInserttaxList;
        if(toUpdatetaxList.size()>0)
            update toUpdatetaxList;
        if(!TaxTobeDeleted.IsEmpty()){
            Delete TaxTobeDeleted;
        }
        Update InvoiceNumber; 
        Utilities.clearMethods();         
        return new PageReference('/'+psId);
    }
    
    Public PageReference cancel(){
        return new PageReference('/'+psId);
    }
    
    Public void uploadPF(){
        uploadPF = true;
    }
    
    Public void uploadTax(){
        uploadTax = true;
        addTax = false ; 
    }
    
    Public static String decode(final Blob input,  final String charset){
        final String hex = EncodingUtil.convertToHex(input);
        final Integer size = hex.length() >> 1;
        final List<String> bytes = new String[size];
        
        for (Integer i = 0; i < size; ++i) {
            bytes.set(i,  hex.mid(i << 1,  2));
        }
        return (EncodingUtil.urlDecode('%' + String.join(bytes,  '%'), charset)).remove('ï»¿');
    }
    
    
    Public PageReference processUploadTax(){
        if(fileBody == null){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'Please Upload a file'));
            return null;
        }
        for(TaxWrapper taxw : taxwList){
            TaxTobeDeleted.add(taxw.tax);
        }
        taxwList.clear();
        try{  
            nameFile = PaymentDetailsController.decode(fileBody,'ISO-8859-1');//fileBody.toString();
        }catch(Exception e){   
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'CSV File Format only Accepted. Please check your file format.'));
            return null;
        }
        
        filelines = nameFile.split('\n');
        for (Integer i = 1;i<filelines.size();i++){
            String[] inputvalues = new String[]{};
                String[] headervalues = new String[]{};
                    inputvalues = filelines[i].split(',');
            headervalues = filelines[0].split(',');
            taxw = new TaxWrapper();
            taxw.counter = String.valueOf(taxcounter);
            taxw.tax.CurrencyIsoCode = ps.CurrencyIsoCode;
            if(headervalues[0].contains('Tax Type')){
                if(inputvalues[0]  !=  ''){
                    taxw.tax.Name = inputvalues[0].trim();
                    taxw.tax.VG_Tax_Type__c=taxw.tax.Name;
                    }
                if(inputvalues[1]  !=  '')
                    taxw.tax.VG_Tax_Percent__c = Decimal.valueOf(inputvalues[1].trim());
                if(inputvalues[2]  !=  '')
                    taxw.tax.VG_Taxable_Amount__c = Decimal.valueOf(inputvalues[2].trim());
                if(inputvalues[3].trim()  != '' && inputvalues[3].trim() !=null ){
                    taxw.GWP = Decimal.valueOf(inputvalues[3].trim());
                    taxw.tax.VG_Tax_Amount_GWP_100__c=taxw.GWP;
                }else{
                    taxw.tax.VG_Tax_Amount_GWP_100__c=0;
                }
                if(inputvalues[4] !=  '')
                    taxw.tax.VG_Tax_Jurisdiction__c = inputvalues[4].trim();
                if(inputvalues[5]  !=  '')
                    taxw.tax.VG_Tax_Administered_By__c = inputvalues[5].trim();
                if(inputvalues[6]  !=  '')
                    taxw.tax.VG_Tax_Paid_By__c = inputvalues[6].trim();
                if(inputvalues[7]  !=  '')
                    taxw.tax.VG_Comment__c = inputvalues[7].trim();
                if(inputvalues[8]  !=  ''){
                    if(inputvalues[8].trim()  ==  'Y' || inputvalues[8].trim()  ==  'Yes')
                        taxw.tax.VG_Override__c = true;
                    else
                        taxw.tax.VG_Override__c = false;
                }else{
                    taxw.tax.VG_Override__c = false;
                }
           }else{
                System.debug('file header mis match please check the file or use template file.::'+headervalues[0]+'::'+headervalues[0].length());
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'file header mis match please check the file or use template file.'));
                return null;
            }
            taxw.show = false;
            taxcounter++;
            taxwList.add(taxw);
        }
        if(taxwList.size()  > 0)
            IsDownload = True;
        else
            IsDownload = false;
        for(TaxWrapper taxw:taxwList){
            if(taxw.tax.VG_Tax_Administered_By__c == '--None--' || taxw.tax.VG_Tax_Paid_By__c == '--None--' || taxw.tax.VG_Tax_Administered_By__c == null || taxw.tax.VG_Tax_Paid_By__c == null ){
                IsDownload = false;
            }
        }
        uploadTax = false;
        addTax = True; 
        thisTimeGWP();
        return null;
    }
    
    Public PageReference processUploadPF(){
        if(fileBody == null){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'Please Upload a file'));
            return null;
        }
        try{  
            nameFile = PaymentDetailsController.decode(fileBody,'ISO-8859-1');
        }catch(Exception e){                                  
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'CSV File Format only Accepted. Please check your file format.'));
            return null;
        }
        filelines = nameFile.split('\n');
        for (Integer i = 1;i<filelines.size();i++){
            String[] inputvalues = new String[]{};
                String[] headervalues = new String[]{};
                    inputvalues = filelines[i].split(',');
            headervalues = filelines[0].split(',');
            pfw = new PFWrapper();
            pfw.counter = String.valueOf(pfcounter);
            pfw.pf.CurrencyIsoCode = ps.CurrencyIsoCode;
            if(headervalues[0].contains('Due Date')){
                if(inputvalues[0]  != ''){
                    inputvalues[0]=inputvalues[0].trim().replace('-','/');                                       
                    pfw.pf.VG_Due_Date__c = Date.parse(inputvalues[0].trim());
                }
                if(inputvalues[1]  != '')
                    pfw.pf.VG_Payment_Percent__c = Decimal.valueOf(inputvalues[1].trim());
                if(inputvalues[2]  != '')
                    pfw.pf.VG_Comment__c = inputvalues[2].trim();
                if(inputvalues[3]  != '')
                    pfw.pf.CurrencyIsoCode = inputvalues[3].trim();
                else
                    pfw.pf.CurrencyIsoCode = ps.CurrencyIsoCode;
            }else{
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'file header mis match please check the file or use template file.'));
                return null;
            }
            
            If(ps.RecordTypeId == HozId){
                if(pfw.pf.VG_Payment_Percent__c  != null && rr.VG_Deposit_Premium__c  != null){
                    pfw.GWP = ps.Gross_Written_Premium__c*(pfw.pf.VG_Payment_Percent__c/100)*(rr.VG_Deposit_Premium__c/100);
                }else if(pfw.pf.VG_Payment_Percent__c  != null && rr.VG_Deposit_Premium__c == null){
                    pfw.GWP = ps.Gross_Written_Premium__c*(pfw.pf.VG_Payment_Percent__c/100);
                }
            }else{
                pfw.GWP = ps.Gross_Written_Premium__c*(pfw.pf.VG_Payment_Percent__c/100);
            }      
            pfw.show = true;
            pfwList.add(pfw);
            pfcounter++;
        }
        uploadPF = false;
        thisTimeGWP();
        return null;
    }
    
    
    Public void doneUploadTax(){
        uploadTax = false;
        addTax = True ; 
    }
    
    
    Public void doneUploadPF(){
        uploadPF = false;
    }
    
    
    Public void downloadAllTaxes(){
        finish();
    }
    
    
    Public Class PFWrapper{
        Public VG_Payment_Frequency__c pf{get;set;}
        Public Boolean show{get;set;}
        Public String counter{get;set;}
        Public Decimal GWP{get;set;}
        Public date duedate{get;set;}
        Public Decimal currenctCurrencyGWP{get;set;}
        Public PFWrapper(){
            pf = new VG_Payment_Frequency__c ();
            show = true;
            GWP = currenctCurrencyGWP = 0;
        }
    }
    
    Public Class TaxWrapper{
        Public VG_Taxes__c tax{get;set;}
        Public Boolean show{get;set;}
        Public String counter{get;set;}
        Public Decimal GWP{get;set;}
        
        Public TaxWrapper(){
            tax = new VG_Taxes__c ();
            GWP = 0;
            tax.VG_Tax_Percent__c = 0;
            tax.VG_Taxable_Amount__c = 0;
        }
    }
}