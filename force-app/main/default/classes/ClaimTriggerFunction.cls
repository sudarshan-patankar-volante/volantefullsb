Public Class ClaimTriggerFunction{
    Public Static Void Handler(List<Claim__c> TriggerNew,List<Claim__c> TriggerOld,Map<Id,Claim__c> TriggerNewMap,Map<Id,Claim__c> TriggerOldMap,Boolean IsBefore,Boolean IsAfter,Boolean IsInsert,Boolean IsUpdate,Boolean IsDelete){
        if(IsBefore && IsInsert){
            ClaimNumber(TriggerNew);
        }
        if(IsBefore && IsUpdate){          
              
        }
        if(IsAfter && (IsInsert||IsUpdate)){
            updateRollups(TriggerNew);
            UpdateRollUpAccountFields(TriggerNew);
        }
        if(IsBefore && IsDelete){
            
        }
    }
   
   public static void UpdateRollUpAccountFields(List<Claim__c> TriggerNew){                
        
        Set<Id> accIds = new Set<Id>();        
        for (Claim__c cl : TriggerNew){
            accIds.add(cl.Account__c);
        } 
        List<Claim__c> listOfAllClamies = [select id, Name ,Account__c,Total_Claim_Reserve__c,Total_Claims_Paid__c,Total_Claims_O_S__c from Claim__c where Account__c IN :accIds];       
        List<Claim__c> subListOfAllClamies;
        List<Account> AccountToBeUpdated = new List<Account>();
        Map<Id, List<Claim__c>> AccountClaimMap = new Map<Id, List<Claim__c>>();
        for(Claim__c c: listOfAllClamies){
            if(AccountClaimMap.get(c.Account__c) == null){
                subListOfAllClamies = new List<Claim__c>();
            }else{
                subListOfAllClamies = AccountClaimMap.get(c.Account__c);
            }
            subListOfAllClamies.add(c);
            AccountClaimMap.put(c.Account__c, subListOfAllClamies);
        } 
        for(Id AccountId : AccountClaimMap.keySet()){
            if(AccountId != null){
                Decimal paid = 0;
                Decimal reserve = 0;
                Decimal os = 0;
                for(Claim__c c: AccountClaimMap.get(AccountId)){
                     if(c.Total_Claims_O_S__c != null)
                        os=os+c.Total_Claims_O_S__c;
                    if(c.Total_Claims_Paid__c != null)
                        paid=paid+c.Total_Claims_Paid__c;
                    if(c.Total_Claim_Reserve__c != null)                
                        reserve=reserve+c.Total_Claim_Reserve__c;
                }
                Account tempAccount = new Account();
                tempAccount.Id = AccountId;
                tempAccount.Total_claims_o_s__c=os;
                tempAccount.Total_claims_paid__c=paid;
                tempAccount.Total_claims_reserve__c=reserve;
                if(tempAccount.Id != null)
                    AccountToBeUpdated.add(tempAccount);
            }
        }
        if(!AccountToBeUpdated.IsEmpty()){
            Update AccountToBeUpdated;
        }                          
    } 
    
    public static void ClaimNumber(List<Claim__c> TriggerNew){
        Set<ID> PolId=new Set<ID>();
        for(Claim__c cl:TriggerNew){
            PolId.add(cl.Policy_Number__c);
        }
        Map<Id,Policy__c> mapPolicy=new Map<Id,Policy__c>([Select Id,Name From Policy__c where id IN: PolId]);
        List<Claim__c> claimList =new List<Claim__c>([Select Id,Name,Policy_Number__r.Name From Claim__c where Policy_Number__c IN:mapPolicy.keyset()]);
        //map<Id,Integer> mapclaim=new Map<Id,Integer>();
        Map<Id,List<Claim__c>> mapclaim=new map<Id,List<Claim__c>>();
        for(Claim__c c:claimList){ 
             if(mapclaim.containsKey(c.Policy_Number__c)){
                List<Claim__c> cList = mapclaim.get(c.Policy_Number__c);
                cList.add(c);
                mapclaim.put(c.Policy_Number__c, cList);
             }else{
                mapclaim.put(c.Policy_Number__c, new List<Claim__c> { c });
             }
         } 
         
         for(Claim__c cl : TriggerNew){
             if(mapPolicy.get(cl.Policy_Number__c).Id==cl.Policy_Number__c){
                 Integer num;
                 if(mapclaim.get(cl.Policy_Number__c)!=null){
                     num=mapclaim.get(cl.Policy_Number__c).size()+1;
                 }else{
                     num=1;  
                 }
                 cl.Name=mapPolicy.get(cl.Policy_Number__c).Name+'/CLM/'+num;                   
             }
        }                                         
    }
    
    public static void updateRollups(List<Claim__c> TriggerNew){
        Set<Id> policyIds = new Set<Id>();
        for(Claim__c c: TriggerNew){
            policyIds.add(c.Policy_Number__c);
        }
        List<Claim__c> listOfAllClaims = [Select Id, Policy_Number__c, Total_Claim_Reserve__c, Total_Claims_Paid__c, Total_Claims_O_S__c from Claim__c where Policy_Number__c IN: policyIds];
        List<Claim__c> subListOfAllClaims;
        List<Policy__c> policiesToBeUpdated = new List<Policy__c>();
        Map<Id, List<Claim__c>> policyClaimMap = new Map<Id, List<Claim__c>>();
        for(Claim__c c: listOfAllClaims){
            if(policyClaimMap.get(c.Policy_Number__c) == null){
                subListOfAllClaims = new List<Claim__c>();
            }else{
                subListOfAllClaims = policyClaimMap.get(c.Policy_Number__c);
            }
            subListOfAllClaims.add(c);
            policyClaimMap.put(c.Policy_Number__c, subListOfAllClaims);
        }
        for(Id policyId : policyClaimMap.keySet()){
            Decimal paid = 0;
            Decimal reserve = 0;
            Decimal os = 0;
            for(Claim__c c: policyClaimMap.get(policyId)){
                paid = paid + c.Total_Claims_Paid__c;
                reserve = reserve  + c.Total_Claim_Reserve__c;
                os = os + c.Total_Claims_O_S__c;
            }
            Policy__c tempPolicy = new Policy__c();
            tempPolicy.Id = policyId;
            tempPolicy.Total_claims_paid__c = paid;
            tempPolicy.Total_claims_reserve__c = reserve;
            tempPolicy.Total_claims_o_s__c = os;
            policiesToBeUpdated.add(tempPolicy);
        }
        if(!policiesToBeUpdated.IsEmpty()){
            Update policiesToBeUpdated;
        }
    }
}