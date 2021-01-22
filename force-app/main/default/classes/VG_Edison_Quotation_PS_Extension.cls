public class VG_Edison_Quotation_PS_Extension {
    Public String MF {get; set;}
    Public String ImageURL {get; set;}
    public String LogoURL{get;set;}
    public String PP1{get;set;}
    public String FooterURL{get;set;}
    Public Policy_Schedule__c ps{get;set;}
    public String PrintView{get;set;}
    public String PSId{get;set;}
    public Boolean comp{get;set;}
    public Decimal NoV{get;set;}
    public Boolean tpft{get;set;}
    public Boolean tpo{get;set;}
    public Boolean fto{get;set;}
    public Boolean mixed{get;set;}
    public String today{get;set;}
    Public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    Public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    public Date IncepDate{get;set;}
    public String IncepDateFormat{get;set;}
    public Date MTAStartDate{get;set;}
    public String MTAStartDateFormat{get;set;}
    public String underwriter{get;set;} 
    public String Sign_Url{get;set;}
    Public List<VG_Policy_Schedule_Endorsement__c> pseList1{get;set;}
    Public List<VG_Policy_Schedule_Endorsement__c> pseList2{get;set;}
    Public List<VG_Policy_Schedule_Endorsement__c> pseList3{get;set;}
    
    public VG_Edison_Quotation_PS_Extension() {
        PSId=apexpages.currentpage().getparameters().get('Id');
        ps=[Select Id,Name,Product__c,VG_Brokerage_Percent__c,Policy__r.Gross_Written_Premium__c,Gross_Written_Premium__c,Policy__r.Underwriter__r.Name,Policy__r.Insured__r.ShippingPostalCode,Policy__r.VG_Brokerage_Percent__c,Policy__r.Broker_Name__r.Name,Policy__r.VG_Sub_Broker__r.Name,Policy__r.Broker_Name__r.VG_Intermediary_Number__c,Policy__r.Actual_GWP__c,Base_Creation_Start_Date__c,Policy__r.Insured__r.Name,Policy__r.VG_Current_Insurer__r.Name,Policy__r.Name,VG_Is_MTA__c,Actual_GWP__c,IPT_Percent__c,IPT__c,VG_MGA_Commission_Amount__c, Transaction_GWP__c, Policy__r.Insured__r.AccountNumber,Policy__r.Insured__r.Bank_Sort_Code__c,VG_MTA_Start_Date__c,Policy__r.VG_Inception_Date__c,Levies__c,VG_Fee_Income__c,Policy__r.Insured__r.BillingPostalCode,Policy__r.Deductible_or_Excess_Amount__c,Policy__r.VG_Brokerage_Amount__c from Policy_Schedule__c Where Id=:PSId];
        today=System.Today().format();
        IncepDate = ps.Policy__r.VG_Inception_Date__c;   
        if(IncepDate != null)
            IncepDateFormat = IncepDate.format();
        MTAStartDate=ps.VG_MTA_Start_Date__c;
        if(MTAStartDate != null)
            MTAStartDateFormat=MTAStartDate.format();
        string strOrgId = UserInfo.getOrganizationId();
        //ImageURL = '/servlet/servlet.FileDownload?file=';
        List< document > documentList = [select Id, name from document where Name='Volante_Global_logo'];
        List< document > MFList = [select Id, name from document where Name='Motor Felt'];
        ImageURL = ImageURL + documentList[0].Id;
        ImageURL = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;              
        //ImageURL = 'https://volante--dev--c.cs85.content.force.com/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                      
        documentList.clear();
        documentList = [select Id, name from document where Name='VG_Edison_Quote'];               
        LogoURL=LogoURL+documentList[0].Id;
        LogoURL = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                   
        documentList.clear();
        documentList = [select Id, name from document where Name='VG_Edison_Quote2'];               
        FooterURL=FooterURL+documentList[0].Id;
        FooterURL = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                   
        documentList.clear();
        if(ps.Policy__r.Underwriter__r.Name!=null){
            underwriter=ps.Policy__r.Underwriter__r.Name;
            documentList = [select Id, name from document where Name=:underwriter];    
            Sign_Url = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                           
        }
        
        documentList.clear();
        MF='https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+MFList[0].Id+'&oid=' + strOrgId;        
        System.debug('currentPage::'+ApexPages.currentPage()+'::'+ApexPages.currentPage().getHeaders()+'::'+ApexPages.currentPage().getHeaders().get('Host'));  //Output of this debug :: ::volante--dev--c.cs85.visual.force.com       
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
        pseList=new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Endorsement_Number__c,VG_Title__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =:PSID ORDER BY VG_Endorsement_Number__c ASC]);
        System.debug('pseList::'+pseList); 
        pseList1 =new List<VG_Policy_Schedule_Endorsement__c>();
        pseList2 =new List<VG_Policy_Schedule_Endorsement__c>();
        pseList3 =new List<VG_Policy_Schedule_Endorsement__c>();
        integer i=0;
        integer j;      
            if(pseList.size()>0 ){
                while(i<8 && i<pseList.size()){               
                    pseList1.add(pseList[i++]);
                    System.debug('pseList1::'+pseList1);               
                }
                j=8;
                while(j<48 && j<pseList.size()){               
                    pseList2.add(pseList[j++]);
                    System.debug('pseList2::'+pseList2);               
                }
                for(j=48;j<pseList.size();j++){
                    pseList3.add(pseList[j]);
                    System.debug('pseList3::'+pseList3);
                }
            }
        
        psaList=new List<VG_Policy_Schedule_Asset__c>([select id,Name,VG_Coverage__c,VG_Number_of_Vehicles__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =:PSID]);
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
        }else{
            mixed=false;
            comp=false; 
            fto=false;
            tpo=false;
            tpft=false;
        }
    }
}