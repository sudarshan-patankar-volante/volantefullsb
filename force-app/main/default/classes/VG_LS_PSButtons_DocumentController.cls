Public Class VG_LS_PSButtons_DocumentController{
    Public String PrintView{get;set;}
    Public Policy_Schedule__c ps{get;set;}
    Public String MF {get; set;}
    public String Logo{get;set;}
    public String PILogo{get;set;}
    Public String PSId{get;set;}
    public String ELLogo{get;set;}
    public String AffnityLogo{get;set;}
    public String PI_Sign_Url{get;set;}
    public String Auth_Sign_Url{get;set;}
    Public Risk_Capture__c rc{get;set;}
    Public List<VG_Policy_Schedule_Asset__c> psaList{get;set;} 
    Public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    Public Map<String,Decimal> psaMap{get;set;}
    
    
    public String PAtext{get;set;}
    public String Bentext{get;set;}
    public String MCtext{get;set;}
    public String LOItext{get;set;}
    public String CBtext{get;set;}
    public String CEtext{get;set;}
    public String CEEtext{get;set;}
    public String DoEtext{get;set;}
    public String DrEtext{get;set;}
    public String FEtext{get;set;}
    public String HPEtext{get;set;}
    public String HMEtext{get;set;}
    public String NAMtext{get;set;}
    public String NJMtext{get;set;}
    public String RCOtext{get;set;}
    public String Clubtext{get;set;}
    Public VG_LS_PSButtons_DocumentController(){
         PSId=apexpages.currentpage().getparameters().get('Id');
         ps=[Select Id,Name,Policy__r.Insured__r.Business_Description__c,Gross_Written_Premium__c,Policy__r.Broker_Name__r.E_mail_address__c,Policy__r.Broker_Name__r.ShippingState,Policy__r.Policy_Basis__c,VG_Machinery_Breakdown_Cover__c,VG_Machinery_Breakdown_BI_Cover__c,Product__c,Limit__c,Sum_Insured__c,Policy__r.VG_Territorial_Limits__c,Policy__r.VG_Additional_Insureds__c,Policy__r.VG_Wording__c,Policy__r.VG_Governance_Compliance__r.VG_Conditions_Subjectivites__c,Policy__r.Jurisdiction__c,Policy__r.Gross_Written_Premium__c,Policy__r.Line_Of_Business__c,VG_Deductible__c,VG_Extended_Reporting_Period__c,Policy__r.VG_Aggregate_Limit__c,Policy__r.Insured__r.BillingStreet,Policy__r.Insured__r.BillingCity,Policy__r.Insured__r.BillingCountry,Policy__r.Insured__r.BillingPostalCode,Policy__r.Insured__r.BillingState,Policy__r.VG_Expiry_Date__c,Policy__r.Insured__r.Company_Registration_Number__c,Policy__r.Broker_Name__r.Name,Policy__r.Broker_Name__r.Phone,Policy__r.Broker_Name__r.ShippingStreet,Policy__r.Broker_Name__r.ShippingCity,Policy__r.Broker_Name__r.ShippingCountry,Policy__r.Broker_Name__r.ShippingPostalCode,Policy__r.Underwriter__r.Name,Policy__r.Broker_Name__r.Billing_Phone__c,Policy__r.VG_Continuous_Cover_Date__c,Policy__r.Extended_Reporting__c,Policy__r.Retroactive_Date__c,Policy__r.VG_Brokerage_Percent__c,VG_Brokerage_Percent__c,VG_Brokerage_Amount__c,Policy__r.Broker_Name__r.VG_Intermediary_Number__c,Base_Creation_Start_Date__c,Policy__r.Insured__r.Name,Policy__r.Insured__r.Country__c,Policy__r.Insured__r.ShippingStreet,Policy__r.Insured__r.ShippingCity,Policy__r.Insured__r.ShippingPostalCode,Policy__r.Insured__r.ShippingState,Policy__r.Insured__r.ShippingCountry,Policy__r.Insured__r.SicDesc,Policy__r.Name,Policy__r.Inception_Expiry_Time__c,VG_Is_MTA__c,Actual_GWP__c,IPT_Percent__c,IPT__c,VG_MGA_Commission_Amount__c,Transaction_GWP__c, Policy__r.Insured__r.AccountNumber,Policy__r.Insured__r.Bank_Sort_Code__c,VG_MTA_Start_Date__c,Policy__r.VG_Inception_Date__c,Levies__c,VG_Fee_Income__c,Policy__r.Deductible_or_Excess_Amount__c,Policy__r.Deductible_or_Excess_Basis__c from Policy_Schedule__c Where Id=:PSId];
         rc=[select id,Policy_Schedule__c,Policy_Schedule__r.Product__c,Name,CurrencyIsoCode,VG_Additional_Information__c,VG_Policy_Details__c,VG_Dispute_Clause__c from Risk_Capture__c where Policy_Schedule__c =:PSId];
         psaList=new List<VG_Policy_Schedule_Asset__c>([Select id,Name,VG_Perils__c,VG_Sub_limit__c,VG_Perils_Text__c,VG_Sum_Insured__c,VG_Declared_Value__c,VG_Coverage__c, VG_Limit__c,VG_Policy_Schedule__c,VG_Territorial_Limits__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =:PSId]);
         System.debug('psaList::'+psaList.size());
         pseList=new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Endorsement_Details__c,VG_Endorsement_Number__c,VG_Title__c from VG_Policy_Schedule_Endorsement__c where  VG_Policy_Schedule__c =:PSId AND (VG_Type__c=:'Endorsements' OR VG_Type__c=:'' OR VG_Type__c=:null)]);        
         string strOrgId = UserInfo.getOrganizationId();
         List< document > MFList = [select Id, name from document where Name='Motor Felt'];
         MF='https://'+ApexPages.currentPage().getHeaders().get('Host')+'/LS/servlet/servlet.ImageServer?id='+MFList[0].Id+'&oid=' + strOrgId;        
         System.debug('image::'+MF+'::'+Logo);
         List< document > documentList1 = [select Id, name from document where Name='VG PI Logo'];
         PILogo = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/LS/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId; 
         System.debug('image::'+MF+'::'+PILogo);
         documentList1.clear();
         documentList1 = [select Id, name from document where Name='David Sign'];
         PI_Sign_Url = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/LS/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId;     
         documentList1.clear();
         documentList1 = [select Id, name from document where Name='VG_LS_Affnity_Logo'];
         AffnityLogo = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/LS/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId; 
         System.debug('image::'+MF+'::'+AffnityLogo);
         documentList1.clear();
         documentList1 = [select Id, name from document where Name='LS EL_Image'];
         ELLogo = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/LS/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId; 
         documentList1.clear();
         documentList1 = [select Id, name from document where Name='David Sign'];
         PI_Sign_Url = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/LS/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId;     
         documentList1.clear();
         documentList1 = [select Id, name from document where Name='Talbir Bains'];
         Auth_Sign_Url = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/LS/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId;     
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
        
         String aInfo=rc.VG_Additional_Information__c;
         String[] tempDetail=aInfo.split('<br>');
         List<String> sList=new List<String>();
         for(Integer i=0;i<tempDetail.size();i++){
            System.debug('3-1-19::'+tempDetail[i]);
            String[] tmp=tempDetail[i].split(':');
            if(tmp.size() > 1){
                sList.add(tmp[1]);
                System.debug('4-1-19::'+tmp[1]);
            }else{
                sList.add('');
            }
         }
           
         psaMap=new Map<String,Decimal>();
         psaMap.put('Death',0);
         psaMap.put('Medical Costs',0);
         psaMap.put('Loss of Income',0);
         for(VG_Policy_Schedule_Asset__c psa:psaList){
            if(psa.VG_Perils__c !=null && psa.VG_Perils__c !='--None--' && (psa.VG_Perils__c=='Death' || psa.VG_Perils__c=='Medical Costs' || psa.VG_Perils__c == 'Loss of Income' )){                 
                if(psaMap.Containskey(psa.VG_Perils__c)){
                    If(psa.VG_Sum_Insured__c!=null){
                        psaMap.put(psa.VG_Perils__c,psa.VG_Sum_Insured__c);
                    }                  
                }            
            }
        }
       
        If(rc.Policy_Schedule__r.Product__c=='PA'){
            System.debug('size::'+sList.size());
            PAtext=sList[0].trim();
            Bentext=sList[1].trim();
            MCtext=sList[2].trim();
            LOItext=sList[3].trim();
            CBtext=sList[4].trim();
            CEtext=sList[5].trim();
            CEEtext=sList[6].trim();
            DoEtext=sList[7].trim();
            DrEtext=sList[8].trim();
            FEtext=sList[9].trim();
            HPEtext=sList[10].trim();
            HMEtext=sList[11].trim();
            NAMtext=sList[12].trim();
            NJMtext=sList[13].trim();
            RCOtext=sList[14].trim();
            Clubtext=sList[15].trim();  
        }
    }    
}