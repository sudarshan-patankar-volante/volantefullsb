Public class VG_GentiumStep4_Controller {
    public List<Endorsement_Library__c> ElList {get; set;}
    public List<LibraryWrapper> LibraryWrapperList {get; set;}
    public Id PSId {get; set;}
    public String PSName {get; set;}
//below one line added by siddik on 12.4.18
    public Policy_Schedule__c ps {get; set;}
    public Id policyid {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> existingEndorsements {get; set;}
    public Boolean hasEndorsements {get; set;}
    public Id OriginalId {get; set;}
    public String MTAType {get; set;}
    public Boolean IsCancellation {get; set;}
    public Boolean IsExtension {get; set;}
    public Boolean IsRevision {get; set;}
    public Boolean IsDeclaration {get; set;}
    public Integer counterEnd {get; set;}
    public Set<Id> existingEndSet {get; set;}
    
    Public VG_GentiumStep4_Controller(){
        LibraryWrapperList = new List<LibraryWrapper>();
        LibraryWrapper LW;
        existingEndSet = new Set<Id>();
        PSId = apexpages.currentpage().getparameters().get('Id');
        System.debug('PSID::'+PSId);
        policyid=apexpages.currentpage().getparameters().get('policyid');
        OriginalId = apexpages.currentpage().getparameters().get('OriginalId');
        MTAType = apexpages.currentpage().getparameters().get('MTAType');
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
        PSName = [Select Id, Name,CurrencyIsoCode from Policy_Schedule__c where Id =: PSId].Name;
    //below one line added by siddik on 12.4.18        
        ps = [Select Id, Name,CurrencyIsoCode from Policy_Schedule__c where Id =: PSId limit 1];
        Id GentiumLibraryId =  Schema.SObjectType.Endorsement_Library__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();
        if(MTAType == null){
            existingEndorsements = [Select Id, VG_Endorsement_Details__c, VG_Policy_Schedule__c, VG_Premium__c, VG_Title__c, VG_Endorsement_Library_Id__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =: PSId];
        }else{
            existingEndorsements = [Select Id, VG_Endorsement_Details__c, VG_Policy_Schedule__c, VG_Premium__c, VG_Title__c, VG_Endorsement_Library_Id__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =: OriginalId];                      
        }
        System.debug('existingEndorsements::'+existingEndorsements);
        if(existingEndorsements.IsEmpty()){
            hasEndorsements = False;
            counterEnd = 0;
        }else{
            hasEndorsements = True;
            counterEnd = existingEndorsements.size();
        }
        for(VG_Policy_Schedule_Endorsement__c Endsmt: existingEndorsements){          
            Id endId = Endsmt.VG_Endorsement_Library_Id__c;
            existingEndSet.add(endId);            
        }
        System.debug('Library Id:'+existingEndSet);
        ElList = [Select Id,Text__c, Name, Endorsement_Title__c from Endorsement_Library__c where RecordTypeId =: GentiumLibraryId ORDER By Name ASC];
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
            System.debug('LibraryWrapperList:'+LibraryWrapperList);
        }
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
        return new PageReference('/'+policyid);
    }
    
    public PageReference Nexta(){
        List<VG_Policy_Schedule_Endorsement__c> endorsementsToBeInserted = new List<VG_Policy_Schedule_Endorsement__c>();
        VG_Policy_Schedule_Endorsement__c tempEndsmt;
        if(!existingEndorsements.IsEmpty() && MTAType == null){
            Delete existingEndorsements;
        }
        counterEnd = 1;
        for(LibraryWrapper LW : LibraryWrapperList){
            if(LW.isSelected){
                tempEndsmt = new VG_Policy_Schedule_Endorsement__c();
                tempEndsmt.VG_Endorsement_Details__c = LW.EL.Text__c;
            //below one line added by siddik on 12.4.18
                tempEndsmt.CurrencyIsoCode=ps.CurrencyIsoCode;
                tempEndsmt.VG_Endorsement_Library_Id__c = LW.EL.Id;
                tempEndsmt.VG_Policy_Schedule__c = PSId;
                tempEndsmt.VG_Title__c = LW.EL.Endorsement_Title__c;
                tempEndsmt.VG_Premium__c = 0;
                tempEndsmt.Name = PSName + '/PE/' + counterEnd;
                tempEndsmt.VG_Endorsement_Number__c = LW.EL.Name;
                counterEnd++;
                endorsementsToBeInserted.add(tempEndsmt);
            }
        }
        if(!endorsementsToBeInserted.IsEmpty()){
            Insert endorsementsToBeInserted;
            System.debug(endorsementsToBeInserted.size() + 'Endorsements Inserted');
        }
        PageReference reference=new PageReference('/apex/VG_Gentium_Step4b');
        reference.getParameters().put('Id',PSId);
        reference.getParameters().put('policyid',policyid);
        if(MTAType !=null){
            reference.getParameters().put('MTAType',MTAType);
            reference.getParameters().put('OriginalId',OriginalId);
        }
        reference.setRedirect(true);
        return reference;
    }
    
    public PageReference Previousa(){
        
        if(!existingEndorsements.IsEmpty() && MTAType ==null){
            Delete existingEndorsements;
        }
       
        //Added by Anu 5.2.2018
        if(MTAType !=null && (MTAType == 'Revision of Cover' || MTAType == 'Declaration')){
            List<Risk_Capture__c> rclist=new List<Risk_Capture__c>([select id from Risk_Capture__c where Policy_Schedule__c =:PSId]);
            if(!rclist.IsEmpty()){
                Delete rclist;
            }
        }
        //end by Anu 5.2.2018
        PageReference reference=new PageReference('/apex/VG_Gentium_Step3');
        reference.getParameters().put('Id',PSId);
        reference.getParameters().put('policyid',policyid);
        if(MTAType !=null){
            reference.getParameters().put('MTAType',MTAType);
            reference.getParameters().put('OriginalId',OriginalId);
        }
        reference.setRedirect(true);
        return reference;
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