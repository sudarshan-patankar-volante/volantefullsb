Public Class ClaimsProgressionTriggerFunction{
    Public Static Void Handler(List<Claims_Progression__c> TriggerNew,List<Claims_Progression__c> TriggerOld,Map<Id,Claims_Progression__c> TriggerNewMap,Map<Id,Claims_Progression__c> TriggerOldMap,Boolean IsBefore,Boolean IsAfter,Boolean IsInsert,Boolean IsUpdate,Boolean IsDelete){
        if(IsBefore && IsInsert){
            ClaimProgressionName(TriggerNew);
        }
        if(IsBefore && IsUpdate){          
              
        }
        if(IsAfter && IsInsert){
            createClaimBordereauxRecords(TriggerNew);
        }
        if(IsBefore && IsDelete){
            
        }
    }
    Public Static Void createClaimBordereauxRecords(List<Claims_Progression__c> TriggerNew){
        Set<ID> csSet=new Set<ID>();
        Set<String> recordTypeName=new Set<String>();
        for(Claims_Progression__c cp:TriggerNew){
            csSet.add(cp.VG_Claims_Schedule__c);
        }
        Map<ID,Schema.RecordTypeInfo> ps_rt_Map = Policy_Schedule__c.sObjectType.getDescribe().getRecordTypeInfosById();
        Map<ID,Schema.RecordTypeInfo> umr_rt_Map = VG_UMR__c.sObjectType.getDescribe().getRecordTypeInfosById();
        Map<id,Claims_Schedule__c> csMap=new Map<id,Claims_Schedule__c>([select id,Name,Claim__r.Risk_Inception_Date__c,VG_Policy_Schedule__r.RecordType.Name,VG_Policy_Schedule__r.RecordTypeId from Claims_Schedule__c where id IN: csSet]);
        for(Claims_Schedule__c cs: csMap.values()){
            if(!recordTypeName.contains(cs.VG_Policy_Schedule__r.RecordType.Name)){
                recordTypeName.add(cs.VG_Policy_Schedule__r.RecordType.Name);
            }
        }
        System.debug('recordTypeName::'+recordTypeName);
        Map<id,VG_UMR__c> umrMap=new Map<id,VG_UMR__c>([select id,Name,RecordTypeId,VG_RI_Inception_Date__c,VG_RI_Expiry_Date__c from VG_UMR__c  where RecordType.Name IN: recordTypeName]);
        System.debug('umrMap::'+umrMap.values());
        List<VG_Claim_Bordereaux__c> cbList=new List<VG_Claim_Bordereaux__c>();
        List<Claim__Share> claimsToBeShared = new List<Claim__Share>();
        for(Claims_Progression__c cp:TriggerNew){
            if(csMap.get(cp.VG_Claims_Schedule__c).Claim__r.Risk_Inception_Date__c !=null){
                for(VG_UMR__c u: umrMap.values()){
                    System.debug('test1::'+umr_rt_Map.get(u.RecordTypeId).getName()+'::'+csMap.get(cp.VG_Claims_Schedule__c).VG_Policy_Schedule__r.RecordType.Name);
                    if(umr_rt_Map.get(u.RecordTypeId).getName()==csMap.get(cp.VG_Claims_Schedule__c).VG_Policy_Schedule__r.RecordType.Name){                      
                    //if(u.RecordTypeId==csMap.get(cp.VG_Claims_Schedule__c).VG_Policy_Schedule__r.RecordTypeId){
                        System.debug('date::'+u.VG_RI_Inception_Date__c+'::'+csMap.get(cp.VG_Claims_Schedule__c).Claim__r.Risk_Inception_Date__c+'::'+u.VG_RI_Expiry_Date__c);
                        if(u.VG_RI_Inception_Date__c <=csMap.get(cp.VG_Claims_Schedule__c).Claim__r.Risk_Inception_Date__c  && u.VG_RI_Expiry_Date__c >= csMap.get(cp.VG_Claims_Schedule__c).Claim__r.Risk_Inception_Date__c){
                            System.debug('date::'+u.VG_RI_Inception_Date__c+'::'+csMap.get(cp.VG_Claims_Schedule__c).Claim__r.Risk_Inception_Date__c+'::'+u.VG_RI_Expiry_Date__c);
                            VG_Claim_Bordereaux__c tempCB=new VG_Claim_Bordereaux__c();
                            tempCB.CurrencyIsoCode=cp.CurrencyIsoCode;
                            tempCB.VG_Capacity_Details__c=u.id;
                            tempCB.VG_Claims_Progression__c=cp.id;
                            cbList.add(tempCB);
                            Claim__Share tempShare = new Claim__Share();
                            tempShare.ParentID = cp.Claim__c;
                            tempShare.UserOrGroupId = '00G0O000003A3s8';
                            tempShare.AccessLevel = 'Read';
                            claimsToBeShared.add(tempShare);
                        }
                    }
                }
            }
        }
        System.debug('cblist::'+cbList);
        if(!cbList.IsEmpty()){
            Insert cbList;
        }
        if(!claimsToBeShared.IsEmpty()){
            Insert claimsToBeShared;
        }
    }
    
        


    public static void ClaimProgressionName(List<Claims_Progression__c> TriggerNew){
        Set<ID> csId=new Set<ID>();
        for(Claims_Progression__c cp:TriggerNew){
            csId.add(cp.VG_Claims_Schedule__c);
        }
        Map<Id,Claims_Schedule__c> MapCsc=new Map<Id,Claims_Schedule__c>([Select Id,Name,Claim__r.Name From Claims_Schedule__c where id IN: csId]);
        List<Claims_Progression__c> cprList =new List<Claims_Progression__c>([Select Id,Name,VG_Claims_Schedule__c From Claims_Progression__c where VG_Claims_Schedule__c IN:MapCsc.keyset()]);
        Map<Id,List<Claims_Progression__c>> cpMap=new map<Id,List<Claims_Progression__c>>();
        for(Claims_Progression__c cp:cprList){ 
             if(cpMap.containsKey(cp.VG_Claims_Schedule__c)) {
                    List<Claims_Progression__c> cpList = cpMap.get(cp.VG_Claims_Schedule__c);
                    cpList.add(cp);
                    cpMap.put(cp.VG_Claims_Schedule__c, cpList);
                } else {
                    cpMap.put(cp.VG_Claims_Schedule__c, new List<Claims_Progression__c> { cp });
                }
         } 
         
        for(Claims_Progression__c cp : TriggerNew){
             if(MapCsc.get(cp.VG_Claims_Schedule__c).Id==cp.VG_Claims_Schedule__c){
                 Integer num;    
                 if(cpMap.get(cp.VG_Claims_Schedule__c)!=null)
                    num=cpMap.get(cp.VG_Claims_Schedule__c).size()+1;
                 else{
                     num=1;
                 }
                 cp.Name=MapCsc.get(cp.VG_Claims_Schedule__c).Claim__r.Name+'/CP/'+num;                    
             }
         }
                                                     
     }
}