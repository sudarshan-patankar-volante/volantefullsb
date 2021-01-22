Public Class VG_Governance_Compliance_Controller{
    
    public Id policyId {get; set;}
    
    public VG_Governance_Compliance__c gc{get;set;}    
    public Policy__c policy{get;set;}
    public VG_Governance_Compliance_Controller(ApexPages.StandardController stdController){
        policy= (Policy__c )stdController.getRecord();
        gc=[select id,Name,VG_Question_1__c,VG_Question_6__c,VG_Question_2__c,VG_Question_11__c,Referred_to__c,VG_Question_7__c,VG_Question_3__c,VG_Question_8__c,VG_Question_4__c,VG_Question_9__c,VG_Question_5__c,VG_Question_10__c,VG_Contact_Certainty_Date__c,VG_Contract_Certainty__c from VG_Governance_Compliance__c where id=:policy.VG_Governance_Compliance__c ];
    }
}