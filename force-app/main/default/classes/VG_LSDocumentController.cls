Public Class VG_LSDocumentController{
    Public String PrintView{get;set;}
    Public Policy__c pol{get;set;}
    Public String MF {get; set;}
    public String Logo{get;set;}
    public String PILogo{get;set;}
    public String ELLogo{get;set;}
    public String AffnityLogo{get;set;}
    Public String PolId{get;set;}
    public String PI_Sign_Url{get;set;}
    public String Auth_Sign_Url{get;set;}
    public Decimal sumInsured{get;set;}
    public Decimal maxSumInsured{get;set;}
    Public List<Risk_Capture__c > rcList{get;set;}
    Public List<VG_Policy_Schedule_Asset__c> psaList{get;set;} 
    Public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    public Map<Id,Policy_Schedule__c> psMap{get;set;}
    public Map<String,Decimal> psaPerils{get;set;}
    public Map<String,Boolean> psaPerilsAccess{get;set;}
    public Date Today{get;set;}
    
    public String pdtext{get;set;}
    public String BItext{get;set;}
    public String LLtext{get;set;}
    public String GDtext{get;set;}
    public String MAtext{get;set;}
    public String FLtext{get;set;}
    public String ELtext{get;set;}
    public String PPLtext{get;set;}
    public String PItext{get;set;} 
    public String DOtext{get;set;}
    /*public String PAtext{get;set;}
    public String CBtext{get;set;}
    public String CEtext{get;set;}
    public String CEEtext{get;set;}
    public String DoEtext{get;set;}
    public String DrEtext{get;set;}
    public String FEtext{get;set;}
    public String HPEtext{get;set;}
    public String HMEtext{get;set;}
    public String Bentext{get;set;}
    public String MCtext{get;set;}
    public String LOItext{get;set;}
    public String RCOtext{get;set;}
    public String NJMtext{get;set;}
    public String NAMtext{get;set;}
    public String Clubtext{get;set;}
    public String Endorsement_Text{get;set;}
    
    public String LEtext{get;set;}*/
    public String SCtext{get;set;}
    public String PStext{get;set;}
    public String AEtext{get;set;}
    public String IVtext{get;set;}
    public String GPtext{get;set;}
    public String GRtext{get;set;}
    public String ICWtext{get;set;}
    public String AICWtext{get;set;}
    public String RRtext{get;set;}
    public String BDtext{get;set;}
    
    public Boolean PropertyProduct{get;set;}
    public Boolean LiabilityProduct{get;set;}
    public Boolean DOProduct{get;set;}
    
    public Boolean PropertyDamage{get;set;}
    public Boolean sItem{get;set;}
    public Boolean BusinessInter{get;set;}
    public Boolean fidility{get;set;}
    public Boolean LossLicence{get;set;}
    public Boolean GoodsinTrans{get;set;}
    public Boolean money{get;set;}
    
    public Boolean EmpLiability{get;set;}
    public Boolean PublicandProductLiability{get;set;}
    public Boolean ProfessionalIndemnity{get;set;}
    public Boolean DirectorsOfficers{get;set;}
    
    public Boolean Periltext{get;set;}
    public Boolean Endorsement{get;set;}
    public Boolean sublimit{get;set;}
    
    public Decimal TotalGwp{get;set;}
    public Decimal TotalIpt{get;set;}
    public Decimal TotalFeeIncome{get;set;}
    public Decimal TotalGwp_Ipt_FIncome{get;set;}
    
    Public VG_LSDocumentController(){
         PolId=apexpages.currentpage().getparameters().get('Id');
         pol=[Select Id,Name,CurrencyIsoCode,Retroactive_Date__c,IPT__c,Gross_Written_Premium_Rollup__c,VG_Fee_Income__c,Broker_Name__r.Name,Broker_Name__r.ShippingState,Insured__r.BillingStreet,Insured__r.BillingState,Insured__r.BillingPostalCode,Insured__r.BillingCity,Insured__r.BillingCountry,Insured__r.Business_Description__c,Broker_Name__r.E_mail_address__c,Insured__r.ShippingStreet,Insured__r.ShippingCity,Insured__r.ShippingPostalCode,Insured__r.ShippingState,Insured__r.ShippingCountry,Insured__r.SicDesc,Broker_Name__r.ShippingStreet,Broker_Name__r.ShippingCity,Broker_Name__r.ShippingCountry,Broker_Name__r.ShippingPostalCode,Policy_Basis__c,VG_Territorial_Limits__c,VG_Additional_Insureds__c,Broker_Name__r.Billing_Phone__c,VG_Wording__c,VG_Expiry_Date__c,VG_Inception_Date__c,VG_Governance_Compliance__r.VG_Conditions_Subjectivites__c,Jurisdiction__c,Underwriter__r.Name,Insured__r.Name,Gross_Written_Premium__c,Line_Of_Business__c from Policy__c where Id=:PolId];
         
         PropertyProduct=false;
         LiabilityProduct=false;
         DOProduct=false;
         PropertyDamage=false;
         sItem=false;
         BusinessInter=False;
         fidility=false;
         LossLicence=false;
         GoodsinTrans=false;
         money=false;
         
         EmpLiability=False;
         PublicandProductLiability=False;
         ProfessionalIndemnity=False;
         DirectorsOfficers=False;
         
         Periltext=false;
         Endorsement=false;
         sublimit=false;
        
         TotalGwp=0;
         TotalIpt=0;
         TotalFeeIncome=0;
         
         Today=Date.today().addDays(30); 
            
         psMap=new map<Id,Policy_Schedule__c>([Select Id,Name,Gross_Written_Premium__c,Policy__r.Insured__r.Business_Description__c,Policy__r.Broker_Name__r.E_mail_address__c,Policy__r.Policy_Basis__c,VG_Machinery_Breakdown_Cover__c,VG_Machinery_Breakdown_BI_Cover__c,Product__c,Limit__c,Sum_Insured__c,Policy__r.VG_Territorial_Limits__c,Policy__r.VG_Additional_Insureds__c,Policy__r.VG_Wording__c,Policy__r.VG_Governance_Compliance__r.VG_Conditions_Subjectivites__c,Policy__r.Jurisdiction__c,Policy__r.Gross_Written_Premium__c,Policy__r.Line_Of_Business__c,VG_Deductible__c,VG_Extended_Reporting_Period__c,Policy__r.VG_Aggregate_Limit__c,Policy__r.Insured__r.BillingStreet,Policy__r.Insured__r.BillingCity,Policy__r.Insured__r.BillingCountry,Policy__r.Insured__r.BillingPostalCode,Policy__r.VG_Expiry_Date__c,Policy__r.Insured__r.Company_Registration_Number__c,Policy__r.Broker_Name__r.Name,Policy__r.Broker_Name__r.Phone,Policy__r.Broker_Name__r.ShippingStreet,Policy__r.Broker_Name__r.ShippingCity,Policy__r.Broker_Name__r.ShippingCountry,Policy__r.Broker_Name__r.ShippingPostalCode,Policy__r.Underwriter__r.Name,Policy__r.Broker_Name__r.Billing_Phone__c,Policy__r.VG_Continuous_Cover_Date__c,Policy__r.Extended_Reporting__c,Policy__r.Retroactive_Date__c,Policy__r.VG_Brokerage_Percent__c,VG_Brokerage_Percent__c,VG_Brokerage_Amount__c,Policy__r.Broker_Name__r.VG_Intermediary_Number__c,Base_Creation_Start_Date__c,Policy__r.Insured__r.Name,Policy__r.Insured__r.Country__c,Policy__r.Insured__r.ShippingStreet,Policy__r.Insured__r.ShippingCity,Policy__r.Insured__r.ShippingPostalCode,Policy__r.Insured__r.ShippingState,Policy__r.Insured__r.ShippingCountry,Policy__r.Insured__r.SicDesc,Policy__r.Name,Policy__r.Inception_Expiry_Time__c,VG_Is_MTA__c,Actual_GWP__c,IPT_Percent__c,IPT__c,VG_MGA_Commission_Amount__c,Transaction_GWP__c, Policy__r.Insured__r.AccountNumber,Policy__r.Insured__r.Bank_Sort_Code__c,VG_MTA_Start_Date__c,Policy__r.VG_Inception_Date__c,Levies__c,VG_Fee_Income__c,Policy__r.Deductible_or_Excess_Amount__c,Policy__r.Deductible_or_Excess_Basis__c from Policy_Schedule__c Where Policy__c=:PolId]);
         rcList=new List<Risk_Capture__c >([select id,Policy_Schedule__c,Policy_Schedule__r.Product__c,Name,CurrencyIsoCode,VG_Additional_Information__c,VG_Policy_Details__c,VG_Dispute_Clause__c from Risk_Capture__c where Policy_Schedule__c IN:psMap.keySet()]);      
         psaList=new List<VG_Policy_Schedule_Asset__c>([Select id,Name,VG_Perils__c,VG_Perils_Text__c,VG_Sum_Insured__c,VG_Declared_Value__c,VG_Coverage__c, VG_Limit__c,VG_Territorial_Limits__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN:psMap.keySet()]);
         System.debug('psaList::'+psaList.size());
         pseList=new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Endorsement_Details__c ,VG_Endorsement_Number__c,VG_Title__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c IN:psMap.keySet() AND (VG_Type__c=:'Endorsements' OR VG_Type__c=:'' OR VG_Type__c=:null) ORDER BY VG_Title__c ]);
         
         If(!pseList.IsEmpty()){
             Endorsement=True;             
         }
         psaPerils=new Map<String,Decimal>();
         for(VG_Policy_Schedule_Asset__c psa:psaList){
             If(psa.VG_Sum_Insured__c!=null){            
                 if(psa.VG_Perils__c=='Business Hours' || psa.VG_Perils__c=='Money in Safes'){
                    psaPerils.put(psa.VG_Perils__c,psa.VG_Sum_Insured__c);
                 }
             }else{
                 if(psa.VG_Perils__c=='Business Hours' || psa.VG_Perils__c=='Money in Safes'){
                    psaPerils.put(psa.VG_Perils__c,0);
                 }
             }
             If(psa.VG_Sum_Insured__c!=null){   
                 If(psa.VG_Perils__c== 'Annual Carryings (Security Company)' || psa.VG_Perils__c== 'Annual Carryings (Own Employees)'){
                    psaPerils.put(psa.VG_Perils__c,psa.VG_Sum_Insured__c);
                 }
             }else{
                 If(psa.VG_Perils__c== 'Annual Carryings (Security Company)' || psa.VG_Perils__c== 'Annual Carryings (Own Employees)'){
                    psaPerils.put(psa.VG_Perils__c,0);
                 }
             }
             System.debug('14.2.2019::'+psa.VG_Perils__c+'::'+psaPerils.size());
         }
         psaPerilsAccess=new Map<String,Boolean>();
         psaPerilsAccess.put('Business Hours',false);
         psaPerilsAccess.put('Money in Safes',false);
         psaPerilsAccess.put('Annual Carryings (Own Employees)',false);
         psaPerilsAccess.put('Annual Carryings (Security Company)',false);
         for(VG_Policy_Schedule_Asset__c psa:psaList){
             if(psa.VG_Perils__c=='Business Hours')
                 psaPerilsAccess.put('Business Hours',True);
             if(psa.VG_Perils__c=='Money in Safes')
                 psaPerilsAccess.put('Money in Safes',True);
             if(psa.VG_Perils__c=='Annual Carryings (Own Employees)')
                 psaPerilsAccess.put('Annual Carryings (Own Employees)',True);
             if(psa.VG_Perils__c=='Annual Carryings (Security Company)')
                 psaPerilsAccess.put('Annual Carryings (Security Company)',True);
         }
         for(Policy_Schedule__c ps:psMap.values()){
             If(ps.Gross_Written_Premium__c!=null)
                TotalGwp+=ps.Gross_Written_Premium__c;
             If(ps.IPT__c!=null)
                TotalIpt+=ps.IPT__c;
             If(ps.VG_Fee_Income__c!=null)
                TotalFeeIncome+=ps.VG_Fee_Income__c;
         }
         TotalGwp_Ipt_FIncome=TotalGwp+TotalIpt+TotalFeeIncome;
         System.debug('TotalGwp_Ipt_FIncome::'+TotalGwp_Ipt_FIncome); 
         sumInsured=0;
         string strOrgId = UserInfo.getOrganizationId();
         List< document > MFList = [select Id, name from document where Name='Motor Felt'];
         MF='https://'+ApexPages.currentPage().getHeaders().get('Host')+'/LS/servlet/servlet.ImageServer?id='+MFList[0].Id+'&oid=' + strOrgId;        
         System.debug('image::'+MF+'::'+Logo);
         List< document > documentList1 = [select Id, name from document where Name='VG PI Logo'];
         PILogo = 'https://'+ApexPages.currentPage().getHeaders().get('Host')+'/LS/servlet/servlet.ImageServer?id='+documentList1[0].Id+'&oid=' + strOrgId; 
         System.debug('image::'+MF+'::'+PILogo);
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
        
        for(Policy_Schedule__c ps:psMap.values()){             
             If(ps.Product__c=='Property'){
                 PropertyProduct=True;
                 for(VG_Policy_Schedule_Asset__c psa:psaList){                         
                     If(psa.VG_Coverage__c=='Property Damage'){                 
                         PropertyDamage=True;
                     }else If(psa.VG_Coverage__c=='Specified Items'){
                         sItem=True;
                         If(psa.VG_Perils_Text__c!=null && psa.VG_Perils_Text__c!=''){
                             Periltext=True;
                         }
                     }else If(psa.VG_Coverage__c=='Business Interruption'){
                         BusinessInter=True;
                     }else If(psa.VG_Coverage__c=='Fidelity'){
                         fidility=True;
                     }else If(psa.VG_Coverage__c=='Loss of License'){
                         LossLicence=True;
                     }else If( psa.VG_Coverage__c=='Goods In Transit'){
                         GoodsinTrans=True;
                     }else If(psa.VG_Coverage__c =='Money'){
                         money=True;
                         maxSumInsured=0;
                         List<Decimal> maxSI = new List<Decimal>();
                         for(VG_Policy_Schedule_Asset__c psa1:psaList){ 
                             If(psa1.VG_Perils__c== 'In transit (employees)' || psa1.VG_Perils__c== 'In transit (security co.)'){                                              
                                 if (psa1.VG_Sum_Insured__c != null){
                                    maxSI.add(psa1.VG_Sum_Insured__c);
                                 }                      
                             }                             
                         }
                         If(!maxSI.IsEmpty()){
                             maxSI.sort();
                             maxSumInsured=maxSI[maxSI.size() - 1];
                             System.debug('psa.VG_Sum_Insured__c::'+maxSumInsured);
                         }
                     }             
                 }
             }else If(ps.Product__c=='Liability'){
                 LiabilityProduct=True;
                 for(VG_Policy_Schedule_Asset__c psa:psaList){
                     If(psa.VG_Coverage__c=='Employers Liability'){
                         EmpLiability=True;
                     }else If(psa.VG_Coverage__c=='Public & Product Liability'){
                         PublicandProductLiability=True;
                     }else If(psa.VG_Coverage__c=='Professional Indemnity'){
                         ProfessionalIndemnity=True;
                     }                
                 }
             }else If(ps.Product__c=='D&O'){
                 DOProduct=True;
                 for(VG_Policy_Schedule_Asset__c psa:psaList){
                     If(psa.VG_Coverage__c=='D&O'){
                         DirectorsOfficers=True;
                     }
                 }
             }
            for(Risk_Capture__c rc:rcList){
                If(rc.VG_Additional_Information__c!='' && rc.VG_Additional_Information__c!=null){
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
                    
                    If(rc.Policy_Schedule__r.Product__c=='Property'){
                        System.debug('size::'+sList.size());
                        pdtext= sList[0].trim();
                        BItext= sList[1].trim();
                        LLtext= sList[2].trim();
                        GDtext= sList[3].trim();
                        MAtext= sList[4].trim();
                        FLtext= sList[5].trim();   
                        SCtext= sList[6].trim();
                        PStext= sList[7].trim();
                        AEtext= sList[8].trim();                             
                        If(sList[9].contains('%') && sList[9]!=null && sList[9]!=''){
                           IVtext= sList[9].remove('%').trim();
                        }else{
                           IVtext= sList[9].trim();
                        }
                        sumInsured =(Decimal.valueOf(IVtext))/100;
                        GPtext= sList[11].trim();
                        GRtext= sList[12].trim();
                        ICWtext=sList[13].trim();
                        AICWtext= sList[14].trim();
                        RRtext= sList[15].trim();
                        BDtext= sList[16].trim();                                     
                    }else If(rc.Policy_Schedule__r.Product__c=='Liability'){
                        System.debug('size1::'+sList.size());
                        ELtext=sList[0].trim();
                        PPLtext=sList[1].trim();
                        PItext=sList[2].trim();          
                    }else if(rc.Policy_Schedule__r.Product__c=='D&O'){
                        System.debug('size3::'+sList.size());
                       DOtext=sList[0].trim();
                    }
                }    
            }
        }
    }   
}