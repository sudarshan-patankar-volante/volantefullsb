Public Class ClaimScheduleTriggerFunction{
    Public Static Void Handler(List<Claims_Schedule__c> TriggerNew,List<Claims_Schedule__c> TriggerOld,Map<Id,Claims_Schedule__c> TriggerNewMap,Map<Id,Claims_Schedule__c> TriggerOldMap,Boolean IsBefore,Boolean IsAfter,Boolean IsInsert,Boolean IsUpdate,Boolean IsDelete){
        if(IsBefore && IsInsert){
            ClaimScheduleName(TriggerNew);
        }
        if(IsBefore && IsUpdate){          
              
        }
        if(IsAfter && IsInsert){
        
        }
        if(IsBefore && IsDelete){
            
        }
    }
    public static void ClaimScheduleName(List<Claims_Schedule__c> TriggerNew){
        Set<ID> claimId=new Set<ID>();
        for(Claims_Schedule__c cs:TriggerNew){
            claimId.add(cs.Claim__c);
        }
        Map<Id,Claim__c> MapClaim=new Map<Id,Claim__c>([Select Id,Name From Claim__c where id IN: claimId]);
        List<Claims_Schedule__c> clsList =new List<Claims_Schedule__c>([Select Id,Name,Claim__c From Claims_Schedule__c where Claim__c IN:MapClaim.keyset()]);
        Map<Id,List<Claims_Schedule__c>> csMap=new map<Id,List<Claims_Schedule__c>>();
        for(Claims_Schedule__c cs:clsList){ 
             if(csMap.containsKey(cs.Claim__c)) {
                    List<Claims_Schedule__c> csList = csMap.get(cs.Claim__c);
                    csList.add(cs);
                    csMap.put(cs.Claim__c, csList);
                } else {
                    csMap.put(cs.Claim__c, new List<Claims_Schedule__c> { cs });
                }
         } 
         
           for(Claims_Schedule__c cs : TriggerNew){
                 if(MapClaim.get(cs.Claim__c).Id==cs.Claim__c){
                     Integer num;    
                     if(csMap.get(cs.Claim__c)!=null)
                        num=csMap.get(cs.Claim__c).size()+1;
                     else{
                         num=1;
                     }
                     cs.Name=MapClaim.get(cs.Claim__c).Name+'/CS/'+num;                    
                 }
            }
                                                     
    }
}