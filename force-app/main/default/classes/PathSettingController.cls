Public Class PathSettingController{       
    @AuraEnabled
    public Static String getPSGWP(String policyId){
        String message='';
        List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([select id,Name,Gross_Written_Premium__c,RecordType.Name from Policy_Schedule__c where Policy__c =: policyId AND (Gross_Written_Premium__c = 0 OR Gross_Written_Premium__c = null)]);
        for(Policy_Schedule__c ps: psList){
            message += 'GWP has to be > 0 before quoted stage '+ps.Name+' <br/>';
        }
        System.debug('msg::'+message);
        return message;
    }       
}