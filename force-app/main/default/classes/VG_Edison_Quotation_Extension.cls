public class VG_Edison_Quotation_Extension {
    /*Replaced with VG_Edison_Quotation_Extension_PS

    Public String MF {get; set;}
    Public String ImageURL {get; set;}
    public String LogoURL{get;set;}
    public String PP1{get;set;}
    public String FooterURL{get;set;}
    Public Policy__c pol{get;set;}
    public String PrintView{get;set;}
    public String PId{get;set;}
    public Date IncepDate{get;set;}
    public Boolean comp{get;set;}
    public Decimal NoV{get;set;}
    public Boolean tpft{get;set;}
    public Boolean tpo{get;set;}
    public Boolean fto{get;set;}
    public Boolean mixed{get;set;}
    public String today{get;set;}
    Public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    Public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    Public Map<id,Policy_Schedule__c> psMap{get;set;}
    public String IncepDateFormat{get;set;}
    public String MTAStartDateFormat{get;set;}
    public VG_Edison_Quotation_Extension() {
        PId=apexpages.currentpage().getparameters().get('Id');
        pol=[Select Id,Name,Broker_Name__r.Name,VG_Brokerage_Amount__c,Actual_GWP__c,Broker_Name__r.VG_Intermediary_Number__c,Insured__r.Name,Insured__r.AccountNumber,Insured__r.Bank_Sort_Code__c,VG_Inception_Date__c,Levies__c,VG_Fee_Income__c,Insured__r.BillingPostalCode,Deductible_or_Excess_Amount__c from Policy__c Where Id=:PId limit 1];
        System.debug('Pol::'+pol); 
        IncepDate = pol.VG_Inception_Date__c;
        IncepDateFormat = IncepDate.format();
        today=System.today().format();
        string strOrgId = UserInfo.getOrganizationId();
        //ImageURL = '/servlet/servlet.FileDownload?file=';
        List< document > documentList = [select Id, name from document where Name='Volante_Global_logo'];
        List< document > MFList = [select Id, name from document where Name='Motor Felt'];
        ImageURL = ImageURL + documentList[0].Id;
        ImageURL = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;              
        documentList.clear();
        documentList = [select Id, name from document where Name='VG_Edison_Quote'];               
        LogoURL=LogoURL+documentList[0].Id;
        LogoURL = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                   
        documentList.clear();
        documentList = [select Id, name from document where Name='VG_Edison_Quote2'];               
        FooterURL=LogoURL+documentList[0].Id;
        FooterURL = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                   
        MF='https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/servlet/servlet.ImageServer?id='+MFList[0].Id+'&oid=' + strOrgId;
        PrintView='<!--[if gte mso 9]>' +
        '<xml>' +
        '<w:WordDocument>' +
        '<w:View>Print</w:View>' +
        '<w:Zoom>100</w:Zoom>' +
        '<w:DoNotOptimizeForBrowser/>' +
        '</w:WordDocument>' +
        '</xml>' +
        '<![endif]>';  
        System.debug('PP1::'+PP1);   
        psMap=new Map<id,Policy_Schedule__c>([select id,Name from Policy_Schedule__c where Policy__c=:PID]);
        System.debug('psMap::'+psMap); 
        pseList=new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Endorsement_Number__c,VG_Title__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c IN: psMap.keyset()]);
        System.debug('pseList::'+pseList); 
        psaList=new List<VG_Policy_Schedule_Asset__c>([select id,Name,VG_Coverage__c,VG_Number_of_Vehicles__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psMap.keyset()]);
        System.debug('psaList::'+psaList);
        List<String> cov=new List<String>();
        NoV=0;
        for(VG_Policy_Schedule_Asset__c psa:psaList){
            if(psa.VG_Coverage__c !=null){
                String[] c=psa.VG_Coverage__c.split(';');
                for(String s: c){
                    cov.add(s);
                }
            }
            if(psa.VG_Number_of_Vehicles__c !=null){
                NoV=NoV+psa.VG_Number_of_Vehicles__c;
            }
                
        }    
        if(!cov.IsEmpty()){
            Set<String> coverage=new Set<String>();
            for(String s:cov){
                if(!coverage.contains(s))
                    coverage.add(s);
            }
            System.debug('coverage::'+coverage);
            if(coverage.contains('M3 - Fully Comprehensive') && !coverage.contains('M6 - Third Party Fire & Theft') && !coverage.contains('M6 - Third Party Only') && !coverage.contains('M6 - Fire & Theft Only')){
               comp=True; 
               fto=false;
               tpo=false;
               tpft=false;
               mixed=false;
            }else if(!coverage.contains('M3 - Fully Comprehensive') && coverage.contains('M6 - Third Party Fire & Theft') && !coverage.contains('M6 - Third Party Only') && !coverage.contains('M6 - Fire & Theft Only')){
               tpft=True; 
               comp=false; 
               fto=false;
               tpo=false;
               mixed=false;
            }else if(!coverage.contains('M3 - Fully Comprehensive') && !coverage.contains('M6 - Third Party Fire & Theft') && coverage.contains('M6 - Third Party Only') && !coverage.contains('M6 - Fire & Theft Only')){
               tpo=True; 
               comp=false; 
               fto=false;
               tpft=false;
               mixed=false;
            }else if(!coverage.contains('M3 - Fully Comprehensive') && !coverage.contains('M6 - Third Party Fire & Theft') && !coverage.contains('M6 - Third Party Only') && coverage.contains('M6 - Fire & Theft Only')){
               fto=True; 
               comp=false; 
               tpo=false;
               tpft=false;
               mixed=false;
            }else{
               mixed=true;
               comp=false; 
               fto=false;
               tpo=false;
               tpft=false;
            }
            System.debug('Status::'+mixed+comp+fto+tpo+tpft);
        }
        
    }*/
}