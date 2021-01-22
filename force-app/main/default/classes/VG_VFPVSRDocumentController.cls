Public Class VG_VFPVSRDocumentController{
    Public String PrintView{get;set;}
    Public Boolean Bald_Eagle{get;set;}
    Public Boolean Bald_Eagle_2{get;set;}
    public String PILogo{get;set;}
    public String VGLogo{get;set;}
    public String AP_Sign_Url{get;set;} 
    public Date todayDate{get;set;}
    public Decimal suminsured{get;set;}
    public Decimal Premium{get;set;}
    public Decimal totaltax{get;set;}
    public Decimal totalGWP{get;set;}
    public Decimal psGWP {get; set;}
    public Decimal taxx{get;set;}
    public Decimal totalPayable {get;set;}
    public Decimal attachment{get;set;}
    public Decimal taxpercent{get;set;}
    Public String polId{get;set;}
    Public String Tax_TableContent{get;set;}
    public List<Endorsement_Library__c> ElList{get;set;}
    public List<taxWrapper> taxWrapperList {get; set;}
    public List<Policy_Schedule__c> psList{get; set;}
    public Map<Id, Policy_Schedule__c> psmap{get; set;}
    Public Policy__c pol{get;set;}
    Public VG_Taxes__c tax{get;set;}
    Public Policy_Schedule__c psh{get;set;}
    Public Risk_Capture__c rc{get;set;}
    Public List<VG_Policy_Schedule_Asset__c> psaList{get;set;} 
    Public String ELText{get;set;} 
    Public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    public List<VG_Taxes__c > InsertedtaxList{get;set;}
    
    public VG_VFPVSRDocumentController(){
        polId = apexpages.currentpage().getparameters().get('Id');
        pol = [Select Id, Name,Insured__r.Parent.Name,Insured__r.BillingState,Terms_of_Trade_Days__c,VG_Retroactive_Date_Applicable__c,Broker_Name__c,Broker_Contact__r.Name,Broker_Contact__r.Email, Broker_Name__r.E_mail_address__c, Policy_Basis__c,  VG_Governance_Compliance__r.VG_Conditions_Subjectivites__c, Jurisdiction__c, Gross_Written_Premium__c,Line_Of_Business__c,   VG_Aggregate_Limit__c, Insured__r.BillingStreet, Insured__r.BillingCity, Insured__r.BillingCountry, Insured__r.BillingPostalCode, VG_Expiry_Date__c, Insured__r.Company_Registration_Number__c, Broker_Name__r.Name, Broker_Name__r.Phone, Broker_Name__r.ShippingStreet, Broker_Name__r.ShippingCity, Broker_Name__r.ShippingCountry, Broker_Name__r.ShippingPostalCode, Underwriter__r.Name, Broker_Name__r.Billing_Phone__c, VG_Continuous_Cover_Date__c, Extended_Reporting__c, Retroactive_Date__c, VG_Brokerage_Percent__c,  VG_Brokerage_Amount__c, Broker_Name__r.VG_Intermediary_Number__c,  Insured__r.Name, Insured__r.Country__c, Insured__r.ShippingStreet, Insured__r.ShippingCity, Insured__r.ShippingPostalCode, Insured__r.ShippingState, Insured__r.ShippingCountry, Insured__r.SicDesc,  Inception_Expiry_Time__c,  Actual_GWP__c,  IPT__c, Insured__r.AccountNumber, Insured__r.Bank_Sort_Code__c, VG_Inception_Date__c,Deductible_or_Excess_Amount__c, Deductible_or_Excess_Basis__c from Policy__c Where Id=:polId ];
        psList = new List<Policy_Schedule__c>([Select Id, Name, Policy__r.Insured__r.BillingState,Policy__r.Terms_of_Trade_Days__c,Policy__r.VG_Retroactive_Date_Applicable__c,Policy__r.Broker_Name__c,Policy__r.Broker_Contact__r.Name,Policy__r.Broker_Contact__r.Email,VG_Capacity_Paper__c, Policy__r.Broker_Name__r.E_mail_address__c, VG_VAT__c, Policy__r.Policy_Basis__c, VG_VAT_Amount__c, VG_Witholding_Tax_Amount__c, VG_Machinery_Breakdown_Cover__c, VG_Machinery_Breakdown_BI_Cover__c, Product__c, Limit__c, Attachment__c, Sum_Insured__c, Policy__r.VG_Territorial_Limits__c, Policy__r.VG_Additional_Insureds__c, Policy__r.VG_Wording__c, Policy__r.VG_Governance_Compliance__r.VG_Conditions_Subjectivites__c, Policy__r.Jurisdiction__c, Policy__r.Gross_Written_Premium__c, Gross_Written_Premium__c, Policy__r.Line_Of_Business__c, VG_Deductible__c, VG_Extended_Reporting_Period__c, Policy__r.VG_Aggregate_Limit__c, Policy__r.Insured__r.BillingStreet, Policy__r.Insured__r.BillingCity, Policy__r.Insured__r.BillingCountry, Policy__r.Insured__r.BillingPostalCode, Policy__r.VG_Expiry_Date__c, Policy__r.Insured__r.Company_Registration_Number__c, Policy__r.Broker_Name__r.Name, Policy__r.Broker_Name__r.Phone, Policy__r.Broker_Name__r.ShippingStreet, Policy__r.Broker_Name__r.ShippingCity, Policy__r.Broker_Name__r.ShippingCountry, Policy__r.Broker_Name__r.ShippingPostalCode, Policy__r.Underwriter__r.Name, Policy__r.Broker_Name__r.Billing_Phone__c, Policy__r.VG_Continuous_Cover_Date__c, Policy__r.Extended_Reporting__c, Policy__r.Retroactive_Date__c, Policy__r.VG_Brokerage_Percent__c, VG_Brokerage_Percent__c, VG_Brokerage_Amount__c, Policy__r.Broker_Name__r.VG_Intermediary_Number__c, Base_Creation_Start_Date__c, Policy__r.Insured__r.Name, Policy__r.Insured__r.Country__c, Policy__r.Insured__r.ShippingStreet, Policy__r.Insured__r.ShippingCity, Policy__r.Insured__r.ShippingPostalCode, Policy__r.Insured__r.ShippingState, Policy__r.Insured__r.ShippingCountry, Policy__r.Insured__r.SicDesc, Policy__r.Name, Policy__r.Inception_Expiry_Time__c, VG_Is_MTA__c, Actual_GWP__c, IPT_Percent__c, IPT__c, VG_MGA_Commission_Amount__c, Transaction_GWP__c,  Policy__r.Insured__r.AccountNumber, Policy__r.Insured__r.Bank_Sort_Code__c, VG_MTA_Start_Date__c, Policy__r.VG_Inception_Date__c, Levies__c, VG_Fee_Income__c, Policy__r.Deductible_or_Excess_Amount__c, Policy__r.Deductible_or_Excess_Basis__c from Policy_Schedule__c Where Policy__c=:PolId]);
        suminsured=0;
        psGWP = 0;
        totaltax=totalGWP=taxx=0;
        psmap = new Map<Id, Policy_Schedule__c>();
        for(Policy_Schedule__c ps: psList){
           suminsured+=ps.Sum_Insured__c;
           psGWP += ps.Gross_Written_Premium__c;
           system.debug('ipt::'+ps.IPT__c+'::'+totalGWP);
           totalGWP += (ps.IPT__c!=null?ps.IPT__c:0);
           suminsured = suminsured.setscale(0);
           attachment = psList[0].Attachment__c;
           
           psmap.put(ps.id,ps);
           
        }
        totalPayable = 0;
        Premium = psGWP.setscale(0);
        totalPayable += premium;
        todayDate = system.today();
        InsertedtaxList = new List<VG_Taxes__c >([select id, Name, VG_Override__c, CurrencyIsoCode,VG_Policy_Schedule__r.IPT__c ,VG_Policy_Schedule__r.Policy__r.Insured__r.BillingState,VG_Tax_Type__c, VG_Is_Temp_Delete__c, VG_Taxable_Amount__c, VG_Tax_Amount__c, VG_Tax_Paid_By__c, VG_Comment__c, VG_Tax_Percent__c, VG_Tax_Administered_By__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.Policy__r.Policy_Status__c, VG_Tax_Jurisdiction__c,VG_Tax_Amount_GWP_100__c from VG_Taxes__c where VG_Policy_Schedule__c =: psmap.keyset()]);
        Map<String, List<VG_Taxes__c>> taxMap = new Map<String, List<VG_Taxes__c>>();
        taxWrapperList = new List<taxWrapper>();
        if(!InsertedtaxList.IsEmpty()){
            for(VG_Taxes__c taxes: InsertedtaxList ){
                List<VG_Taxes__c> taxesList = taxMap.get(taxes.Name) == null ? new List<VG_Taxes__c>() : taxMap.get(taxes.Name);
                taxesList.add(taxes);
                taxMap.put(taxes.Name, taxesList);
                tax = taxes;
                totaltax = totaltax + taxes.VG_Tax_Amount_GWP_100__c;
            } 
        }        
        for(String taxName : taxMap.keySet()){
            taxWrapper tw = new taxWrapper();
            tw.taxName = taxName;
            for(VG_Taxes__c tx : taxMap.get(taxName)){
                totalPayable += (tx.VG_Tax_Amount_GWP_100__c!=null?tx.VG_Tax_Amount_GWP_100__c:0);
                tw.taxValue += (tx.VG_Tax_Amount_GWP_100__c!=null?tx.VG_Tax_Amount_GWP_100__c:0);
                tw.taxableAmount += (tx.VG_Taxable_Amount__c!=null?tx.VG_Taxable_Amount__c:0);
                tw.taxJurisdiction = (tx.VG_Tax_Jurisdiction__c!=null?tx.VG_Tax_Jurisdiction__c:'');
                tw.taxPercent = (tx.VG_Tax_Percent__c!=null?tx.VG_Tax_Percent__c:0);                 
            }
            taxWrapperList.add(tw);
        }
        Bald_Eagle=Bald_Eagle_2=false;
        string strOrgId  =  UserInfo.getOrganizationId(); 
        List< document > documentList1  =  [select Id,  name from document where Name='VG_VFP_VSR_Quote'];
        PILogo  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/VFP/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId; 
        documentList1.clear();
        documentList1  =  [select Id,  name from document where Name='Volante_Global_logo'];
        VGLogo=  'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/VFP/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId; 
        documentList1.clear();
        documentList1  =  [select Id,  name from document where Name='Andrew Pearson'];       
        AP_Sign_Url = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/VFP/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId; 
        documentList1.clear();
        
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
    
    Public Class taxWrapper{
        Public String taxName {get; set;}
        Public String taxJurisdiction {get; set;}
        Public Decimal taxValue {get; set;}
        Public Decimal taxableAmount {get; set;}
        Public Decimal taxPercent {get; set;}
        
        Public taxWrapper(){
            taxName = '';
            taxValue = 0.0;
            taxableAmount = 0.0;
            taxJurisdiction = '';
            taxPercent = 0;
        }
    } 
}