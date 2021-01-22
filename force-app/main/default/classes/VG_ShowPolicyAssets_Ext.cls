Public Class VG_ShowPolicyAssets_Ext{
    public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    public List<VG_Policy_Schedule_Asset__c> psaList2{get;set;}
    public Map<String,Decimal> psaMap{get;set;}
    public Map<id,Policy_Schedule__c> psMap{get;set;}
    public String PId{get;set;}
    public VG_ShowPolicyAssets_Ext(){
        psaList=new List<VG_Policy_Schedule_Asset__c>();
        psaList2=new List<VG_Policy_Schedule_Asset__c>();
        psaMap=new Map<String,Decimal>();
        PId=apexpages.currentpage().getparameters().get('id');
        psMap=new Map<id,Policy_Schedule__c>([select id,Name,RecordType.Name from Policy_Schedule__c where Policy__c=:PID AND (VG_Is_MTA__c = FALSE OR (VG_MTA_Type__c = 'Declaration' OR VG_MTA_Type__c = 'Revision of Cover'))]);
        
        psaList=[select id,Name,VG_Number_of_Vehicles__c,VG_Vehicle_Type__c,VG_Use__c,VG_Coverage__c,VG_Rate_Per_Vehicle__c  from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psMap.keyset() order by CreatedDate desc];
        Set<String> types=new Set<String>();
        System.debug('16.10::'+psMap.size()+'::'+psaList.size());
        for(VG_Policy_Schedule_Asset__c psa: psaList){
            //psaMap.put(psa.VG_Vehicle_Type__c, psa.VG_Number_of_Vehicles__c);
            if(!types.contains(psa.VG_Vehicle_Type__c)){
                types.add(psa.VG_Vehicle_Type__c);
            }
        }
        for(String s:types){
            for(VG_Policy_Schedule_Asset__c psa: psaList){
                if(s==psa.VG_Vehicle_Type__c){
                    psaList2.add(psa);
                    if(psaMap.containsKey(s)){
                        if(psa.VG_Number_of_Vehicles__c != null){
                            Decimal nov=psa.VG_Number_of_Vehicles__c+psaMap.get(s);
                            psaMap.put(s, nov);
                        }
                    }else{
                        if(psa.VG_Number_of_Vehicles__c != null){
                            psaMap.put(s, psa.VG_Number_of_Vehicles__c);
                        }else{
                            psaMap.put(s, 0);
                        }
                    }
                }
            }
        }
    }
}