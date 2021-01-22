// In PSA Use also required by siddik on 26.2.2018
Public without sharing Class VG_PolicyScheduleEdit1_Controller{
    
    public VG_Policy_Schedule_Asset__c psa{get;set;}
    public String Index{get;set;}
    public Integer counter{get;set;}
    public Integer counterRisk{get;set;}
    public Policy_Schedule__c ps{get;set;}
    public String fileName {get;set;}
    public string nameFile{get;set;}
    public String[] filelines  =  new String[]{};
    public String polid{get;set;}
    public Decimal totalpre{get;set;}
    public Id oldpolicyId{get;set;}
    public Id renewpolicyid{get;set;}
    public Boolean IsRenewal {get; set;}
    public string CapacityPaper{get;set;}
    public String Product_seleced{get;set;}
    public integer rrCount{get;set;}
    
    public Blob fileBody {get;set;}
    public Id PSId {get; set;}
    public Decimal TechUWPre{get;set;}
    public Decimal OldAR{get;set;}
    public Decimal OldTotalAR{get;set;}
    public Decimal OldTotalPremium{get;set;}
    public Decimal NewTotalPremium{get;set;}
    public Id OriginalId {get; set;}
    public String MTAType {get; set;}
    public Boolean uploadAsset{get;set;}
    public Boolean DMLAlert{get;set;}
    public Boolean pmsg {get; set;}
    public Boolean IsCancellation {get; set;}
    public Boolean showError {get; set;}
    public Boolean IsExtension {get; set;}
    public Boolean IsRevision {get; set;}
    public Boolean IsDeclaration {get; set;}
    public Boolean skipSplit {get; set;}
   
    public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    public List<VG_ReInsurance__c> RIList {get; set;}
    public List<Risk_Capture__c> rcList{get;set;}
    public List<WrapperAsset> waList{get;set;}
    public List<VG_Policy_Schedule_Asset__c> PSAtoBeDeleted{get;set;}
    public List<SelectOption> DecTypes {get; set;}
    public List<VG_Policy_Schedule_Asset__c> psaListDup {get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseListDup {get;set;}
    public List<Risk_Capture__c> rcListDup {get;set;}
    public List<VG_ReInsurance__c> RIListDup {get; set;}
    public Policy_Schedule__c originalPS {get; set;}
    public list<SelectOption> coverageOptions {get; set;}
    public List<VG_Policy_Schedule_Asset__c> deletedPSAList {get;set;}
    Public List<WrapperRisk> wrcList{get;set;}
    Public Risk_Capture__c rc{get;set;}
    public List<Endorsement_Library__c> ElList {get; set;}
    public List<LibraryWrapper> LibraryWrapperList {get; set;}
    public String PSName {get; set;}
    public Id policyid {get; set;}
    public Boolean hasEndorsements {get; set;}
    public Integer counterEnd {get; set;}
    public Set<Id> existingEndSet {get; set;}
    public Set<Id> oldTAR {get; set;}
    public decimal riskPremium{get;set;}
    public decimal TUWPremium {get;set;}
    public decimal endPremium {get;set;}
    public decimal riskPremiumPro {get;set;}
    public decimal techModelPremium{get;set;}
    public decimal netModelPremium{get;set;}
    public decimal grossWrittenPremium{get;set;}
    public decimal endPremiumPro {get;set;}
    public decimal actPremium{get;set;}
    public decimal brokerageAmount{get;set;}
    public decimal transactPremium {get;set;}
    public decimal technicalPremium {get;set;}
    public Decimal RateChange {get;set;}
    public Boolean hasAssets {get; set;}    
    public Boolean hasRCs {get; set;}
    public String COB {get;set;}
    public Map<Id,VG_Policy_Schedule_Endorsement__c> pseMap{get;set;}
    public List<VG_Policy_Schedule_Asset__c> ULRPSAtoBeDeleted {get;set;}
    public list<SelectOption> NonEEAVolanteEntity_Select {get; set;}
    Public List<SelectOption> splitTypes{get; set;}   
    
    public VG_PolicyScheduleEdit1_Controller(ApexPages.StandardController controller) {
        
        PSId = apexpages.currentpage().getparameters().get('PSId');
        oldpolicyId = apexpages.currentpage().getparameters().get('oldpolicyId');
        renewpolicyid = apexpages.currentpage().getparameters().get('renewpolicyid');
        OriginalId = apexpages.currentpage().getparameters().get('OriginalId');
        MTAType = apexpages.currentpage().getparameters().get('MTAType');
        
        showError = DMLAlert = false;
        rrCount = 0;
       
        totalpre = TechUWPre = OldTotalPremium = NewTotalPremium  = 0;
        
        
        psaList = new List<VG_Policy_Schedule_Asset__c>();
       
        deletedPSAList = new List<VG_Policy_Schedule_Asset__c>();
        wrcList = new List<WrapperRisk>();  
        waList = new List<WrapperAsset>(); 
        LibraryWrapperList = new List<LibraryWrapper>();
        PSAtoBeDeleted  =  new List<VG_Policy_Schedule_Asset__c>();
        ULRPSAtoBeDeleted =  new List<VG_Policy_Schedule_Asset__c>();
        coverageOptions = new list<SelectOption>();
        
        existingEndSet = new Set<Id>();
        oldTAR = new Set<Id>();
        fileBody = blob.valueOf('');
        
        LibraryWrapper LW;
        rc = new Risk_Capture__c();          
        
        DecTypes = new List<SelectOption>();
        DecTypes.add(new SelectOption('--Select--','--Select--'));
        DecTypes.add(new SelectOption('1st Quarter','1st Quarter'));
        DecTypes.add(new SelectOption('2nd Quarter','2nd Quarter'));
        DecTypes.add(new SelectOption('3rd Quarter','3rd Quarter'));
        DecTypes.add(new SelectOption('4th Quarter','4th Quarter'));
        DecTypes.add(new SelectOption('Annual','Annual'));
        NonEEAVolanteEntity_Select = new List<SelectOption>();
        for(String s : Label.Edison_NonEEAVolanteEntity.split(';')){
            NonEEAVolanteEntity_Select.add(new SelectOption(s,s));
        }
        Schema.DescribeFieldResult coverageDescription = VG_Policy_Schedule_Asset__c.VG_Coverage__c.getDescribe();
        Id EdisonLibraryId =  Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        for(Schema.Picklistentry picklistEntry : coverageDescription.getPicklistValues()){
            coverageOptions.add(new SelectOption(pickListEntry.getValue(),pickListEntry.getLabel()));
        }
        if(PSId != null){
            psaList=[select id,Name,VG_Number_of_Vehicles__c,VG_Policy_Schedule__r.VG_Capacity_Paper__c,VG_Rate_change__c,VG_Model_Rate__c,VG_Vehicle_Type__c, VG_IsTemp__c, VG_IsTempDelete__c, VG_Use__c, VG_Sum_Insured__c ,VG_Coverage__c, VG_Rate_Per_Vehicle__c,VG_Premium__c, VG_Deductible__c,VG_Technical_UW_Rate_Annual__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =: PSId];
            rrCount=psaList.size();
           
            
            if(!psaList.IsEmpty()){
                totalpre = 0;
                counter = 0;
                for(VG_Policy_Schedule_Asset__c psa:psaList){
                    totalpre = totalpre + psa.VG_Premium__c;
                    /*if(renewpolicyid != null){
                        OldTotalPremium  =  OldTotalPremium  + psa.VG_Premium__c;
                        oldTAR.add(psa.id);
                    }*/
                    WrapperAsset wa=new WrapperAsset();
                    wa.psa = psa;
                    if(psa.VG_Policy_Schedule__r.VG_Capacity_Paper__c != 'ULR')
                        wa.techPremium = ((wa.psa.VG_Number_of_Vehicles__c!=null?wa.psa.VG_Number_of_Vehicles__c:0)*(wa.psa.VG_Technical_UW_Rate_Annual__c!=null?wa.psa.VG_Technical_UW_Rate_Annual__c:0)).setScale(2); 
                    wa.Counter=String.valueOf(counter);
                    System.debug(wa.psa.id);
                    System.debug(totalpre);
                    waList.add(wa);
                    counter++;
                }
            }
                system.debug('list::'+waList.size());
            
            PSName = [Select Id, Name,Product__c,VG_Capacity_Paper__c from Policy_Schedule__c where Id =: PSId].Name;
        }else{
            rcList=new List<Risk_Capture__c>();
            pseList=new List<VG_Policy_Schedule_Endorsement__c>();
        }
        System.debug('Test');
        System.debug(waList); 
        //System.debug(OldTotalPremium);
        if(MTAType == null){
            System.debug('Constructor if');
            polid=apexpages.currentpage().getparameters().get('id');
            ps = [select id,Name,VG_Volante_Entities__c,VG_Entity_Split_Required__c,Split_Type__c,Policy__r.Line_Of_Business__c,VG_MTA_Start_Date__c ,VG_MTA_End_Date__c ,VG_MTA_Type__c,VG_Declaration_Type_percent__c,Policy__r.VG_Is_Renewal__c,VG_Rate_Change__c,VG_Capacity_Paper__c,Policy__r.VG_Renewal_Policy_Id__c,IPT_Percent__c,VG_Gross_Written_Premium_100__c,Gross_Written_Premium__c,Levies__c, Policy__c, Premium_Adjustment__c, VG_IsTempDelete__c, VG_Is_MTA__c, VG_IsTemp__c, VG_Declaration_Type__c, VG_Brokerage_Percent__c, VG_Technical_Model_Premium__c, Base_Creation_End_Date__c, Base_Creation_Start_Date__c, VG_Fee_Income__c , Product__c, Policy__r.VG_Expiry_Date__c, Policy__r.VG_Inception_Date__c,VG_VAT__c,VG_VAT_Amount__c, VG_Adjustment_Reason__c , MTA_Reason_for_Cancellation__c from Policy_Schedule__c Where Id =:PSId];
            COB = ps.Policy__r.Line_Of_Business__c;
            rc=new Risk_Capture__c();       
            psaList = [select id, Name, VG_Number_of_Vehicles__c, VG_Rate_change__c, VG_Sum_Insured__c , VG_Model_Rate__c, Technical_UW_Premium__c, VG_Vehicle_Type__c, VG_Coverage__c, VG_IsTempDelete__c, VG_IsTemp__c, VG_Use__c,  VG_Rate_Per_Vehicle__c, VG_Premium__c,  VG_Deductible__c, VG_Technical_UW_Rate_Annual__c   from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c = :PSId];
            If(ps.Policy__r.VG_Is_Renewal__c == True){
                psaList = [select id, Name, VG_Sum_Insured__c , VG_Rate_change__c, VG_Model_Rate__c, VG_Number_of_Vehicles__c, Technical_UW_Premium__c, VG_Vehicle_Type__c, VG_Coverage__c, VG_IsTempDelete__c, VG_IsTemp__c, VG_Use__c,  VG_Rate_Per_Vehicle__c, VG_Premium__c,  VG_Deductible__c, VG_Technical_UW_Rate_Annual__c   from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c = :PSId ORDER BY VG_Number_of_Vehicles__c ASC];           
            }     
            pseMap = new Map<Id,VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Title__c,VG_IsTempDelete__c,VG_IsTemp__c,VG_Premium__c,VG_Endorsement_Details__c,VG_Endorsement_Library_Id__c,VG_Endorsement_Number__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c=:PSId]);
            pseList = new List<VG_Policy_Schedule_Endorsement__c>();
            pseList = pseMap.values();
            rcList = new List<Risk_Capture__c>([select Id,Name,Drivers_Name__c,Drivers_DOB__c,VG_IsTempDelete__c,VG_IsTemp__c,Drivers_Convictions__c,Drivers_Conviction_Points__c,Drivers_License_Ban_Details__c,Drivers_Claims__c,Drivers_Medical_Conditions__c,Policy_Schedule__c from Risk_Capture__c where Policy_Schedule__c=:PSId]);
            splitTypes = new List<SelectOption>();
            skipSplit = False;
            if(ps.Policy__r.VG_Inception_Date__c.year() <= 2020){
                splitTypes.add(new SelectOption('','--None--'));
                skipSplit = True;
            }
            splitTypes.add(new SelectOption('Non EEA','Non EEA'));
            if(ps.VG_Fee_Income__c > 0){
                VAT_Setting__mdt [] vs = [SELECT VG_VAT__c FROM VAT_Setting__mdt];
                ps.VG_VAT__c = vs[0].VG_VAT__c;
                ps.VG_VAT_Amount__c = (ps.VG_VAT__c / 100) * ps.VG_Fee_Income__c;    
            }else{
                ps.VG_VAT__c=0;
                ps.VG_VAT_Amount__c=0;
            }
            if(!rcList.IsEmpty()){
                counterRisk=0;
                for(Risk_Capture__c rc : rcList){
                    WrapperRisk wrc=new WrapperRisk();
                    wrc.rc = rc;
                    wrc.Counter = String.valueOf(counterRisk);
                    wrcList.add(wrc);
                    counterRisk++;
                }
            }else{
                counterRisk=0;
            }
            if(pseList.IsEmpty()){
                hasEndorsements = False;
                counterEnd = 0;
                pseList=new List<VG_Policy_Schedule_Endorsement__c>();
            }else{
                hasEndorsements = True;
                counterEnd = pseList.size();
            }
            for(VG_Policy_Schedule_Endorsement__c Endsmt: pseList){
                Id endId = Endsmt.VG_Endorsement_Library_Id__c;
                existingEndSet.add(endId);            
            }
            System.debug('Library Id:'+existingEndSet);
            ElList = [Select Id,Text__c, Name, Endorsement_Title__c from Endorsement_Library__c where RecordTypeId =: EdisonLibraryId ORDER By Name ASC];
            for(Endorsement_Library__c EL : ElList){
                LW = new LibraryWrapper();
                LW.EL = EL;
                if(existingEndSet.contains(EL.Id)){
                    LW.isSelected = True;
                }else{
                    LW.isSelected = False;
                }
                LW.premium = 0;
                LibraryWrapperList.add(LW);
            }
            Product_seleced=ps.Product__c;
            CapacityPaper = ps.VG_Capacity_Paper__c;
            RateChange = ps.VG_Rate_Change__c;
            System.debug('Ratechange::'+RateChange+ps.VG_Rate_Change__c);
            ps.Base_Creation_Start_Date__c = ps.Policy__r.VG_Inception_Date__c;
            ps.Base_Creation_End_Date__c = ps.Policy__r.VG_Expiry_Date__c;
            updateCalc();
        }else{
            System.debug('Constructor else');
            psaListDup = new List<VG_Policy_Schedule_Asset__c>();
            pseListDup = new List<VG_Policy_Schedule_Endorsement__c>();
            RIListDup = new List<VG_ReInsurance__c>();
            rcListDup = new List<Risk_Capture__c>();
            if(PSId == null){
                originalPS = [select id,Name,VG_MTA_Type__c,VG_Declaration_Type_percent__c,VG_Capacity_Paper__c,VG_Rate_Change__c,Gross_Written_Premium__c,VG_Gross_Written_Premium_100__c,IPT_Percent__c,VG_VAT__c,VG_VAT_Amount__c, Levies__c, Policy__c, Premium_Adjustment__c, VG_Technical_Model_Premium__c, VG_Declaration_Type__c, VG_Brokerage_Percent__c, Product__c, Policy__r.VG_Expiry_Date__c, Policy__r.VG_Inception_Date__c, MTA_Reason_for_Cancellation__c,Base_Creation_End_Date__c,Base_Creation_Start_Date__c from Policy_Schedule__c Where Id =:OriginalId];
                polid = originalPS.Policy__c;
                ps = originalPS.clone(false, true, false, false);
                ps.id = null;
                ps.VG_MTA_Type__c = MTAType;
                ps.VG_Is_MTA__c = True;
                Product_seleced = originalPS.Product__c;
                RateChange = originalPS.VG_Rate_Change__c;
                if(ps.VG_Fee_Income__c>0){
                    VAT_Setting__mdt [] vs = [SELECT VG_VAT__c FROM VAT_Setting__mdt];
                    ps.VG_VAT__c=vs[0].VG_VAT__c;
                    ps.VG_VAT_Amount__c=(ps.VG_VAT__c/100)*ps.VG_Fee_Income__c;    
                }else{
                    ps.VG_VAT__c=0;
                    ps.VG_VAT_Amount__c=0;
                }
                RIList =new List<VG_ReInsurance__c>([Select Id, VG_Policy_Schedule__c,VG_RI_Currency__c, VG_UMR__c from VG_ReInsurance__c where VG_Policy_Schedule__c =: OriginalId]);
                
                for(VG_ReInsurance__c ri : RIList){
                    VG_ReInsurance__c temp = ri.clone(false, true, false, false);
                    temp.Id = null;
                    RIListDup.add(temp);
                }
                if(MTAType == 'Revision of Cover'){
                    ps.Base_Creation_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    ps.VG_MTA_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    System.debug('25.4::'+ps.Base_Creation_End_Date__c+'::'+ps.Base_Creation_Start_Date__c);
                    updateCalc();
                }
                if(MTAType == 'Declaration'){
                    ps.VG_Declaration_Type__c = null;
                    ps.Base_Creation_Start_Date__c = OriginalPS.Policy__r.VG_Inception_Date__c;
                    ps.Base_Creation_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    ps.VG_MTA_Start_Date__c = OriginalPS.Policy__r.VG_Inception_Date__c;
                    ps.VG_MTA_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    updateCalc();
                }
            }else{
                ps = [select id,Name,VG_MTA_Type__c,Gross_Written_Premium__c,VG_Capacity_Paper__c,VG_Gross_Written_Premium_100__c,VG_Fee_Income__c, IPT_Percent__c, Levies__c,VG_VAT__c,VG_VAT_Amount__c, VG_MTA_Start_Date__c, VG_Declaration_Type_percent__c , VG_Is_MTA__c, VG_Technical_Model_Premium__c, Policy__c, VG_MTA_End_Date__c, VG_Declaration_Type__c, VG_MTA_Cancellation_Date__c, Premium_Adjustment__c, Product__c, Policy__r.VG_Expiry_Date__c, MTA_Reason_for_Cancellation__c from Policy_Schedule__c Where Id =:PSId ];
                polid = ps.Policy__c;
                Product_seleced=ps.Product__c;
                CapacityPaper = ps.VG_Capacity_Paper__c;
                if(ps.VG_Fee_Income__c>0){
                    VAT_Setting__mdt [] vs = [SELECT VG_VAT__c FROM VAT_Setting__mdt];
                    ps.VG_VAT__c=vs[0].VG_VAT__c;
                    ps.VG_VAT_Amount__c=(ps.VG_VAT__c/100)*ps.VG_Fee_Income__c;    
                }else{
                    ps.VG_VAT__c=0;
                    ps.VG_VAT_Amount__c=0;
                }
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
        
        if(psaList.IsEmpty()){
            psa=new VG_Policy_Schedule_Asset__c();
            psaList.add(psa);
        }
        
        System.debug('waList::'+waList.size()+'::'+waList);  
        //Added By siddik on 22.2.2018
        for(WrapperAsset wa : waList){
            if(wa.psa.VG_Technical_UW_Rate_Annual__c !=null &&  wa.psa.VG_Rate_Per_Vehicle__c !=null){
                wa.techPremium=(wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                TechUWPre=TechUWPre+wa.techPremium;
            }
        }
        //End Code Adding By siddik on 22.2.2018
        System.debug('Test');
        System.debug(waList); 
        //System.debug(OldTotalPremium);
    }
        
    public void uploadAsset(){
        uploadAsset = true;
    }
    public PageReference processuploadAsset(){
        totalpre=0;
        try{ 
            DMLAlert = false;
            if(fileBody !=  blob.valueOf('')){
                for(WrapperAsset wa : waList){
                    PSAtoBeDeleted.add(wa.psa);
                }
                waList.clear();
                DMLAlert = True;               
            }
            if(DMLAlert){
                //nameFile = PaymentDetailsController.decode(fileBody, 'ISO-8859-1'); //fileBody.toString();
                WrapperAsset wa;
                
                filelines  =  Utilities.decode(fileBody,'ISO-8859-1');//nameFile.split('\n'); 
                fileBody = blob.valueOf('');
                
                for (Integer i = 1;i<filelines.size();i++){
                    String[] inputvalues  =  new String[]{};
                        String[] headervalues  =  new String[]{};
                            wa = new WrapperAsset();
                    headervalues  =  filelines[0].split(',');
                    
                    inputvalues  =  filelines[i].split(',');              
                    if(!('No. of Vehicles'== headervalues[0].trim() &&'Type'== headervalues[1].trim() &&'Coverage'== headervalues[2].trim() &&'Use'== headervalues[3].trim() &&'Deductible'== headervalues[4].trim() &&'Tech UW Rate'== headervalues[5].trim() &&  'Actual Rate'== headervalues[6].trim()  && 'Model Rate'== headervalues[7].trim() && 'Rate change'== headervalues[8].trim() )){
                        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'file header mis match please check the file.'));
                        return null;
                    }
                    
                    
                     system.debug(inputvalues[0].trim());
                if(inputvalues[0].trim() != null && inputvalues[0].trim() !='' ){
                    wa.psa.VG_Number_of_Vehicles__c = integer.valueOf(inputvalues[0].trim());
                }else{
                    wa.psa.VG_Number_of_Vehicles__c = 0;
                }
                system.debug(inputvalues[0].trim()); 
                if(inputvalues[1].trim() != null && inputvalues[1].trim() !='' )
                    wa.psa.VG_Vehicle_Type__c = inputvalues[1].trim();
                else
                    wa.psa.VG_Vehicle_Type__c ='--None--';
                
                if(inputvalues[2].trim() != null && inputvalues[2].trim() !='' )
                    wa.psa.VG_Coverage__c = inputvalues[2].trim();
                else
                    wa.psa.VG_Coverage__c='--None--';
                
                if(inputvalues[3].trim() != null && inputvalues[3].trim() !='' )
                    wa.psa.VG_Use__c = inputvalues[3].trim();
                else
                    wa.psa.VG_Use__c ='--None--';
                
                if(inputvalues[4].trim() != null && inputvalues[4].trim() !='' )
                    wa.psa.VG_Deductible__c= Decimal.valueOf(inputvalues[4].trim());
                else
                    wa.psa.VG_Deductible__c= 0;
                
                if(inputvalues[5].trim() != null && inputvalues[5].trim() !='' )
                    wa.psa.VG_Technical_UW_Rate_Annual__c= Decimal.valueOf(inputvalues[5].trim().remove('"'));  
                else
                    wa.psa.VG_Technical_UW_Rate_Annual__c= 0;   
                
                
                if(inputvalues[6].trim() != null && inputvalues[6].trim() !='' )
                    wa.psa.VG_Rate_Per_Vehicle__c= Decimal.valueOf(inputvalues[6].trim().remove('%').remove('"'));
                else
                    wa.psa.VG_Rate_Per_Vehicle__c= 0;
                if(inputvalues[7].trim() != null && inputvalues[7].trim() !='' )
                    wa.psa.VG_Model_Rate__c= Decimal.valueOf(inputvalues[7].trim().remove('%').remove('"'));
                else
                    wa.psa.VG_Model_Rate__c= 0;
                
                
                if(inputvalues[8].trim() != null && inputvalues[8].trim() !='')
                    wa.psa.VG_Rate_change__c= Decimal.valueOf(inputvalues[8].trim().remove('%').remove('"'));
                  
                    
                    wa.counter = String.valueOf(i-1);
                    waList.add(wa);
                }
            } 
            DMLAlert = True;   
        }catch(Exception e){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Error ::'+e));
            system.debug(e);
            return null;
        }
        
        uploadAsset = false;
        RRCalc();
        return null;
    }
    
    public void doneuploadAsset(){
        uploadAsset = false;               
    }
    
    public void RemoveUploadAsset(){
        counter=0;
        System.debug('waList::'+waList.size()+'::'+waList);
        totalpre=0;
        for(WrapperAsset wa:waList){
            wa.Counter=String.valueOf(counter);            
            if(counter== integer.valueOf(Index)){
                wa.psa.VG_IsTempDelete__c = True;
            }
            counter++;
            if(!wa.psa.VG_IsTempDelete__c && (wa.psa.VG_Technical_UW_Rate_Annual__c !=null && wa.psa.VG_Rate_Per_Vehicle__c !=null  && wa.psa.VG_Coverage__c !=null)){
                System.debug('if::');
                wa.psa.VG_Premium__c = wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Rate_Per_Vehicle__c;
                wa.techPremium = (wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                totalpre=totalpre+wa.psa.VG_Premium__c;
            }
        }
        System.debug('waList::'+waList.size()+'::'+waList);
    }
      
    public void RemoveAsset(){
        if(waList[integer.valueOf(Index)].psa.id != null){
            deletedPSAList.add(waList[integer.valueOf(Index)].psa);
        }
        waList.remove(integer.valueOf(Index));
        counter=0;
        System.debug('waList::'+waList.size()+'::'+waList);
        totalpre=0;
        for(WrapperAsset wa:waList){
            wa.Counter=String.valueOf(counter);            
            if(counter== integer.valueOf(Index)){
                wa.psa.VG_IsTempDelete__c = True;
                wa.psa.VG_Premium__c=0;
            }
            counter++;
            if(!wa.psa.VG_IsTempDelete__c && (wa.psa.VG_Technical_UW_Rate_Annual__c !=null && wa.psa.VG_Rate_Per_Vehicle__c !=null  && wa.psa.VG_Coverage__c !=null)){
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
            if(!temp.psa.VG_IsTempDelete__c && temp.psa.VG_Technical_UW_Rate_Annual__c !=null && temp.psa.VG_Rate_Per_Vehicle__c !=null && temp.psa.VG_Number_of_Vehicles__c !=null && temp.psa.VG_Coverage__c !=null && temp.psa.VG_Vehicle_Type__c != null && temp.psa.VG_Use__c !=null){
                System.debug('if::');
                temp.psa.VG_Premium__c=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Rate_Per_Vehicle__c).setScale(2);
                temp.techPremium=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                
            }else if(!temp.psa.VG_IsTempDelete__c && (temp.psa.VG_Technical_UW_Rate_Annual__c ==null || temp.psa.VG_Rate_Per_Vehicle__c ==null || temp.psa.VG_Number_of_Vehicles__c ==null || temp.psa.VG_Coverage__c ==null || temp.psa.VG_Vehicle_Type__c == null || temp.psa.VG_Use__c ==null)){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the Number,Use, Rate, Technical Rate  and Coverage for all vehicles before adding a new asset..'));    
                allOkToTaddNewAsset = False;                        
            }else{
                temp.psa.VG_Premium__c=0;
            }                
            If(!temp.psa.VG_IsTempDelete__c && temp.psa.VG_Premium__c!=null)
                totalpre=totalpre+temp.psa.VG_Premium__c;  
            System.debug('totalpre::'+totalpre);                        
        }
        
        System.debug('totalpre::'+totalpre);
        if(allOkToTaddNewAsset){
            VG_Policy_Schedule_Asset__c psaNew=new VG_Policy_Schedule_Asset__c();
            waNew.psa=psaNew;  
            waNew.psa.VG_Premium__c=0;    
            waList.add(waNew);
            counter++;
            //totalpre=totalpre+waNew.psa.VG_Premium__c;
            System.debug('inside::'+totalpre);
        }
        System.debug('waList::'+waList.size()+'::'+waList);
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
            } 
        }
        System.Debug(ps.VG_Declaration_Type_percent__c);
    }
    
    public void addULRAsset(){
        Boolean allOkToTaddNewAsset = True;
        
        for(WrapperAsset temp: waList){
            if(temp.psa.VG_Rate_Per_Vehicle__c == null || temp.psa.VG_Number_of_Vehicles__c ==null  && temp.psa.VG_Premium__c == null){
                System.debug('if::');                        
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the No.Of Vehicles,Actual Rate and Premium for all vehicles before adding a new asset..'));                    
                allOkToTaddNewAsset =false;
                showError=true;
            }
        }
        if(allOkToTaddNewAsset){
            WrapperAsset waNew = new WrapperAsset();
            waNew.Counter = string.valueOf(counter);
            VG_Policy_Schedule_Asset__c psaNew = new VG_Policy_Schedule_Asset__c();
            waNew.psa=psaNew;  
            waNew.psa.VG_Premium__c=0;    
            waList.add(waNew);
            counter++;
            ULRRRCalc();
        }
    }
    public void RemoveURLAsset(){
        System.debug('Index ::'+Index);
        if(waList[integer.valueOf(Index)].psa.id != null)
            ULRPSAtoBeDeleted.add(waList[integer.valueOf(Index)].psa);
        waList.remove(integer.valueOf(Index));
        counter=0;
        totalpre=0;
        for(WrapperAsset wa : waList){
            wa.Counter=String.valueOf(counter);
            counter++;
            totalpre = totalpre + wa.psa.VG_Premium__c;
        }
    }
    public void ULRRRCalc(){
        totalpre=0;
        for(WrapperAsset wa : waList){
            System.debug('wa ::'+wa.counter);
            if(wa.psa.VG_Number_of_Vehicles__c != null && wa.psa.VG_Rate_Per_Vehicle__c != null)
                wa.psa.VG_Premium__c = (wa.psa.VG_Number_of_Vehicles__c  * wa.psa.VG_Rate_Per_Vehicle__c).setScale(2);
            else
                wa.psa.VG_Premium__c = 0;
            totalpre = totalpre + wa.psa.VG_Premium__c;
        }
    }
    
    public void AddRisk(){
        WrapperRisk wrc=new WrapperRisk();
        rc.VG_IsTemp__c = True;   
        wrc.rc=rc;             
        wrc.Counter=String.valueOf(counterRisk);
        wrcList.add(wrc);
        counterRisk++;
        System.debug('wrc::'+wrc.rc.Policy_Schedule__c);
        rc=new Risk_Capture__c();
        
    }
    
    public void RemoveRisk(){
        //wrcList.remove(integer.valueOf(Index));
        counterRisk=0;
        for(WrapperRisk wrc:wrcList){
            wrc.Counter=String.valueOf(counterRisk);
            if(counterRisk == integer.valueOf(Index)){
                wrc.rc.VG_IsTempDelete__c = True;
            }
            counterRisk++;
        }
    }
    
    public void EditRisk(){
        rc=wrcList[integer.valueOf(Index)].rc;
        System.debug('rc::'+rc.Policy_Schedule__c);
        wrcList.remove(integer.valueOf(Index));
        counterRisk--;
    }
    
    public PageReference updateCalc(){
        
        if(ps.VG_Fee_Income__c>0){
            VAT_Setting__mdt [] vs  =  [SELECT VG_VAT__c FROM VAT_Setting__mdt];
            ps.VG_VAT__c = vs[0].VG_VAT__c;
            ps.VG_VAT_Amount__c = (ps.VG_VAT__c/100)*ps.VG_Fee_Income__c;    
        }else{
            ps.VG_VAT__c = 0;
            ps.VG_VAT_Amount__c = 0;
        }
        if(psaList.IsEmpty()){
            hasAssets  =  False;
        }else{
            hasAssets  =  True;
        }
        if(rcList.IsEmpty()){
            hasRCs  =  False;
        }else{
            hasRCs  =  True;
        }
        if(pseList.IsEmpty()){
            hasEndorsements  =  False;
        }else{
            hasEndorsements  =  True;
        }
        Decimal proratingfator  =  1;
        riskPremium = 0;
        TUWPremium  =  0;
        techModelPremium = 0;
        for(VG_Policy_Schedule_Asset__c psa:psaList){
            if(!psa.VG_IsTempDelete__c){
                riskPremium = riskPremium+psa.VG_Premium__c;
                if(psa.Technical_UW_Premium__c !=  null)
                    TUWPremium  =  TUWPremium + psa.Technical_UW_Premium__c;
                if(psa.VG_Number_of_Vehicles__c!=null && psa.VG_Model_Rate__c!=null)
                    techModelPremium = techModelPremium+(psa.VG_Number_of_Vehicles__c*psa.VG_Model_Rate__c);
            }
        }
        
        endPremium  =  0;
        for(VG_Policy_Schedule_Endorsement__c pse:pseList){
            if(!pse.VG_IsTempDelete__c)
                if(pse.VG_Premium__c !=  null)
                endPremium  = endPremium +pse.VG_Premium__c;
        } 
        System.debug('MTAType::'+ps.VG_MTA_Type__c+'::'+MTAType );
        if((MTAType  ==  null && ps.VG_MTA_Type__c == null) && ps.Policy__r.Line_Of_Business__c  !=  'MOTOR-ULR'){
            proratingfator  =  Decimal.valueOf(ps.Base_Creation_Start_Date__c.daysBetween(ps.Base_Creation_End_Date__c)+1)/365;
        }else{
            if(MTAType  ==  'Revision of Cover' || ps.VG_MTA_Type__c == 'Revision of Cover'  && ps.Policy__r.Line_Of_Business__c  !=  'MOTOR-ULR'){
                system.debug('xxxx::'+ps.VG_MTA_Start_Date__c+'::'+ps.VG_MTA_End_Date__c);
                proratingfator  =  Decimal.valueOf(ps.VG_MTA_Start_Date__c.daysBetween(ps.VG_MTA_End_Date__c)+1)/365;
            }else if(MTAType  ==  'Declaration' || ps.VG_MTA_Type__c == 'Declaration'  && ps.Policy__r.Line_Of_Business__c  !=  'MOTOR-ULR'){
                system.debug('yyyy::'+ps.VG_Declaration_Type_percent__c);
                proratingfator  =  (ps.VG_Declaration_Type_percent__c/100);//*(Decimal.valueOf(ps.Base_Creation_Start_Date__c.daysBetween(ps.Base_Creation_End_Date__c)+1)/365)
            }
        }
        System.debug('proratingfator::'+proratingfator);
        riskPremiumPro  =  riskPremium * proratingfator;
        System.debug('proratingfator::'+riskPremiumPro+'::'+proratingfator);
        ps.Risk_Premium_Pro__c  =  riskPremiumPro ;
        techUWPre  =  TUWPremium * proratingfator;
        techModelPremium = techModelPremium* proratingfator;
        ps.Technical_UW_Premium__c  =  techUWPre; 
        endPremiumPro  =  endPremium * proratingfator;
        ps.Endorsement_Premium_Pro__c  =  endPremiumPro;
        netModelPremium = riskPremiumPro+endPremiumPro;
        technicalPremium  =  (riskPremium + endPremium )*proratingfator;
        if(ps.Premium_Adjustment__c !=  null)
            grossWrittenPremium  =  technicalPremium+ ps.Premium_Adjustment__c;
        else
            grossWrittenPremium  =  technicalPremium+ 0;
        
        if(ps.VG_Brokerage_Percent__c !=  null){
            brokerageAmount  =  grossWrittenPremium * (ps.VG_Brokerage_Percent__c/100);
        }else{
            brokerageAmount  =  0;
        }
        actPremium = grossWrittenPremium-brokerageAmount;
        if(ps.Levies__c !=  null && ps.VG_Fee_Income__c !=  null){
            transactPremium  =  grossWrittenPremium + ps.Levies__c+ps.VG_Fee_Income__c-brokerageAmount ;
        }else if(ps.Levies__c !=  null) {
            transactPremium  =  actPremium + ps.Levies__c-brokerageAmount ;
        }else if(ps.VG_Fee_Income__c !=  null) {
            transactPremium  =  grossWrittenPremium + 0+ps.VG_Fee_Income__c-brokerageAmount ;
        }else{
            transactPremium  =  grossWrittenPremium -brokerageAmount ;
        }
        return null;
    }
    
    public PageReference Cancel(){
        //below If code only for EdisonRenewPolicy Revise //added by anu 25.1.2019
        System.debug('Test 20.7 ::');
        System.debug(oldpolicyId);
        System.debug(oldpolicyId);
        System.debug(oldpolicyId!=null && renewpolicyid!=null);
        If(oldpolicyId!=null && renewpolicyid!=null){
            System.debug('renewpolicyid::'+renewpolicyid);
            List<Policy_Schedule__c> ps1 =[select id,Name,Product__c,VG_Capacity_Paper__c,Policy__c,Policy__r.VG_Renewal_Policy_Id__c from Policy_Schedule__c where Policy__c=:renewpolicyid];
            delete ps1;   
            Policy__c policy=[select id,Name,CurrencyIsoCode,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,Insured__c,AP_TP__c,Adjustment_Reason__c,Am_I_Underwriter__c,Broker_Name__c,Declaration_Type__c,Deductible_or_Excess_Amount__c,Deductible_or_Excess_Basis__c,Formula_Sum_Insured_Share__c,Inception_Expiry_Time__c,IsApproved_External__c,Line_Of_Business__c,Payment_Frequency__c,Policy_Basis__c,Policy_Status__c,Risk_Assessor__c,Sum_Insured_Share__c,Total_Sum_Insured__c,Type_of_Insurance__c,Underwriter__c,VG_Aggregate_Limit__c,VG_Booked_Time__c,VG_Bound_Booked__c,VG_Bound_Time__c,VG_Brokerage_Percent__c,VG_Current_Insurer__c,VG_Expiry_Date__c,VG_Inception_Date__c,VG_IsApproved__c,VG_Prospect_Premium__c,VG_Quoted_Bound__c,VG_Quoted_Time__c,VG_Sub_Broker__c,VG_Sub_Status__c,IPT__c,Gross_Written_Premium__c,Gross_Written_Premium_Rollup__c,VG_Brokerage_Amount__c,Earned_Aggregate_Balance__c,Extended_Reporting__c,Lead_Insurer__c,Loss_Ratio__c,Retroactive_Date__c,Total_Aggregate_Balance__c,Actual_GWP__c,Total_claims_o_s__c,MTA_Cancel_List__c,Endorsement_GWP__c,Jurisdiction__c,Levies__c,Premium_Adjustment__c,Risk_Premium__c,Technical_Model_Premium__c,Technical_UW_Premium__c,Total_claims_paid__c,Paid_Aggregate_Balance__c,VG_Fee_Income__c,VG_MGA_Commission_Amount__c,VG_Lloyds_Products__c,Total_claims_reserve__c,VG_Additional_Insureds__c,VG_Continuous_Cover_Date__c,VG_Governance_Compliance__c,VG_Local_Policies__c,VG_Plan_Rate__c,VG_Territorial_Limits__c,VG_Wording__c,Commercial_Adjustment__c,Transaction_GWP__c,VG_Is_Renewal__c,VG_Renewal_Policy_Id__c from Policy__c where id=:oldpolicyId limit 1];               
            policy.VG_Is_Renewal__c=false;
            policy.VG_Renewal_Policy_Id__c='';
            update policy;
            Policy__c renewpolicy=[select id,Name,CurrencyIsoCode,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,Insured__c,AP_TP__c,Adjustment_Reason__c,Am_I_Underwriter__c,Broker_Name__c,Declaration_Type__c,Deductible_or_Excess_Amount__c,Deductible_or_Excess_Basis__c,Formula_Sum_Insured_Share__c,Inception_Expiry_Time__c,IsApproved_External__c,Line_Of_Business__c,Payment_Frequency__c,Policy_Basis__c,Policy_Status__c,Risk_Assessor__c,Sum_Insured_Share__c,Total_Sum_Insured__c,Type_of_Insurance__c,Underwriter__c,VG_Aggregate_Limit__c,VG_Booked_Time__c,VG_Bound_Booked__c,VG_Bound_Time__c,VG_Brokerage_Percent__c,VG_Current_Insurer__c,VG_Expiry_Date__c,VG_Inception_Date__c,VG_IsApproved__c,VG_Prospect_Premium__c,VG_Quoted_Bound__c,VG_Quoted_Time__c,VG_Sub_Broker__c,VG_Sub_Status__c,IPT__c,Gross_Written_Premium__c,Gross_Written_Premium_Rollup__c,VG_Brokerage_Amount__c,Earned_Aggregate_Balance__c,Extended_Reporting__c,Lead_Insurer__c,Loss_Ratio__c,Retroactive_Date__c,Total_Aggregate_Balance__c,Actual_GWP__c,Total_claims_o_s__c,MTA_Cancel_List__c,Endorsement_GWP__c,Jurisdiction__c,Levies__c,Premium_Adjustment__c,Risk_Premium__c,Technical_Model_Premium__c,Technical_UW_Premium__c,Total_claims_paid__c,Paid_Aggregate_Balance__c,VG_Fee_Income__c,VG_MGA_Commission_Amount__c,VG_Lloyds_Products__c,Total_claims_reserve__c,VG_Additional_Insureds__c,VG_Continuous_Cover_Date__c,VG_Governance_Compliance__c,VG_Local_Policies__c,VG_Plan_Rate__c,VG_Territorial_Limits__c,VG_Wording__c,Commercial_Adjustment__c,Transaction_GWP__c,VG_Is_Renewal__c,VG_Renewal_Policy_Id__c from Policy__c where id=:renewpolicyid limit 1];                            
            delete renewpolicy;
            return new PageReference('/'+oldpolicyId);      
        }else{        
            return new PageReference('/'+PSId);
        }
    }
    
    public PageReference previous(){
        System.debug('NewTotalPremium ::'+NewTotalPremium );
        System.debug('OldTotalPremium ::'+OldTotalPremium );
        if(MTAType == null){
            return new PageReference('/apex/VG_EdisonPS_Edit1?psid='+psid);
        }else{
            return new PageReference('/apex/VG_EdisonPS_Edit1?MTAType='+MTAType+'&OriginalId='+OriginalId+'&psid='+ps.id);
        }   
    }
    
    public PageReference previous4(){
        System.debug('NewTotalPremium ::'+NewTotalPremium );
        System.debug('OldTotalPremium ::'+OldTotalPremium );
        if(MTAType == null){
            return new PageReference('/apex/VG_EdisonPS_Edit3b?psid='+psid);
        }else{
            return new PageReference('/apex/VG_EdisonPS_Edit1?MTAType='+MTAType+'&OriginalId='+OriginalId+'&psid='+ps.id);
        }   
    }
    public void RemoveCustom(){
        List<VG_Policy_Schedule_Endorsement__c> newPSEList=new List<VG_Policy_Schedule_Endorsement__c>();
        newPSEList.addAll(pseList);
        pseList.clear();
        for(VG_Policy_Schedule_Endorsement__c pse: newPSEList){
            if(!pse.VG_IsTempDelete__c){
                pseList.add(pse);
            }
        }
    }
    public void AddCustom(){
        hasEndorsements = True;    
        VG_Policy_Schedule_Endorsement__c tempEndsmt = new VG_Policy_Schedule_Endorsement__c();
        tempEndsmt.VG_Policy_Schedule__c = PSId;
        tempEndsmt.VG_Type__c= 'Endorsements';
        tempEndsmt.VG_Premium__c = 0;
        tempEndsmt.CurrencyIsoCode=ps.CurrencyIsoCode;
        pseList.add(tempEndsmt);
    }
    
    public PageReference Nexta(){
        //System.debug(OldTotalPremium );
        List<VG_Policy_Schedule_Endorsement__c> endorsementsToBeInserted = new List<VG_Policy_Schedule_Endorsement__c>();
        VG_Policy_Schedule_Endorsement__c tempEndsmt;
        counterEnd = 1;
        hasEndorsements = False;
        
        for(LibraryWrapper LW : LibraryWrapperList){
            if(LW.isSelected){
                hasEndorsements = True;
                if(!existingEndSet.contains(LW.EL.Id)){
                    System.debug('LW.EL.Id::'+LW.EL.Id);
                    tempEndsmt = new VG_Policy_Schedule_Endorsement__c();
                    tempEndsmt.VG_Endorsement_Details__c = LW.EL.Text__c;
                    tempEndsmt.VG_Endorsement_Library_Id__c = LW.EL.Id;
                    tempEndsmt.VG_Policy_Schedule__c = PSId;
                    tempEndsmt.VG_Title__c = LW.EL.Endorsement_Title__c;
                    tempEndsmt.VG_Premium__c = 0;
                    //tempEndsmt.Name = PSName + '/PE/' + counterEnd;
                    tempEndsmt.VG_Endorsement_Number__c = LW.EL.Name;
                    tempEndsmt.VG_IsTempDelete__c = False;
                    tempEndsmt.CurrencyIsoCode=ps.CurrencyIsoCode;
                    tempEndsmt.VG_IsTemp__c = True;
                    //counterEnd++;
                    pseList.add(tempEndsmt);
                    existingEndSet.add(LW.EL.Id);
                }
            }else{
                if(existingEndSet.contains(LW.EL.Id)){
                    for(VG_Policy_Schedule_Endorsement__c endsmt : pseList){
                        if(endsmt.VG_Endorsement_Library_Id__c == LW.EL.Id){
                            endsmt.VG_IsTempDelete__c = True;
                            endsmt.VG_IsTemp__c = False;
                        }
                    }
                }
            }
        }
        if(MTAType == null){
            return new PageReference('/apex/VG_EdisonPS_Edit3b?psid='+psid);
        }else{
            return new PageReference('/apex/VG_EdisonPS_Ins1?MTAType='+MTAType+'&OriginalId='+OriginalId+'&psid='+ps.id);
        } 
    }
    
    public PageReference Nextb(){
        OldTotalPremium = 0;
        NewTotalPremium = 0;
        System.debug(OldAR);
        system.debug('::'+waList);
       if(ps.Policy__r.VG_Is_Renewal__c   == true){ 
         
        for(WrapperAsset wa : waList){
            if(!wa.psa.VG_IsTempDelete__c && wa.psa.VG_Rate_change__c !=null ){
                    system.debug('2::'+waList);
                    system.debug('VG_Rate_change__c::'+wa.psa.VG_Rate_change__c);
                OldAR =(wa.psa.VG_Rate_Per_Vehicle__c/(1+(wa.psa.VG_Rate_change__c/100))).setScale(2);
                    System.debug('AR::'+wa.psa.VG_Rate_Per_Vehicle__c+'RC::'+wa.psa.VG_Rate_change__c/100);
                    System.debug('OldAR::'+OldAR);
                NewTotalPremium = NewTotalPremium + wa.psa.VG_Premium__c;
                OldTotalAR = (wa.psa.VG_Number_of_Vehicles__c*OldAR).setScale(2);
                    System.debug('NOV ::'+wa.psa.VG_Number_of_Vehicles__c+'OldAR::'+OldAR);
                    System.debug('OldTotalAR ::'+OldTotalAR );
                OldTotalPremium = OldTotalPremium  + OldTotalAR ;
            }
            System.debug('id::'+wa.psa.id);
        }
        } 
            System.debug('Test::');
            System.debug('NewTotalPremium ::'+NewTotalPremium );
            System.debug('OldTotalPremium ::'+OldTotalPremium );
        If( NewTotalPremium !=null && NewTotalPremium !=0 && OldTotalPremium !=0 && OldTotalPremium !=null){
                System.debug('NewTotalPremium ::'+NewTotalPremium );
                System.debug('OldTotalPremium ::'+OldTotalPremium );
            RateChange = (((NewTotalPremium/OldTotalPremium )-1)*100).setScale(2);
         }else{
             RateChange = 0;
         }        
        
        if(MTAType == null){
            return new PageReference('/apex/VG_EdisonPS_Edit4?psid='+psid);
        }else{
            return new PageReference('/apex/VG_EdisonPS_Ins1?MTAType='+MTAType+'&OriginalId='+OriginalId+'&psid='+ps.id);
        } 
    }
    
     public void RRCalc(){
        totalpre=0;
        for(WrapperAsset wa : waList){
            If(ps.Policy__r.Line_Of_Business__c  !=  'MOTOR-ULR'){
                if(!wa.psa.VG_IstempDelete__c && wa.psa.VG_Coverage__c !=null && wa.psa.VG_Vehicle_Type__c != null && wa.psa.VG_Use__c !=null){                   
                    if(wa.psa.VG_Number_of_Vehicles__c!=null && wa.psa.VG_Technical_UW_Rate_Annual__c!=null)
                        wa.techPremium=(wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                    else
                        wa.techPremium=0;
                    if(wa.psa.VG_Number_of_Vehicles__c!=null && wa.psa.VG_Rate_Per_Vehicle__c!=null)
                        wa.psa.VG_Premium__c=(wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Rate_Per_Vehicle__c).setScale(2);
                    else
                        wa.psa.VG_Premium__c=0;
                    totalpre=totalpre+(wa.psa.VG_Premium__c!=null?wa.psa.VG_Premium__c:0);
                    wa.psa.Technical_UW_Premium__c=wa.techPremium;                   
                }            
            }
            psaList.add(wa.psa);
        }         
    }
    
    public PageReference NextPSA(){
        //System.debug(OldTotalPremium );
        if(CapacityPaper == '--None--'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please select Capacity Paper'));   
            showError=true; 
            return null;
        }        
        Boolean noAsset = True;       
        for(WrapperAsset temp : waList){
            if(!temp.psa.VG_IsTempDelete__c){               
                noAsset = False;
                Break;
            }
        }
        //OldTotalPremium  = NewTotalPremium  = 0;
        
        if(waList.size() == 0){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please add atleast one asset to the policy schedule..'));    
            return null;  
        }else{
            Boolean allOkToTaddNewAsset = True;
            psaList = new List<VG_Policy_Schedule_Asset__c >();
            Decimal TUWStep1Premium = 0;
            totalpre=0;
            for(WrapperAsset temp : waList){
                If(Product_seleced =='Uninsured Loss Recovery'){
                    System.debug('te::'+temp.psa.VG_Sum_Insured__c);
                    if(temp.psa.VG_Rate_Per_Vehicle__c !=null && temp.psa.VG_Number_of_Vehicles__c !=null  && temp.psa.VG_Premium__c !=null){
                        System.debug('if::');                        
                    }else{ 
                        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the No.Of Vehicles,Actual Rate and Premium for all vehicles before adding a new asset..'));    
                        allOkToTaddNewAsset = False;
                        showError=true;
                        return null;   
                    }                    
                }
                If(Product_seleced !='Uninsured Loss Recovery'){
                    if(!temp.psa.VG_IsTempDelete__c && (temp.psa.VG_Technical_UW_Rate_Annual__c!=null && temp.psa.VG_Rate_Per_Vehicle__c !=null && temp.psa.VG_Number_of_Vehicles__c !=null && temp.psa.VG_Coverage__c !=null && temp.psa.VG_Vehicle_Type__c != null && temp.psa.VG_Use__c !=null)){
                        temp.psa.VG_Premium__c=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Rate_Per_Vehicle__c).setScale(2);
                        temp.techPremium=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                        temp.psa.Technical_UW_Premium__c=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                        TUWStep1Premium = TUWStep1Premium + temp.psa.Technical_UW_Premium__c;
                        totalpre=totalpre+temp.psa.VG_Premium__c;
                    }else if(!temp.psa.VG_IsTempDelete__c && (temp.psa.VG_Technical_UW_Rate_Annual__c ==null || temp.psa.VG_Rate_Per_Vehicle__c ==null || temp.psa.VG_Number_of_Vehicles__c ==null || temp.psa.VG_Coverage__c ==null || temp.psa.VG_Vehicle_Type__c == null || temp.psa.VG_Use__c ==null)){
                        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the Number,Use, Rate,Technical Rate and Coverage for all vehicles before adding a new asset..'));    
                        allOkToTaddNewAsset = False; 
                        showError = True;  
                        return null;  
                    }
                }
                psaList.add(temp.psa);
            }
            
            
            ps.Technical_UW_Premium__c = TUWStep1Premium ;
            if(MTAType == null &&  (Product_seleced == '--None--' ||  Product_seleced == 'null')){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Product..'));    
                showError=true;   
                return null;  
            }
            Integer count=0;
            totalpre=0;
            for(VG_Policy_Schedule_Asset__c psa:psaList){
                count=count+1;
                psa.VG_Policy_Schedule__c=PSId;
                if(!psa.VG_IsTempDelete__c && (psa.VG_Number_of_Vehicles__c!=null && psa.VG_Rate_Per_Vehicle__c !=null)){
                    psa.VG_Premium__c=psa.VG_Number_of_Vehicles__c*psa.VG_Rate_Per_Vehicle__c;
                    if(Product_seleced !='Uninsured Loss Recovery')
                        psa.Technical_UW_Premium__c=psa.VG_Number_of_Vehicles__c*psa.VG_Technical_UW_Rate_Annual__c;
                    totalpre=totalpre+psa.VG_Premium__c;
                }
                psa.Name=ps.Name+'/RR/'+count;
            }
            //Upsert psaList;
            if(MTAType  ==  null){
                if(Product_seleced !='Uninsured Loss Recovery')
                    return new PageReference('/apex/VG_EdisonPS_Edit2?PSId='+PSId);
                else
                    return new PageReference('/apex/VG_EdisonPS_Edit3?PSId='+PSId);
            }else{
                counter=0;
                for(VG_ReInsurance__c ri : RIListDup){
                    ri.VG_Policy_Schedule__c = PSId;
                    ri.Name=ps.Name+'/CB/'+counter; 
                }
                Upsert RIListDup;
                return new PageReference('/apex/VG_EdisonPS_Ins2?MTAType='+MTAType+'&OriginalId='+OriginalId+'&id='+ps.id+'&policyid='+polid);
            }
        }
    } 
    
    public PageReference NextRC(){
        //System.debug(OldTotalPremium );
        List<Risk_Capture__c> rcInsList=new List<Risk_Capture__c>();
        for(WrapperRisk wrc:wrcList){
            wrc.rc.Name=ps.Name+'/RD/'+wrc.Counter;
            wrc.rc.Policy_schedule__c=PSId;
        }
        if(MTAType == null){
            return new PageReference('/apex/VG_EdisonPS_Edit3?id='+psid);
        }else{
            return new PageReference('/apex/VG_EdisonPS_Ins3?MTAType='+MTAType+'&OriginalId='+OriginalId+'&id='+ps.id);
        }   
    } 
    
    public PageReference Previousa(){
        if(Product_seleced =='Uninsured Loss Recovery')
            return new PageReference('/apex/VG_EdisonPS_Edit1?psid='+psid);
        else
            return new PageReference('/apex/VG_EdisonPS_Edit2?id='+psid);
    }
    
    public PageReference Previousb(){
        System.debug('NewTotalPremium ::'+NewTotalPremium );
        System.debug('OldTotalPremium ::'+OldTotalPremium );
        return new PageReference('/apex/VG_EdisonPS_Edit3?id='+psid);
    }
    
    public PageReference Finish(){
        if(deletedPSAList.size() > 0){
            delete deletedPSAList;
        }
        //Policy__c pol = [Select Id,Name, VG_Expiry_Date__c,VG_Is_Renewal__c from Policy__c where Id=: policyid];       
        List<VG_Policy_Schedule_Asset__c> PSAtoBeUpserted = new List<VG_Policy_Schedule_Asset__c>();
        List<Risk_Capture__c> RCtoBeUpserted = new List<Risk_Capture__c>();
        List<Risk_Capture__c> RCtoBeDeleted = new List<Risk_Capture__c>();
        List<VG_Policy_Schedule_Endorsement__c> endorsementsToBeUpserted = new List<VG_Policy_Schedule_Endorsement__c>();
        List<VG_Policy_Schedule_Endorsement__c> endorsementsToBeDeleted = new List<VG_Policy_Schedule_Endorsement__c>();       
        //below one line added by siddik on 16.4.2018
        ps.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        //below one line added by siddik on 21.8.2018
        ps.Gross_Written_Premium__c=grosswrittenpremium;
        ps.VG_Gross_Written_Premium_100__c=grosswrittenpremium;
        //below 2 line added by Anu on 29.8.2018
        if(Product_seleced !='Uninsured Loss Recovery')
            ps.VG_Technical_Model_Premium__c = techModelPremium; 
        ps.Actual_GWP__c=actPremium;
        ps.Transaction_GWP__c=transactPremium;
        ps.VG_Brokerage_Amount__c=brokerageAmount;
        ps.Product__c=Product_seleced;
        ps.VG_Capacity_Paper__c  =  CapacityPaper;
        ps.Net_Premium__c = netModelPremium;
        If(RateChange == 0.00 && ps.Policy__r.VG_Is_Renewal__c   == false)       
            ps.VG_Rate_Change__c   =   null;
        else
            ps.VG_Rate_Change__c   =  RateChange;
        ps.Name = ps.Name.remove('/EEA').remove('/NonEEA');
        if(ps.Split_Type__c == 'Non EEA'){
            ps.Name += '/NonEEA';           
        }else{
            ps.VG_Volante_Entities__c = '';                   
        }
        Update ps; 
        if(Product_seleced !='Uninsured Loss Recovery'){       
            for(WrapperAsset wa: waList){
                System.debug(wa.psa.id);
                wa.psa.CurrencyIsoCode = ps.CurrencyIsoCode;           
                if(wa.psa.VG_IsTempDelete__c && wa.psa.Id !=  null){
                    PSAtoBeDeleted.add(wa.psa);
                }else if(!wa.psa.VG_IsTempDelete__c){
                    PSAtoBeUpserted.add(wa.psa);  
                    System.debug('PSAtoBeUpserted::'+PSAtoBeUpserted);
                }            
            }   
        }else{
            if(!ULRPSAtoBeDeleted.isEmpty())
                delete ULRPSAtoBeDeleted;
            for(WrapperAsset wa: waList){
                wa.psa.CurrencyIsoCode = ps.CurrencyIsoCode;
                PSAtoBeUpserted.add(wa.psa);
            }
        }
        Integer tmpcount = 0; 
        for(VG_Policy_Schedule_Asset__c psa: PSAtoBeUpserted){
            psa.Name = ps.Name+'/RR/'+tmpcount;
            tmpcount++;
        }
        Integer rccount=0;      
        for(WrapperRisk wr : wrcList){
            wr.rc.CurrencyIsoCode=ps.CurrencyIsoCode;
            if(wr.rc.VG_IsTempDelete__c && wr.rc.Id != null){
                RCtoBeDeleted.add(wr.rc);
            }
            if(!wr.rc.VG_IsTempDelete__c){
                System.debug('rccount::'+rccount);
                wr.rc.Name=ps.Name+'/RR/'+rccount;
                RCtoBeUpserted.add(wr.rc);
                rccount++;
                System.debug('rccount::'+rccount);
            }           
        }
        Set<ID> pseIds=new Set<ID>();
        Integer pseCount=0;
        for(VG_Policy_Schedule_Endorsement__c pse: pseList){
            if(!pse.VG_IsTempDelete__c && pse.Id != null){
                pse.Name=ps.Name+ '/PE/' + pseCount;
                pseCount++;
            }
            System.debug(pse.Name+'::'+pse.id);
            pseIds.add(pse.id);
        }
        for(VG_Policy_Schedule_Endorsement__c pse: pseList){
            if(!pse.VG_IsTempDelete__c && pse.Id == null){
                pse.Name=ps.Name+ '/PE/' + pseCount;
                System.debug('Name::'+pse.Name+'::'+PSName+'::'+pseCount);
                pseCount++;
            }
            System.debug('Name::'+pse.Name);
            if(!pse.VG_IsTempDelete__c){
                endorsementsToBeUpserted.add(pse);
            }
        }
        for(VG_Policy_Schedule_Endorsement__c pse: pseMap.values()){
            System.debug(pse.Name+'::'+pse.id+'::'+pseIds.contains(pse.id));
            if(!pseIds.contains(pse.id)){
                endorsementsToBeDeleted.add(pse);
            }
        }
        System.debug('PSAtoBeDeleted::'+PSAtoBeDeleted.size()+':'+PSAtoBeDeleted+endorsementsToBeDeleted);
        if(!PSAtoBeDeleted.IsEmpty()){
            Delete PSAtoBeDeleted;
        }
        System.debug('Here::'+PSAtoBeUpserted.size());
        for(VG_Policy_Schedule_Asset__c psa: PSAtoBeUpserted){
            System.debug('ID::'+psa.id);          
        }
        if(!PSAtoBeUpserted.IsEmpty()){
            system.debug('wee::'+PSAtoBeUpserted);
            Upsert PSAtoBeUpserted;
        }
        
        If(Product_seleced !='Uninsured Loss Recovery'){            
            if(!RCtoBeDeleted.IsEmpty()){
                Delete RCtoBeDeleted;
            }
            if(!RCtoBeUpserted.IsEmpty()){
                Upsert RCtoBeUpserted;
            }
        }
        if(!endorsementsToBeDeleted.IsEmpty()){
            Delete endorsementsToBeDeleted;
        }
        if(!endorsementsToBeUpserted.IsEmpty()){
            Upsert endorsementsToBeUpserted;
        }             
        return new PageReference('/'+PSId);
    }
    
    public class WrapperAsset{
        public VG_Policy_Schedule_Asset__c psa{get;set;}
        public String Counter{get;set;}
        public Decimal techPremium{get;set;}
        public WrapperAsset(){
            psa = new VG_Policy_Schedule_Asset__c();
        }
    }
    
    public class WrapperRisk{
        public Risk_Capture__c rc{get;set;}
        public String Counter{get;set;}
    }
    
    Public Class LibraryWrapper{
        Public Endorsement_Library__c EL {get; set;}
        Public Boolean isSelected {get; set;} 
        Public Decimal premium {get; set;}
        Public LibraryWrapper(){
            EL = new Endorsement_Library__c();
            isSelected = False;
            premium = 0;
        }
        
    }
}