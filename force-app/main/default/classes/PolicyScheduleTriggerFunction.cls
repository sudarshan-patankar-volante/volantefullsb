/*
*Created By : Siddik
*Created On : 24-11-2017
*JIRA.No    : VG-11
*Test Class : PolicyScheduleTriggerFunctionTest
*
* Added By     : Siddik
* Added On     : 06-09-2018
* JIRA.No      : 108
* Action       : Added a method updateSLAFields.
* Description  : Set Policy Schedule Booked Time.
*
* Added By     : Siddik
* Added On     : 13-12-2017
* JIRA.No      : -
* Action       : Added a method createRIRecords.
* Description  : createRIRecords.This method calculate the no.of UMR records
                 available for TriggerNew Policy schedule's[match with record type] opp
                 and insert the Reinsurance records, which is equal to no.of UMR records.
*/

Public Class PolicyScheduleTriggerFunction{
    public static boolean stopCOIFlag = false;
    public static boolean allowCOI_Ext_Cac_Reduc_Flag = false;
    Public Static boolean allowInsertRI = false;
    
    Public Static Void Handler(List<Policy_Schedule__c> TriggerNew,List<Policy_Schedule__c> TriggerOld,Map<Id,Policy_Schedule__c> TriggerNewMap,Map<Id,Policy_Schedule__c> TriggerOldMap,Boolean IsBefore,Boolean IsAfter,Boolean IsInsert,Boolean IsUpdate,Boolean IsDelete){
        
        if(IsBefore && (IsInsert||IsUpdate)){
            if(!Utilities.avoidRecursionCheck('updateSLAFields'))
                updateSLAFields(TriggerNew, TriggerOldMap, IsInsert, IsUpdate);
            if(!Utilities.avoidRecursionCheck('UpdateTransactionPremium'))
                UpdateTransactionPremium(TriggerNew,TriggerOldMap,IsUpdate);           
        }
        
        if((IsAfter && IsInsert)){
            createRIRecords(TriggerNew);
            if(stopCOIFlag){
                stopCOIFlag = false;
                Set<Policy_Schedule__c> mtaPs= new Set<Policy_Schedule__c>();
                String BID = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
                for(Policy_Schedule__c ps: TriggerNew){
                    if(ps.VG_Is_Co_Insurance__c && ps.VG_Is_MTA__c && ps.RecordTypeID == BID ){
                        if(!Utilities.avoidRecursionCheck('createCOInsuranceChildsforMTAPS'))
                            createCOInsuranceChildsforMTAPS(ps.id , ps.MTA_Parent_Policy_Schedule__c);
                    }
                }
            }
            if(allowCOI_Ext_Cac_Reduc_Flag ){
                allowCOI_Ext_Cac_Reduc_Flag = false;
                Set<ID> policyIds = new Set<ID>();
                Set<String> newInsertedPS = new Set<String>();
                for(Policy_Schedule__c ps: TriggerNew){
                    newInsertedPS.add(ps.Name);
                }
                for(Policy_Schedule__c ps: TriggerNew){
                    System.debug('policyIds::'+policyIds);
                    if(!policyIds.contains(ps.Policy__c)){
                        policyIds.add(ps.Policy__c);
                        System.debug('policyIds::'+policyIds);
                        if(!Utilities.avoidRecursionCheck('setCOI_Ext_Cac_Reduc'))
                            setCOI_Ext_Cac_Reduc(ps.Policy__c, newInsertedPS);
                    }
                }           
            }
        }
        
        if(IsAfter && IsUpdate){
            createRIHelper(TriggerNew, TriggerOldMap, IsInsert, IsUpdate);
            VG_Functionality_Switches__c cs = VG_Functionality_Switches__c.getInstance();
            if(!cs.Skip_Validation__c && !Utilities.avoidRecursionCheck('checkvalidation')){
                checkvalidation(TriggerNew, TriggerOldMap,IsUpdate); 
            }
            if(!Utilities.avoidRecursionCheck('UpdateTaxValues'))
                UpdateTaxValues(TriggerNew,TriggerOldMap,IsUpdate); 
            if(!Utilities.avoidRecursionCheck('UpdateChildRecords'))
                UpdateChildRecords(TriggerNew,TriggerOldMap,IsUpdate);        
        }    
        
        if(IsAfter && IsDelete){    
            if(!Utilities.avoidRecursionCheck('deleteSplitPairPS'))
                deleteSplitPairPS(TriggerOldMap);
        }          
    }
    
    Public Static Void UpdateChildRecords(List<Policy_Schedule__c> TriggerNew, Map<Id, Policy_Schedule__c> TriggerOldMap, Boolean IsUpdate){
        String BDGID = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
        String EDMID = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        Set<Id> PSIds = new Set<Id>();
        
        for(Policy_Schedule__c ps: TriggerNew){
            if(ps.Name != TriggerOldMap.get(ps.id).Name){
                 PSIds.add(ps.id);
            }
        }
        if(!PSIds.IsEmpty()){
            List<Policy_Schedule__c> CoinsurancepsList = new List<Policy_Schedule__c>([select id, Name, VG_Co_Insurance_Parent__r.Name,Policy__r.Name,VG_Co_Insurance_type__c ,VG_Co_Insurance_Parent__c  from Policy_Schedule__c where VG_Co_Insurance_Parent__c = : PSIds]);
        
            for(Policy_Schedule__c ps: TriggerNew){
                if(ps.VG_Co_Insurance_type__c == 'Parent'){
                   for(Policy_Schedule__c coips: CoinsurancepsList){
                        if(coips.VG_Co_Insurance_Parent__r.Name.contains('/EEA')){
                            if(!coips.Name.contains('/EEA'))
                                coips.Name = coips.Name+'/EEA';                           
                        }else{
                            if(coips.Name.contains('/EEA'))
                                coips.Name = coips.Name.remove('/EEA');                            
                        }
                        System.debug('test::'+ps.Split_Type__c+'::'+ps.VG_Volante_Entities__c);
                        coips.Split_Type__c = ps.Split_Type__c;
                        coips.VG_Volante_Entities__c = ps.VG_Volante_Entities__c;
                        System.debug('test::'+coips.Split_Type__c+'::'+coips.VG_Volante_Entities__c);
                    }                 
                }
            }
            if(!CoinsurancepsList.IsEmpty()){
               update CoinsurancepsList;                                             
            } 
            List<VG_Policy_Schedule_Asset__c> psaList= new List<VG_Policy_Schedule_Asset__c>([Select id, Name,VG_Policy_Schedule__r.Name,VG_Policy_Schedule__c,VG_Policy_Schedule__r.RecordTypeId From VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =: PSIds AND (VG_Policy_Schedule__r.RecordTypeId  =: BDGID OR VG_Policy_Schedule__r.RecordTypeId  =:EDMID)]);
            List<Risk_Capture__c> rcList=new List<Risk_Capture__c>([select id,Name,CurrencyIsoCode,Policy_Schedule__r.Name,Policy_Schedule__c,Policy_Schedule__r.RecordTypeId from Risk_Capture__c where Policy_Schedule__c =: PSIds AND (Policy_Schedule__r.RecordTypeId  =:EDMID)]);
            List<VG_Payment_Frequency__c> InsertedpfList = new List<VG_Payment_Frequency__c >([select id, Name,VG_Policy_Schedule__r.Name, VG_Policy_Schedule__r.RecordTypeId from VG_Payment_Frequency__c where VG_Policy_Schedule__c =: PSIds]);
            List<VG_ReInsurance__c> riList = new  List<VG_ReInsurance__c>([Select Id,Name,VG_Policy_Schedule__r.Name from VG_ReInsurance__c where  VG_Policy_Schedule__c =: PSIds AND VG_Policy_Schedule__r.RecordTypeId  =: BDGID]);
            List<VG_Policy_Schedule_Endorsement__c> pseList =  new List<VG_Policy_Schedule_Endorsement__c>([select id, Name,VG_Policy_Schedule__r.Name,VG_Policy_Schedule__c,VG_Type__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c =: PSIds AND (VG_Policy_Schedule__r.RecordTypeId  =: BDGID OR VG_Policy_Schedule__r.RecordTypeId  =:EDMID)]);
            List<VG_ReInsurance__c> RINameToUpdate = new List<VG_ReInsurance__c>();            
            List<VG_Policy_Schedule_Endorsement__c> PSENameToUpdate = new List<VG_Policy_Schedule_Endorsement__c>();            
            List<VG_Payment_Frequency__c> PFNameToUpdate = new List<VG_Payment_Frequency__c>();    
            Map<id,VG_Policy_Schedule_Asset__c> RRNameToUpdate = new Map<id,VG_Policy_Schedule_Asset__c>();        
            List<Risk_Capture__c> RCNameToUpdate = new List<Risk_Capture__c>();    
                        
            Map<id, List<VG_ReInsurance__c>> psRIMap = new Map<Id, List<VG_ReInsurance__c>>();
            for(VG_ReInsurance__c ri : riList){
                if(psRIMap.containsKey(ri.VG_Policy_Schedule__c)) {
                    List<VG_ReInsurance__c> reList = psRIMap.get(ri.VG_Policy_Schedule__c);
                    reList.add(ri);
                    psRIMap.put(ri.VG_Policy_Schedule__c,  reList);
                } else {
                    psRIMap.put(ri.VG_Policy_Schedule__c,  new List<VG_ReInsurance__c> { ri });
                }
            }
            Map<id, List<VG_Policy_Schedule_Asset__c>> psRRMap = new Map<Id, List<VG_Policy_Schedule_Asset__c>>();
            for(VG_Policy_Schedule_Asset__c psa : psaList){
                if(psRRMap.containsKey(psa.VG_Policy_Schedule__c)) {
                    List<VG_Policy_Schedule_Asset__c> rrList = psRRMap.get(psa.VG_Policy_Schedule__c);
                    rrList.add(psa);
                    psRRMap.put(psa.VG_Policy_Schedule__c,  rrList);
                } else {
                    psRRMap.put(psa.VG_Policy_Schedule__c,  new List<VG_Policy_Schedule_Asset__c> { psa });
                }
            }
            Map<id, List<Risk_Capture__c>> psRCMap = new Map<Id, List<Risk_Capture__c>>();
            for(Risk_Capture__c rc : rcList){
                if(psRCMap.containsKey(rc.Policy_Schedule__c)) {
                    List<Risk_Capture__c> rdList = psRCMap.get(rc.Policy_Schedule__c);
                    rdList.add(rc);
                    psRCMap.put(rc.Policy_Schedule__c,  rcList);
                } else {
                    psRCMap.put(rc.Policy_Schedule__c,  new List<Risk_Capture__c> { rc });
                }
            }
            Map<id, List<VG_Policy_Schedule_Endorsement__c>> psPSEMap = new Map<Id, List<VG_Policy_Schedule_Endorsement__c >>();
            for(VG_Policy_Schedule_Endorsement__c pse : pseList){
                if(psPSEMap.containsKey(pse.VG_Policy_Schedule__c)) {
                    List<VG_Policy_Schedule_Endorsement__c> peList = psPSEMap.get(pse.VG_Policy_Schedule__c);
                    peList.add(pse);
                    psPSEMap.put(pse.VG_Policy_Schedule__c,  peList);
                } else {
                    psPSEMap.put(pse.VG_Policy_Schedule__c,  new List<VG_Policy_Schedule_Endorsement__c> { pse });
                }
            }
            Map<id, List<VG_Payment_Frequency__c>> psPFMap = new Map<Id, List<VG_Payment_Frequency__c>>();
            for(VG_Payment_Frequency__c pf : InsertedpfList ){
                if(psPFMap.containsKey(pf.VG_Policy_Schedule__c)) {
                    List<VG_Payment_Frequency__c> pfrList = psPFMap.get(pf.VG_Policy_Schedule__c);
                    pfrList.add(pf);
                    psPFMap.put(pf.VG_Policy_Schedule__c,  pfrList);
                } else {
                    psPFMap.put(pf.VG_Policy_Schedule__c,  new List<VG_Payment_Frequency__c> { pf });
                }
            }
          
            for(Policy_Schedule__c ps: TriggerNew){
               if(psPFMap.get(ps.id)!=null){
                   for(VG_Payment_Frequency__c pf :  psPFMap.get(ps.id)){                        
                        if(!ps.Name.contains('/EEA') || !ps.Name.contains('/NonEEA')){
                            System.debug('ps.Name::'+ps.Name);
                            if(pf.Name.contains('/EEA'))
                                pf.Name = pf.Name.remove('/EEA');
                            if(pf.Name.contains('/NonEEA'))
                                pf.Name = pf.Name.remove('/NonEEA');                           
                        }    
                        if(!pf.Name.contains('/EEA') || !pf.Name.contains('/NonEEA')){
                            String[] pfname = pf.Name.split('/PF/');
                            System.debug('pfname::'+pfname[0]+'::'+pfname[1]);
                            if(ps.Name !=pfName[0]){
                                pf.Name =  ps.Name + '/PF/' + pfName[1];                                
                            }                                
                        } 
                        PFNameToUpdate.add(pf);                                            
                   }
               }
               if(psRIMap.get(ps.id)!=null){
                   for(VG_ReInsurance__c ri: psRIMap.get(ps.id)){
                      
                      if(!ri.Name.contains('/EEA')){
                            String[] riname = ri.Name.split('/CB/');
                            System.debug('riname::'+riname[0]+'::'+riname[1]);
                            if(ri.Name !=riName[0]){
                                ri.Name =  ps.Name + '/CB/' + riName[1];                               
                            }
                       }
                       if(!ps.Name.contains('/EEA')){
                          if(ri.Name.contains('/EEA')){
                              ri.Name = ri.Name.remove('/EEA');                             
                          }
                       }
                       RINameToUpdate.add(ri);    
                   }
               }
               if(psRRMap.get(ps.id)!=null){
                   for(VG_Policy_Schedule_Asset__c rr : psRRMap.get(ps.id)){
                        if(!rr.Name.contains('/EEA') || !rr.Name.contains('/NonEEA')){
                            String[] rrname = rr.Name.split('/RR/');
                            System.debug('rrname::'+rrname[0]+'::'+rrname[1]);
                            if(rr.Name !=rrName[0]){
                                rr.Name =  ps.Name + '/RR/' + rrName[1];                                
                            }                          
                        }  
                        if(!ps.Name.contains('/EEA')){
                            System.debug('ps.Name::'+ps.Name);
                            if(rr.Name.contains('/EEA')){
                                rr.Name = rr.Name.remove('/EEA');                               
                            } 
                        }
                        System.debug('rr::'+rr.Name+'::'+ps.Name);
                        RRNameToUpdate.put(rr.id,rr); 
                    }
                }
                if(psRCMap.get(ps.id)!=null){
                   for(Risk_Capture__c rc : psRCMap.get(ps.id)){
                        if(!rc.Name.contains('/EEA') || !rc.Name.contains('/NonEEA')){
                            String[] rcname = rc.Name.split('/RD/');
                            System.debug('rcname::'+rcname[0]+'::'+rcname[1]);
                            if(rc.Name !=rcName[0]){
                                rc.Name =  ps.Name + '/RD/' + rcName[1];                                
                            }                          
                        }  
                        if(!ps.Name.contains('/EEA')){
                            System.debug('ps.Name::'+ps.Name);
                            if(rc.Name.contains('/EEA')){
                                rc.Name = rc.Name.remove('/EEA');                               
                            } 
                        }
                        System.debug('rc::'+rc.Name+'::'+ps.Name);
                        RCNameToUpdate.add(rc); 
                    }
                }
                if(psPSEMap.get(ps.id)!=null){
                    for(VG_Policy_Schedule_Endorsement__c pse : psPSEMap.get(ps.id)){
                        if(!pse.Name.contains('/EEA') || !pse.Name.contains('/NonEEA')){
                            System.debug('psename::'+pse.VG_Type__c );
                            if(pse.VG_Type__c == 'Endorsements' || pse.VG_Type__c ==null){
                                String[] psename = pse.Name.split('/PE/');
                                System.debug('psename::'+psename[0]+'::'+psename[1]);
                                if(pse.Name !=pseName[0]){
                                    pse.Name =  ps.Name + '/PE/' + pseName[1];                                   
                                }
                            }else if(pse.VG_Type__c == 'Sub-limits'){
                                String[] psename = pse.Name.split('/PESB/');
                                //System.debug('psename::'+psename[0]+'::'+psename[1]);
                                if(pse.Name !=pseName[0]){
                                    pse.Name =  ps.Name + '/PESB/' + pseName[1];                                    
                                }
                            }
                        }
                        PSENameToUpdate.add(pse);   
                    }
                }
           }
           //Utilities.SkipMethods('ExpiryDate_Update_2');
           if(!PFNameToUpdate.IsEmpty())
               update PFNameToUpdate;
           if(!RINameToUpdate.IsEmpty())
               update RINameToUpdate; 
           if(!RCNameToUpdate.IsEmpty())
               update RCNameToUpdate;  
           if(RRNameToUpdate.size()>0)
               update RRNameToUpdate.values();
           if(!PSENameToUpdate.IsEmpty())
               update PSENameToUpdate;  
           //Utilities.clearMethods();  
       }         
   }
       
   Public Static Void checkEntityMatch(List<Policy_Schedule__c> TriggerNew, Map<Id,  Policy__c> policyMap){
        for(Policy_Schedule__c ps : TriggerNew){
            system.debug('Recordtype is:'+policyMap.get(ps.Policy__c).RecordType.Name);
            if(ps.VG_Volante_Entities__c != null && policyMap.get(ps.Policy__c).RecordType.Name == 'VFP' && (policyMap.get(ps.Policy__c).VG_Volante_Entities__c == null || !policyMap.get(ps.Policy__c).VG_Volante_Entities__c.contains(ps.VG_Volante_Entities__c))){
                ps.addError('Entity selected on Policy Schedule must match the entity on Policy.');
            }
        }
    }
    
    Public Static Void deleteSplitPairPS(Map<Id, Policy_Schedule__c> TriggerOldMap){
        Set<String> pairPSNames = new Set<String>();
        String otherPSName;
        for(Policy_Schedule__c ps : TriggerOldMap.values()){
            if(ps.VG_Entity_Split_Required__c){
                if(ps.Split_Type__c == 'EEA'){
                    otherPSName = ps.Name.replace('EEA','NonEEA');
                }else if(ps.Split_Type__c == 'Non EEA'){
                    otherPSName = ps.Name.replace('NonEEA','EEA');
                } 
                pairPSNames.add(otherPSName);
            }
        }
        if(!pairPSNames.IsEmpty()){
            List<Policy_Schedule__c> psToBeDeleted = [Select Id from Policy_Schedule__c where Name IN: pairPSNames];
            if(!psToBeDeleted.IsEmpty()){
                Delete psToBeDeleted;
            }
        }
    }
    
    Public Static Void checkvalidation(List<Policy_Schedule__c> TriggerNew, Map<Id, Policy_Schedule__c> TriggerOldMap, Boolean IsUpdate){
          Set<Id> policyIds  =  new Set<Id>();
          Boolean checkPolicyValidations = False;
          for(Policy_Schedule__c ps: TriggerNew){
              If(ps.VG_Is_MTA__c==True && ps.VG_Status__c=='Booked'){
                  checkPolicyValidations = True;               
              }
              policyIds.add(ps.policy__c);  
          }  
          Map<Id,  Policy__c> policyMap  =  new Map<Id,  Policy__c>([select id, Name, RecordType.Name, VG_Volante_Entities__c, Policy_Status__c from Policy__c where Id IN: policyIds]);
          try{
              checkEntityMatch(TriggerNew, policyMap);
              if(checkPolicyValidations){
                  Update policyMap.values();                
              }
          }Catch(Exception e){
              System.debug('Exception::'+e);
              String errMsg='';
            for(Policy_Schedule__c ps: TriggerNew){
                if(e.getMessage().contains('is required in') || e.getMessage().contains('failed')){
                    System.debug(e.getMessage()+'psname::'+ps.Name);
                    String[] errors=e.getMessage().split(',');
                    System.debug('error::'+errors[1]);
                    errMsg  += errors[1].remove(': []');                                                        
                }
                if(errMsg  !=   ''){   
                   System.debug('errMsg::'+errMsg);        
                   ps.addError(errMsg, false);
                }
            }
        }                
    }
    
    Public Static Void UpdateTransactionPremium(List<Policy_Schedule__c> TriggerNew, Map<Id, Policy_Schedule__c> TriggerOldMap, Boolean IsUpdate){
        String EID = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        String AesirID = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Aesir').getRecordTypeId();
        
        for(Policy_Schedule__c ps:TriggerNew){
            System.debug('22.8.19::'+ps);
            if(ps.RecordTypeId  !=  EID && ps.RecordTypeId !=  AesirID){
                if(ps.Gross_or_Net_Premium__c == 'Gross'){
                    ps.Transaction_GWP__c = (ps.Gross_Written_Premium__c  == null ? 0 : ps.Gross_Written_Premium__c )+(ps.VG_Fee_Income__c  == null ? 0 : ps.VG_Fee_Income__c)+(ps.IPT__c  !=   null ? ps.IPT__c : 0);
                }else if(ps.Gross_or_Net_Premium__c == 'Net'){
                    ps.Transaction_GWP__c = (ps.Actual_GWP__c == null ? 0 : ps.Actual_GWP__c)+(ps.VG_Fee_Income__c  == null ? 0 : ps.VG_Fee_Income__c)+(ps.IPT__c  !=   null ? ps.IPT__c : 0);
                }
            }else if(ps.RecordTypeId == AesirID && ps.RecordTypeId  ==  EID){ //Its wrong...In this condition need to remove EID
                if(IsUpdate && ps.Transaction_GWP__c  == null && ps.Transaction_GWP__c  == 0 && ps.IPT__c  !=   null){
                    ps.Transaction_GWP__c = ps.IPT__c;
                }else if(IsUpdate && ps.Transaction_GWP__c  !=   TriggerOldMap.get(ps.id).Transaction_GWP__c && ps.IPT__c  !=   null){
                    ps.Transaction_GWP__c = ps.Transaction_GWP__c + ps.IPT__c;
                }else if(IsUpdate && ps.Transaction_GWP__c  !=   TriggerOldMap.get(ps.id).Transaction_GWP__c && ps.IPT__c  ==  null){
                    ps.Transaction_GWP__c = ps.Transaction_GWP__c;
                }else if(IsUpdate && ps.IPT__c  !=   TriggerOldMap.get(ps.id).IPT__c){
                    Decimal IPT =  TriggerOldMap.get(ps.id).IPT__c  ==  null ? 0 : TriggerOldMap.get(ps.id).IPT__c;
                    Decimal TGWP =  ps.Transaction_GWP__c - IPT;
                    ps.Transaction_GWP__c = TGWP + ps.IPT__c;
                }
            }else if(ps.RecordTypeId  ==  EID){
                ps.Transaction_GWP__c = (ps.Gross_Written_Premium__c != null? ps.Gross_Written_Premium__c : 0)+(ps.Levies__c != null? ps.Levies__c : 0)+(ps.VG_Fee_Income__c != null? ps.VG_Fee_Income__c : 0)-(ps.VG_Brokerage_Amount__c != null? ps.VG_Brokerage_Amount__c : 0 );            
                ps.Transaction_GWP__c= ps.Transaction_GWP__c+(ps.IPT__c!=null?ps.IPT__c:0);
            }
            if(ps.IPT__c  !=  null && ps.Gross_Written_Premium__c  !=  null && ps.Gross_Written_Premium__c.setScale(2) !=  0){
                ps.IPT_Percent__c = (ps.IPT__c/(ps.Gross_Written_Premium__c.setScale(2)))*100;                               
            }else if(ps.Gross_Written_Premium__c  !=  null && ps.Gross_Written_Premium__c.setScale(2) == 0 ){
                ps.IPT_Percent__c  =  0;
            }
        }               
    }
    
     Public Static Void UpdateTaxValues(List<Policy_Schedule__c> TriggerNew, Map<Id, Policy_Schedule__c> TriggerOldMap, Boolean IsUpdate){
        String EID = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        String HOZID = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Horizon').getRecordTypeId();        
        Set<Id> PSIds = new Set<Id>();
        
        for(Policy_Schedule__c ps:TriggerNew){
            //If(ps.Gross_Written_Premium__c != TriggerOldMap.get(ps.id).Gross_Written_Premium__c)
                PSIds.add(ps.id);                 
            System.debug('GWP::'+ps.Gross_Written_Premium__c+TriggerOldMap.get(ps.id).Gross_Written_Premium__c);
        } 
        List<VG_Policy_Schedule_Asset__c> rrList= new List<VG_Policy_Schedule_Asset__c>([Select id, Name, VG_Deposit_Premium__c From VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c =: PSIds AND VG_Policy_Schedule__r.RecordTypeId  =: HOZID]);
        List<VG_Payment_Frequency__c> PFToUpdate = new List<VG_Payment_Frequency__c>();    
        List<VG_Payment_Frequency__c> InsertedpfList = new List<VG_Payment_Frequency__c >([select id, Name, VG_Policy_Schedule__r.Gross_Written_Premium__c,VG_Comment__c, VG_Is_Temp_Delete__c, VG_GWP_This_Time__c, CurrencyIsoCode, VG_Payment_Percent__c, VG_Due_Date__c,VG_Policy_Schedule__r.RecordTypeId, VG_Outstanding_taxes__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.Policy__r.Policy_Status__c from VG_Payment_Frequency__c where VG_Policy_Schedule__c =: PSIds AND VG_Payment_Percent__c  !=  null ORDER BY VG_Due_Date__c ASC ]);
            
        for(Policy_Schedule__c ps:TriggerNew){
            for(VG_Payment_Frequency__c pf :InsertedpfList){
                If(pf.VG_Policy_Schedule__r.RecordTypeId  == HOZID && pf.VG_Policy_Schedule__c == ps.Id){
                    Decimal GWPThisTime =0;
                    for(VG_Policy_Schedule_Asset__c rr: rrList){                  
                        If(rr.VG_Deposit_Premium__c!= null)        
                            GWPThisTime = pf.VG_Policy_Schedule__r.Gross_Written_Premium__c*(pf.VG_Payment_Percent__c/100)*(rr.VG_Deposit_Premium__c/100);
                        else
                            GWPThisTime = pf.VG_Policy_Schedule__r.Gross_Written_Premium__c*(pf.VG_Payment_Percent__c/100);
                    }
                    If(GWPThisTime.setScale(2) != pf.VG_GWP_This_Time__c.setScale(2)){
                        pf.VG_GWP_This_Time__c= GWPThisTime;
                        PFToUpdate.add(pf);                       
                    }                  
                }  
                If(ps.Gross_Written_Premium__c != TriggerOldMap.get(ps.id).Gross_Written_Premium__c && pf.VG_Policy_Schedule__c == ps.Id && pf.VG_Policy_Schedule__r.RecordTypeId  != HOZID){
                    pf.VG_GWP_This_Time__c = pf.VG_Policy_Schedule__r.Gross_Written_Premium__c*(pf.VG_Payment_Percent__c/100);
                    PFToUpdate.add(pf);
                }               
            }            
        }
        If(!PFToUpdate.IsEmpty()){
            update PFToUpdate;             
        }    
          
        List<VG_Taxes__c> TaxesToUpdate = new List<VG_Taxes__c>();
        List<VG_Taxes__c> listOfAlltaxes  =  [select id,  Name , VG_Tax_Amount_GWP_100__c ,VG_Tax_Percent__c,VG_Policy_Schedule__r.Gross_Written_Premium__c,VG_Is_Temp_Delete__c, VG_Tax_Administered_By__c, VG_Tax_Paid_By__c, VG_Policy_Schedule__c,VG_Policy_Schedule__r.IPT__c , VG_Policy_Schedule__r.RecordTypeId, VG_Taxable_Amount__c, VG_Tax_Amount__c from VG_Taxes__c where VG_Policy_Schedule__c IN :PSIds  AND VG_Policy_Schedule__r.RecordTypeId  =: EID];       
            
        for(Policy_Schedule__c ps:TriggerNew){
            for(VG_Taxes__c tax: listOfAlltaxes){
                If(tax.VG_Policy_Schedule__r.RecordTypeId  ==  EID && ps.Gross_Written_Premium__c != TriggerOldMap.get(ps.id).Gross_Written_Premium__c){
                    tax.VG_Taxable_Amount__c = tax.VG_Policy_Schedule__r.Gross_Written_Premium__c;
                    tax.VG_Tax_Amount__c = tax.VG_Policy_Schedule__r.Gross_Written_Premium__c*(tax.VG_Tax_Percent__c/100);
                    TaxesToUpdate.add(tax);
                    System.debug('TaxesToUpdate::'+TaxesToUpdate);
                }
                System.debug('TaxesToUpdate::'+TaxesToUpdate);  
                  
            }
        }
        If(!TaxesToUpdate.IsEmpty())
            update TaxesToUpdate;    
    }
    
    
    
    Public Static Void updateSLAFields(List<Policy_Schedule__c> TriggerNew, Map<Id, Policy_Schedule__c> TriggerOldMap,Boolean IsInsert,Boolean IsUpdate){
        for(Policy_Schedule__c ps : TriggerNew){
            if(IsUpdate){
                if( ps.VG_Status__c == 'Booked' && ps.VG_Status__c != TriggerOldMap.get(ps.id).VG_Status__c){
                    ps.VG_Booked_Time__c = System.Now();
                }
            }else{
                if( ps.VG_Status__c == 'Booked'){
                    ps.VG_Booked_Time__c = System.Now();
                }
            }
        }
    }
    
     public static void createRIHelper(List<Policy_Schedule__c> TriggerNew,  Map<Id, Policy_Schedule__c> TriggerOldMap,  Boolean IsInsert,  Boolean IsUpdate){
        String EID = Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
        if(IsInsert){
            createRIRecords(TriggerNew);
        }else if(IsUpdate){
            List<Policy_Schedule__c> changedPS  =  new List<Policy_Schedule__c>();
            Set<Id> psIds  =  new Set<Id>();
            
            for(Policy_Schedule__c ps: TriggerNew){
                if((ps.VG_Capacity_Paper__c  !=   TriggerOldMap.get(ps.Id).VG_Capacity_Paper__c || ps.CurrencyISOCode  !=   TriggerOldMap.get(ps.Id).CurrencyISOCode || ps.VG_Volante_Entities__c != TriggerOldMap.get(ps.Id).VG_Volante_Entities__c) && ps.Bordereaux_Override__c != 'Yes'){
                    changedPS.add(ps);
                    psIds.add(ps.Id);
                }
            }
            if(!changedPS.IsEmpty()){
                List<VG_ReInsurance__c> umrList  =  [Select Id from VG_ReInsurance__c where VG_Policy_Schedule__c IN: psIds];
                Delete umrList;
                allowInsertRI = True;
                createRIRecords(changedPS);
            }
        }
    }
    
    Public Static void createRIRecords(List<Policy_Schedule__c> TriggerNew){
        Map<ID, Schema.RecordTypeInfo> ps_rt_Map  =  Policy_Schedule__c.sObjectType.getDescribe().getRecordTypeInfosById();
        Map<ID, Schema.RecordTypeInfo> umr_rt_Map  =  VG_UMR__c.sObjectType.getDescribe().getRecordTypeInfosById();
        Set<String> recordTypeName = new Set<String>();
        Set<ID> psIds = new Set<ID>();
        Set<Id> policyIds  =  new Set<Id>();
        for(Policy_Schedule__c ps: TriggerNew){
            System.debug('PS::'+ps+'::'+ps_rt_Map+'::'+umr_rt_Map);
            psIds.add(ps.id);
            policyIds.add(ps.policy__c);
            //Code Added By siddik on 23.2.2018[below if only to avoid null pointer exception]
            if(ps_rt_Map.get(ps.RecordTypeId) !=  null){
                if(!recordTypeName.contains(ps_rt_Map.get(ps.RecordTypeId).getName())){
                    recordTypeName.add(ps_rt_Map.get(ps.RecordTypeId).getName());
                }
            }
            
            //Code added finished  on 23.2.2018
        }
        Map<Id, List<VG_UMR__c>> psUmrMap = new Map<Id, List<VG_UMR__c>>();
        List<VG_ReInsurance__c> riList = new List<VG_ReInsurance__c>();
        List<Policy__Share> policiesToBeShared  =  new List<Policy__Share>();
        List<AccountShare> accountToBeShared  =  new List<AccountShare>();
        List<VG_UMR__c> umrList = new List<VG_UMR__c>([select id, Name,VG_UMR__c.VG_Volante_Entities__c,VG_UMR__c.RecordTypeId,  VG_Capacity_Paper__c,  VG_RI_Inception_Date__c, VG_RI_Expiry_Date__c, VG_Account__c, RecordType.Name from VG_UMR__c where RecordType.Name IN: recordTypeName ]);
        Map<Id,  Policy__c> policyMap  =  new Map<Id,  Policy__c>([Select Id,  VG_Inception_Date__c from Policy__c where Id IN: policyIds]);
        if(!umrList.IsEmpty()){
            for(Policy_Schedule__c ps: TriggerNew){
                Boolean checkEntity = True;
                if(policyMap.get(ps.Policy__c).VG_Inception_Date__c.year() <= 2020){
                    checkEntity = False;
                }
                for(VG_UMR__c u: umrList){
                    System.debug('Values = >'+ps_rt_Map.get(ps.recordTypeID).getName()+', '+umr_rt_Map.get(u.recordTypeID).getName());
                    if(ps_rt_Map.get(ps.recordTypeID).getName() == umr_rt_Map.get(u.recordTypeID).getName() && ((ps_rt_Map.get(ps.recordTypeID).getName()  !=   'VFP' && ps_rt_Map.get(ps.recordTypeID).getName()  !=   'Aesir' && ps_rt_Map.get(ps.recordTypeID).getName()  !=   'Horizon' && ps_rt_Map.get(ps.recordTypeID).getName()  !=   'Imara' && ps_rt_Map.get(ps.recordTypeID).getName()  !=   'Edison Motor' && ps_rt_Map.get(ps.recordTypeID).getName()  !=   'Bridge' && ps_rt_Map.get(ps.recordTypeID).getName()  != 'Affinity') || ((ps.VG_Volante_Entities__c!=null && checkEntity)?(ps_rt_Map.get(ps.recordTypeID).getName()  ==  'VFP' && u.VG_Capacity_Paper__c  ==  ps.VG_Capacity_Paper__c && (u.VG_Volante_Entities__c != null && u.VG_Volante_Entities__c.contains(ps.VG_Volante_Entities__c))) :(ps_rt_Map.get(ps.recordTypeID).getName()  ==  'VFP' && u.VG_Capacity_Paper__c  ==  ps.VG_Capacity_Paper__c)) || (ps_rt_Map.get(ps.recordTypeID).getName()  ==  'Bridge' && u.VG_Capacity_Paper__c  ==  ps.VG_Capacity_Paper__c) || (ps_rt_Map.get(ps.recordTypeID).getName()  ==  'Edison Motor' && u.VG_Capacity_Paper__c  ==  ps.VG_Capacity_Paper__c) || (ps_rt_Map.get(ps.recordTypeID).getName()  ==  'Horizon' && u.VG_Capacity_Paper__c  ==  ps.VG_Capacity_Paper__c)  || (ps_rt_Map.get(ps.recordTypeID).getName()  ==  'Imara' && u.VG_Capacity_Paper__c  ==  ps.VG_Capacity_Paper__c) || (ps_rt_Map.get(ps.recordTypeID).getName()  ==  'Aesir' && u.VG_Capacity_Paper__c  ==  ps.VG_Capacity_Paper__c) || (ps_rt_Map.get(ps.recordTypeID).getName()  ==  'Affinity' && u.VG_Capacity_Paper__c  ==  ps.VG_Capacity_Paper__c))){
                        if((u.VG_RI_Inception_Date__c < =  policyMap.get(ps.Policy__c).VG_Inception_Date__c) && (u.VG_RI_Expiry_Date__c > =  policyMap.get(ps.Policy__c).VG_Inception_Date__c)){
                            if(psUmrMap.containsKey(ps.id)) {
                                List<VG_UMR__c> uList  =  psUmrMap.get(ps.id);
                                uList.add(u);
                                psUmrMap.put(ps.id,  uList);
                            } else {
                                psUmrMap.put(ps.id,  new List<VG_UMR__c> { u });
                            }
                        }
                    }
                }
            }
            List<UMR_Sharing_Id__mdt> sharingList  =  [Select Id,  Account_Id__c,  Record_Type__c, Sharing_Public_Group_Id__c from UMR_Sharing_Id__mdt];
            Map<String,  Id> sharingIds  =  new Map<String,  Id>();
            for(UMR_Sharing_Id__mdt UMRSharing : sharingList){
                System.debug('UMRSharing is: '+UMRSharing.Account_Id__c+UMRSharing.Record_Type__c);
                sharingIds.put(UMRSharing.Account_Id__c+UMRSharing.Record_Type__c,  UMRSharing.Sharing_Public_Group_Id__c);
            }
            //Code Added Start by siddik on 17.5.2018
            Map<Id, Policy_Schedule__c> triggerPs = new Map<id, Policy_Schedule__c>([select id, Name, Account_Id__c, Bordereaux_Override__c, RecordType.Name from Policy_Schedule__c where id IN: psIds]);
            //Code Added End by siddik on 17.5.2018
            for(Policy_Schedule__c ps: TriggerNew){
                System.debug('Condition::'+ps.Bordereaux_Override__c +'::'+!ps.VG_Is_MTA__c+'::'+allowInsertRI+'::'+(psUmrMap.get(ps.id) != null) +'::'+ psUmrMap.get(ps.id));
                
                if((ps.Bordereaux_Override__c != 'Yes') && ((!ps.VG_Is_MTA__c || allowInsertRI) && psUmrMap.get(ps.id)  !=   null && !psUmrMap.get(ps.id).IsEmpty())){
                    System.debug('ss::'+psUmrMap.get(ps.id).IsEmpty());
                    Integer counter = 0;
                    for(VG_UMR__c u : psUmrMap.get(ps.id)){
                        System.debug('UMR::'+u);
                        VG_ReInsurance__c ri = new VG_ReInsurance__c();
                        ri.Name = ps.Name+'/CB/'+counter;
                        ri.CurrencyIsoCode = ps.CurrencyIsoCode;
                        ri.VG_Policy_Schedule__c = ps.id;
                        ri.VG_UMR__c = u.id;
                        riList.add(ri);
                        counter++;
                        String accId15digit = ((String)u.VG_Account__c).substring(0,15);
                        system.debug('SharingId is: '+accId15digit+u.RecordType.Name);
                        if(sharingIds.get(accId15digit+u.RecordType.Name)  !=   null){
                            Policy__Share tempShare  =  new Policy__Share();
                            tempShare.ParentID  =  ps.Policy__c;
                            tempShare.UserOrGroupId  =  sharingIds.get(accId15digit+u.RecordType.Name);
                            tempShare.AccessLevel  =  'Read';
                            System.debug('27.11::'+tempShare);
                            policiesToBeShared.add(tempShare);
                            AccountShare tempAccShare  =  new AccountShare();
                            System.debug('Ps::'+ps);
                            tempAccShare.AccountID  = triggerPs.get(ps.id).Account_Id__c;
                            System.debug('AccountId::'+tempAccShare.AccountID+'::'+ps.Account_Id__c);
                            tempAccShare.UserOrGroupId  =  sharingIds.get(accId15digit+u.RecordType.Name); 
                            tempAccShare.AccountAccessLevel  =  'Read';
                            tempAccShare.OpportunityAccessLevel  =  'Read';
                            tempAccShare.CaseAccessLevel  =  'Read';
                            accountToBeShared.add(tempAccShare);
                        }
                    }
                }
            }
            System.debug('20.7.18 Test1::'+riList.size()+'::'+policiesToBeShared.size()+'::'+accountToBeShared);
            if(!riList.IsEmpty()){
                Insert riList;
            }
            if(!policiesToBeShared.IsEmpty()){
                Insert policiesToBeShared;
            }
            if(!accountToBeShared.IsEmpty()){
                Insert accountToBeShared;
            }
        }
    }
    
     @future
    public static void createCOInsuranceChildsforMTAPS(String PSID,String CIParentPsID){
        
        Set<Id> coInsuranceParentIds = new Set<Id>();
        
        Map<Id,Policy_Schedule__c> mtaParentmap = new Map<Id,Policy_Schedule__c>();
        Map<String,Policy_Schedule__c> psToBeInserted = new Map<String,Policy_Schedule__c>();
        Map<String,String> psNameMap = new Map<String,String>();
        
        List<VG_Policy_Schedule_Endorsement__c> insertPSEList = new List<VG_Policy_Schedule_Endorsement__c>();
        List<VG_Policy_Schedule_Asset__c> insertPSAList = new List<VG_Policy_Schedule_Asset__c>();
        List<VG_Exposure_Premium__c> insertEXPList = new List<VG_Exposure_Premium__c>();
        
        Map<Id,Policy_Schedule__c> allPSMap = new Map<Id,Policy_Schedule__c>([select id,Name,VG_Volante_Entities__c,VG_Entity_Split_Required__c,Split_Type__c,VG_Co_Insurance_Parent__c,IsDeleted,CurrencyIsoCode,RecordTypeId,CreatedDate,VG_Financials_Created__c,VG_Risk_Premium__c,Insured_Id__c,Declaration_Date__c,Product__c,Policy__c,VG_Plan_Rate__c,IPT_Percent__c,Premium_Adjustment__c,Endorsement_GWP__c,Levies__c,VG_Transaction_Type__c,VG_Risk_Transaction_Type__c,VG_Is_MTA__c,VG_MTA_Type__c,VG_MTA_Status__c,VG_MTA_Start_Date__c,VG_MTA_End_Date__c,VG_Current_Plan_Rate__c,VG_MTA_Cancellation_Date__c,MTA_Reason_for_Cancellation__c,VG_Declaration_Type__c,VG_Status__c,Net_Premium__c,VG_Declaration_Type_percent__c,VG_Fee_Income__c,VG_Adjustment_Reason__c,VG_Brokerage_Percent__c,VG_Net_Premium_Due__c,VG_Pre_MTA_Expiry_Date__c,VG_Base_Policy__c,Base_Creation_Start_Date__c,Base_Creation_End_Date__c,Commission__c,Gross_Base_Premium__c,VG_MGA_Commission_Amount__c,VG_Technical_Model_Premium__c,Technical_UW_Premium__c,Risk_Premium_Pro__c,Endorsement_Premium_Pro__c,Limit__c,Attachment__c,Sum_Insured__c,ILF_Factor__c,ILF_Premium__c,Rate_On_Line__c,Rate_Per_Mil__c,Share__c,Underwriting_Premium__c,Premium_Adjustment_2__c,ORC__c,ORC_Amount__c,Account_Id__c,VG_VAT__c,VG_VAT_Amount__c,VG_Lloyds_Product__c,VG_Net_Premium_Receivable__c,VG_Auto_acquisition_Threshold__c,VG_Extended_Reporting_Period_AP__c,ILF_Layer__c,VG_Retired_Directors_Additional_Premium__c,VG_Retired_Directors_Year__c,VG_Extended_Reporting_Period__c,Technical_Layer_Premium__c,Written_share__c,Gross_Written_Premium__c,Gross_or_Net_Premium__c,VG_Overider_Amount__c,VG_Overider_Percent__c,VG_Total_Layer_Premium__c,Transaction_GWP__c,Actual_GWP__c,IPT__c,VG_Brokerage_Amount__c,VG_Deductible__c,VG_Coverages__c,VG_Number_Of_vehicle__c,VG_Turn_Over__c,VG_Type_Of_Operation__c,VG_CREDIT_Augur_SCORE__c,VG_Exposure_Premium__c,VG_Experience_Premium__c,VG_Selected_Weight__c,VG_Net_Base_Premium__c,VG_Occupancy__c,VG_PD_Base_Rate__c,VG_BI_Base_Rate__c,VG_Machinery_Breakdown_Cover__c,VG_Machinery_Breakdown_BI_Cover__c,VG_Adjustment_Factor__c,VG_Adjusted_PD_Base_Rate__c,VG_Adjusted_BI_Base_Rate__c,VG_Witholding_Tax_Amount__c,VG_Net_Premium_Received__c,VG_Reinsurance_Type__c,VG_Structure__c,VG_Sub_Structure__c,VG_Technical_Loss_Ratio__c,MID_Check_Box__c,VG_Capacity_Paper__c,VG_Payment_Due_Date__c,VG_Wording__c,VG_Reporting_Date__c,VG_Rate_Change__c,VG_Municipality_Code__c,VG_Side_B_Rentention__c,VG_Side_C_Rentention__c,VG_D_O_Product__c,VG_Gross_Written_Premium_100__c,VG_Bridge_Selected_Asset__c,MTA_Parent_Policy_Schedule__c from Policy_Schedule__c where VG_Co_Insurance_Parent__c =: CIParentPsId OR Id =: PSId]);
        Policy_Schedule__c OriginalPS;
        Map<Id,Policy_Schedule__c> childCOIMap = new Map<Id,Policy_Schedule__c>();
        for(Policy_schedule__c tmp : allPSMap.values() ){
            if(tmp.id != PSID){
                childCOIMap.put(tmp.id,tmp);
            }else{
                OriginalPS = tmp;
            }
        }
        List<VG_Policy_Schedule_Endorsement__c> PSEList = new List<VG_Policy_Schedule_Endorsement__c>([select id, Name,IsDeleted,CurrencyIsoCode,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastViewedDate,LastReferencedDate,VG_Premium__c,VG_Policy_Schedule__c,VG_Policy_Schedule__r.Split_Type__c,VG_Title__c,VG_Endorsement_Details__c,VG_Endorsement_Library_Id__c,VG_Endorsement_Number__c,VG_IsTemp__c,VG_IsTempDelete__c,VG_Policy_Schedule__r.Name,VG_Sub_limit__c,VG_Type__c,VG_Product__c from VG_Policy_Schedule_Endorsement__c Where  VG_Policy_Schedule__c IN: childCOIMap.keyset()]);
        List<VG_Policy_Schedule_Asset__c> PSAList = new List<VG_Policy_Schedule_Asset__c>([SELECT VG_Policy_Schedule__r.Split_Type__c,VG_Policy_Schedule__r.Name,Annual_Rate_100__c,Asset__c,CreatedById,CreatedDate,CurrencyIsoCode,Id,IsDeleted,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,RecordTypeId,SystemModstamp,Technical_UW_Premium__c,VG_AAD__c,VG_Address2__c,VG_Address3__c,VG_Address__c,VG_Adjusted_BI_Premium__c,VG_Adjusted_PD_Premium__c,VG_Aggregate_Precent__c,VG_Aggregate__c,VG_Attachment__c,VG_Avg_SI__c,VG_Base_Premium_Rate__c,VG_Base_Premium__c,VG_Binder_Ref__c,VG_BI_Indemnity_Period__c,VG_Bordereax_Date__c,VG_Brokerage__c,VG_Building_Discount_Loading__c,VG_CC_Information__c,VG_Ceding_Commission__c,VG_Cession__c,VG_CH_Commission__c,VG_Country__c,VG_Coverage_Type__c,VG_Coverage__c,VG_Date_of_Birth__c,VG_Declared_Value__c,VG_Deductible_Precent__c,VG_Deductible__c,VG_Deposit_Premium_Formula__c,VG_Deposit_Premium__c,VG_Event_Limit__c,VG_Expected_Ceding_Commission__c,VG_Expected_Loss_Ratio__c,VG_Expected_Premium_Income__c,VG_Expected_Profit_Commission__c,VG_Fee_Amounts__c,VG_GNPI__c,VG_Gross_Written_Premium__c,VG_Information__c,VG_Insured_Name__c,VG_IsTempDelete__c,VG_IsTemp__c,VG_Limit_Precent__c,VG_Limit__c,VG_Loss_Ratio_for_Max__c,VG_Loss_Ratio_for_Min__c,VG_Management_Expenses_for_PC__c,VG_Max_Ceding_Commission__c,VG_Max_Rate__c,VG_Max_SI__c,VG_MB_BI_Indemnity_Period__c,VG_MB_PD_Deductible__c,VG_MB_Waiting_Period__c,VG_Minimum_Premium_Formula__c,VG_Minimum_Premium__c,VG_Min_Ceding_Commission__c,VG_Min_Rate__c,VG_Net_BI_Premium__c,VG_Net_MB_Premium__c,VG_Net_PD_Premium__c,VG_Net_Risk_Premium__c,VG_No_Claims_Bonus_Value__c,VG_No_Claims_Bonus__c,VG_No_of_Surplus_Lines__c,VG_Number_of_Vehicles__c,VG_OtherRisk__c,VG_Payment_Ref__c,VG_Payment_Terms__c,VG_PD_Deductible__c,VG_Perils_Text__c,VG_Perils__c,VG_Policy_Basis__c,VG_Policy_Cover_End_Date__c,VG_Policy_Cover_Start_Date__c,VG_Policy_No__c,VG_Policy_Schedule__c,VG_Postcode__c,VG_Premium__c,VG_Profession__c,VG_Provisional_Rate__c,VG_Rate_on_Income__c,VG_Rate_Per_Vehicle__c,VG_Registration_Plate__c,VG_Retention_Line__c,VG_Retention__c,VG_Retroactive_Date__c,VG_Return_Period_Entry__c,VG_Return_Period_Exit__c,VG_Risk_End__c,VG_Risk_Premium__c,VG_Risk_start__c,VG_Scheme_Name__c,VG_Share__c,VG_Signed_Share__c,VG_Sub_Aggregation__c,VG_Sub_broker__c,VG_Sub_limit__c,VG_Sum_Insured__c,VG_Swing_Load__c,VG_Tax_on_Premium__c,VG_Technical_UW_Rate_Annual__c,VG_Territorial_Limits__c,VG_Transaction_Effective_date__c,VG_Transaction_Type__c,VG_Treaty_Limit__c,VG_Use__c,VG_Vehicle_Make__c,VG_Vehicle_Model__c,VG_Vehicle_Type__c,VG_Waiting_Period__c,VG_Written_Share__c FROM VG_Policy_Schedule_Asset__c Where VG_Policy_Schedule__c IN: childCOIMap.keyset()]);
        List<VG_Exposure_Premium__c> expList = new List<VG_Exposure_Premium__c>([select id, Name, CurrencyIsoCode, CreatedDate, VG_Factor_Name__c, VG_Rating_Factor__c, VG_Rate__c, VG_Other_Factor__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.Name from VG_Exposure_Premium__c where VG_Policy_Schedule__c IN: childCOIMap.keyset()]);
        
        mtaParentmap.put(OriginalPS.MTA_Parent_Policy_Schedule__c,OriginalPS);
        Integer psNumbering = Integer.valueOf(OriginalPS.Name.split('/')[6]);
        OriginalPS = VG_ManageCoInsuranceController.summarayCalc(OriginalPS);
        for(Policy_schedule__c tmp : childCOIMap.values() ){
            Policy_Schedule__c ps = OriginalPS.clone(false,true,false,false);
            ps.MTA_Parent_Policy_Schedule__c = tmp.id;
            ps.id = null;
            ps.VG_Capacity_Paper__c = tmp.VG_Capacity_Paper__c;
            ps.VG_Co_Insurance_type__c= 'Child';
            ps.Share__c = tmp.Share__c;
            ps.VG_Co_Insurance_Parent__c = OriginalPS.id;
            String[] psName = OriginalPS.Name.split('/');
            System.debug('Split::'+ps.Split_Type__c);
            if(ps.Split_Type__c == 'EEA'){
                ps.Name = psName[0]+'/'+psName[1]+'/'+psName[2]+'/'+psName[3]+'/'+psName[4]+'/MTA/'+(psNumbering + 1)+'/EEA';            
            }else{
                ps.Name = psName[0]+'/'+psName[1]+'/'+psName[2]+'/'+psName[3]+'/'+psName[4]+'/MTA/'+(psNumbering + 1);            
                ps.VG_Volante_Entities__c = '';
            }
            psNumbering ++;
            ps = VG_ManageCoInsuranceController.summarayCalc(ps);
            psNameMap.put(tmp.Name , ps.Name);
            psToBeInserted.put(ps.Name , ps);
        }
        
        psToBeInserted.put(OriginalPS .Name , OriginalPS );
        if(psToBeInserted.size() > 0){
            PolicyScheduleTriggerFunction.allowInsertRI = true; 
            Upsert psToBeInserted.values();
            for(VG_Policy_Schedule_Endorsement__c pse : PSEList ){
                 VG_Policy_Schedule_Endorsement__c  tmp = pse.clone(false,true,false,false);
                 if(pse.VG_Policy_Schedule__r.Split_Type__c == 'EEA')
                     tmp.Name = psNameMap.get(pse.VG_Policy_Schedule__r.Name)+'/'+pse.Name.split('/')[8]+'/'+pse.Name.split('/')[9];
                 else
                     tmp.Name = psNameMap.get(pse.VG_Policy_Schedule__r.Name)+'/'+pse.Name.split('/')[7]+'/'+pse.Name.split('/')[8];
                 tmp.VG_Policy_Schedule__c = psToBeInserted.get(psNameMap.get(pse.VG_Policy_Schedule__r.Name)).id;
                 insertPSEList.add(tmp);
             }
             for(VG_Policy_Schedule_Asset__c psa : PSAList ){
                VG_Policy_Schedule_Asset__c  tmp = psa.clone(false,true,false,false);
                if(psa.VG_Policy_Schedule__r.Split_Type__c == 'EEA')                         
                    tmp.Name = psNameMap.get(psa.VG_Policy_Schedule__r.Name)+'/'+psa.Name.split('/')[8]+'/'+psa.Name.split('/')[9];
                else
                    tmp.Name = psNameMap.get(psa.VG_Policy_Schedule__r.Name)+'/'+psa.Name.split('/')[7]+'/'+psa.Name.split('/')[8];                
                tmp.VG_Policy_Schedule__c = psToBeInserted.get(psNameMap.get(psa.VG_Policy_Schedule__r.Name)).id;
                insertPSAList.add(tmp);
            }
            for(VG_Exposure_Premium__c exp : expList ){
                VG_Exposure_Premium__c tmp = exp.clone(false,true,false,false);
                tmp.VG_Policy_Schedule__c = psToBeInserted.get(psNameMap.get(exp.VG_Policy_Schedule__r.Name)).id;
                insertEXPList.add(tmp);
            }
            if(insertPSEList.size() > 0){
                Insert insertPSEList;
            }
            if(insertPSAList.size() > 0){
                Insert insertPSAList;
            }
            if(insertEXPList.size() > 0){
                Insert insertEXPList ;
            }
         }
    }
    
    @future
    public static void setCOI_Ext_Cac_Reduc(String policyId, Set<String> newInsertedPS){
        System.debug('newInsertedPS details');
        System.debug(newInsertedPS.size());
        System.debug(newInsertedPS);
        Map<Id, Policy_Schedule__c> psMap = new map<Id, Policy_Schedule__c>([select Id, Name, VG_Volante_Entities__c,VG_Entity_Split_Required__c,Split_Type__c,VG_MTA_Type__c, MTA_Parent_Policy_Schedule__c, VG_Co_Insurance_type__c, VG_Co_Insurance_Parent__c from Policy_Schedule__c where Policy__c =: policyId]);
        Map<Id, Id> psMTAMap = new Map<Id, Id>();
        List<Policy_Schedule__c> psUpdateList = new List<Policy_Schedule__c>();
        for(Policy_Schedule__c ps : psMap.values()){
            if(newInsertedPS.contains(ps.Name) && ps.MTA_Parent_Policy_Schedule__c != null && (ps.VG_MTA_Type__c == 'Extension' || ps.VG_MTA_Type__c == 'Cancellation' || ps.VG_MTA_Type__c == 'Reduction')){
                psMTAMap.put(ps.MTA_Parent_Policy_Schedule__c, ps.id);
            }
        }
        System.debug('psMTAMap details');
        System.debug(psMTAMap.size());
        System.debug(psMTAMap);
        for(Policy_Schedule__c ps : psMap.values()){
            if(newInsertedPS.contains(ps.Name) && ps.VG_Co_Insurance_type__c == 'Child' && (ps.VG_MTA_Type__c == 'Extension' || ps.VG_MTA_Type__c == 'Cancellation' || ps.VG_MTA_Type__c == 'Reduction')){
                System.debug('PS ::'+ ps);
                System.debug(psMTAMap.get(psMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Co_Insurance_Parent__c));
                ps.VG_Co_Insurance_Parent__c  = psMTAMap.get(psMap.get(ps.MTA_Parent_Policy_Schedule__c).VG_Co_Insurance_Parent__c);
                System.debug(ps.VG_Co_Insurance_Parent__c);
                psUpdateList.add(ps);
            }
        }
        System.debug('psUpdateList details');
        System.debug(psUpdateList.size());
        System.debug(psUpdateList);
        if(!psUpdateList.IsEmpty()){
            update psUpdateList;
        }
    }    
}