Public Class VG_Edit_Governance_Compliance_Controller{
    
    public Id policyId {get; set;}
    
    public String psid{get;set;}
    
    public VG_Governance_Compliance__c gc{get;set;}    
    public Policy__c policy{get;set;}
    public Map<Id,Policy_Schedule__c> psMap{get;set;}
    public List<SelectOption> psList{get;set;}
    
    public Policy_Schedule__c ps{get;set;}
    
    public VG_Edit_Governance_Compliance_Controller(){
        policyId = apexpages.currentpage().getparameters().get('Id');
        policy=[select id,VG_Deadline__c,Name,VG_Governance_Compliance__c,RecordType.Name,Type_of_Insurance__c,Line_Of_Business__c,VG_Inception_Date__c,VG_Lead_or_Follow__c,Broker_Name__r.Name,Insured__r.Name,Insured__r.Business_Description__c,VG_Expiry_Date__c,VG_Territorial_Limits__c,VG_Wording__c,VG_Policy_Currency__c from Policy__c where id=:policyId];
        psMap=new Map<Id,Policy_schedule__c>([select id,Name,Policy__r.CreatedDate,Limit__c,Attachment__c,Sum_Insured__c,Share__c,VG_Total_Layer_Premium__c,Product__c,Gross_Written_Premium__c,VG_Brokerage_Amount__c from Policy_Schedule__c where Policy__c =: policy.id]);
        System.debug('Recordtype::'+policy.RecordType.Name);
        psMap.values().sort();
        psList=new List<SelectOption>();
        psList.add(new SelectOption('--None--','--None--'));
        ps=new Policy_Schedule__c();
        for(Policy_Schedule__c ps: psMap.values()){
            System.debug('7.2.2019::'+ps);
            psList.add(new SelectOption(ps.id,ps.Name));
        }
        if(policy.VG_Governance_Compliance__c !=null){
            gc=[select id,VG_Referral__c,VG_Referral_completed_By__c,VG_Peer_Review__c,VG_Policy_Issuance_Date__c,VG_Deadline__c,VG_Contact_Certainty_Date__c,VG_Reason_for_Referral__c,VG_Referred_to__c,Referred_to__c,VG_Rating_Considerations__c,VG_Proposed_Terms__c,VG_Referral_Underwirter_Comments__c,VG_Referral_Complete__c,VG_Documents_attached__c,VG_Contract_Certainty_Comments__c,VG_Contract_Certainty__c,Name,VG_Question_1__c,VG_Question_2__c,VG_Question_3__c,VG_Question_4__c,VG_Question_5__c,VG_Question_6__c,VG_Question_7__c,VG_Question_8__c,VG_Question_9__c,VG_Question_10__c,VG_Question_11__c,VG_Peer_Reviewer_2__c,VG_Peer_Reviewer_1__c,VG_Peer_Review_1_Comments__c,VG_Peer_Review_2_Comments__c,VG_Peer_Review_1_Complete__c,VG_Peer_Review_2_Complete__c,VG_Peer_Review_1_Date__c,VG_Peer_Review_2_Date__c,VG_Slip_Reference_No__c,VG_Loss_History__c,VG_Pricing_Rationale__c,VG_UW_Consideration__c,VG_Key_Clauses_Exclusions__c,VG_Conditions_Subjectivites__c from VG_Governance_Compliance__c where id=:policy.VG_Governance_Compliance__c limit 1];
        }else{
            gc=new VG_Governance_Compliance__c();
            gc.Name='Governance Compliance for policy '+policy.Name;
        }
    }
    Public PageReference cancel(){
        return new PageReference('/'+policyId);
    }
    public void setPSValues(){
        if(psid !='--None--'){
            ps=psMap.get(psid);
            
        }
    }
    Public Pagereference createGC(){
        if(gc.VG_Peer_Review_1_Complete__c)
            gc.VG_Peer_Review_1_Date__c=System.today();
        if(gc.VG_Peer_Review_2_Complete__c)
            gc.VG_Peer_Review_2_Date__c=System.today();
        if(gc.VG_Contract_Certainty__c)
            gc.VG_Contact_Certainty_Date__c=System.today();
        if(policy.VG_Governance_Compliance__c !=null){
            update gc;
            Policy__c tmp=new Policy__c();
            tmp.id=policy.id;
            tmp.VG_Deadline__c=policy.VG_Deadline__c;
            update tmp;
        }else{
            insert gc;
            Policy__c tmp=new Policy__c();
            tmp.id=policy.id;
            tmp.VG_Governance_Compliance__c=gc.id;
            tmp.VG_Deadline__c=policy.VG_Deadline__c;
            update tmp;
        }
        return new PageReference('/'+policyId);
    }

}