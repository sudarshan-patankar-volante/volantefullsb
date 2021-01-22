Public Class ChangeBrokerController{
    
    public Policy__c policy{get;set;}
    
    public String PolicyId{get;set;}
    
    public ChangeBrokerController(){
        PolicyId =  apexpages.currentpage().getparameters().get('Id');
        policy = [select id, Name, Broker_Contact__c, Broker_Name__c from Policy__c where Id =: PolicyId limit 1];
        policy.Broker_Name__c = null;
        policy.Broker_Contact__c = null;
    }
    
    public PageReference cancel(){
        return new PageReference('/'+policy.id);
    }
    
    public PageReference save(){
        if(policy.Broker_Contact__c == null){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please fill Broker Cantact.')); 
            return null;
        }
        try{
        
            update policy;
            return new PageReference('/'+policy.id);
        }Catch(Exception e){
            return null;
        }
    }
    
}