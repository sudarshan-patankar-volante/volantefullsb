// In PSA Use also required by siddik on 26.2.2018
Public Class VG_PolicyScheduleStep1_Controller{
    public Policy__c polRec{get;set;}
    public VG_Policy_Schedule_Asset__c psa{get;set;}
    public String Index{get;set;}
    public String fileName {get;set;}
    public string nameFile{get;set;}
    public String[] filelines  =  new String[]{};
    public Integer counter{get;set;}
    public Decimal totalpre{get;set;}
    public Policy_Schedule__c ps{get;set;}
    public String polid{get;set;}
    public String Product_seleced{get;set;}
    public string CapacityPaper{get;set;}
    public integer rrCount{get;set;}
    public Boolean DMLAlert{get;set;}
    
    public Blob fileBody {get;set;}
    public Id PSId {get; set;}
    public Id OriginalId {get; set;}
    public String MTAType {get; set;}
    public Boolean uploadAsset{get;set;}
    public Boolean IsCancellation {get; set;}
    public Boolean pmsg {get; set;}
    public Boolean showError {get; set;}
    public Boolean IsExtension {get; set;}
    public Boolean IsRevision {get; set;}
    public Boolean IsDeclaration {get; set;}
    public List<VG_Policy_Schedule_Asset__c> ULRdeletedPSA {get;set;}
    public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    public List<VG_ReInsurance__c> RIList {get; set;}
    public List<Risk_Capture__c> rcList{get;set;}
    public List<WrapperAsset> waList{get;set;}
    public List<SelectOption> DecTypes {get; set;}
    public List<VG_Policy_Schedule_Asset__c> psaListDup {get;set;}
    public List<VG_Policy_Schedule_Asset__c> PSAtoBeDeleted{get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseListDup {get;set;}
    public List<Risk_Capture__c> rcListDup {get;set;}
    public List<VG_ReInsurance__c> RIListDup {get; set;}
    public Policy_Schedule__c originalPS {get; set;}
    public list<SelectOption> coverageOptions {get; set;}
    public VG_PolicyScheduleStep1_Controller(ApexPages.StandardSetController controller) {
        
        PSId = apexpages.currentpage().getparameters().get('PSId');
        OriginalId = apexpages.currentpage().getparameters().get('OriginalId');
        MTAType = apexpages.currentpage().getparameters().get('MTAType');
        
        showError = DMLAlert = false;
        totalpre = 0;
        rrCount = counter = 0;
        fileBody = blob.valueOf('');
        
        waList = new List<WrapperAsset>();
        psaList = new List<VG_Policy_Schedule_Asset__c>();
        PSAtoBeDeleted  =  new List<VG_Policy_Schedule_Asset__c>();
        ULRdeletedPSA = new List<VG_Policy_Schedule_Asset__c>();
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
            psaList = [select id,Name,VG_IsTempDelete__c ,VG_Number_of_Vehicles__c,VG_Vehicle_Type__c, VG_Use__c,VG_Sum_Insured__c, VG_Rate_change__c, VG_Model_Rate__c, VG_Coverage__c,VG_Rate_Per_Vehicle__c,VG_Premium__c, VG_Deductible__c,VG_Technical_UW_Rate_Annual__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c=:PSId];
            rrCount = psaList.size();
            if(!psaList.IsEmpty()){
                totalpre = 0;
                counter = 0;
                for(VG_Policy_Schedule_Asset__c psa: psaList){
                    WrapperAsset wa = new WrapperAsset();
                    wa.psa = psa;
                    wa.Counter = String.valueOf(counter);
                    if(wa.psa.VG_Technical_UW_Rate_Annual__c != null && wa.psa.VG_Rate_Per_Vehicle__c != null  && wa.psa.VG_Coverage__c != null){
                        wa.techPremium = (wa.psa.VG_Number_of_Vehicles__c * wa.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                    }
                    waList.add(wa);
                    counter++;
                    totalpre = totalpre + psa.VG_Premium__c;
                }
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
        }else{
            IsDeclaration=IsCancellation = IsRevision = IsExtension = False;
        }
        
        if(MTAType == null){
            polid = apexpages.currentpage().getparameters().get('id');
            ps = new Policy_Schedule__c();
            ps.Policy__c = polid;
            
            if(PSID != null){
                
                Policy_Schedule__c psTemp = [select id,Name,Product__c,VG_Capacity_Paper__c,policy__c from Policy_Schedule__c where Id=:PSID] ;
                polid = psTemp.policy__c;
                Product_seleced = psTemp.Product__c;
                CapacityPaper = psTemp.VG_Capacity_Paper__c;
            }
            
            ps.VG_Base_Policy__c = True;
            polRec = [Select Id, VG_Inception_Date__c,Line_Of_Business__c, VG_Expiry_Date__c,CurrencyIsoCode from Policy__c where Id =: polid];
            ps.CurrencyIsoCode = polRec.CurrencyIsoCode;
            ps.Base_Creation_Start_Date__c = polRec.VG_Inception_Date__c;
            ps.Base_Creation_End_Date__c = polRec.VG_Expiry_Date__c;
            
        }else{
            psaListDup = new List<VG_Policy_Schedule_Asset__c>();
            pseListDup = new List<VG_Policy_Schedule_Endorsement__c>();
            RIListDup = new List<VG_ReInsurance__c>();
            rcListDup = new List<Risk_Capture__c>();
            if(PSId == null){
                originalPS = [select id,Name,Split_Type__c,VG_Volante_Entities__c,IPT_Percent__c, Levies__c, Policy__c,VG_Capacity_Paper__c, Premium_Adjustment__c, VG_Declaration_Type__c, VG_Brokerage_Percent__c, Product__c, Policy__r.VG_Expiry_Date__c, Policy__r.VG_Inception_Date__c, MTA_Reason_for_Cancellation__c from Policy_Schedule__c Where Id =:OriginalId];
                polid = originalPS.Policy__c;
                ps=originalPS.clone(false, true, false, false);
                ps.id = null;
                ps.VG_MTA_Type__c = MTAType;
                ps.VG_Is_MTA__c = True;
                Product_seleced=ps.Product__c;
                CapacityPaper  =  originalPS.VG_Capacity_Paper__c;
                polRec = [Select Id, VG_Inception_Date__c, Line_Of_Business__c, VG_Expiry_Date__c,CurrencyIsoCode from Policy__c where Id =: polid];            
                RIList =new List<VG_ReInsurance__c>([Select Id, VG_Policy_Schedule__c,VG_RI_Currency__c, VG_UMR__c from VG_ReInsurance__c where VG_Policy_Schedule__c =: OriginalId]);
                Integer counter=0;
                for(VG_ReInsurance__c ri : RIList){
                    VG_ReInsurance__c temp = ri.clone(false, true, false, false);
                    temp.Id = null;
                    RIListDup.add(temp);
                }
                if(MTAType == 'Revision of Cover'){
                    ps.Base_Creation_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    ps.VG_MTA_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    ps.MTA_Parent_Policy_Schedule__c=OriginalId;           
                }
                if(MTAType == 'Declaration'){
                    ps.VG_Declaration_Type__c = null;
                    ps.Base_Creation_Start_Date__c = OriginalPS.Policy__r.VG_Inception_Date__c;
                    ps.Base_Creation_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    ps.VG_MTA_Start_Date__c = OriginalPS.Policy__r.VG_Inception_Date__c;
                    ps.VG_MTA_End_Date__c = OriginalPS.Policy__r.VG_Expiry_Date__c;
                    ps.MTA_Parent_Policy_Schedule__c=OriginalId;                     
                }
            }else{
                ps = [select id,Name, IPT_Percent__c, Levies__c,VG_Capacity_Paper__c,VG_MTA_Start_Date__c, VG_Declaration_Type_percent__c , Policy__c, VG_MTA_End_Date__c, VG_Declaration_Type__c, VG_MTA_Cancellation_Date__c, Premium_Adjustment__c, Product__c, Policy__r.VG_Expiry_Date__c, MTA_Reason_for_Cancellation__c from Policy_Schedule__c Where Id =:PSId ];
                polid = ps.Policy__c; 
                Product_seleced=ps.Product__c; 
                CapacityPaper  =  ps.VG_Capacity_Paper__c;
                polRec = [Select Id, VG_Inception_Date__c, Line_Of_Business__c, VG_Expiry_Date__c,CurrencyIsoCode from Policy__c where Id =: polid];               
            }
            
        }
        
        if(psaList.IsEmpty()){
            if(MTAType != 'Revision of Cover'){
                psa = new VG_Policy_Schedule_Asset__c();
                psaList.add(psa);
            }
        }
        
    }
    
    public void uploadAsset(){
        uploadAsset = True;
    }
    
    public PageReference processuploadAsset(){
        
        totalpre=0;
        
        if(fileBody == null || fileBody == blob.valueOf('')){
            pmsg = true;
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'Must select file.'));
            return null;
        }else{
            pmsg = false;            
        }
         try{ 
            DMLAlert = false;
            if(fileBody !=  blob.valueOf('')){
                System.debug('waList::'+waList);
                for(WrapperAsset wa : waList){
                    PSAtoBeDeleted.add(wa.psa);
                }
                waList.clear();
                DMLAlert = True;               
            }
            System.debug('DMLAlert::'+DMLAlert);
            if(DMLAlert){
                System.debug('DMLAlert::'+DMLAlert);
                WrapperAsset wa;
                filelines  =  Utilities.decode(fileBody,'ISO-8859-1');//nameFile.split('\n'); 
                fileBody = blob.valueOf('');
                for (Integer i = 1 ; i < filelines.size() ; i++){
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
        }catch(Exception e){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Error ::'+e+e.getLineNumber()));
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
        totalpre=0;
        for(WrapperAsset wa:waList){
            wa.Counter=String.valueOf(counter);            
            if(counter== integer.valueOf(Index)){
                wa.psa.VG_IsTempDelete__c = True;
            }
            counter++;
            if(!wa.psa.VG_IsTempDelete__c && (wa.psa.VG_Technical_UW_Rate_Annual__c !=null && wa.psa.VG_Premium__c !=null && wa.psa.VG_Rate_Per_Vehicle__c !=null && wa.psa.VG_Coverage__c !=null)){
                System.debug('if::');
                wa.psa.VG_Premium__c = wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Rate_Per_Vehicle__c;
                wa.techPremium = (wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                totalpre=totalpre+wa.psa.VG_Premium__c;
            }
        }
    }
    
    public void RemoveAsset(){
        //waList.remove(integer.valueOf(Index));
        if(waList[integer.valueOf(Index)].psa.id != null){
            ULRdeletedPSA.add(waList[integer.valueOf(Index)].psa);
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
            }
            totalpre = totalpre + (wa.psa.VG_Premium__c != null ? wa.psa.VG_Premium__c : 0);
        }        
    }
    
    public void addAsset(){
        Boolean allOkToTaddNewAsset = True;
        WrapperAsset waNew=new WrapperAsset();
        waNew.Counter=string.valueOf(counter);
        totalpre=0;
        for(WrapperAsset temp : waList){
            System.debug('Rate::'+temp.psa.VG_Rate_Per_Vehicle__c +':No.of:'+temp.psa.VG_Number_of_Vehicles__c+':coverage:'+temp.psa.VG_Coverage__c+':type:'+temp.psa.VG_Vehicle_Type__c);
            if(!temp.psa.VG_IsTempDelete__c && temp.psa.VG_Technical_UW_Rate_Annual__c !=null && temp.psa.VG_Rate_Per_Vehicle__c !=null && temp.psa.VG_Number_of_Vehicles__c !=null && temp.psa.VG_Coverage__c !=null && temp.psa.VG_Vehicle_Type__c != null && temp.psa.VG_Use__c !=null){
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
        }
        System.debug('waList::'+waList.size()+'::'+waList);
    }
    
    public void addULRAsset(){
        Boolean allOkToTaddNewAsset = True;
        for(WrapperAsset temp: waList){
            if(temp.psa.VG_Rate_Per_Vehicle__c ==null || temp.psa.VG_Number_of_Vehicles__c ==null  && temp.psa.VG_Premium__c ==null){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the No.Of Vehicles,Actual Rate and Premium for all vehicles before adding a new asset..'));    
                allOkToTaddNewAsset = False;  
                showError= True;            
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
        if(waList[integer.valueOf(Index)].psa.id != null){
            ULRdeletedPSA.add(waList[integer.valueOf(Index)].psa);
        }
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
            if(wa.psa.VG_Number_of_Vehicles__c != null && wa.psa.VG_Rate_Per_Vehicle__c != null){
                wa.psa.VG_Premium__c = (wa.psa.VG_Number_of_Vehicles__c  * wa.psa.VG_Rate_Per_Vehicle__c).setScale(2);
            }else{
                wa.psa.VG_Premium__c = 0;
            }
            totalpre = totalpre +( wa.psa.VG_Premium__c != null ? wa.psa.VG_Premium__c : 0 );
        }
    }
    
    public PageReference Cancel(){
        List<Policy_Schedule__c> ps = [select id,Name from Policy_Schedule__c where id=:PSId];
        List<VG_Policy_Schedule_Asset__c> psaList= [select id,Name,VG_Number_of_Vehicles__c,VG_Vehicle_Type__c,VG_Coverage__c,VG_Rate_Per_Vehicle__c,VG_Premium__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c=:PSId];
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
        if(IsDeclaration ||  IsRevision )
            return new PageReference('/'+OriginalId);
        else
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
    
    public void RRCalc(){
        totalpre=0;
        for(WrapperAsset wa : waList){
            If(ps.Policy__r.Line_Of_Business__c  !=  'MOTOR-ULR'){
                System.debug('RRCalc::'+wa.psa.VG_IstempDelete__c+'::'+wa.psa.VG_Technical_UW_Rate_Annual__c+'::'+wa.psa.VG_Number_of_Vehicles__c+'::'+wa.psa.VG_Coverage__c+'::'+wa.psa.VG_Vehicle_Type__c+'::'+wa.psa.VG_Use__c);
                if(!wa.psa.VG_IstempDelete__c && wa.psa.VG_Coverage__c !=null && wa.psa.VG_Vehicle_Type__c != null && wa.psa.VG_Use__c !=null){                   
                    System.debug('RRCalc::'+wa.psa.VG_IstempDelete__c+'::'+wa.psa.VG_Technical_UW_Rate_Annual__c+'::'+wa.psa.VG_Number_of_Vehicles__c+'::'+wa.psa.VG_Coverage__c+'::'+wa.psa.VG_Vehicle_Type__c+'::'+wa.psa.VG_Use__c);                
                    if(wa.psa.VG_Number_of_Vehicles__c!=null && wa.psa.VG_Technical_UW_Rate_Annual__c!=null)
                        wa.techPremium=(wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                    else
                        wa.techPremium=0;
                    System.debug('wa.techPremium::'+wa.techPremium);
                    if(wa.psa.VG_Number_of_Vehicles__c!=null && wa.psa.VG_Rate_Per_Vehicle__c!=null)
                        wa.psa.VG_Premium__c=(wa.psa.VG_Number_of_Vehicles__c*wa.psa.VG_Rate_Per_Vehicle__c).setScale(2);
                    else
                        wa.psa.VG_Premium__c=0;
                    System.debug('Premium::'+wa.psa.VG_Premium__c);
                    totalpre=totalpre+(wa.psa.VG_Premium__c!=null?wa.psa.VG_Premium__c:0);
                    wa.psa.Technical_UW_Premium__c=wa.techPremium;                   
                }            
            }
            psaList.add(wa.psa);
        }         
    }
    
    public PageReference Next(){
        
        // Code Added By siddik on 22.2.2018
        if(MTAType == 'Revision of Cover' && Product_seleced == '--None--' ){
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
                System.debug('Product_seleced::'+Product_seleced);
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
                    
                    If(!temp.psa.VG_IsTempDelete__c && temp.psa.VG_Premium__c!=null)
                       totalpre=totalpre+temp.psa.VG_Premium__c;
                }                
                If(Product_seleced !='Uninsured Loss Recovery'){
                    System.debug('25.4::'+temp.psa.Name+':'+temp.psa.VG_Technical_UW_Rate_Annual__c+':'+temp.psa.VG_Rate_Per_Vehicle__c+':'+temp.psa.VG_Coverage__c+':'+temp.psa.VG_Number_of_Vehicles__c+':'+temp.psa.VG_Vehicle_Type__c+':'+temp.psa.VG_Use__c);
                    if(!temp.psa.VG_IsTempDelete__c && temp.psa.VG_Technical_UW_Rate_Annual__c !=null && temp.psa.VG_Rate_Per_Vehicle__c !=null && temp.psa.VG_Number_of_Vehicles__c !=null && temp.psa.VG_Coverage__c !=null && temp.psa.VG_Vehicle_Type__c != null && temp.psa.VG_Use__c !=null){
                        System.debug('if::');
                        temp.psa.VG_Premium__c=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Rate_Per_Vehicle__c).setScale(2);
                        temp.techPremium=(temp.psa.VG_Number_of_Vehicles__c*temp.psa.VG_Technical_UW_Rate_Annual__c).setScale(2);
                        temp.psa.Technical_UW_Premium__c=temp.techPremium;
                        totalpre=totalpre+temp.psa.VG_Premium__c;
                    }else if(!temp.psa.VG_IsTempDelete__c && (temp.psa.VG_Technical_UW_Rate_Annual__c ==null || temp.psa.VG_Rate_Per_Vehicle__c ==null || temp.psa.VG_Number_of_Vehicles__c ==null || temp.psa.VG_Coverage__c ==null || temp.psa.VG_Vehicle_Type__c == null || temp.psa.VG_Use__c ==null)){
                        System.debug('else::');
                        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter the Number,Use, Rate, Technical Rate and Coverage for all vehicles before adding a new asset..'));    
                        allOkToTaddNewAsset = False;  
                        return null;                                                   
                    }
                }               
            }
            if(PSId == null){
                Policy__c pol= [select id,Name from Policy__c where id=:polid];
                List<Policy_Schedule__c> psList=new List<Policy_Schedule__c>([SELECT Id,Name,Policy__c,Split_Type__c  FROM Policy_Schedule__c WHERE Policy__c=:polid ORDER BY CreatedDate DESC]);                         
                  
                List<Integer> psNumList=new List<Integer>();                 
                if(psList.size()>0){
                    for(Policy_Schedule__c psh: psList){
                        psh.Name = psh.Name.remove('/NonEEA');
                        if(psh.Name.contains('/PS/'))
                            psNumList.add(Integer.valueOf(psh.Name.split('/PS/')[1]));
                        else if(psh.Name.contains('/MTA/'))
                            psNumList.add(Integer.valueOf(psh.Name.split('/MTA/')[1]));
                    }
                    psNumList.sort();
                    ps.Name=pol.Name+'/PS/'+((psNumList[psNumList.size()-1])+1);
     
                }else{
                    ps.Name=pol.Name+'/PS/0';
                }
                
                ps.VG_Capacity_Paper__c =CapacityPaper;        
                if(MTAType != null && MTAType == 'Revision of Cover'){
                    ps.Base_Creation_Start_Date__c = ps.VG_MTA_Start_Date__c;
                    ps.VG_Base_Policy__c = True;
                    ps.VG_Is_MTA__c = True;
                    ps.MTA_Parent_Policy_Schedule__c=OriginalId; 
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
                if(MTAType == null && Product_seleced =='--None--'){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Product..'));    
                    showError=true;   
                    return null;  
                }else{
                    ps.RecordTypeId=Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();                       
                    ps.Product__c=Product_seleced;
                    Insert ps;
                    System.debug('ps::'+ps+ps.Product__c);
                    PSId = ps.Id;
                }                
            }else{
                if(MTAType == null && Product_seleced == '--None--' ){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select Product..'));    
                    showError=true;   
                    return null;  
                }
                ps.Product__c=Product_seleced;
                ps.id=PSID;
                String psName;
                ps.Name= [select id,Name,Split_Type__c from Policy_Schedule__c where id=:PSID].Name; 
                System.debug('PSNAMe::'+ps.Name+'::'+psName );
                update ps;
            }
            //List<VG_Policy_Schedule_Asset__c> PSAtoBeDeleted = new List<VG_Policy_Schedule_Asset__c>();
            List<VG_Policy_Schedule_Asset__c> PSAtoBeUpserted = new List<VG_Policy_Schedule_Asset__c>();      
            System.debug('waList::'+waList);
            for(WrapperAsset wa: waList){   
                if(wa.psa.VG_IsTempDelete__c && wa.psa.id != null){
                     PSAtoBeDeleted.add(wa.psa);
                }
                if(!wa.psa.VG_IsTempDelete__c){
                     PSAtoBeUpserted.add(wa.psa);          
                }  
            }
            if(ULRdeletedPSA.size() > 0){
                delete ULRdeletedPSA;
            }
            System.debug(PSAtoBeDeleted);
            If(!PSAtoBeDeleted.IsEmpty()){
                Delete PSAtoBeDeleted;               
            }
            If(!PSAtoBeUpserted.IsEmpty()){
                Integer count=0;
                for(VG_Policy_Schedule_Asset__c psa: PSAtoBeUpserted){
                    psa.VG_Policy_Schedule__c=PSId;
                    if(psa.VG_Number_of_Vehicles__c!=null && psa.VG_Rate_Per_Vehicle__c !=null){
                        psa.VG_Premium__c=psa.VG_Number_of_Vehicles__c*psa.VG_Rate_Per_Vehicle__c;
                    }
                    psa.CurrencyIsoCode=ps.CurrencyIsoCode;
                    psa.RecordTypeId=Schema.SObjectType.VG_Policy_Schedule_Asset__c.getRecordTypeInfosByName().get('Edison').getRecordTypeId();                
                    System.debug('PSNAMe::'+ps.Name);
                    psa.Name=ps.Name+'/RR/'+count;
                    count++;
                }
                System.debug('PSAtoBeUpserted::'+PSAtoBeUpserted);
                Upsert PSAtoBeUpserted;
                System.debug('PSAtoBeUpserted::'+PSAtoBeUpserted);
            }
            
             if(MTAType == null){
                if(Product_seleced !='Uninsured Loss Recovery')
                    return new PageReference('/apex/VG_EdisonPS_Ins2?policyid='+polid+'&id='+PSId);
                else
                    return new PageReference('/apex/VG_EdisonPS_Ins3?policyid='+polid+'&id='+PSId);
            }else{
                List<Policy_Schedule__c> TriggerNew  =  new List<Policy_Schedule__c>();
                TriggerNew.add(ps);
                PolicyScheduleTriggerFunction.allowInsertRI  =  True;
                PolicyScheduleTriggerFunction.createRIRecords(TriggerNew);
                if(Product_seleced !='Uninsured Loss Recovery')
                    return new PageReference('/apex/VG_EdisonPS_Ins2?MTAType='+MTAType+'&OriginalId='+OriginalId+'&id='+ps.id+'&policyid='+polid);
                else
                    return new PageReference('/apex/VG_EdisonPS_Ins3?MTAType='+MTAType+'&OriginalId='+OriginalId+'&id='+ps.id+'&policyid='+polid);
            }
        }
    }  
    
    
    public class WrapperAsset{
        public VG_Policy_Schedule_Asset__c psa{get;set;}
        public String Counter{get;set;}
        public Decimal techPremium{get;set;}
        public WrapperAsset(){
            psa = new VG_Policy_Schedule_Asset__c();
        }
    }    
}