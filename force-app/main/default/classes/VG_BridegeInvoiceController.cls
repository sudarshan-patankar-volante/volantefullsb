Public Class VG_BridegeInvoiceController{
    Public String PrintView{get;set;}
    Public String MF {get; set;}
    public String Logo{get;set;}
    Public String PSId{get;set;}
    Public String PFId{get;set;}
    Public String FooterURL {get; set;}
    Public Decimal totalAmountDue{get;set;}
    Public Decimal totalTaxAmount{get;set;}
    Public Decimal BrokerCommisson{get;set;}
    public List<VG_Taxes__c> InsertedtaxList{get;set;}
    Public Policy_Schedule__c ps{get;set;}
    Public VG_Payment_Frequency__c pf{get;set;}
    Public Date inceptiondate{get;set;}
    Public Date Duedate{get;set;}
    
    public VG_BridegeInvoiceController(){
         PSId = apexpages.currentpage().getparameters().get('Id');
         PFId = apexpages.currentpage().getparameters().get('PFId');
         System.debug('PFID::'+PFId);
         ps=[Select Id, Name, CurrencyIsoCode, VG_Is_Co_Insurance__c, VG_Gross_Written_Premium_100__c,  Product__c, Policy__r.VG_Is_Renewal__c, Limit__c, Policy__r.Terms_of_Trade_Days__c, Policy__r.Broker_Name__r.Terms__c, VG_MTA_Type__c, Gross_Written_Premium__c, VG_Extended_Reporting_Period__c, Policy__r.VG_Aggregate_Limit__c, Policy__r.Insured__r.BillingStreet, Policy__r.Insured__r.BillingCity, Policy__r.Insured__r.BillingCountry, Policy__r.Insured__r.BillingPostalCode, Policy__r.VG_Expiry_Date__c, Policy__r.Insured__r.Company_Registration_Number__c, Policy__r.Broker_Name__r.Name, Policy__r.Broker_Name__r.BillingStreet, Policy__r.Broker_Name__r.BillingCity, Policy__r.Broker_Name__r.BillingCountry, Policy__r.Broker_Name__r.BillingPostalCode, Policy__r.Underwriter__r.Name, Policy__r.Broker_Name__r.Billing_Phone__c, Policy__r.VG_Continuous_Cover_Date__c, Policy__r.Extended_Reporting__c, Policy__r.Retroactive_Date__c, Policy__r.VG_Brokerage_Percent__c, VG_Brokerage_Percent__c, VG_Brokerage_Amount__c, Policy__r.Broker_Name__r.VG_Intermediary_Number__c, Base_Creation_Start_Date__c, Policy__r.Insured__r.Name, Policy__r.Insured__r.Country__c, Policy__r.Insured__r.ShippingStreet, Policy__r.Insured__r.ShippingCity, Policy__r.Insured__r.ShippingPostalCode, Policy__r.Insured__r.ShippingState, Policy__r.Insured__r.ShippingCountry, Policy__r.Insured__r.SicDesc, Policy__r.Name, Policy__r.Inception_Expiry_Time__c, VG_Is_MTA__c, Actual_GWP__c, IPT_Percent__c, IPT__c, VG_MGA_Commission_Amount__c, Transaction_GWP__c,  Policy__r.Insured__r.AccountNumber, Policy__r.Insured__r.Bank_Sort_Code__c, VG_MTA_Start_Date__c, VG_MTA_Cancellation_Date__c, VG_MTA_End_Date__c, Policy__r.VG_Inception_Date__c, Levies__c, VG_Fee_Income__c, Policy__r.Deductible_or_Excess_Amount__c from Policy_Schedule__c Where Id=:PSId];         
         System.debug(ps.Name+'::'+ps.Policy__r.VG_Is_Renewal__c);
         pf=[select id, Name, VG_Comment__c,VG_Invoice_Number__c , VG_Is_Temp_Delete__c, VG_GWP_This_Time__c,CurrencyIsoCode, VG_Payment_Percent__c, VG_Due_Date__c, VG_Outstanding_taxes__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.Policy__r.Policy_Status__c from VG_Payment_Frequency__c where Id=: PFId ORDER BY VG_Due_Date__c ASC ];       
         InsertedtaxList = new List<VG_Taxes__c >([select id, Name, CurrencyIsoCode, VG_Is_Temp_Delete__c , VG_Taxable_Amount__c, VG_Tax_Amount__c, VG_Tax_Paid_By__c, VG_Comment__c, VG_Tax_Percent__c, VG_Tax_Administered_By__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.Policy__r.Policy_Status__c, VG_Tax_Jurisdiction__c from VG_Taxes__c where VG_Policy_Schedule__c =: PSId ]);       
         inceptiondate = System.Today();
         totalAmountDue = totalTaxAmount = BrokerCommisson  = 0;
         If(ps.VG_Brokerage_Amount__c != null && pf.VG_Payment_Percent__c != null && !ps.VG_Is_Co_Insurance__c)
             BrokerCommisson =  ps.VG_Brokerage_Amount__c*(pf.VG_Payment_Percent__c/100);
         If(ps.VG_Gross_Written_Premium_100__c != null && ps.VG_Brokerage_Percent__c != null && ps.VG_Is_Co_Insurance__c)
             BrokerCommisson =  ps.VG_Gross_Written_Premium_100__c * (ps.VG_Brokerage_Percent__c / 100);
         
         If(pf.Name.contains('PF/0')){
             for(VG_Taxes__c tax: InsertedtaxList){
                 If(tax.VG_Tax_Amount__c != null)
                     totalTaxAmount += tax.VG_Tax_Amount__c;
             }
             if(!ps.VG_Is_Co_Insurance__c)
                 totalAmountDue = pf.VG_GWP_This_Time__c + totalTaxAmount;
             else
                 totalAmountDue = ps.VG_Gross_Written_Premium_100__c + totalTaxAmount;
             System.debug('totalAmountDue::'+BrokerCommisson+'::'+pf.VG_GWP_This_Time__c+'::'+totalAmountDue);
         }else{
             totalTaxAmount = 0;
             if(!ps.VG_Is_Co_Insurance__c)
                 totalAmountDue = pf.VG_GWP_This_Time__c ;
             else
                 totalAmountDue = ps.VG_Gross_Written_Premium_100__c;
             System.debug('totalAmountDue::'+BrokerCommisson+'::'+pf.VG_GWP_This_Time__c+'::'+totalAmountDue);
         } 
         
         /*If(!InsertedtaxList.IsEmpty()){
             for(VG_Taxes__c tax: InsertedtaxList){
                 If(tax.VG_Tax_Administered_By__c != null && tax.VG_Tax_Administered_By__c=='Insurer'){
                     totalAmountDue = ps.Gross_Written_Premium__c+ps.IPT__c;
                     System.debug('totalAmountDue::'+totalAmountDue);                
                 }else if(tax.VG_Tax_Administered_By__c != null && tax.VG_Tax_Administered_By__c=='Broker'){
                     totalAmountDue = ps.Gross_Written_Premium__c;                
                 }
             }
         }*/
         if(ps.Policy__r.VG_Inception_Date__c != null && ps.Policy__r.Terms_of_Trade_Days__c  != null){
            Duedate = ps.Policy__r.VG_Inception_Date__c.addDays(Integer.valueOf(ps.Policy__r.Terms_of_Trade_Days__c));
         }else{
            If(ps.Policy__r.VG_Inception_Date__c != null && ps.Policy__r.Broker_Name__r.Terms__c != null)
               Duedate = ps.Policy__r.VG_Inception_Date__c.addDays(Integer.valueOf(ps.Policy__r.Broker_Name__r.Terms__c));
             else If(ps.Policy__r.VG_Inception_Date__c != null)
               Duedate = ps.Policy__r.VG_Inception_Date__c.addDays(0);
         }
         string strOrgId  =  UserInfo.getOrganizationId();
         //psaList = new List<VG_Policy_Schedule_Asset__c>([Select id, Name, VG_Sub_limit__c, VG_Deductible__c, Asset__c, Asset__r.VG_Total_Sum_Insured_SI__c, Asset__r.VG_Total_Property_Damage_SI__c, Asset__r.VG_Total_Business_Interruption_SI__c, Asset__r.VG_BI_Indemnity_Period__c, Asset__r.VG_MB_PD_Deductible__c, Asset__r.VG_Waiting_Period__c, VG_Coverage__c,  VG_Limit__c, VG_Territorial_Limits__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =:ps.id]);
         //pseList = new List<VG_Policy_Schedule_Endorsement__c>([Select id, Name, VG_Endorsement_Number__c, VG_Title__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =:ps.id]);
         List< document > MFList  =  [select Id,  name from document where Name='Motor Felt'];
         MF='https://'+ApexPages.currentPage().getHeaders().get('Host')+'/Bridge/servlet/servlet.ImageServer?id='+MFList[0].Id+'&oid=' + strOrgId;        
         System.debug('image::'+MF+'::'+Logo);
         List< document > documentList  =  [select Id,  name from document where Name='Bridge Logo'];
         Logo  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/Bridge/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId; 
         System.debug('image::'+MF+'::'+Logo);
         documentList.clear();
         documentList  =  [select Id,  name from document where Name='Volante_Global_logo'];                       
         FooterURL  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Bridge/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId; 
         PrintView='<!--[if gte mso 9]>' +
        '<xml>' +
        '<w:WordDocument>' +
        '<w:View>Print</w:View>' +
        '<w:Zoom>100</w:Zoom>' +
        '<w:DoNotOptimizeForBrowser/>' +
        '</w:WordDocument>' +
        '</xml>' +
        '<![endif]>';    
    }
}