/*@Created By: Anusuya
 *
 *@Created On: 16-Nov-2017
 *
 *@JIRA Number: VG-6
 *
 *@TestClasses: ContactTriggerFunction_Test
 */
 
Public Class ContactTriggerFunction{
    Public Static Void Handler(List<Contact> TriggerNew,List<Contact> TriggerOld,Map<Id,Contact> TriggerNewMap,Map<Id,Contact> TriggerOldMap,Boolean IsBefore,Boolean IsAfter,Boolean IsInsert,Boolean IsUpdate,Boolean IsDelete){
        if(IsBefore && (IsInsert||IsUpdate)){
            
        }
        if(IsBefore && IsUpdate){          
              
        }
        if(IsAfter && IsInsert){
        
        }
        if(IsAfter && IsUpdate){
        
        }
        if(IsBefore && IsDelete){
            
        }
    }
}