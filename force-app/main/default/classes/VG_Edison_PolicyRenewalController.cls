Public Class VG_Edison_PolicyRenewalController{
    
    public String policyId {get;set;}
    public Boolean isHide{get;set;}
    public Boolean IsRenewal {get;set;}
    public Boolean IsRRSelected {get;set;}
    public Policy__c policy{get;set;}
    public Policy__c renewalPolicy{get;set;}
    public VG_Policy_Schedule_Asset__c psa{get;set;}
    public Policy_Schedule__c ps{get;set;}
    public VG_Policy_Schedule_Endorsement__c pse{get;set;}
    
    public List<RRwrap> rrWrapList{get;set;}
    public List<PSEwrap> pseWrapList{get;set;}
    public List<VG_Policy_Schedule_Asset__c > psaList{get;set;}
    public List<VG_Policy_Schedule_Endorsement__c > pseList{get;set;}
    
    public Map<id,Policy_Schedule__c > psMap{get;set;}
    
    public VG_Edison_PolicyRenewalController(){
        policyId = apexpages.currentpage().getparameters().get('Id');
        policy=[select id, Name, CurrencyIsoCode, RecordTypeId, CreatedDate, CreatedById, VG_Programme_Reference_Number__c,VG_Programme_Reference_Number__r.Name, LastModifiedDate, LastModifiedById, Insured__c, AP_TP__c, Adjustment_Reason__c, Am_I_Underwriter__c, Broker_Name__c, Declaration_Type__c, Deductible_or_Excess_Amount__c, Deductible_or_Excess_Basis__c, Formula_Sum_Insured_Share__c, Inception_Expiry_Time__c, IsApproved_External__c, Line_Of_Business__c, Payment_Frequency__c, Policy_Basis__c, Policy_Status__c, Risk_Assessor__c, Sum_Insured_Share__c, Total_Sum_Insured__c, Type_of_Insurance__c, Underwriter__c, VG_Aggregate_Limit__c, VG_Booked_Time__c, VG_Bound_Booked__c, VG_Bound_Time__c, VG_Brokerage_Percent__c, VG_Current_Insurer__c, VG_Expiry_Date__c, VG_Inception_Date__c, VG_IsApproved__c, VG_Prospect_Premium__c, VG_Quoted_Bound__c, VG_Quoted_Time__c, VG_Sub_Broker__c, VG_Sub_Status__c, IPT__c, Gross_Written_Premium__c, Gross_Written_Premium_Rollup__c, VG_Brokerage_Amount__c, Earned_Aggregate_Balance__c, Extended_Reporting__c, Lead_Insurer__c, Loss_Ratio__c, Retroactive_Date__c, Total_Aggregate_Balance__c, Actual_GWP__c, Total_claims_o_s__c, MTA_Cancel_List__c, Endorsement_GWP__c, Jurisdiction__c, Levies__c, Premium_Adjustment__c, Risk_Premium__c, Technical_Model_Premium__c, Technical_UW_Premium__c, Total_claims_paid__c, Paid_Aggregate_Balance__c, VG_Fee_Income__c, VG_MGA_Commission_Amount__c, VG_Lloyds_Products__c, Total_claims_reserve__c, VG_Additional_Insureds__c, VG_Continuous_Cover_Date__c, VG_Local_Policies__c, VG_Plan_Rate__c, VG_Territorial_Limits__c, VG_Wording__c, Commercial_Adjustment__c, Transaction_GWP__c, VG_Is_Renewal__c, VG_Renewal_Policy_Id__c from Policy__c where id=:policyid limit 1];
        IsRenewal =false;
        isHide=true;
        renewalPolicy=new Policy__c();
        renewalPolicy=policy.clone(false,true,false,false);
        renewalPolicy.VG_Is_Renewal__c=true;
        renewalPolicy.VG_Inception_Date__c=policy.VG_Inception_Date__c.addYears(1);
        renewalPolicy.VG_Expiry_Date__c=policy.VG_Expiry_Date__c.addYears(1);
        ps= new Policy_Schedule__c();
        rrWrapList=new List<RRwrap>();
        pseWrapList=new List<PSEwrap>();
        Set<ID> psids=new Set<ID>();
        psMap=new Map<Id,Policy_Schedule__c >([select id,Name, Policy__r.VG_Renewal_Policy_Id__c,IPT_Percent__c, VG_Capacity_Paper__c,Gross_Written_Premium__c,Levies__c, Policy__c, Premium_Adjustment__c, VG_IsTempDelete__c, VG_Is_MTA__c, VG_IsTemp__c, VG_Declaration_Type__c, VG_Brokerage_Percent__c, VG_Technical_Model_Premium__c, Base_Creation_End_Date__c, Base_Creation_Start_Date__c, VG_Fee_Income__c , Product__c, Policy__r.VG_Expiry_Date__c, Policy__r.VG_Inception_Date__c,VG_VAT__c,VG_VAT_Amount__c, VG_Adjustment_Reason__c , MTA_Reason_for_Cancellation__c from Policy_Schedule__c where Policy__c =: policy.id]);
        psaList=new List<VG_Policy_Schedule_Asset__c >([select id,Name,VG_Number_of_Vehicles__c,VG_Rate_change__c,VG_Model_Rate__c,Technical_UW_Premium__c,VG_Vehicle_Type__c,VG_Coverage__c,VG_IsTempDelete__c,VG_IsTemp__c,VG_Use__c, VG_Rate_Per_Vehicle__c,VG_Premium__c, VG_Deductible__c,VG_Technical_UW_Rate_Annual__c   from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psMap.keyset()  ORDER By Name DESC]);
        pseList=new List<VG_Policy_Schedule_Endorsement__c >([select id,VG_Endorsement_Number__c,Name,VG_Title__c,VG_IsTempDelete__c,VG_IsTemp__c,VG_Premium__c,VG_Endorsement_Details__c,VG_Endorsement_Library_Id__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c IN: psMap.keyset()  ORDER By Name DESC]);
        IsRRSelected =false;
        for(VG_Policy_Schedule_Asset__c psa:psaList){
            RRwrap rrw=new RRwrap();
            rrw.isSelected=false;
            rrw.psa=psa;
            rrWrapList.add(rrw);
        }
        for(VG_Policy_Schedule_Endorsement__c pse:pseList){
            PSEwrap psew=new PSEwrap();
            psew.isSelected=false;
            psew.pse=pse;
            pseWrapList.add(psew);
        }
    }
    Public PageReference Cancel(){
        return new PageReference('/'+policyId);
    }
    public PageReference gotostep1(){
        return new PageReference('/apex/VG_Edison_Policy_Renewal_Step1');
    }
    public PageReference gotostep2(){
        if(renewalPolicy.VG_Inception_Date__c.monthsBetween(renewalPolicy.VG_Expiry_Date__c) > 18){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'months between inception date and expiry date must below 18..'));
            return null;
        }else{
            return new PageReference('/apex/VG_Edison_Policy_Renewal_Step2');
        }    
    }
    public PageReference gotostep3(){
        for(RRwrap rrw:rrWrapList){
           If(rrw.isSelected==True){
               IsRRSelected =true;
           }
        }
        If(IsRRSelected ==false){
           ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please add atleast one asset to the policy schedule..'));                                 
           return null;
        }
       return new PageReference('/apex/VG_Edison_Policy_Renewal_Step3');
        
    } 
    public PageReference Next(){
        isHide=false;
        renewalPolicy.Policy_Status__c='Prospect';
        renewalPolicy.VG_Sub_Status__c='Lapsed';
        renewalPolicy.CurrencyIsoCode=policy.CurrencyIsoCode;
        renewalPolicy.VG_Governance_Compliance__c = null;
        
        //Generating ProgramReferenceNumber
        VG_Programme__c pgm;
        if(policy.VG_Programme_Reference_Number__c != null){
            String[] pgName = policy.VG_Programme_Reference_Number__r.Name.split('/');
            String newPGName = pgName[0]+'/'+pgName[1]+'/'+pgName[2]+'/'+pgName[3]+'/'+(Integer.valueOf(pgName[4])+1);
            List<VG_Programme__c> renewPG = [Select Id from VG_Programme__c where Name =: newPGName];
            if(!renewPG.IsEmpty()){
                pgm = renewPG[0];
            }else{
                pgm = new VG_Programme__c();
                pgm.Name = newPGName;
                Insert pgm;
            } 
            renewalPolicy.VG_Programme_Reference_Number__c = pgm.id;
        }
        //Generating ProgramReferenceNumber
        
        Insert renewalPolicy;
        policy.VG_Renewal_Policy_Id__c=renewalPolicy.id;
        update policy;
        renewalPolicy=[select id,Name,CurrencyIsoCode,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,Insured__c,AP_TP__c,Adjustment_Reason__c,Am_I_Underwriter__c,Broker_Name__c,Declaration_Type__c,Deductible_or_Excess_Amount__c,Deductible_or_Excess_Basis__c,Formula_Sum_Insured_Share__c,Inception_Expiry_Time__c,IsApproved_External__c,Line_Of_Business__c,Payment_Frequency__c,Policy_Basis__c,Policy_Status__c,Risk_Assessor__c,Sum_Insured_Share__c,Total_Sum_Insured__c,Type_of_Insurance__c,Underwriter__c,VG_Aggregate_Limit__c,VG_Booked_Time__c,VG_Bound_Booked__c,VG_Bound_Time__c,VG_Brokerage_Percent__c,VG_Current_Insurer__c,VG_Expiry_Date__c,VG_Inception_Date__c,VG_IsApproved__c,VG_Prospect_Premium__c,VG_Quoted_Bound__c,VG_Quoted_Time__c,VG_Sub_Broker__c,VG_Sub_Status__c,IPT__c,Gross_Written_Premium__c,Gross_Written_Premium_Rollup__c,VG_Brokerage_Amount__c,Earned_Aggregate_Balance__c,Extended_Reporting__c,Lead_Insurer__c,Loss_Ratio__c,Retroactive_Date__c,Total_Aggregate_Balance__c,Actual_GWP__c,Total_claims_o_s__c,MTA_Cancel_List__c,Endorsement_GWP__c,Jurisdiction__c,Levies__c,Premium_Adjustment__c,Risk_Premium__c,Technical_Model_Premium__c,Technical_UW_Premium__c,Total_claims_paid__c,Paid_Aggregate_Balance__c,VG_Fee_Income__c,VG_MGA_Commission_Amount__c,VG_Lloyds_Products__c,Total_claims_reserve__c,VG_Additional_Insureds__c,VG_Continuous_Cover_Date__c,VG_Local_Policies__c,VG_Plan_Rate__c,VG_Territorial_Limits__c,VG_Wording__c,Commercial_Adjustment__c,Transaction_GWP__c,VG_Is_Renewal__c,VG_Renewal_Policy_Id__c from Policy__c where id=:renewalPolicy.id limit 1];
        ps.Policy__c=renewalPolicy.id;
        System.debug('renewalPolicy::'+renewalPolicy);
        ps.Name=renewalPolicy.Name+'/PS/0';
        ps.CurrencyIsoCode=renewalPolicy.CurrencyIsoCode;
        if(renewalPolicy.Line_Of_Business__c == 'ULR'){
            ps.VG_Capacity_Paper__c = 'ULR';
        }else{
            string firstelement = (new list<Id>(psMap.keySet()))[0] ;
            ps.VG_Capacity_Paper__c = psMap.get(firstelement).VG_Capacity_Paper__c;
            
        }
        Insert ps;
        IsRenewal=True;
        List<VG_Policy_Schedule_Asset__c > rppsaList=new List<VG_Policy_Schedule_Asset__c >();
        List<VG_Policy_Schedule_Endorsement__c > rppseList=new List<VG_Policy_Schedule_Endorsement__c >();
        for(RRwrap rrw:rrWrapList){
            if(rrw.isSelected){
                psa=new VG_Policy_Schedule_Asset__c();
                psa=rrw.psa.clone(false,true,false,false);
                rppsaList.add(psa);
            }          
        }
        for(PSEwrap psew:pseWrapList){
            if(psew.isSelected){
                pse=psew.pse;
                pse.id=null;
                rppseList.add(pse);
            }
        }
        Integer psacount=1;
        Integer psecount=1;
        for(VG_Policy_Schedule_Asset__c psa:rppsaList){
            psa.VG_Policy_Schedule__c=ps.id;
            psa.Name=ps.name+'/RR/'+psacount;
            psa.CurrencyIsoCode=renewalPolicy.CurrencyIsoCode;
            psacount++;
            
        }
        for(VG_Policy_Schedule_Endorsement__c pse:rppseList){
            pse.VG_Policy_Schedule__c=ps.id;
            pse.Name=ps.name+'/PE/'+psecount;
            pse.CurrencyIsoCode=renewalPolicy.CurrencyIsoCode;
            psecount++;
            System.debug('28.3.2019::'+pse+'::'+pse.VG_Endorsement_Number__c);   
        }
        if(!rppsaList.IsEmpty()){
            insert rppsaList;
        }
        if(!rppseList.IsEmpty()){
            Insert rppseList;
        }
        return new PageReference('/apex/VG_EdisonPS_Edit1?PSId='+ps.id+'&oldpolicyId='+policy.Id+'&renewpolicyid='+renewalPolicy.id+'&IsRenewal='+IsRenewal);
    } 
   
    Public Class RRwrap{
        public boolean isSelected{get;set;}
        public VG_Policy_Schedule_Asset__c psa{get;set;}
    }
    Public Class PSEwrap{
        public boolean isSelected{get;set;}
        public VG_Policy_Schedule_Endorsement__c pse{get;set;}
    }
}