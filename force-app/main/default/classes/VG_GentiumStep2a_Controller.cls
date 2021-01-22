Public Class VG_GentiumStep2a_Controller{
    
    public VG_Policy_Schedule_Asset__c psa{get;set;}
    public String Index{get;set;}
    public Integer counter{get;set;}
    public Decimal totalpre{get;set;}
    public Policy_Schedule__c ps{get;set;}
    public String polid{get;set;}
    public String policyCurrency{get;set;}
    public Id PSId {get; set;}
    public Id OriginalId {get; set;}
    public String MTAType {get; set;}
    public Boolean IsCancellation {get; set;}
    public Boolean showError {get; set;}
    public Boolean IsExtension {get; set;}
    public Boolean IsRevision {get; set;}
    public Boolean IsDeclaration {get; set;}
    public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    public List<VG_ReInsurance__c> RIList {get; set;}
    public List<Risk_Capture__c> rcList{get;set;}
    public List<WrapperAsset> waList{get;set;}
    public List<SelectOption> DecTypes {get; set;}
    public List<VG_Policy_Schedule_Asset__c> psaListDup {get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseListDup {get;set;}
    public List<Risk_Capture__c> rcListDup {get;set;}
    public List<VG_ReInsurance__c> RIListDup {get; set;}
    public Policy_Schedule__c originalPS {get; set;}
    public list<SelectOption> coverageOptions {get; set;}
    public VG_GentiumStep2a_Controller(ApexPages.StandardSetController controller) {
        showError=false;
        totalpre=0;
        psaList=new List<VG_Policy_Schedule_Asset__c>();
        polid=apexpages.currentpage().getparameters().get('id');
        PSId = apexpages.currentpage().getparameters().get('PSId');
        policyCurrency = apexpages.currentpage().getparameters().get('policyCurrency');
        OriginalId = apexpages.currentpage().getparameters().get('OriginalId');
        MTAType = apexpages.currentpage().getparameters().get('MTAType');
        DecTypes = new List<SelectOption>();
        DecTypes.add(new SelectOption('--Select--','--Select--'));
        DecTypes.add(new SelectOption('1st Quarter','1st Quarter')); 
        DecTypes.add(new SelectOption('2nd Quarter','2nd Quarter'));
        DecTypes.add(new SelectOption('3rd Quarter','3rd Quarter'));
        DecTypes.add(new SelectOption('4th Quarter','4th Quarter'));
        DecTypes.add(new SelectOption('Half Yearly','Half Yearly'));
        DecTypes.add(new SelectOption('Annual','Annual'));
        Schema.DescribeFieldResult coverageDescription = VG_Policy_Schedule_Asset__c.VG_Coverage__c.getDescribe();

        coverageOptions = new list<SelectOption>();
        
        for(Schema.Picklistentry picklistEntry : coverageDescription.getPicklistValues()){
            coverageOptions.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
        
        if(PSId != null){
            psaList=[select id,Name,VG_Number_of_Vehicles__c,VG_Vehicle_Type__c, VG_Use__c, VG_Coverage__c,VG_Rate_Per_Vehicle__c,VG_Premium__c, VG_Deductible__c,VG_Technical_UW_Rate_Annual__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c=:PSId];
        }
        
        if(MTAType == null){
            System.debug('Constructor if');
            polid=apexpages.currentpage().getparameters().get('id');
            ps=new Policy_Schedule__c();
            ps.Name='Test';
            ps.Policy__c=polid;
            ps.Product__c='Fleet';
            ps.VG_Base_Policy__c = True;
            Policy__c polRec = [Select Id, VG_Inception_Date__c, VG_Expiry_Date__c,CurrencyIsoCode from Policy__c where Id =: polid];
            ps.CurrencyIsoCode=polRec.CurrencyIsoCode;
            ps.Base_Creation_Start_Date__c = polRec.VG_Inception_Date__c;
            ps.Base_Creation_End_Date__c = polRec.VG_Expiry_Date__c;
        }else{
            System.debug('Constructor else');
            psaListDup = new List<VG_Policy_Schedule_Asset__c>();
            pseListDup = new List<VG_Policy_Schedule_Endorsement__c>();
            RIListDup = new List<VG_ReInsurance__c>();
            rcListDup = new List<Risk_Capture__c>();
            if(PSId == null){
                originalPS = [select id,Name, IPT_Percent__c, Levies__c, Policy__c, Premium_Adjustment__c, VG_Declaration_Type__c, VG_Brokerage_Percent__c, Product__c, Policy__r.VG_Expiry_Date__c, Policy__r.VG_Inception_Date__c, MTA_Reason_for_Cancellation__c from Policy_Schedule__c Where Id =:OriginalId];
                polid = originalPS.Policy__c;
                ps=originalPS.clone(false, true, false, false);
                ps.id = null;
                ps.VG_MTA_Type__c = MTAType;
                ps.VG_Is_MTA__c = True;
                
                RIList =new List<VG_ReInsurance__c>([Select Id, VG_Policy_Schedule__c,VG_RI_Currency__c, VG_UMR__c from VG_ReInsurance__c where VG_Policy_Schedule__c =: OriginalId]);
                
                for(VG_ReInsurance__c ri : RIList){
                    VG_ReInsurance__c temp = ri.clone(false, true, false, false);
                    temp.Id = null;
                    RIListDup.add(temp);
                }
                if(MTAType == 'Revision of Cover'){
                    ps.Base_Creation_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    ps.VG_MTA_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                }
                if(MTAType == 'Declaration'){
                    ps.VG_Declaration_Type__c = null;
                    ps.Base_Creation_Start_Date__c = OriginalPS.Policy__r.VG_Inception_Date__c;
                    ps.Base_Creation_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    ps.VG_MTA_Start_Date__c = OriginalPS.Policy__r.VG_Inception_Date__c;
                    ps.VG_MTA_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    
                }
            }else{
                ps = [select id,Name, IPT_Percent__c, Levies__c, VG_MTA_Start_Date__c, VG_Declaration_Type_percent__c , Policy__c, VG_MTA_End_Date__c, VG_Declaration_Type__c, VG_MTA_Cancellation_Date__c, Premium_Adjustment__c, Product__c, Policy__r.VG_Expiry_Date__c, MTA_Reason_for_Cancellation__c from Policy_Schedule__c Where Id =:PSId ];
                polid = ps.Policy__c;
                
            }
            if(MTAType == 'Extension'){
                IsExtension = True;
                IsCancellation = IsRevision = IsDeclaration = False;
            }else if(MTAType == 'Cancellation'){
                IsCancellation = True;
                IsExtension = IsRevision = IsDeclaration = False;
            }else if(MTAType == 'Revision of Cover'){
                IsRevision = True;
                IsCancellation = IsExtension = IsDeclaration = False;
            }else if(MTAType == 'Declaration'){
                IsDeclaration = True;
                IsCancellation = IsRevision = IsExtension = False;
            }
            System.debug('MTAType:'+MTAType);
        }
        waList=new List<WrapperAsset>();
        if(psaList.IsEmpty()){
            if(MTAType != 'Revision of Cover'){
                psa=new VG_Policy_Schedule_Asset__c();
                psaList.add(psa);
            }
        }
        counter=0;
        for(VG_Policy_Schedule_Asset__c tempPS : psaList){
            WrapperAsset wa=new WrapperAsset();
            wa.psa=tempPS;
            wa.Counter=String.valueOf(counter);
            waList.add(wa);
            counter++;
        }
        System.debug('waList::'+waList.size()+'::'+waList);  
        //Code added by siddik on 26.2.2018 
        if(!waList.IsEmpty()){
            totalpre=0;
            for(WrapperAsset wa:waList){
                if(wa.psa.VG_Technical_UW_Rate_Annual__c !=null && wa.psa.VG_Rate_Per_Vehicle__c !=null  && wa.psa.VG_Coverage__c !=null){
                    wa.techPremium=(wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                    totalpre=totalpre+wa.psa.VG_Premium__c;
                }
            }
        }
        //Code added finished  on 26.2.2018
    }
    
    
    public void RemoveAsset(){
        waList.remove(integer.valueOf(Index));
        counter=0;
        System.debug('waList::'+waList.size()+'::'+waList);
        totalpre=0;
        for(WrapperAsset wa:waList){
            wa.Counter=String.valueOf(counter);
            counter++;
            if(wa.psa.VG_Technical_UW_Rate_Annual__c !=null && wa.psa.VG_Rate_Per_Vehicle__c !=null  && wa.psa.VG_Coverage__c !=null){
                System.debug('if::');
                wa.psa.VG_Premium__c=wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Rate_Per_Vehicle__c;
                wa.techPremium=(wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                totalpre=totalpre+wa.psa.VG_Premium__c;
            }
        }
        System.debug('totalpre::'+totalpre);
        System.debug('waList::'+waList.size()+'::'+waList);
    }
    
    public void addAsset(){
        Boolean allOkToTaddNewAsset = True;
        WrapperAsset waNew=new WrapperAsset();
        waNew.Counter=string.valueOf(counter);
        totalpre=0;
        for(WrapperAsset temp : waList){
            System.debug('Rate::'+temp.psa.VG_Rate_Per_Vehicle__c +':No.of:'+temp.psa.VG_Number_of_Vehicles__c+':coverage:'+temp.psa.VG_Coverage__c+':type:'+temp.psa.VG_Vehicle_Type__c);
            if(temp.psa.VG_Technical_UW_Rate_Annual__c !=null && temp.psa.VG_Rate_Per_Vehicle__c !=null && temp.psa.VG_Number_of_Vehicles__c !=null && temp.psa.VG_Coverage__c !=null && temp.psa.VG_Vehicle_Type__c != null && temp.psa.VG_Use__c !=null){
                System.debug('if::');
                temp.psa.VG_Premium__c=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Rate_Per_Vehicle__c).setScale(2);
                temp.techPremium=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                totalpre=totalpre+temp.psa.VG_Premium__c;
                
            }else{
                System.debug('else::');
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the Number,Use, Rate, Technical Rate  and Coverage for all vehicles before adding a new asset..'));    
                allOkToTaddNewAsset = False;     
                
            }
        }
        System.debug('totalpre::'+totalpre);
        if(allOkToTaddNewAsset){
            VG_Policy_Schedule_Asset__c psaNew=new VG_Policy_Schedule_Asset__c();
            waNew.psa=psaNew;
            waList.add(waNew);
            counter++;
        }
        System.debug('waList::'+waList.size()+'::'+waList);
    }
    
    
    public PageReference Cancel(){
        List<Policy_Schedule__c> ps =[select id,Name from Policy_Schedule__c where id=:PSId];
        List<VG_Policy_Schedule_Asset__c> psaList=[select id,Name,VG_Number_of_Vehicles__c,VG_Vehicle_Type__c,VG_Coverage__c,VG_Rate_Per_Vehicle__c,VG_Premium__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c=:PSId];
        List<VG_Policy_Schedule_Endorsement__c> pseList=new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Title__c,VG_Premium__c,VG_Endorsement_Details__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c=:PSId]);
        List<Risk_Capture__c> rcList=new List<Risk_Capture__c>([select Id,Name,Drivers_Name__c,Drivers_DOB__c,Drivers_Convictions__c,Drivers_Conviction_Points__c,Drivers_License_Ban_Details__c,Drivers_Claims__c,Drivers_Medical_Conditions__c from Risk_Capture__c where Policy_Schedule__c=:PSId]);
        if(!psaList.IsEmpty()){
            Delete psaList;
        }
        if(!pseList.IsEmpty()){
            Delete pseList;
        }
        if(!rcList.IsEmpty()){
            Delete rcList;
        }
        if(ps!=null){
            Delete ps;
        }
        return new PageReference('/'+polid);
    }
    
    public void updateDeclarationRate(){
        Declaration_Rates__c decRates = Declaration_Rates__c.getInstance('Edison_Motor');
        if(ps.VG_Declaration_Type__c != '--Select--'){
            if(ps.VG_Declaration_Type__c == '1st Quarter'){
                ps.VG_Declaration_Type_percent__c = decRates.Q1_Declaration_Rate__c;
            }else if(ps.VG_Declaration_Type__c == '2nd Quarter'){
                ps.VG_Declaration_Type_percent__c = decRates.Q2_Declaration_Rate__c;
            }else if(ps.VG_Declaration_Type__c == '3rd Quarter'){
                ps.VG_Declaration_Type_percent__c = decRates.Q3_Declaration_Rate__c;
            }else if(ps.VG_Declaration_Type__c == '4th Quarter'){
                ps.VG_Declaration_Type_percent__c = decRates.Q4_Declaration_Rate__c;
            }else if(ps.VG_Declaration_Type__c == 'Annual'){
                ps.VG_Declaration_Type_percent__c = decRates.Annual_Declaration_Rate__c;
            }else if(ps.VG_Declaration_Type__c == 'Half Yearly'){
                ps.VG_Declaration_Type_percent__c = decRates.Half_Yearly_Declaration_Rate__c;
            }  
        }
        System.Debug(ps.VG_Declaration_Type_percent__c);
    }
    public PageReference Previous(){
        if(psid != null){
            Policy_Schedule__c ps =[select id,Name from Policy_Schedule__c where id=:psid];
            List<VG_Policy_Schedule_Asset__c> psaList=[select id,Name,VG_Number_of_Vehicles__c,VG_Vehicle_Type__c,VG_Coverage__c,VG_Rate_Per_Vehicle__c,VG_Premium__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c=:psid];
            List<VG_Policy_Schedule_Endorsement__c> pseList=new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Title__c,VG_Premium__c,VG_Endorsement_Details__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c=:psid]);
            List<Risk_Capture__c> rcList=new List<Risk_Capture__c>([select Id,Name,Drivers_Name__c,Drivers_DOB__c,Drivers_Convictions__c,Drivers_Conviction_Points__c,Drivers_License_Ban_Details__c,Drivers_Claims__c,Drivers_Medical_Conditions__c from Risk_Capture__c where Policy_Schedule__c=:psid]);
            List<VG_ReInsurance__c> riList=new List<VG_ReInsurance__c>([select Id from VG_ReInsurance__c where VG_Policy_Schedule__c=:psid]);
            if(!psaList.IsEmpty()){
                Delete psaList;
            }
            if(!pseList.IsEmpty()){
                Delete pseList;
            }
            if(!rcList.IsEmpty()){
                Delete rcList;
            }
            if(!riList.IsEmpty()){
                Delete riList;
            }
            delete ps;
        }
        return new PageReference('/apex/VG_Gentium_Step1?id='+polid+'&policyCurrency='+policyCurrency);
    }
    public PageReference Next(){
        // Code Added By siddik on 22.2.2018
        if(MTAType == 'Revision of Cover' && ps.Product__c == null ){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Product..'));   
            showError=true; 
            return null;  
        }
        //code added end 22.2.2018
        if(waList.IsEmpty()&&MTAType != 'Revision of Cover'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please add atleast one asset to the policy schedule..'));    
            return null;  
        }else{
            Boolean allOkToTaddNewAsset = True;
            psaList = new List<VG_Policy_Schedule_Asset__c >();
            for(WrapperAsset temp : waList){
                psaList.add(temp.psa);
                System.debug('25.4::'+temp.psa.Name+':'+temp.psa.VG_Technical_UW_Rate_Annual__c+':'+temp.psa.VG_Rate_Per_Vehicle__c+':'+temp.psa.VG_Coverage__c+':'+temp.psa.VG_Number_of_Vehicles__c+':'+temp.psa.VG_Vehicle_Type__c+':'+temp.psa.VG_Use__c);
                if(temp.psa.VG_Technical_UW_Rate_Annual__c !=null && temp.psa.VG_Rate_Per_Vehicle__c !=null && temp.psa.VG_Number_of_Vehicles__c !=null && temp.psa.VG_Coverage__c !=null && temp.psa.VG_Vehicle_Type__c != null && temp.psa.VG_Use__c !=null){
                    System.debug('if::');
                    temp.psa.VG_Premium__c=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Rate_Per_Vehicle__c).setScale(2);
                    temp.psa.CurrencyIsoCode=policyCurrency;
                    temp.techPremium=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                    temp.psa.Technical_UW_Premium__c=temp.techPremium;
                }else{
                    System.debug('else::');
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the Number,Use, Rate, Technical Rate and Coverage for all vehicles before adding a new asset..'));    
                    allOkToTaddNewAsset = False;   
                    return null;  
                }
            }
            if(PSId == null){
                Policy__c pol=[select id,Name from Policy__c where id=:polid];
                List<Policy_Schedule__c> psList2=new List<Policy_Schedule__c>([SELECT Id,Name,Policy__c FROM Policy_Schedule__c WHERE Policy__c=:polid ORDER BY CreatedDate DESC]);        
                String tmp;
                if(psList2.size()>0){
                    String psName=psList2[0].Name;
                    String[] tempDetail=psName.split('/PS/');
                    tmp=tempDetail[1];
                    ps.Name=pol.Name+'/PS/'+(Integer.valueOf(tmp)+1);
                }else{
                    tmp='0';
                    ps.Name=pol.Name+'/PS/'+(Integer.valueOf(tmp));
                } 
                if(MTAType != null && MTAType == 'Revision of Cover'){
                    ps.Base_Creation_Start_Date__c = ps.VG_MTA_Start_Date__c;
                    ps.VG_Base_Policy__c = True;
                    ps.VG_Is_MTA__c = True;
                    ps.VG_MTA_Type__c = 'Revision of Cover';
                }
                if(MTAType != null && MTAType == 'Declaration'){
                    ps.VG_Base_Policy__c = True;
                    ps.VG_Is_MTA__c = True;
                    ps.VG_MTA_Type__c = 'Declaration';
                    if(ps.VG_Declaration_Type__c == null || ps.VG_Declaration_Type__c=='--Select--'){
                        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Declaration Type..'));   
                        showError=true;
                        return null;  
                    }
                }
                if(MTAType != null && ps.VG_MTA_Start_Date__c ==null){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select MTA Start Date..'));    
                    showError=true;   
                    return null;
                }
                // Code Added By siddik on 19.2.2018
                System.debug('Test::'+ps.VG_MTA_Start_Date__c+ps.VG_MTA_End_Date__c);
                if(MTAType != null && ps.VG_MTA_Start_Date__c>(ps.VG_MTA_End_Date__c+1)){
                    Date d=ps.VG_MTA_End_Date__c;
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'MTA Start Date Must Come before  '+d.format()));    
                    showError=true;   
                    return null;
                }
                //code added end 19.2.2018
                if(MTAType == null && ps.Product__c == null){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Product..'));    
                    showError=true;   
                    return null;  
                }else{
                    ps.Product__c='Fleet';
                    ps.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();       
                    upsert ps;
                    System.debug('ps::'+ps+ps.Product__c);
                    PSId = ps.Id;
                }
                
            }else{
                if(MTAType == null && ps.Product__c == null ){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Product..'));    
                    showError=true;   
                    return null;  
                }
            }
            Integer count=0;
            for(VG_Policy_Schedule_Asset__c psa:psaList){
                count=count+1;
                psa.VG_Policy_Schedule__c=PSId;
                if(psa.VG_Number_of_Vehicles__c!=null && psa.VG_Rate_Per_Vehicle__c !=null){
                    psa.VG_Premium__c=psa.VG_Number_of_Vehicles__c*psa.VG_Rate_Per_Vehicle__c;
                }
                psa.CurrencyIsoCode=policyCurrency;
                psa.RecordTypeId=Schema.SObjectType.VG_Policy_Schedule_Asset__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();           
                psa.Name=ps.Name+'/RR/'+count;
            }
            Upsert psaList;
            if(MTAType == null){
                return new PageReference('/apex/VG_Gentium_Step3?policyid='+polid+'&id='+PSId);
            }else{
                for(VG_ReInsurance__c ri : RIListDup){
                    ri.VG_Policy_Schedule__c = PSId;
                }
                Upsert RIListDup;
                return new PageReference('/apex/VG_VG_Gentium_Step3?MTAType='+MTAType+'&OriginalId='+OriginalId+'&id='+ps.id+'&policyid='+polid);
            }
        }
    }  
    
    
    public class WrapperAsset{
        public VG_Policy_Schedule_Asset__c psa{get;set;}
        public String Counter{get;set;}
        public Decimal techPremium{get;set;}
    }
}