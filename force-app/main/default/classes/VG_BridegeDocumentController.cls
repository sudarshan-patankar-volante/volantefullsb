Public Class VG_BridegeDocumentController{
    String[] rd1{get;set;}
    public String F_SI{get;set;}
    public Decimal Fi_Ded_PBA{get;set;}
    public Decimal Fi_Ded_Cur{get;set;}
    
    public String GLPL_Coverage{get;set;}
    public Decimal GL_GLSI{get;set;}
    public Decimal GL_Ded_PBA{get;set;}
    public Decimal GL_Ded_Cur{get;set;}
    public String GL_Anl_Tnover_Nordics{get;set;}
    public String GL_Anl_Tnover_EU{get;set;}
    public String GL_PLSI{get;set;}     
    public String GL_PLDed_PBA{get;set;}
    public String GL_PLDed_Cur{get;set;}
    public String GL_Risk_qualty{get;set;}
    public String GL_Desc_qualty{get;set;}
    
    public String LA_Env_Cov_Factor{get;set;}
    public Decimal LA_SI{get;set;}
    public Decimal LA_SIAgg{get;set;}
    public Decimal LA_Ded_PBA{get;set;}
    public Decimal LA_Ded_Cur{get;set;}
    
    public Decimal CE_Anl_Tnover{get;set;}
    public Decimal CE_WorkSI{get;set;} 
    public String CE_EQ_Mob_SI{get;set;} 
    public String CE_EQ_Pill_SI{get;set;} 
    public String CE_EQ_Other_SI{get;set;}
    public Decimal Total_CE_EQ_SI{get;set;} 
    public Decimal CE_EX_Prty_SI{get;set;}
    public Decimal CE_Works_Ded_Cur{get;set;}
    public Decimal CE_Works_Ded_PBA{get;set;}
    
    public Decimal Oil_Damage_SI{get;set;}
    public Decimal Cistern_SI{get;set;}
    public Decimal Freeze_SI{get;set;}
    public Decimal Robbery_SI{get;set;}
    public Decimal Extra_Cost_SI{get;set;}
    public Decimal Tools_SI{get;set;}
    public Decimal Lift_SI{get;set;}
    public Decimal Forklift_SI{get;set;}
    public Decimal Business_Sample_SI{get;set;}
    public Decimal MB_Ded_Cur{get;set;}
    public Decimal MB_Ded_PBA{get;set;}
    public Decimal Epi_disease_SI{get;set;}
    public Decimal Crime_SI{get;set;}
    public Decimal Crime_Ded_Cur{get;set;}
    public Decimal Crime_Ded_PBA{get;set;}
    public String SO_SObject{get;set;}
    public Decimal SO_SI{get;set;}
    public Decimal SO_Ded_Cur{get;set;}
    public Decimal SO_Ded_PBA{get;set;}
    
    public Decimal BI_SI{get;set;}
    public Boolean LossofRent{get;set;}
    public Boolean MachineryBI{get;set;}
    public Boolean MachineryBreakdown{get;set;}
    Public Boolean pselistcheck{get;set;}
    Public Boolean endpselistcheck{get;set;}
    Public Boolean slpselistcheck{get;set;}
    Public Boolean GLPLpselistcheck{get;set;}
    Public Boolean GLPLslpselistcheck{get;set;}
    Public Boolean AllRiskpselistcheck{get;set;}
    Public Boolean AllRiskslpselistcheck{get;set;}
    Public Boolean LegalAidpselistcheck{get;set;}
    Public Boolean LegalAidslpselistcheck{get;set;}
    Public Boolean CARpselistcheck{get;set;}
    Public Boolean CARslpselistcheck{get;set;}
    Public Boolean Crimepselistcheck{get;set;}
    Public Boolean Crimeslpselistcheck{get;set;}
    Public String PrintView{get;set;}
    Public String BIindemnityperiod{get;set;}
    Public String MBBIindemnityperiod{get;set;}
    Public String Waitingperiod{get;set;}
    Public String MBWaitingperiod{get;set;}
    Public String CC_BIindemnityperiod{get;set;}
    Public String CC_MBBIindemnityperiod{get;set;}
    Public String CC_BIindemnityperiod_English{get;set;}
    Public String CC_MBBIindemnityperiod_English{get;set;}
    Public Decimal CC_PD_Deductible{get;set;}
    Public Decimal CC_MB_PD_Deductible{get;set;}
    Public String CC_Waitingperiod{get;set;}
    Public String CC_MBWaitingperiod{get;set;}
    Public String CC_Waitingperiod_English{get;set;}
    Public String CC_MBWaitingperiod_English{get;set;}
    Public Decimal totalTSIMachinary{get;set;}
    Public Decimal totalBISI{get;set;}
    Public Decimal totalMBBISI{get;set;}
    Public Decimal totalGoods{get;set;}
    Public Decimal totalContentsSI{get;set;}
    Public Decimal totalCustomerProperty{get;set;}
    Public Decimal totalother{get;set;}
    Public Decimal totalPD{get;set;}
    Public Decimal totalall_cp_Good_Mach_other{get;set;}  
    
    Public Decimal asstotalTSIMachinary{get;set;}   
    Public Decimal asstotalBISI{get;set;}
    Public Decimal asstotalMBBISI{get;set;}
    Public Decimal asstotalGoods{get;set;}
    Public Decimal asstotalContentsSI{get;set;}
    Public Decimal asstotalCustomerProperty{get;set;}
    Public Decimal asstotalother{get;set;}
    Public Decimal asstotalall_cp_Good_Mach_other{get;set;}
    
    Public String MF {get; set;}
    public String Logo{get;set;}
    public String PILogo{get;set;}
    Public String PSId{get;set;}
    Public Boolean IsProperty{get;set;}
    Public Boolean IsCommercialCombined{get;set;}
    
    Public Boolean IsPropertyComment{get;set;}
    Public Boolean sublimit{get;set;}
    Public Boolean Terlimit{get;set;}
    Public Boolean psadeductible{get;set;}
    public String underwriter{get;set;} 
    public String Sign_Url{get;set;}
    public String FooterURL{get;set;}
    public String PI_Sign_Url{get;set;}
    public String word{get;set;}
    public String psword{get;set;}
    public String pswordSwedish{get;set;}
    Public String coverage {get; set;}
    Public String EndorsementName {get; set;}
    Public String sublimitName {get; set;}
    Public Boolean Endorsement{get; set;}
    Public Policy_Schedule__c ps{get;set;}    
    Public List<VG_Policy_Schedule_Asset__c> psaList1{get;set;} 
    Public List<VG_Policy_Schedule_Asset__c> psaList{get;set;} 
    Public List<Asset__c> assList{get;set;} 
    Public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    Public List<VG_Policy_Schedule_Endorsement__c> slpseList{get;set;}
    Public List<String> wordingList{get;set;} 
    Public Map<String, String> tlMap{get;set;}
    Public Map<String, String> tlMapswedish{get;set;}
    Public Map<String, String> coverageMapswedish{get;set;}
    Public Map<String, Decimal> slMap{get;set;}
    Public Map<String, Decimal> slMapswedish{get;set;}
    Public Map<String, Decimal> dlMap{get;set;}
    Public Map<String, Decimal> dlMapswedish{get;set;}
    Public Map<String, String> transdata{get;set;}  
    public Map<String,  List<VG_Policy_Schedule_Endorsement__c >> endCoMap{get;set;}   
    public Map<String, boolean> endCovCheckMap{get;set;}
    public Map<String,  List<VG_Policy_Schedule_Endorsement__c >> endCoMap1{get;set;}
    public Map<String, boolean> endCovCheckMap1{get;set;}
    
    public VG_BridegeDocumentController(){
        GL_Desc_qualty='';
        totalTSIMachinary = 0;
        totalother = 0;
        totalGoods = 0;
        totalCustomerProperty = 0;
        totalBISI = 0;
        totalMBBISI = 0;
        totalContentsSI = 0;
        totalPD = 0;
        totalall_cp_Good_Mach_other = 0;
        CC_PD_Deductible = 0;
        CC_MB_PD_Deductible = 0;
        IsProperty = False;
        IsCommercialCombined = False;
        
        pselistcheck = False;
        endpselistcheck = False;
        slpselistcheck = False;
        Endorsement = False;
        coverage='';
        EndorsementName='';
        sublimitName='';
        tlMap = new Map<String, String>();
        tlMapswedish = new Map<String, String>();
        coverageMapswedish = new Map<String, String>();
        slMap = new Map<String, Decimal>();
        slMapswedish = new Map<String, Decimal>();
        dlMap = new Map<String, Decimal>();
        dlMapswedish = new Map<String, Decimal>();
        PSId = apexpages.currentpage().getparameters().get('Id');
        ps=[Select Id, Name, VG_Wording__c, VG_Auto_acquisition_Threshold__c, Policy__r.Description__c,VG_Retired_Directors_Year__c, Policy__r.Broker_Name__r.E_mail_address__c, Policy__r.Policy_Basis__c, VG_Machinery_Breakdown_Cover__c, VG_Machinery_Breakdown_BI_Cover__c, Product__c, Limit__c, Sum_Insured__c, Policy__r.VG_Territorial_Limits__c, Policy__r.VG_Additional_Insureds__c, Policy__r.VG_Wording__c, Policy__r.VG_Governance_Compliance__r.VG_Conditions_Subjectivites__c, Policy__r.Jurisdiction__c, Policy__r.Gross_Written_Premium__c, Policy__r.Line_Of_Business__c, VG_Deductible__c, VG_Extended_Reporting_Period__c, Policy__r.VG_Aggregate_Limit__c, Policy__r.Insured__r.BillingStreet, Policy__r.Insured__r.BillingCity, Policy__r.Insured__r.BillingCountry, Policy__r.Insured__r.BillingPostalCode, Policy__r.VG_Expiry_Date__c, Policy__r.Insured__r.Company_Registration_Number__c, Policy__r.Broker_Name__r.Name, Policy__r.Broker_Name__r.Phone, Policy__r.Broker_Name__r.ShippingStreet, Policy__r.Broker_Name__r.ShippingCity, Policy__r.Broker_Name__r.ShippingCountry, Policy__r.Broker_Name__r.ShippingPostalCode, Policy__r.Underwriter__r.Name, Policy__r.Broker_Name__r.Billing_Phone__c, Policy__r.VG_Continuous_Cover_Date__c, Policy__r.Extended_Reporting__c, Policy__r.Retroactive_Date__c, Policy__r.VG_Brokerage_Percent__c, VG_Brokerage_Percent__c, VG_Brokerage_Amount__c, Policy__r.Broker_Name__r.VG_Intermediary_Number__c, Base_Creation_Start_Date__c, Policy__r.Insured__r.Name, Policy__r.Insured__r.Country__c, Policy__r.Insured__r.ShippingStreet, Policy__r.Insured__r.ShippingCity, Policy__r.Insured__r.ShippingPostalCode, Policy__r.Insured__r.ShippingState, Policy__r.Insured__r.ShippingCountry, Policy__r.Insured__r.SicDesc, Policy__r.Name, Policy__r.Inception_Expiry_Time__c, VG_Is_MTA__c, Actual_GWP__c, IPT_Percent__c, IPT__c, VG_MGA_Commission_Amount__c, Transaction_GWP__c,  Policy__r.Insured__r.AccountNumber, Policy__r.Insured__r.Bank_Sort_Code__c, VG_MTA_Start_Date__c, Policy__r.VG_Inception_Date__c, Levies__c, VG_Fee_Income__c, Policy__r.Deductible_or_Excess_Amount__c, Policy__r.Deductible_or_Excess_Basis__c from Policy_Schedule__c Where Id=:PSId];
        
        If(ps.Product__c != null && (ps.Product__c.contains('Property'))){
            IsProperty = True;
            IsCommercialCombined = False;
        }else{
            IsProperty = False;
        }       
        If(ps.Product__c != null && (ps.Product__c=='Commercial Combined')){
            IsCommercialCombined = True;             
        }
        string strOrgId  =  UserInfo.getOrganizationId();
        psaList = new List<VG_Policy_Schedule_Asset__c>([Select id, Name, VG_Sum_Insured__c, VG_CC_Information__c, Asset__r.VG_Contents_SI__c, Asset__r.VG_Total_BISI_for_the_indemnity_period__c, Asset__r.VG_Full_Value_Building_P__c, Asset__r.VG_Company_Division__c, Asset__r.VG_Street__c, Asset__r.VG_Street_Number__c, Asset__r.VG_Postal_Code__c, Asset__r.VG_City__c, Asset__r.VG_Comment__c, Asset__r.VG_Country__c, Asset__r.VG_Block_ID__c, Asset__r.CurrencyIsoCode, Asset__r.VG_Building_SI__c, Asset__r.VG_Total_Business_Interruption_SI__c, Asset__r.VG_Total_MBBISI_for_the_indemnity_period__c, Asset__r.VG_Full_Value_Building__c, Asset__r.VG_Other_SI__c, Asset__r.VG_Customer_Property_SI__c, Asset__r.VG_Goods_SI__c, VG_Sub_limit__c, VG_Deductible__c, Asset__c, Asset__r.VG_Total_Sum_Insured_SI__c, Asset__r.VG_Machinery_SI__c, Asset__r.VG_EML_BI__c, Asset__r.VG_EML_PD__c, Asset__r.VG_Total_Property_Damage_SI__c, Asset__r.VG_BI_Indemnity_Period__c, Asset__r.VG_MB_PD_Deductible__c, Asset__r.VG_PD_Deductible__c, Asset__r.VG_MB_BI_Indemnity_Period__c, Asset__r.VG_Waiting_Period__c, Asset__r.VG_MB_Waiting_Period__c, VG_Coverage__c,  VG_Limit__c, VG_Territorial_Limits__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =:ps.id]);
        psaList1 = new List<VG_Policy_Schedule_Asset__c>(psaList.clone());
        psaList1.sort();
        System.debug('psaList::'+psaList1.size());
        assList = new List<Asset__c>([Select id, Name, VG_Contents_SI__c, VG_Total_BISI_for_the_indemnity_period__c, VG_Full_Value_Building_P__c, VG_Company_Division__c, VG_Street__c, VG_Street_Number__c, VG_Postal_Code__c, VG_City__c, VG_Comment__c, VG_Country__c, VG_Block_ID__c, CurrencyIsoCode, VG_Building_SI__c, VG_Total_Business_Interruption_SI__c, VG_Total_MBBISI_for_the_indemnity_period__c, VG_Full_Value_Building__c, VG_Other_SI__c, VG_Customer_Property_SI__c, VG_Goods_SI__c, VG_Total_Sum_Insured_SI__c, VG_Machinery_SI__c, VG_EML_BI__c, VG_EML_PD__c, VG_Total_Property_Damage_SI__c, VG_BI_Indemnity_Period__c, VG_MB_PD_Deductible__c, VG_PD_Deductible__c, VG_MB_BI_Indemnity_Period__c, VG_Waiting_Period__c, VG_MB_Waiting_Period__c, VG_Account__c from Asset__c where VG_Account__c=:ps.Policy__r.Insured__c]);
        System.debug('assList::'+assList.size());
        pseList = new List<VG_Policy_Schedule_Endorsement__c>([Select id, Name, VG_Endorsement_Number__c, VG_Sub_limit__c, VG_Endorsement_Details__c, VG_Title__c, VG_Product__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =:ps.id AND (VG_Type__c=:'Endorsements' OR VG_Type__c=:'' OR VG_Type__c=:null)]);
        slpseList = new List<VG_Policy_Schedule_Endorsement__c>([Select id, Name, VG_Endorsement_Number__c, VG_Type__c, VG_Sub_limit__c, VG_Endorsement_Details__c, VG_Title__c, VG_Product__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =:ps.id AND VG_Type__c=:'Sub-limits']);
        System.debug('17/12::'+slpseList.size()+'::'+pseList.size()+'::'+psaList.size());
        List< document > MFList  =  [select Id,  name from document where Name='Motor Felt'];
        MF='https://'+ApexPages.currentPage().getHeaders().get('Host')+'/Bridge/servlet/servlet.ImageServer?id='+MFList[0].Id+'&oid=' + strOrgId;        
        System.debug('image::'+MF+'::'+Logo);
        List< document > documentList  =  [select Id,  name from document where Name='Bridge Logo'];
        Logo  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/Bridge/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId; 
        System.debug('image::'+MF+'::'+Logo);
        documentList.clear();
        documentList  =  [select Id,  name from document where Name='Bridge_Footer'];               
        FooterURL = FooterURL+documentList[0].Id;
        FooterURL  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Bridge/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                   
        documentList.clear();
        List< document > documentList1  =  [select Id,  name from document where Name='VG PI Logo'];
        PILogo  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/Bridge/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId; 
        System.debug('image::'+MF+'::'+PILogo);
        documentList1.clear();
        documentList1  =  [select Id,  name from document where Name='David Sign'];
        PI_Sign_Url  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Bridge/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId;     
        documentList1.clear();
        if(ps.Policy__r.Underwriter__r.Name != null){
            underwriter = ps.Policy__r.Underwriter__r.Name;
            documentList  =  [select Id,  name from document where Name=:underwriter];    
            if(documentList.size()>0)
                Sign_Url  =  'https://'+ApexPages.currentPage().getHeaders().get('Host')+ '/Bridge/servlet/servlet.ImageServer?id='+documentList[0].Id+'&oid=' + strOrgId;                           
        }
        PrintView='<!--[if gte mso 9]>' +
            '<xml>' +
            '<w:WordDocument>' +
            '<w:View>Print</w:View>' +
            '<w:Zoom>100</w:Zoom>' +
            '<w:DoNotOptimizeForBrowser/>' +
            '</w:WordDocument>' +
            '</xml>' +
            '<![endif]>';
        
        If(pselist.size()>0){
            System.debug('pselistcheck::'+pselistcheck);
            pselistcheck=True;
        }     
        for(VG_Policy_Schedule_Endorsement__c pse: pseList){
            If(pse.VG_Product__c=='Fire' || pse.VG_Product__c=='Burglary' || pse.VG_Product__c=='Water' || pse.VG_Product__c=='All Risk' || pse.VG_Product__c=='Business Interruption' || pse.VG_Product__c=='Escaping Liquid' || pse.VG_Product__c=='Cistern' || pse.VG_Product__c=='Freeze & Refrigerator' || pse.VG_Product__c=='Machinery BI' || pse.VG_Product__c=='Loss of Rent' || pse.VG_Product__c=='Epidemic Disease' || pse.VG_Product__c=='Crisis' || pse.VG_Product__c=='Assault' || pse.VG_Product__c=='Tools' || pse.VG_Product__c=='Lift' || pse.VG_Product__c=='Forklift' || pse.VG_Product__c=='Business Sample' || pse.VG_Product__c =='Machinery Breakdown' ){
                AllRiskpselistcheck=True;
            }
            If(pse.VG_Product__c == 'Liability GL/PL')
                GLPLpselistcheck=True;  
            If(pse.VG_Product__c=='Legal Aid')
                LegalAidpselistcheck =True;  
            If(pse.VG_Product__c=='CAR/EAR')
                CARpselistcheck =True; 
            If(pse.VG_Product__c=='Crime')
                Crimepselistcheck=True; 
        } 
        for(VG_Policy_Schedule_Endorsement__c pse: slpseList){
            If(pse.VG_Product__c=='Fire' || pse.VG_Product__c=='Burglary' || pse.VG_Product__c=='Water' || pse.VG_Product__c=='All Risk' || pse.VG_Product__c=='Business Interruption' || pse.VG_Product__c=='Escaping Liquid' || pse.VG_Product__c=='Cistern' || pse.VG_Product__c=='Freeze & Refrigerator' || pse.VG_Product__c=='Machinery BI' || pse.VG_Product__c=='Loss of Rent' || pse.VG_Product__c=='Epidemic Disease' || pse.VG_Product__c=='Crisis' || pse.VG_Product__c=='Assault' || pse.VG_Product__c=='Tools' || pse.VG_Product__c=='Lift' || pse.VG_Product__c=='Forklift' || pse.VG_Product__c=='Business Sample' || pse.VG_Product__c =='Machinery Breakdown'){
                AllRiskslpselistcheck=True;
            }
            If(pse.VG_Product__c == 'Liability GL/PL')
                GLPLslpselistcheck=True; 
            If(pse.VG_Product__c=='Legal Aid')
                LegalAidslpselistcheck =True;  
            If(pse.VG_Product__c=='CAR/EAR')
                CARslpselistcheck =True;  
            If(pse.VG_Product__c=='Crime')
                Crimeslpselistcheck=True;          
        }     
          
        for(VG_Policy_Schedule_Asset__c psa:psaList){    
            If(psa.VG_Coverage__c=='Loss of Rent'){
                LossOfRent =True;               
            }else If(psa.VG_Coverage__c=='Machinery BI'){
                MachineryBI=True;                
            }else If(psa.VG_Coverage__c=='Machinery Breakdown'){
                MachineryBreakdown =True;
            }            
            if(psa.VG_Coverage__c!=null && psa.VG_Coverage__c!='--None--' && psa.VG_Coverage__c!='CAR/EAR' && psa.VG_Coverage__c!='Special Objects' && psa.VG_Coverage__c!='Legal Aid' && psa.VG_Coverage__c!='Personal Accident (visitor)' && psa.VG_Coverage__c!='Liability GL/PL' && psa.VG_Coverage__c!='Crime' && psa.VG_Coverage__c!='Business Interruption due to Health Problems' ){
                endpselistcheck=True;
            }           
            If(psa.VG_Coverage__c=='Extra Costs' || psa.VG_Coverage__c=='Robbery'){
                AllRiskslpselistcheck= true;
                slpselistcheck=true;
            }  
            
            GLPL_Coverage = psa.VG_CC_Information__c;
            If(GLPL_Coverage != null){
                rd1 = GLPL_Coverage.Split('<br>');
                for(integer i = 0; i < rd1.size();i++){
                    String[] tmp = rd1[i].split(':');  
                    System.debug('rd3::'+tmp);
                    if(tmp.size() > 1){
                        rd1[i]=tmp[1];
                        System.debug('tmp::'+tmp[1]+rd1[i]);
                    }else{
                        rd1[i]='';
                    } 
                } 
            }
            If(ps.Product__c=='Commercial Combined'){
                If(psa.VG_Coverage__c=='Fire'){
                    for(integer i = 0; i < rd1.size();i++){
                        System.debug('rd1 Fire::'+rd1[5]+rd1[6]);
                        F_SI = rd1[7].trim();
                        Fi_Ded_PBA = Decimal.valueOf(rd1[8].trim());
                        Fi_Ded_Cur = Decimal.valueOf(rd1[7].trim());
                    }
                }
                If(psa.VG_Coverage__c=='Escaping Liquid'){
                    for(integer i = 0; i < rd1.size();i++){
                        Oil_Damage_SI = Decimal.valueOf(rd1[1].trim());                
                    }
                }
                If(psa.VG_Coverage__c=='Cistern'){
                    for(integer i = 0; i < rd1.size();i++){
                        Cistern_SI = Decimal.valueOf(rd1[1].trim());                
                    }
                }
                If(psa.VG_Coverage__c=='Freeze & Refrigerator'){
                    for(integer i = 0; i < rd1.size();i++){
                        Freeze_SI = Decimal.valueOf(rd1[0].trim());                
                    }
                }  
                If(psa.VG_Coverage__c=='Extra Costs'){
                    System.debug('15.3.2019::'+rd1);
                    for(integer i = 0; i < rd1.size();i++){
                        Extra_Cost_SI = Decimal.valueOf(rd1[0].trim());                
                    }
                }  
                If(psa.VG_Coverage__c=='Robbery'){
                    for(integer i = 0; i < rd1.size();i++){
                        Robbery_SI = Decimal.valueOf(rd1[0].trim());                
                    }
                }    
                If(psa.VG_Coverage__c=='Epidemic Disease'){
                    for(integer i = 0; i < rd1.size();i++){
                        Epi_disease_SI = Decimal.valueOf(rd1[0].trim());                
                    }
                }  
                If(psa.VG_Coverage__c=='Tools'){
                    for(integer i = 0; i < rd1.size();i++){
                        Tools_SI = Decimal.valueOf(rd1[0].trim());                
                    }
                } 
                If(psa.VG_Coverage__c=='Lift'){
                    for(integer i = 0; i < rd1.size();i++){
                        Lift_SI = Decimal.valueOf(rd1[0].trim());                
                    }
                }  
                If(psa.VG_Coverage__c=='Forklift'){
                    for(integer i = 0; i < rd1.size();i++){
                        Forklift_SI = Decimal.valueOf(rd1[0].trim());                
                    }
                } 
                If(psa.VG_Coverage__c=='Business Sample'){
                    for(integer i = 0; i < rd1.size();i++){
                        Business_Sample_SI = Decimal.valueOf(rd1[0].trim());                
                    }
                }  
                If(psa.VG_Coverage__c=='Machinery Breakdown'){
                    for(integer i = 0; i < rd1.size();i++){
                        MB_Ded_Cur = Decimal.valueOf(rd1[2].trim());   
                        MB_Ded_PBA = Decimal.valueOf(rd1[3].trim());                
                    }
                }  
                If(psa.VG_Coverage__c=='Liability GL/PL'){                                                     
                    System.debug('psaList::'+psaList.size()+psa.VG_Coverage__c);
                    System.debug('rd1::'+rd1);
                    for(integer i = 0; i < rd1.size();i++){
                        System.debug('rd12::'+rd1[0]+rd1[1]);
                        GL_GLSI = Decimal.ValueOf(rd1[0].trim());
                        GL_Ded_PBA = Decimal.valueOf(rd1[1].trim());
                        GL_Ded_Cur = Decimal.valueOf(rd1[2].trim());
                        GL_Anl_Tnover_Nordics = rd1[3].trim();
                        GL_Anl_Tnover_EU = rd1[4].trim();
                        GL_PLSI = rd1[5].trim();     
                        GL_PLDed_PBA = rd1[6].trim();
                        GL_PLDed_Cur = rd1[7].trim();
                        GL_Risk_qualty = rd1[8].trim();
                        If(rd1[9]!=null)
                            GL_Desc_qualty = rd1[9].trim();                   
                    } 
                }else If(psa.VG_Coverage__c=='Legal Aid'){     
                    System.debug('psaList::'+psaList.size()+psa.VG_Coverage__c);
                    System.debug('rd1::'+rd1);
                    for(integer i = 0; i < rd1.size();i++){
                        System.debug('rd12::'+rd1[0]+rd1[1]);
                        LA_Env_Cov_Factor = rd1[0].trim();
                        LA_SI = Decimal.valueOf(rd1[1].trim());
                        LA_Ded_PBA = Decimal.valueOf(rd1[3].trim());
                        LA_Ded_Cur = Decimal.valueOf(rd1[2].trim());
                        If(rd1.size() > 4)
                            LA_SIAgg = Decimal.valueOf(rd1[4].trim()); 
                        else
                            LA_SIAgg = 0;                                                       
                    } 
                }else if(psa.VG_Coverage__c=='CAR/EAR'){
                    System.debug('psaList::'+psaList.size()+psa.VG_Coverage__c);
                    System.debug('rd1::'+rd1);
                    for(integer i = 0; i < rd1.size();i++){
                        If(rd1[2]!=null)
                            CE_Anl_Tnover = Decimal.valueOf(rd1[2].trim());
                        else{
                            CE_Anl_Tnover = 0;
                        }
                        CE_WorkSI = Decimal.valueOf(rd1[3].trim());
                        CE_EQ_Mob_SI = rd1[13].trim();
                        CE_EQ_Pill_SI = rd1[14].trim();
                        CE_EQ_Other_SI = rd1[15].trim();
                        Total_CE_EQ_SI = 0;
                        Decimal EQ_SI = 0;
                        If(CE_EQ_Mob_SI!='null' && CE_EQ_Pill_SI!='null' && CE_EQ_Other_SI!='null'){  
                            System.debug('EQSI::'+CE_EQ_Mob_SI+CE_EQ_Pill_SI+ CE_EQ_Other_SI);                 
                            EQ_SI = Decimal.valueOf(CE_EQ_Mob_SI)+Decimal.valueOf(CE_EQ_Pill_SI)+Decimal.valueOf(CE_EQ_Other_SI);                                          
                        }else{
                            EQ_SI = 0;    
                        }
                        Total_CE_EQ_SI = EQ_SI;
                        If(CE_EX_Prty_SI != null){
                            CE_EX_Prty_SI = Decimal.valueOf(rd1[18].trim());
                        }else{
                            CE_EX_Prty_SI = 0;
                        }
                        CE_Works_Ded_Cur = Decimal.valueOf(rd1[4].trim());
                        CE_Works_Ded_PBA = Decimal.valueOf(rd1[5].trim());
                        
                    }
                }else if(psa.VG_Coverage__c=='Crime'){
                    System.debug('psaList::'+psaList.size()+psa.VG_Coverage__c);
                    System.debug('rd1::'+rd1);
                    for(integer i = 0; i < rd1.size();i++){
                        Crime_SI = Decimal.valueOf(rd1[0].trim());
                        Crime_Ded_Cur = Decimal.valueOf(rd1[2].trim());
                        Crime_Ded_PBA = Decimal.valueOf(rd1[1].trim());
                    }
                }else if(psa.VG_Coverage__c=='Special Objects'){
                    System.debug('psaList::'+psaList.size()+psa.VG_Coverage__c);
                    System.debug('rd1::'+rd1);
                    If(rd1 != null && rd1.size()>0){
                        for(integer i = 0; i < rd1.size();i++){
                            SO_SObject = rd1[0].trim();
                            SO_SI = Decimal.valueOf(rd1[1].trim());
                            SO_Ded_Cur = Decimal.valueOf(rd1[4].trim());
                            SO_Ded_PBA = Decimal.valueOf(rd1[5].trim());
                        }
                    }
                }else if(psa.VG_Coverage__c=='Business Interruption due to Health Problems'){
                    System.debug('psaList::'+psaList.size()+psa.VG_Coverage__c);
                    System.debug('rd1::'+rd1);
                    for(integer i = 0; i < rd1.size();i++){
                        BI_SI =  Decimal.valueOf(rd1[2].trim());
                    }
                }
            }
        }
        for(VG_Policy_Schedule_Asset__c psa:psaList){       
            If(psa.Asset__r.VG_Machinery_SI__c != null)
                totalTSIMachinary += psa.Asset__r.VG_Machinery_SI__c;
            If(psa.Asset__r.VG_Other_SI__c != null)
                totalother+= psa.Asset__r.VG_Other_SI__c;
            If(psa.Asset__r.VG_Goods_SI__c != null)
                totalGoods+= psa.Asset__r.VG_Goods_SI__c;
            If(psa.Asset__r.VG_Customer_Property_SI__c != null)
                totalCustomerProperty+= psa.Asset__r.VG_Customer_Property_SI__c;
            If(psa.Asset__r.VG_Total_MBBISI_for_the_indemnity_period__c != null)
                totalMBBISI+=psa.Asset__r.VG_Total_MBBISI_for_the_indemnity_period__c;
            If(psa.Asset__r.VG_Total_BISI_for_the_indemnity_period__c != null)
                totalBISI +=psa.Asset__r.VG_Total_BISI_for_the_indemnity_period__c;
            If(psa.Asset__r.VG_Total_Property_Damage_SI__c != null)
                totalPD +=psa.Asset__r.VG_Total_Property_Damage_SI__c;                                       
        } 
        If(!assList.IsEmpty()){
            asstotalTSIMachinary = 0;
            asstotalother = 0;
            asstotalGoods = 0;
            asstotalCustomerProperty = 0;
            asstotalBISI = 0;
            asstotalMBBISI = 0;
            asstotalContentsSI = 0;
            asstotalall_cp_Good_Mach_other = 0;
            
            for(Asset__c ass:assList){
                If(ass.VG_Machinery_SI__c != null){
                    asstotalTSIMachinary += ass.VG_Machinery_SI__c;
                    System.debug('totalTSIMachinary::'+totalTSIMachinary);
                }
                If(ass.VG_Other_SI__c != null)
                    asstotalother+= ass.VG_Other_SI__c;
                If(ass.VG_Goods_SI__c != null)
                    asstotalGoods+= ass.VG_Goods_SI__c;
                If(ass.VG_Customer_Property_SI__c != null)
                    asstotalCustomerProperty+= ass.VG_Customer_Property_SI__c;
                If(ass.VG_Contents_SI__c != null)
                    asstotalContentsSI+=ass.VG_Contents_SI__c;
                If(ass.VG_Total_MBBISI_for_the_indemnity_period__c != null)
                    asstotalMBBISI+=ass.VG_Total_MBBISI_for_the_indemnity_period__c;
                If(ass.VG_Total_BISI_for_the_indemnity_period__c != null){
                    asstotalBISI +=ass.VG_Total_BISI_for_the_indemnity_period__c; 
                }
            }  
            asstotalall_cp_Good_Mach_other+=asstotalTSIMachinary +asstotalother+asstotalGoods+asstotalCustomerProperty+asstotalContentsSI;
            
        }
        
        If(!assList.IsEmpty()){ 
            if(ps.Product__c=='Commercial Combined'){             
                If(assList[0].VG_BI_Indemnity_Period__c != null){
                    String period = assList[0].VG_BI_Indemnity_Period__c;
                    String[] convert = period.Split(' ');
                    for(integer i = 0; i < convert.size();i++){
                        String[] tmp = convert;  
                        System.debug('rd3::'+tmp+tmp[1]+tmp[0]);
                        convert[i]=tmp[0];
                        System.debug('convert[i]::'+convert[i]+'::'+convert[0]);
                    }                        
                    CC_BIindemnityperiod = convert[0]+' månader'; 
                    CC_BIindemnityperiod_English = convert[0]+' months';  
                }
                If(assList[0].VG_MB_BI_Indemnity_Period__c != null){
                    String period = assList[0].VG_MB_BI_Indemnity_Period__c;
                    String[] convert = period.Split(' ');
                    for(integer i = 0; i < convert.size();i++){
                        String[] tmp = convert;  
                        System.debug('rd3::'+tmp+tmp[1]+tmp[0]);
                        convert[i]=tmp[0];
                        System.debug('convert[i]::'+convert[i]+'::'+convert[0]);
                    } 
                    
                    CC_MBBIindemnityperiod = convert[0]+' månader';
                    CC_MBBIindemnityperiod_English = convert[0]+' months';  
                }
                If(assList[0].VG_Waiting_Period__c != null){
                    String period = assList[0].VG_Waiting_Period__c;
                    String[] convert = period.Split(' ');
                    for(integer i = 0; i < convert.size();i++){
                        String[] tmp = convert;  
                        System.debug('rd3::'+tmp+tmp[1]+tmp[0]);
                        convert[i]=tmp[0];
                        System.debug('convert[i]::'+convert[i]+'::'+convert[0]);
                    } 
                    
                    CC_Waitingperiod = convert[0]+' timmar'; 
                    CC_Waitingperiod_English = convert[0]+' hours';  
                }
                If(assList[0].VG_MB_Waiting_Period__c != null){
                    String period = assList[0].VG_MB_Waiting_Period__c;
                    String[] convert = period.Split(' ');
                    for(integer i = 0; i < convert.size();i++){
                        String[] tmp = convert;  
                        System.debug('rd3::'+tmp+tmp[1]+tmp[0]);
                        convert[i]=tmp[0];
                        System.debug('convert[i]::'+convert[i]+'::'+convert[0]);
                    } 
                    
                    CC_MBWaitingperiod = convert[0]+' timmar';  
                    CC_MBWaitingperiod_English = convert[0]+' hours';  
                }
                If(assList[0].VG_PD_Deductible__c != null){
                    CC_PD_Deductible = assList[0].VG_PD_Deductible__c;
                }
                If(assList[0].VG_MB_PD_Deductible__c != null){
                    CC_MB_PD_Deductible = assList[0].VG_MB_PD_Deductible__c;
                }                                  
            }
        }         
        endCoMap  =  new Map<String,  List<VG_Policy_Schedule_Endorsement__c >>();
        for(VG_Policy_Schedule_Endorsement__c pse: pseList) {
            if(endCoMap.containsKey(pse.VG_Product__c )) {
                List<VG_Policy_Schedule_Endorsement__c> endList  =  endCoMap.get(pse.VG_Product__c );
                endList.add(pse);
                endCoMap.put(pse.VG_Product__c ,  endList);
            } else {
                endCoMap.put(pse.VG_Product__c ,  new List<VG_Policy_Schedule_Endorsement__c> { pse });
            }
        }
        endCovCheckMap = new Map<String, Boolean>();
        for(VG_Policy_Schedule_Asset__c psa:psaList){
            if(!endCovCheckMap.containsKey(psa.VG_Coverage__c)){
                endCovCheckMap.put(psa.VG_Coverage__c, False);
            }
            System.debug('17/12::'+endCovCheckMap);
        }
        for(VG_Policy_Schedule_Endorsement__c pse: pseList) {
            if(endCovCheckMap.containsKey(pse.VG_Product__c )){
                endCovCheckMap.put(pse.VG_Product__c , True);
                System.debug('17/12::'+endCovCheckMap);
            }
            
        }
        System.debug('17/12::'+endCovCheckMap);
        endCoMap1  =  new Map<String,  List<VG_Policy_Schedule_Endorsement__c >>();
        for(VG_Policy_Schedule_Endorsement__c pse: slpseList) {
            if(endCoMap1.containsKey(pse.VG_Product__c )) {
                List<VG_Policy_Schedule_Endorsement__c> endList  =  endCoMap1.get(pse.VG_Product__c );
                endList.add(pse);
                endCoMap1.put(pse.VG_Product__c ,  endList);
            } else {
                endCoMap1.put(pse.VG_Product__c ,  new List<VG_Policy_Schedule_Endorsement__c> { pse });
            }
        }
        endCovCheckMap1 = new Map<String, Boolean>();
        for(VG_Policy_Schedule_Asset__c psa:psaList){            
            if(!endCovCheckMap1.containsKey(psa.VG_Coverage__c)){
                endCovCheckMap1.put(psa.VG_Coverage__c, False);
                System.debug('endCovCheckMap1-6::'+endCovCheckMap1.put(psa.VG_Coverage__c, False));
            }
        }
        for(VG_Policy_Schedule_Endorsement__c pse: slpseList) {
            if(endCovCheckMap1.containsKey(pse.VG_Product__c )){
                endCovCheckMap1.put(pse.VG_Product__c , True);
            }
            
        }
        
        transdata  =  new Map<String, String>();
        Translation__mdt [] translist=[SELECT From_Language__c, To_Language__c, Language1__c, Language2__c From Translation__mdt];        
        System.debug('11-9 test::'+translist);
        for(Translation__mdt trs : translist){
            System.debug('11-9 test::'+trs.Language1__c+'::'+trs);
            transdata.put(trs.Language1__c, trs.Language2__c);
            System.debug('11-9 Keys::'+trs.Language1__c+'::'+trs.Language2__c);
        }
        If(ps.Policy__r.VG_Wording__c != null){
            word = transdata.get(ps.Policy__r.VG_Wording__c);                                  
        }
        If(ps.VG_Wording__c != null){           
            String wordings = ps.VG_Wording__c;
            psword  =  wordings.replace(';', '<br/>');
            psword = psword.replace('<br/>','<div style="background:#F0EDEB;"><span style="background:#F0550C;">&nbsp;</span>');     
            String Swedishword = ps.VG_Wording__c;
            //List<String> wordlist = new List<String>();           
            //Swedishword =  Swedishword.replace(';', '<br/>');
            String[] words =  Swedishword.Split(';');
            /*for(integer i = 0; i < words.size();i++){
              wordlist.add(words[i]);   
            }

            System.debug('wordlist::'+wordlist); */
            wordingList = new List<String>();
            for(integer w = 0; w < words.size();w++){
                System.debug('pswordSwedish1::'+transdata.get(words[w]));  
                pswordSwedish = transdata.get(words[w]);
                System.debug('pswordSwedish2::'+pswordSwedish); 
                wordingList.add(pswordSwedish);
                System.debug('wordlist::'+wordingList);
                pswordSwedish = wordingList[w];
            }  
            //pswordSwedish  =  wordlist.replace(',', '<br/>');
            //pswordSwedish  = pswordSwedish .replace('<br/>','<div style="background:#F0EDEB;"><span style="background:#F0550C;">&nbsp;</span>');     
            
        }
        
        if(!psaList.Isempty()){           
            If(psaList[0].Asset__r.VG_BI_Indemnity_Period__c != null){
                String period = psaList[0].Asset__r.VG_BI_Indemnity_Period__c;
                String[] convert = period.Split(' ');
                for(integer i = 0; i < convert.size();i++){
                    String[] tmp = convert;  
                    System.debug('rd3::'+tmp+tmp[1]+tmp[0]);
                    convert[i]=tmp[0];
                    System.debug('convert[i]::'+convert[i]+'::'+convert[0]);
                } 
                
                BIindemnityperiod = convert[0]+' månader';  
            }
            If(psaList[0].Asset__r.VG_MB_BI_Indemnity_Period__c != null){
                String period = psaList[0].Asset__r.VG_MB_BI_Indemnity_Period__c;
                String[] convert = period.Split(' ');
                for(integer i = 0; i < convert.size();i++){
                    String[] tmp = convert;  
                    System.debug('rd3::'+tmp+tmp[1]+tmp[0]);
                    convert[i]=tmp[0];
                    System.debug('convert[i]::'+convert[i]+'::'+convert[0]);
                } 
                
                MBBIindemnityperiod = convert[0]+' månader';  
            }
            
            If(psaList[0].Asset__r.VG_Waiting_Period__c != null){
                String period = psaList[0].Asset__r.VG_Waiting_Period__c;
                String[] convert = period.Split(' ');
                for(integer i = 0; i < convert.size();i++){
                    String[] tmp = convert;  
                    System.debug('rd3::'+tmp+tmp[1]+tmp[0]);
                    convert[i]=tmp[0];
                    System.debug('convert[i]::'+convert[i]+'::'+convert[0]);
                } 
                
                Waitingperiod = convert[0]+' timmar';  
            }
            If(psaList[0].Asset__r.VG_MB_Waiting_Period__c != null){
                String period = psaList[0].Asset__r.VG_MB_Waiting_Period__c;
                String[] convert = period.Split(' ');
                for(integer i = 0; i < convert.size();i++){
                    String[] tmp = convert;  
                    System.debug('rd3::'+tmp+tmp[1]+tmp[0]);
                    convert[i]=tmp[0];
                    System.debug('convert[i]::'+convert[i]+'::'+convert[0]);
                } 
                
                MBWaitingperiod = convert[0]+' timmar';  
            }
        }
        
        for(VG_Policy_Schedule_Asset__c psa:psaList){
            if(psa.VG_Coverage__c  != null && psa.VG_Coverage__c !='--None--'){
                String[] cov = psa.VG_Coverage__c.split(';');
                for(String s:cov){
                    System.debug('11-9 COV::'+psa.VG_Territorial_Limits__c+'::'+ transdata.containsKey(psa.VG_Territorial_Limits__c));
                    if(psa.VG_Territorial_Limits__c  != null && psa.VG_Territorial_Limits__c !='--None--'){
                        Terlimit = true;
                        tlMapswedish.put(transdata.get(s),transdata.get(psa.VG_Territorial_Limits__c));
                        
                    }else{
                        tlMapswedish.put(transdata.get(s),'--None--');
                    }
                    if(psa.VG_Sub_limit__c  != null && psa.VG_Sub_limit__c  != 0){
                        Decimal sl = 0;
                        sl = sl+psa.VG_Sub_limit__c;
                        if(sl>0){
                            sublimit = true;   
                        }
                        slMapswedish.put(transdata.get(s),psa.VG_Sub_limit__c);
                    }else{
                        slMapswedish.put(transdata.get(s),0);
                    }
                    if(psa.VG_Deductible__c  != null && psa.VG_Deductible__c  != 0){
                        Decimal dl = 0;
                        dl = dl+psa.VG_Deductible__c;
                        if(dl>0){
                            psadeductible = true;
                        }
                        dlMapswedish.put(transdata.get(s),psa.VG_Deductible__c);
                    }else{
                        dlMapswedish.put(transdata.get(s),0);
                    }
                }
            }          
        }
        for(VG_Policy_Schedule_Asset__c psa:psaList){
            if(psa.VG_Coverage__c  != null && psa.VG_Coverage__c !='--None--'){  
                coverage = psa.VG_Coverage__c;              
                String[] cov = psa.VG_Coverage__c.split(';');
                for(String s:cov){
                    if(psa.VG_Territorial_Limits__c  != null && psa.VG_Territorial_Limits__c !='--None--'){
                        Terlimit = true;
                        tlMap.put(s, psa.VG_Territorial_Limits__c);                                            
                    }else{
                        tlMap.put(s,'--None--');
                    }
                    if(psa.VG_Sub_limit__c  != null && psa.VG_Sub_limit__c  != 0){
                        Decimal sl = 0;
                        sl = sl+psa.VG_Sub_limit__c;
                        if(sl>0){
                            sublimit = true;   
                        }
                        slMap.put(s, psa.VG_Sub_limit__c);
                    }else{
                        slMap.put(s, 0);
                    }
                    if(psa.VG_Deductible__c  != null && psa.VG_Deductible__c  != 0){
                        Decimal dl = 0;
                        dl = dl+psa.VG_Deductible__c;
                        if(dl>0){
                            psadeductible = true;
                        }
                        dlMap.put(s, psa.VG_Deductible__c);
                    }else{
                        dlMap.put(s, 0);
                    }
                }
            }
        }
        
    }
}