public class VG_Horizon_Quotation{
    public String LogoURL{get;set;}
    public String PrintView{get;set;}
    Public String MF {get; set;}
    public String PSId{get;set;}
    Public Policy_Schedule__c ps{get;set;}
    public String today{get;set;}
   public VG_Horizon_Quotation(){
         PSId=apexpages.currentpage().getparameters().get('Id');
         ps=[Select Id,Name,Product__c,VG_Brokerage_Percent__c,Policy__r.Underwriter__r.Name,Policy__r.Insured__r.ShippingPostalCode,Policy__r.VG_Brokerage_Percent__c,Policy__r.Broker_Name__r.Name,Policy__r.VG_Sub_Broker__r.Name,Policy__r.Broker_Name__r.VG_Intermediary_Number__c,Policy__r.Actual_GWP__c,Base_Creation_Start_Date__c,Policy__r.Insured__r.Name,Policy__r.VG_Current_Insurer__r.Name,Policy__r.Name,VG_Is_MTA__c,Actual_GWP__c,IPT_Percent__c,IPT__c,VG_MGA_Commission_Amount__c,Transaction_GWP__c,Policy__r.Insured__r.AccountNumber,Policy__r.Insured__r.Bank_Sort_Code__c,VG_MTA_Start_Date__c,Policy__r.VG_Inception_Date__c,Policy__r.VG_Expiry_Date__c,Levies__c,VG_Fee_Income__c,Policy__r.Insured__r.BillingPostalCode,Policy__r.Deductible_or_Excess_Amount__c,Policy__r.VG_Brokerage_Amount__c from Policy_Schedule__c Where Id=:PSId];
         today=System.Today().format();
        
         string strOrgId = UserInfo.getOrganizationId();
         List< document > MFList = [select Id, name from document where Name='Motor Felt'];
         MF='https://'+ApexPages.currentPage().getHeaders().get('Host')+'/Horizon/servlet/servlet.ImageServer?id='+MFList[0].Id+'&oid=' + strOrgId;        
         System.debug('image::'+MF+'::'+LogoURL);
         List< document > documentList = [select Id, name from document where Name='Horizon Logo'];
         LogoURL = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/Horizon/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId; 
         System.debug('image::'+MF+'::'+LogoURL);
         documentList.clear();
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