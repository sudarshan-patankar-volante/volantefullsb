/*

 *Created By : Siddik
 
 *Created On : 10-09-2018
 
 *JIRA.No    : -
 
 *Test Class : PolicyScheduleAssetTriggeFunctionTest
 
*/

Public Class PolicyScheduleAssetTriggerFunction{

    Public Static Void Handler(List<VG_Policy_Schedule_Asset__c> TriggerNew,List<VG_Policy_Schedule_Asset__c> TriggerOld,Map<Id,VG_Policy_Schedule_Asset__c> TriggerNewMap,Map<Id,VG_Policy_Schedule_Asset__c> TriggerOldMap,Boolean IsBefore,Boolean IsAfter,Boolean IsInsert,Boolean IsUpdate,Boolean IsDelete){
        if(IsAfter && (IsInsert||IsUpdate)){
            updatePolicyScheduleRollups(TriggerNew,TriggerNewMap);
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
    Public Static Void updatePolicyScheduleRollups(List<VG_Policy_Schedule_Asset__c> TriggerNew,Map<Id,VG_Policy_Schedule_Asset__c> TriggerNewMap){
        Set<ID> psIds=new Set<ID>();
        for(VG_Policy_Schedule_Asset__c psa: TriggerNew){
            psIds.add(psa.VG_Policy_Schedule__c);
        }
        List<VG_Policy_Schedule_Asset__c> psaList=new List<VG_Policy_Schedule_Asset__c>([select id,VG_Policy_Schedule__c, VG_Coverage__c,VG_Number_of_Vehicles__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psIds]);
        Map<id,List<VG_Policy_Schedule_Asset__c>> psMap=new Map<id,List<VG_Policy_Schedule_Asset__c>>();
        List<Policy_Schedule__c> psList=new List<Policy_Schedule__c>();
        for(VG_Policy_Schedule_Asset__c psa: psaList){
            if(psMap.containsKey(psa.VG_Policy_Schedule__c)) {
                List<VG_Policy_Schedule_Asset__c> psaList1 = psMap.get(psa.VG_Policy_Schedule__c);
                psaList1.add(psa);
                psMap.put(psa.VG_Policy_Schedule__c, psaList1);
            } else {
                psMap.put(psa.VG_Policy_Schedule__c, new List<VG_Policy_Schedule_Asset__c> { psa });
            }
        }
        for(Id ps: psMap.KeySet()){
            Decimal NOV=0;
            String COV='';
            for(VG_Policy_Schedule_Asset__c psa : psMap.get(ps)){
                if(psa.VG_Number_of_Vehicles__c != null)
                NOV = NOV + psa.VG_Number_of_Vehicles__c;
                if(COV == ''){
                    COV=psa.VG_Coverage__c;
                }else if(psa.VG_Coverage__c != null && psa.VG_Coverage__c != COV ){
                    COV='Mixed';
                }
            }
            System.debug('10-09 Test::'+COV+'::'+NOV);
            Policy_Schedule__c temPs=new Policy_Schedule__c();
            temPs.id=ps;
            temPs.VG_Coverages__c=COV;
            temPs.VG_Number_Of_vehicle__c=NOV;
            psList.add(temPs);
        }
        if(!psList.IsEmpty()){
            update psList;
        }
    }
}