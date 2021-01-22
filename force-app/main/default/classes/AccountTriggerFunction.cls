/*

 *Created By : Siddik
 
 *Created On : 16-11-2017
 
 *JIRA.No    : VG-5
 
 *Test Class : AccountTriggerFunctionTest
*/
Public Class AccountTriggerFunction{
    Public Static Void Handler(List<Account> TriggerNew,List<Account> TriggerOld,Map<Id,Account> TriggerNewMap,Map<Id,Account> TriggerOldMap,Boolean IsBefore,Boolean IsAfter,Boolean IsInsert,Boolean IsUpdate,Boolean IsDelete){
        if(IsAfter && (IsInsert || IsUpdate)){
            VG_Functionality_Switches__c comlianceSwitch = VG_Functionality_Switches__c.getInstance();
            if(comlianceSwitch.Compliance_Check__c)
                ComplyAdvantageCheck(TriggerOldMap,TriggerNewMap, IsInsert, IsUpdate);
        }
    }
    
    Public Static Void ComplyAdvantageCheck(Map<Id,Account> TriggerOldMap,Map<Id,Account> TriggerNewMap, Boolean IsInsert, Boolean IsUpdate){
        Set<Id> accountIds = new Set<Id>();
        if(IsInsert){
            accountIds.addAll(TriggerNewMap.keySet());
        }else{
            for(Account acc : TriggerNewMap.values()){
                if(acc.Name != TriggerOldMap.get(acc.Id).Name){
                    accountIds.add(acc.Id);
                }
            }
        }
        if(!accountIds.IsEmpty()){
            ComplyAdvantageCheck.check(accountIds);
        }
    }
}