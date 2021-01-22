Public Class VG_ClaimScheduleStepsController{
    public List<SelectOption> PSItems {get; set;}
    public String selectedPS {get; set;}
    public Boolean hasPSA{get;set;}
    public Boolean hasPSE{get;set;}
    public Boolean hasAss{get;set;}
    public Claim__c claim{get;set;}
    public Boolean hasRD{get;set;}
    Public String PID{get;set;}
    Public String AccId{get;set;}
    public List<VG_Policy_Schedule_Asset__c> RRList {get; set;}
    public List<RiskRatingWrapper> RiskRatingWrapperList {get; set;}
    Public List<Risk_Capture__c> rcList{get;set;}
    Public List<RCWrapper> rcwList{get;set;}
    public List<PSEndorsementWrapper> PSEWList {get; set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    public List<Asset__c> AssList {get; set;}
    public List<AssetWrapper> AWList{get;set;}
    Public String ClaimId{get;set;}
    public List<Policy_Schedule__c> psList{get;set;}
    public VG_ClaimScheduleStepsController(){
        hasPSA=false;
        hasPSE=false;
        hasRD=false;
        hasAss=false;
        ClaimId=apexpages.currentpage().getparameters().get('id');
        selectedPS = apexpages.currentpage().getparameters().get('selectedPS');
        PID = apexpages.currentpage().getparameters().get('PId');
        claim=[select id,Policy_Number__r.id,Policy_Number__r.Deductible_or_Excess_Basis__c,Policy_Number__r.Deductible_or_Excess_Amount__c,Account__r.id from Claim__c where id=:ClaimId limit 1];
        AccId=claim.Account__r.id;
        PSItems= new List<SelectOption>();
        PSItems.add(new SelectOption('--Select--','--Select--'));
        psList=new List<Policy_Schedule__c>([select id,Name from Policy_Schedule__c where Policy__c=:PID]);
        for(Policy_Schedule__c ps:psList){
            PSItems.add(new SelectOption(ps.id,ps.Name));
        }
        RiskRatingWrapperList=new List<RiskRatingWrapper>();
        RiskRatingWrapper RRW;
        RRList=[Select Id,Name,VG_Policy_Schedule__c,VG_Deductible__c,VG_Number_of_Vehicles__c,VG_Vehicle_Type__c,VG_Use__c,VG_Coverage__c,VG_Rate_Per_Vehicle__c,VG_Premium__c From VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c  =: selectedPS];
        for(VG_Policy_Schedule_Asset__c RR : RRList){
            RRW=new RiskRatingWrapper();
            RRW.RR=RR;
            RiskRatingWrapperList.add(RRW);
        }
        rcList=new List<Risk_Capture__c>([select id,Name,VG_IsTemp__c, VG_IsTempDelete__c,Drivers_Claims__c,Drivers_Conviction_Points__c,Drivers_Convictions__c,Drivers_DOB__c,Drivers_License_Ban_Details__c,Drivers_Medical_Conditions__c,Drivers_Name__c,Policy_Schedule__c from Risk_Capture__c where Policy_Schedule__c  =: selectedPS]);
        rcwList=new List<RCWrapper>();
        for(Risk_Capture__c rc:rcList){
            RCWrapper rcw=new RCWrapper();
            rcw.rc=rc;
            rcwList.add(rcw);
            System.debug('rcw.isSelected::'+rcw.isSelected);
        }
        pseList=new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Endorsement_Number__c,VG_Title__c,VG_IsTempDelete__c,VG_IsTemp__c,VG_Premium__c,VG_Endorsement_Details__c,VG_Endorsement_Library_Id__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c=: selectedPS]);
        PSEWList=new List<PSEndorsementWrapper>(); 
        for(VG_Policy_Schedule_Endorsement__c PSE:pseList){
            PSEndorsementWrapper PSEW=new PSEndorsementWrapper();
            PSEW.PSE=PSE;
            PSEWList.add(PSEW);
        }
        AssList=new List<Asset__c>([select id, Name,VG_Date_Added__c,VG_Date_Removed__c,VG_Status__c,Vehicle_Registration_No__c,VG_Coverage__c, Vehicle_Model__c, Vehicle_Make__c,VG_Use__c from Asset__c where VG_Account__c=:AccId AND VG_Status__c='Active']);
        AWList=new List<AssetWrapper>(); 
        for(Asset__c ass:AssList){
            AssetWrapper aw=new AssetWrapper();
            aw.ass=ass;
            AWList.add(aw);
        }
    }
    public PageReference gotoStep1(){
        return new PageReference('/apex/VG_ClaimSchedule_Step1?id='+ClaimId+'&Pid='+PID+'&selectedPS='+selectedPS);
    }
    public PageReference gotoStep2(){
        if(selectedPS !='--Select--'){
            PageReference reference=new PageReference('/apex/VG_ClaimSchedule_Step6?id='+ClaimId+'&Pid='+PID+'&selectedPS='+selectedPS);
            reference.setRedirect(true);
            return reference;
        }else{
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please Select Policy Schedule.'));
            return null;
        }
        
    }
    public PageReference gotoStep2a(){
        return new PageReference('/apex/VG_ClaimSchedule_Step2?id='+ClaimId+'&Pid='+PID+'&selectedPS='+selectedPS);
    }
    public PageReference gotoStep3(){
        
        return new PageReference('/apex/VG_ClaimSchedule_Step3?id='+ClaimId+'&Pid='+PID+'&selectedPS='+selectedPS);
    }
    public PageReference gotoStep4(){
        return new PageReference('/apex/VG_ClaimSchedule_Step4?id='+ClaimId+'&Pid='+PID+'&selectedPS='+selectedPS);
    }
    public PageReference gotoStep6(){
        return new PageReference('/apex/VG_ClaimSchedule_Step6?id='+ClaimId+'&Pid='+PID+'&selectedPS='+selectedPS);
    }
    public PageReference gotoStep5(){
        hasPSA=false;
        hasPSE=false;
        hasRD=false;
        for(RiskRatingWrapper rrw:RiskRatingWrapperList){
            if(rrw.isSelected){
                hasPSA=true;
            }
        }
        for(RCWrapper rcw:rcwList){
            if(rcw.isSelected){
                hasRD=true;
            }
        }
        for(PSEndorsementWrapper psew:PSEWList){
            if(psew.isSelected){
                hasPSE=true;
            }
        }
        for(AssetWrapper aw:AWList){
            if(aw.isSelected){
                hasAss=true;
            }
        }
        return new PageReference('/apex/VG_ClaimSchedule_Step5?id='+ClaimId+'&Pid='+PID+'&selectedPS='+selectedPS);
    }
    public PageReference Cancel(){
        PageReference reference=new PageReference('/'+ClaimId);
        reference.setRedirect(true);
        return reference;
    }
    public PageReference finish(){
        Claims_Schedule__c cs=new Claims_Schedule__c();
        cs.Name='Test';
        cs.Claim__c=ClaimId;
        cs.VG_Policy_Schedule__c=selectedPS;
        cs.Deductible_Amount__c=claim.Policy_Number__r.Deductible_or_Excess_Amount__c;   
        cs.Deductible_Basis__c=claim.Policy_Number__r.Deductible_or_Excess_Basis__c;
        if(!RiskRatingWrapperList.IsEmpty() && RiskRatingWrapperList[0].RR.VG_Deductible__c!=null)
            cs.Deductible_Amount__c=RiskRatingWrapperList[0].RR.VG_Deductible__c;
        if(!RiskRatingWrapperList.IsEmpty() && RiskRatingWrapperList[0].RR.VG_Coverage__c!=null)        
            cs.Coverage__c=RiskRatingWrapperList[0].RR.VG_Coverage__c;
        Insert cs;
        List<VG_Claim_Schedule_Line_Items__c> InsCSLIList=new List<VG_Claim_Schedule_Line_Items__c>();
        for(RiskRatingWrapper rrw:RiskRatingWrapperList){
            if(rrw.isSelected){
                VG_Claim_Schedule_Line_Items__c tmpcs=new VG_Claim_Schedule_Line_Items__c();
                tmpcs.RecordTypeID=Schema.SObjectType.VG_Claim_Schedule_Line_Items__c.getRecordTypeInfosByName().get('Risk Rating').getRecordTypeId();
                tmpcs.VG_Claims_Schedule__c=cs.id;
                tmpcs.VG_Risk_Rating__c=rrw.RR.id;
                InsCSLIList.add(tmpcs);
            }
        }
        for(RCWrapper rcw:rcwList){
            if(rcw.isSelected){
                VG_Claim_Schedule_Line_Items__c tmpcs=new VG_Claim_Schedule_Line_Items__c();
                tmpcs.RecordTypeID=Schema.SObjectType.VG_Claim_Schedule_Line_Items__c.getRecordTypeInfosByName().get('Risk Detail').getRecordTypeId();
                tmpcs.VG_Claims_Schedule__c=cs.id;
                tmpcs.VG_Risk_Details__c=rcw.rc.id;
                InsCSLIList.add(tmpcs);
            }
        }
        for(PSEndorsementWrapper psew:PSEWList){
            if(psew.isSelected){
                VG_Claim_Schedule_Line_Items__c tmpcs=new VG_Claim_Schedule_Line_Items__c();
                tmpcs.RecordTypeID=Schema.SObjectType.VG_Claim_Schedule_Line_Items__c.getRecordTypeInfosByName().get('Policy Endorsement').getRecordTypeId();
                tmpcs.VG_Claims_Schedule__c=cs.id;
                tmpcs.VG_Policy_Endorsements__c=psew.pse.id;
                InsCSLIList.add(tmpcs);
            }
        }
        for(AssetWrapper aw:AWList){
            if(aw.isSelected){
                VG_Claim_Schedule_Line_Items__c tmpcs=new VG_Claim_Schedule_Line_Items__c();
                tmpcs.RecordTypeID=Schema.SObjectType.VG_Claim_Schedule_Line_Items__c.getRecordTypeInfosByName().get('Asset').getRecordTypeId();
                tmpcs.VG_Claims_Schedule__c=cs.id;
                tmpcs.VG_Asset__c=aw.ass.id;
                InsCSLIList.add(tmpcs);
            }
        }
        if(!InsCSLIList.IsEmpty()){
            Insert InsCSLIList;
        }
        PageReference reference=new PageReference('/'+cs.id);
        reference.setRedirect(true);
        return reference;
    }
    Public Class RCWrapper{
        Public Risk_Capture__c rc {get; set;}
        Public Boolean isSelected {get; set;}
        public RCWrapper(){
            rc=new Risk_Capture__c();
            isSelected=false;
        } 
    }
    Public Class AssetWrapper{
        Public Asset__c ass {get; set;}
        Public Boolean isSelected {get; set;}
        public AssetWrapper(){
            ass=new Asset__c();
            isSelected=false;
        } 
    }
    Public Class RiskRatingWrapper{
        Public VG_Policy_Schedule_Asset__c RR {get; set;}
        Public Boolean isSelected {get; set;}
        public RiskRatingWrapper(){
            RR=new VG_Policy_Schedule_Asset__c();
            isSelected=false;
        }
    }
    Public Class PSEndorsementWrapper{
        Public VG_Policy_Schedule_Endorsement__c PSE {get; set;}
        Public Boolean isSelected {get; set;}
        public PSEndorsementWrapper(){
            PSE=new VG_Policy_Schedule_Endorsement__c();
            isSelected=false;
        }
    }
}