Public Class VG_Revise_Nordics_Step0_Controller{
    public Id PID {get; set;}
    public Policy__c policy{get;set;}
    public List<SelectOption> MTAtypes {get; set;}
    public String seletedType {get; set;}
    public VG_Revise_Nordics_Step0_Controller(){
        PID = apexpages.currentpage().getparameters().get('PId');
        policy = [select id, Name, CurrencyISOCode from Policy__c where id=:PID];
        MTATypes = new List<SelectOption>();
        MTATypes.add(new SelectOption('--Select--','--Select--'));
        MTATypes.add(new SelectOption('Extension','Extension'));
        MTATypes.add(new SelectOption('Cancellation','Cancellation'));
        MTATypes.add(new SelectOption('Reduction', 'Reduction'));
    }
    public PageReference Next(){
        PageReference reference;
        if(seletedType == '--Select--'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select MTA type.')); 
            return null;
        }
        if(seletedType != 'Change Broker'){
            reference=new PageReference('/apex/VG_Revise_Nordics_Step5');
            reference.getParameters().put('MTAType',seletedType );
            reference.getParameters().put('policyid',PId);
            reference.getParameters().put('IsMTA','True');
            reference.getParameters().put('policyCurrency',policy.CurrencyISOCode);
            reference.setRedirect(true);
            return reference;
        }else{
            return new PageReference('/apex/ChangeBroker?Id='+PID);
        }
    }
    public PageReference Cancel(){
        PageReference reference=new PageReference('/'+PID);
        reference.setRedirect(true);
        return reference;
    }
}