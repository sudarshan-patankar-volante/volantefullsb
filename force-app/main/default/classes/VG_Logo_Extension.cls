public class VG_Logo_Extension {
    Public String MF {get; set;}
    Public String ImageURL {get; set;}
    public String LogoURL{get;set;}
    Public String Sign_URL {get; set;}
    public String PP1{get;set;}
    public String FooterURL{get;set;}
    Public String AdviceFooterURL {get; set;}
    Public Policy_Schedule__c ps{get;set;}
    public String PrintView{get;set;}
    Public List<Asset__c> assList{get;set;}
    Public Boolean Asset{get;set;}
    Public Boolean PSAsset{get;set;}
    Public Boolean isRenewal{get;set;}
    Public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    Public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    Public List<VG_Policy_Schedule_Endorsement__c> pseList1{get;set;}
    public String PSId{get;set;}
    public Date IncepDate{get;set;}
    public String IncepDateFormat{get;set;}
    public Date MTAStartDate{get;set;}
    public Date ExpiryDate{get;set;}
    public Decimal BrokerageAmount{get;set;}
    public Decimal IPTAmount{get;set;}
    public Decimal IPTPercent{get;set;}
    public Decimal GWP{get;set;}
    public Decimal TotalAmountdue {get;set;}
    public String today{get;set;}
    public String ClaimLine{get;set;}
    public String MTAStartDateFormat{get;set;}
    public List<WrapperPSA> wrapPSAList{get;set;}
    public List<WrapperPSE> wrapPSEList{get;set;}
    public VG_Logo_Extension() {
        PSId = apexpages.currentpage().getparameters().get('Id');
        ps = [Select Id, Name, Product__c, Policy__c, Policy__r.VG_Is_Renewal__c, Policy__r.Line_Of_Business__c  ,Policy__r.VG_Expiry_Date__c, Policy__r.Gross_Written_Premium__c, Gross_Written_Premium__c, Policy__r.Broker_Name__r.Name, VG_Brokerage_Percent__c, VG_Brokerage_Amount__c, Policy__r.Broker_Name__r.VG_Intermediary_Number__c, Base_Creation_Start_Date__c, Policy__r.Insured__r.Name, Policy__r.Insured__r.Country__c, Policy__r.Insured__r.ShippingStreet, Policy__r.Insured__r.ShippingCity, Policy__r.Insured__r.ShippingPostalCode, Policy__r.Insured__r.ShippingState, Policy__r.Insured__r.ShippingCountry, Policy__r.Insured__r.SicDesc, Policy__r.Name, Policy__r.Inception_Expiry_Time__c, VG_Is_MTA__c, Actual_GWP__c, IPT_Percent__c, IPT__c, VG_MGA_Commission_Amount__c, Transaction_GWP__c, Policy__r.Insured__r.AccountNumber, Policy__r.Insured__r.Bank_Sort_Code__c, VG_MTA_Start_Date__c, Policy__r.VG_Inception_Date__c, Levies__c, VG_Fee_Income__c, Policy__r.Deductible_or_Excess_Amount__c from Policy_Schedule__c Where Id = :PSId];
        System.debug('Ps::'+ps.Policy__c+ps.Policy__r.VG_Is_Renewal__c);
        isRenewal = ps.Policy__r.VG_Is_Renewal__c;
        ExpiryDate = ps.Policy__r.VG_Expiry_Date__c;
        IncepDate  =  ps.Policy__r.VG_Inception_Date__c;
        ClaimLine = System.Label.Claim_Name;
        if(ps.VG_Fee_Income__c  != null)
            ps.VG_Fee_Income__c  = ps.VG_Fee_Income__c.setScale(2);
        if(ps.Levies__c != null)
            ps.Levies__c=ps.Levies__c.setScale(2);
        if(IncepDate !=  null)
            IncepDateFormat  =  IncepDate.format();
        MTAStartDate = ps.VG_MTA_Start_Date__c;
        if(MTAStartDate !=  null)
            MTAStartDateFormat = MTAStartDate.format();
        IPTAmount = BrokerageAmount = GWP = TotalAmountdue = 0;
        If(ps.Gross_Written_Premium__c!= null)
            GWP = ps.Gross_Written_Premium__c.setScale(2);
        If(ps.IPT__c!= null)
            IPTAmount = ps.IPT__c.setScale(2);
        If(ps.IPT_Percent__c!=null)    
            IPTPercent=(ps.IPT_Percent__c).setScale(2);        
        If(ps.VG_Brokerage_Amount__c!= null)
            BrokerageAmount = ps.VG_Brokerage_Amount__c.setScale(2);
        System.debug('23.7::'+IPTAmount+BrokerageAmount+GWP);
        TotalAmountdue  = GWP+IPTAmount-BrokerageAmount;
        System.debug('23.7::'+TotalAmountdue);       
        string strOrgId  =  UserInfo.getOrganizationId();
        today = System.Today().format();
        List< document > documentList  =  [select Id,  name from document where Name = 'Volante_Global_logo'];
        List< document > documentList1  =  [select Id, Name from document where Name = 'VG_Admin'];
        List< document > MFList  =  [select Id,  name from document where Name = 'Motor Felt'];
        ImageURL  =  ImageURL + documentList[0].Id;
        ImageURL  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;              
        documentList.clear();
        documentList  =  [select Id,  name from document where Name = 'VG_Edison_Quote'];               
        LogoURL = LogoURL+documentList[0].Id;
        System.debug('https://volante--qa--c.cs83.content.force.com/servlet/servlet.ImageServer?id=0156E000000HejW&oid=00D4E00000016id');
        LogoURL  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                   
        System.debug(LogoURL);
        documentList.clear();
        documentList  =  [select Id, Name from document where Name = 'certificate signature'];
        System.debug('documentList:'+documentList1);       
        Sign_URL  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                   
        documentList.clear();
        documentList  =  [select Id,  name from document where Name = 'VG_Edison_Quote2'];               
        FooterURL = LogoURL+documentList[0].Id;
        FooterURL  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                   
        documentList.clear();
        documentList  =  [select Id,  name from document where Name = 'VG_AdviceNote_Footer'];               
        AdviceFooterURL = AdviceFooterURL+documentList[0].Id;
        AdviceFooterURL  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                   
        
        MF = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Edison/servlet/servlet.ImageServer?id='+MFList[0].Id+'&oid=' + strOrgId;
        System.debug(MF );
        PrintView = '<!--[if gte mso 9]>' +
        '<xml>' +
        '<w:WordDocument>' +
        '<w:View>Print</w:View>' +
        '<w:Zoom>100</w:Zoom>' +
        '<w:DoNotOptimizeForBrowser/>' +
        '</w:WordDocument>' +
        '</xml>' +
        '<![endif]>';  
        System.debug('PP1::'+PP1);   
        assList = new List<Asset__c>([select id,  Name,  Vehicle_Registration_No__c, VG_Coverage__c,  Vehicle_Model__c,  Vehicle_Make__c, VG_Use__c from Asset__c where VG_Account__c  = :ps.Policy__r.Insured__c AND VG_Status__c = 'Active']);
        psaList = new List<VG_Policy_Schedule_Asset__c>([select id,  Name,  VG_Number_of_Vehicles__c, VG_Rate_Per_Vehicle__c, VG_Premium__c,VG_Use__c,  VG_Coverage__c, VG_Vehicle_Type__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c  = :ps.id ORDER BY VG_Number_of_Vehicles__c DESC]);
        pseList = new List<VG_Policy_Schedule_Endorsement__c>([select id,  Name,  VG_Endorsement_Number__c,  VG_Endorsement_Details__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c = :ps.id ORDER BY VG_Endorsement_Number__c ASC]);
    // below code added by siddik on 29.1.18
        wrapPSEList = new List<WrapperPSE>();
        if(!pseList.IsEmpty()){
           
            WrapperPSE wpse;
            integer counter = 0;
            for(integer i = 0;i<pseList.size();i++){
                if(counter == 0){
                    System.debug('Here i::'+i);
                    wpse = new WrapperPSE();
                }
                System.debug('i::'+i);
                System.debug('WPSE::'+wpse.pseList.size());
                wpse.pseList.add(pseList[i]);
                counter++;
                System.debug('counter::'+counter);
                if(counter == 5){
                    System.debug('were i::'+i);
                    wrapPSEList.add(wpse);
                    counter = 0;
                }
                if((i+1) == pseList.size()&& counter != 0){
                    wrapPSEList.add(wpse);
                }
                System.debug('wrapPSEList::'+wrapPSEList.size()+':'+wrapPSEList);
            }
            
        }
    // end 29.1.18
    // below code added by siddik on 30.1.18
        if(!psaList.Isempty()){
            wrapPSAList = new List<WrapperPSA>();
            WrapperPSA wpsa;
            integer counter = 0;
            for(integer i = 0;i<psaList.size();i++){
                if(counter == 0){
                    System.debug('Here i::'+i);
                    wpsa = new WrapperPSA();
                }
                System.debug('i::'+i);
                System.debug('WPSA::'+wpsa.psaList.size());
                wpsa.psaList.add(psaList[i]);
                counter++;
                System.debug('counter::'+counter);
                if(counter == 10){
                    System.debug('were i::'+i);
                    wrapPSAList.add(wpsa);
                    counter = 0;
                }
                if((i+1) == psaList.size()&& counter != 0){
                    wrapPSAList.add(wpsa);
                }
                System.debug('wrapPSAList::'+wrapPSAList.size()+':'+wrapPSAList);
            }
            
        }
        if(!wrapPSEList.IsEmpty()){
            pseList1 = new List<VG_Policy_Schedule_Endorsement__c>();
            if(wrapPSEList.size()>1){
                if(wrapPSEList[wrapPSEList.size()-1].pseList.size() == 1){
                    pseList1.add(wrapPSEList[wrapPSEList.size()-1].pseList[0]);
                    wrapPSEList.remove(wrapPSEList.size()-1);
                }else if(wrapPSEList[wrapPSEList.size()-1].pseList.size() == 2){
                    pseList1.add(wrapPSEList[wrapPSEList.size()-1].pseList[0]);
                    pseList1.add(wrapPSEList[wrapPSEList.size()-1].pseList[1]);
                    wrapPSEList.remove(wrapPSEList.size()-1);
                }else if(wrapPSEList[wrapPSEList.size()-1].pseList.size() == 3){
                    pseList1.add(wrapPSEList[wrapPSEList.size()-1].pseList[0]);
                    pseList1.add(wrapPSEList[wrapPSEList.size()-1].pseList[1]);
                    pseList1.add(wrapPSEList[wrapPSEList.size()-1].pseList[2]);
                    wrapPSEList.remove(wrapPSEList.size()-1);
                }else if(wrapPSEList[wrapPSEList.size()-1].pseList.size() == 4){
                    pseList1.add(wrapPSEList[wrapPSEList.size()-1].pseList[3]);
                    wrapPSEList[wrapPSEList.size()-1].pseList.remove(3);
                }else if(wrapPSEList[wrapPSEList.size()-1].pseList.size() == 5){
                    pseList1.add(wrapPSEList[wrapPSEList.size()-1].pseList[3]);
                    pseList1.add(wrapPSEList[wrapPSEList.size()-1].pseList[4]);
                    wrapPSEList[wrapPSEList.size()-1].pseList.remove(4);
                    wrapPSEList[wrapPSEList.size()-1].pseList.remove(3);
                }
            }else if(wrapPSEList.size() == 1){
                if(wrapPSEList[0].pseList.size() == 1){
                    pseList1.add(wrapPSEList[0].pseList[0]);
                    wrapPSEList.clear();
                }else if(wrapPSEList[0].pseList.size() == 2){
                    pseList1.add(wrapPSEList[0].pseList[0]);
                    pseList1.add(wrapPSEList[0].pseList[1]);
                    wrapPSEList.clear();
                }else if(wrapPSEList[0].pseList.size() == 3){
                    pseList1.add(wrapPSEList[0].pseList[0]);
                    pseList1.add(wrapPSEList[0].pseList[1]);
                    pseList1.add(wrapPSEList[0].pseList[2]);
                    wrapPSEList.clear();
                }else if(wrapPSEList[0].pseList.size() == 4){
                    pseList1.add(wrapPSEList[0].pseList[3]);
                    wrapPSEList[0].pseList.remove(3);
                }else if(wrapPSEList[0].pseList.size() == 5){
                    pseList1.add(wrapPSEList[0].pseList[3]);
                    pseList1.add(wrapPSEList[0].pseList[4]);
                    wrapPSEList[0].pseList.remove(4);
                    wrapPSEList[0].pseList.remove(3);
                }
            }
            System.debug('PSELIST1::'+pseList1.size()+'::'+pseList1);
        }
    // end 30.1.18
        if(!assList.IsEmpty() && assList.size()> = 10){
            Asset = false;
            PSAsset = True;
        }else if(!assList.IsEmpty() && assList.size()>0 && assList.size()<10){
            Asset = True;
            PSAsset = false;
        }else if(assList.IsEmpty() && !psaList.IsEmpty()){
            Asset = False;
            PSAsset = True;
        }else{
            Asset = false;
            PSAsset = false;
        }
        
    }
    // this WrapperPSA for Policy Schedule Asset created on 30.1.2018
    public Class WrapperPSA{
        public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
        public WrapperPSA(){
            psaList = new List<VG_Policy_Schedule_Asset__c>();
        }
    }
    // this WrapperPSE for Policy Schedule Endoresementcreated on 29.1.2018
    public Class WrapperPSE{
        public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
        public WrapperPSE(){
            pseList = new List<VG_Policy_Schedule_Endorsement__c>();
        }
    }
}