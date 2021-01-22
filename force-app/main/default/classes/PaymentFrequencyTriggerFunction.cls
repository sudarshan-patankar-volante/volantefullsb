Public Class PaymentFrequencyTriggerFunction{
    
    Public Static Void Handler(List<VG_Payment_Frequency__c> TriggerNew,List<VG_Payment_Frequency__c> TriggerOld,Map<Id,VG_Payment_Frequency__c> TriggerNewMap,Map<Id,VG_Payment_Frequency__c> TriggerOldMap,Boolean IsBefore,Boolean IsAfter,Boolean IsInsert,Boolean IsUpdate,Boolean IsDelete){
        if(IsBefore && IsInsert){
            checkDueDate(TriggerNew);
        }
        if(IsBefore && IsUpdate){          
            
        }
        if((IsAfter && IsInsert)){
           
        }
        if(IsAfter && IsUpdate){
            
        }
        if(IsBefore && IsDelete){
            
        }
    }
    public static void checkDueDate(List<VG_Payment_Frequency__c> TriggerNew){
        Set<ID> psIds=new Set<ID>();
        for(VG_Payment_Frequency__c pf: TriggerNew){
            psIds.add(pf.VG_Policy_Schedule__c);
        }
        
        List<VG_Payment_Frequency__c> pflist=new List<VG_Payment_Frequency__c>([select id,Name,VG_Policy_Schedule__r.Name,VG_Payment_Percent__c,VG_Comment__c,VG_Policy_Schedule__r.Gross_Written_Premium__c,VG_Outstanding_taxes__c,VG_Policy_Schedule__c,VG_Due_Date__c from VG_Payment_Frequency__c where VG_Policy_Schedule__c IN: psIds]);
        Map<Id,List<VG_Payment_Frequency__c>> pfMap=new Map<Id,List<VG_Payment_Frequency__c>>();
        for(VG_Payment_Frequency__c pf: pflist){
            if(pfMap.containsKey(pf.VG_Policy_Schedule__c)) {
                System.debug('here');
                List<VG_Payment_Frequency__c > pList = pfMap.get(pf.VG_Policy_Schedule__c);
                pList.add(pf);
                pfMap.put(pf.VG_Policy_Schedule__c, pList);
            } else {
                System.debug('here');
                pfMap.put(pf.VG_Policy_Schedule__c, new List<VG_Payment_Frequency__c > { pf });
            }
        }
        Map<Id,Policy_Schedule__c> psMap=new Map<Id,Policy_Schedule__c>([select Id, Name, RecordType.Name from Policy_Schedule__c where Id IN: psids]);
        for(VG_Payment_Frequency__c pf: TriggerNew){
            if(psMap.get(pf.VG_Policy_Schedule__c).RecordType.Name != 'Imara'){
                if(pfMap.containsKey(pf.VG_Policy_Schedule__c)){
                    for(VG_Payment_Frequency__c pfo:pfMap.get(pf.VG_Policy_Schedule__c)){
                        if(pf.VG_Due_Date__c == pfo.VG_Due_Date__c ){
                            pf.addError('Date Repeated');
                        }
                    }
                }
            }
        }
        Set<Id> pshids=new Set<ID>();
        Integer counter;
        for(VG_Payment_Frequency__c pf: TriggerNew){
            System.debug(pshids.contains(pf.VG_Policy_Schedule__c)+'::'+pshids);
            if(!pshids.contains(pf.VG_Policy_Schedule__c)){
                pshids.add(pf.VG_Policy_Schedule__c);
                if(pfMap.get(pf.VG_Policy_Schedule__c) != null)
                    counter=pfMap.get(pf.VG_Policy_Schedule__c).size();
                else
                    counter=0;
                pf.Name=psMap.get(pf.VG_Policy_Schedule__c).Name+'/PF/'+counter; 
                counter++;      
            }else{
                pf.Name=psMap.get(pf.VG_Policy_Schedule__c).Name+'/PF/'+counter; 
                counter++;  
            }
        }
    }      
}