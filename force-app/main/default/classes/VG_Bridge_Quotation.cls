public class VG_Bridge_Quotation{
    public String LogoURL{get;set;}
    public String PrintView{get;set;}
    public String psId{get;set;}
    public String Sign_Url{get;set;}
    public String underwriter{get;set;}
    public Date QuoteDate{get;set;}
    public String today{get;set;}
    public Id parentId{get;set;}
    public Decimal total{get;set;}
    public Date date1{get;set;}
    Public Policy_Schedule__c ps{get;set;}
    Public List<Policy_Schedule__c> psList{get;set;}
    Public Map<String,String> transdata{get;set;}
    public VG_Bridge_Quotation(){
        total=0;
        psList=new List<Policy_Schedule__c>();
        psId=apexpages.currentpage().getparameters().get('Id');       
        ps=[Select Id,Name,Policy__c,Policy__r.Insured__r.Name,VG_Brokerage_Percent__c,Commission__c,Policy__r.Underwriter__r.Name,Policy__r.Transaction_GWP__c,Policy__r.VG_Quoted_Time__c from Policy_Schedule__c Where Id=:psId];        
        parentId =ps.Policy__c;
        psList=[Select Id,Name,Policy__c,Policy__r.Insured__r.Name,Product__c,ILF_Layer__c,Technical_Layer_Premium__c,Attachment__c,Limit__c,Gross_Written_Premium__c from Policy_Schedule__c Where Policy__c=:parentId];
        for(Policy_Schedule__c ps:psList){
           If(ps.Gross_Written_Premium__c!=null)
              total += ps.Gross_Written_Premium__c;
        }
         today=System.Today().format();
         date1 = Date.parse(today);
         if(ps.Policy__r.VG_Quoted_Time__c!=null){
          QuoteDate = date.newinstance(ps.Policy__r.VG_Quoted_Time__c.year(),ps.Policy__r.VG_Quoted_Time__c.month(),ps.Policy__r.VG_Quoted_Time__c.day());
         }
         transdata = new Map<String,String>();
         Translation__mdt [] translist=[SELECT From_Language__c,To_Language__c,Language1__c,Language2__c From Translation__mdt];        
         System.debug('11-9 test::'+translist);
         for(Translation__mdt trs : translist){
            System.debug('11-9 test::'+trs.Language1__c+'::'+trs);
            transdata.put(trs.Language1__c,trs.Language2__c);
            System.debug('11-9 Keys::'+trs.Language1__c+'::'+trs.Language2__c);
         }
         string strOrgId = UserInfo.getOrganizationId();
         List< document > documentList = [select Id, name from document where Name='Bridge Loge For English Quote'];
         LogoURL=LogoURL+documentList[0].Id;
         LogoURL = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Bridge/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId; 
         documentList.clear();
         if(ps.Policy__r.Underwriter__r.Name!=null){
            underwriter=ps.Policy__r.Underwriter__r.Name;
            documentList = [select Id, name from document where Name=:underwriter];    
            if(documentList.size()>0)
                Sign_Url = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Bridge/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                           
        }
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