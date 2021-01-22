Public Class PolicyTriggerFunction{

    Public Static Boolean avoidRecursion = False;
    
    Public Static Void Handler(List<Policy__c> TriggerNew,List<Policy__c> TriggerOld,Map<Id,Policy__c> TriggerNewMap,Map<Id,Policy__c> TriggerOldMap,Boolean IsBefore,Boolean IsAfter,Boolean IsInsert,Boolean IsUpdate,Boolean IsDelete){
         boolean setPolicyLloydsProducts = false;
        boolean checkEligibilityForApproval = false;
         
        ID BridgeID = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
        ID VFPID = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
        ID HOZId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Horizon').getRecordTypeId();    
        Id AesirId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Aesir').getRecordTypeId();   
        Id ImaraId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Imara').getRecordTypeId();
        Id GenId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();
        
        if(!IsDelete){
            for(Policy__c policy : TriggerNew){
                if(policy.RecordTypeId == BridgeID || policy.RecordTypeId == VFPID){
                    checkEligibilityForApproval = true;
                }
                if(policy.RecordTypeId == BridgeID || policy.RecordTypeId == VFPID || policy.RecordTypeId == HOZId || policy.RecordTypeId == GenId ){
                    setPolicyLloydsProducts = true;
                }
            }
        }
        
        if(IsBefore && (IsInsert||IsUpdate)){
            if(!Utilities.avoidRecursionCheck('updateSLAFields'))
                updateSLAFields(TriggerNew, TriggerOldMap, IsInsert, IsUpdate);
            VG_Functionality_Switches__c cs = VG_Functionality_Switches__c.getInstance();
            if(!cs.Skip_Validation__c){
                if(!Utilities.avoidRecursionCheck('InsertValidateMandatoryFields'))
                    InsertValidateMandatoryFields(TriggerNew ,TriggerOldmap, IsInsert,  IsUpdate);
            }
        }
        
        if(IsBefore && IsInsert){
            PolicyNumberAutoGEN(TriggerNew,IsInsert);
        }
        
        if(IsBefore && IsUpdate){          
            if(setPolicyLloydsProducts){
                if(!Utilities.avoidRecursionCheck('setPolicyLloydsProducts'))
                    setPolicyLloydsProducts(TriggerNew,TriggerOldmap);
            }
            VG_Functionality_Switches__c cs = VG_Functionality_Switches__c.getInstance();
            if(!cs.Skip_Validation__c && !Utilities.avoidRecursionCheck('ValidateMandatoryFields'))
                ValidateMandatoryFields(TriggerNew,TriggerOldmap);
        }
        
        if(IsAfter && IsUpdate){          
            if(!Utilities.avoidRecursionCheck('setExpiryDateforExtension'))       
                setExpiryDateforExtension(TriggerNew, TriggerOldmap,IsInsert,IsUpdate);
            if(checkEligibilityForApproval){
                if(!Utilities.avoidRecursionCheck('checkEligibilityForApproval'))        
                    checkEligibilityForApproval(TriggerNew,TriggerOldmap);
            }
            if(!Utilities.avoidRecursionCheck('currencyUpdateOnChilds'))  
                currencyUpdateOnChilds(TriggerNew,TriggerOldmap); 
            if(!Utilities.avoidRecursionCheck('updateRIRecords'))  
                updateRIRecords(TriggerNew, TriggerOldMap);          
        }
        
        if(IsAfter && (IsUpdate || IsInsert)){
            if(!Utilities.avoidRecursionCheck('UpdateRollUpAccountFields'))
                UpdateRollUpAccountFields(TriggerNew);
        }
        
        if(IsAfter && IsDelete){
            deleteGovernancecompliance(TriggerOld);
        }
    }
    
    public static void setExpiryDateforExtension(List<Policy__c> TriggerNew,  Map<Id,  Policy__c> TriggerOldMap,Boolean IsInsert,Boolean IsUpdate){
                   
        Set<Id> polids  =  new set<Id>(); 
        Integer extensiondate;
        Integer extdate;
        ID VFPID  =  Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
        Set<Id> accountId = new Set<Id>();
        Map<String,Integer> extensiondateMap = new Map<String, Integer>();
        If(IsUpdate){
            for(Policy__c policy : TriggerNew){
                if(policy.VG_Expiry_Date__c !=  null && TriggerOldMap.get(policy.Id).VG_Expiry_Date__c !=  null && policy.RecordTypeId == VFPID){
                    if(policy.VG_Expiry_Date__c <> TriggerOldMap.get(policy.Id).VG_Expiry_Date__c && policy.VG_Renewal_Policy_Id__c!=null){                                  
                        extensiondate = Integer.valueOf(TriggerOldMap.get(policy.Id).VG_Expiry_Date__c.daysBetween(policy.VG_Expiry_Date__c));                                          
                        extensiondateMap.put(policy.Id,extensiondate);
                        accountId.add(policy.Insured__c);                                                
                    }
                }
            }
        } 
        Map<Id, Policy__c> listOfAllPolicies  =  new Map<Id, Policy__c>([select id,  Name , VG_Renewal_Policy_Id__c, VG_Inception_Date__c,VG_Expiry_Date__c,Insured__c, Total_claims_reserve__c, Insured__r.CurrencyIsoCode, CurrencyISOCode, VG_MGA_Commission_Amount__c, Actual_GWP__c from Policy__c where Insured__c IN : accountId ORDER BY CreatedDate ASC]);       
        List<Policy__c> updateRenewalpolicies = new List<Policy__c>();
        for(Policy__c pol : listOfAllPolicies.values()){
             if(pol.VG_Renewal_Policy_Id__c != null && extensiondateMap.get(pol.Id) != null){
                 extensiondateMap.put(pol.VG_Renewal_Policy_Id__c, extensiondateMap.get(pol.Id));
             }
        }   
        for(Id polId : extensiondateMap.keySet()){
            if(TriggerOldMap.get(polId) == null){
                 Policy__c pol = listOfAllPolicies.get(polId);
                 extdate = extensiondateMap.get(polid);
                 pol.VG_Inception_Date__c = pol.VG_Inception_Date__c.addDays(extdate);  
                 pol.VG_Expiry_Date__c= pol.VG_Expiry_Date__c.addDays(extdate); 
                 updateRenewalpolicies.add(pol);
            }
        }
        if(!updateRenewalpolicies.IsEmpty()){
            Utilities.SkipMethods('ExpiryDate_Update_1');  
            Utilities.SkipMethods('ExpiryDate_Update_2');               
            update updateRenewalpolicies;
            Utilities.ClearMethods();
        } 
    }
    
    Public Static Void InsertValidateMandatoryFields(List<Policy__c> TriggerNew,Map<Id,  Policy__c> TriggerOldMap, Boolean IsInsert , Boolean IsUpdate){
        Set<Id> brokerIds = new Set<Id>();
        for(Policy__c pol:TriggerNew){
            brokerIds.add(pol.Broker_Name__c);
        }
        Map<Id,  Account> accBrokerListMap = new Map<Id,  Account>([select id,Name,VG_Volante_Entities__c from Account where Id IN: brokerIds ]);
        for(Policy__c pol:TriggerNew){
            If(pol.VG_Ignore_Validation__c == false){               
                if(accBrokerListMap.size() == 0){
                    pol.addError('Please fill the broker...');
                }else if(accBrokerListMap.get(pol.Broker_Name__c).VG_Volante_Entities__c == null){
                    pol.addError('Please fill Volante Entities in broker...');
                }else{
                    Set<String> allEntities = new Set<String>();
                    if(pol.VG_Volante_Entities__c !=null){
                        allEntities.addAll(pol.VG_Volante_Entities__c.split(';'));
                    }
                        Boolean validEntity = False;
                        for(String s : allEntities){
                            if(accBrokerListMap.get(pol.Broker_Name__c).VG_Volante_Entities__c.contains(s)){
                                validEntity = True;
                            }
                        }
                    if(!validEntity && (!pol.VG_Is_Temp__c) && (IsUpdate && pol.VG_Is_Temp__c == TriggerOldMap.get(pol.Id).VG_Is_Temp__c)){
                        pol.addError(' The broker is not registered with the Volante entity. ');
                    }else if(pol.VG_Volante_Entities__c == null){
                        pol.addError('Please fill Volante Entities in Policy...');
                    } 
                }                           
            }
        }
    }
    
    public static void deleteGovernancecompliance(List<Policy__c> TriggerOld){
        Set<Id> gcids = new set<Id>(); 
        for (Policy__c pol: TriggerOld) {
          gcids.add(pol.VG_Governance_Compliance__c);
        }
        List<VG_Governance_Compliance__c> gclist = new List<VG_Governance_Compliance__c>();
        for(ID gcId: gcids){
            VG_Governance_Compliance__c gc=new VG_Governance_Compliance__c();
            gc.id=gcId;
            if(gc.id != null)
                gclist.add(gc);
        }
        if(!gclist.IsEmpty())
            delete gclist;
    }
    
    Public Static Void PolicyNumberAutoGEN(List<Policy__c> TriggerNew, Boolean IsInsert){
        Map<String,VG_Programme__c> pgmMap = new Map<String,VG_Programme__c>();
        SystemConstants__c LastCreatedPolicyName = [Select Id, Name, DocumentId__c from SystemConstants__c where Name = 'Latest Policy Name' limit 1 FOR UPDATE ];
        List<String> PolicyNameComponents = new List<String>();
        String year = String.valueOf(System.Today().year());
        String policyNum = '';
        String policySubNum;
        String LatestPolicyNameUpdate = 'Reset';
        Integer tempPolicyNum;
        if(LastCreatedPolicyName.DocumentId__c  != 'Reset'){
            LatestPolicyNameUpdate = LastCreatedPolicyName.DocumentId__c;
            PolicyNameComponents = LastCreatedPolicyName.DocumentId__c.split('/');
            year = PolicyNameComponents[3];
            policyNum = PolicyNameComponents[2];
        }
        
        if(IsInsert){
            for(Policy__c pol:TriggerNew){
                Policy_Record_Type__c prt;
                Policy_LOB__c lob;
                Id EMId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
                if(pol.RecordTypeID == EMid){
                    prt = Policy_Record_Type__c.getValues('Edison Motor');
                }
                Id BDGId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
                if(pol.RecordTypeID == BDGid){
                    prt = Policy_Record_Type__c.getValues('Bridge');
                }
                Id FIDOId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
                if(pol.RecordTypeID == FIDOid){
                    prt = Policy_Record_Type__c.getValues('VFP');
                }
                Id AlphaId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Imara').getRecordTypeId();
                if(pol.RecordTypeID == Alphaid){
                    prt = Policy_Record_Type__c.getValues('Imara');
                }
                
                Id AesirId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Aesir').getRecordTypeId();
                if(pol.RecordTypeID == Aesirid){
                    prt = Policy_Record_Type__c.getValues('Aesir');
                }
                Id LSId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
                if(pol.RecordTypeID == LSid){
                    prt = Policy_Record_Type__c.getValues('Affinity');
                }
                Id GentiumId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();
                if(pol.RecordTypeID == Gentiumid){
                    prt = Policy_Record_Type__c.getValues('Gentium');
                }
                Id HOZId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Horizon').getRecordTypeId();
                if(pol.RecordTypeID == HOZId){
                    prt = Policy_Record_Type__c.getValues('Horizon');
                }
        
                if(pol.Line_Of_Business__c == 'Motor'){
                    lob = Policy_LOB__c.getValues('Motor');
                }else{
                    lob = Policy_LOB__c.getValues(pol.Line_Of_Business__c);
                }
                tempPolicyNum = Integer.valueOf((policyNum != '' ? policyNum : '00001'))+1;
                policyNum = String.valueOf(tempPolicyNum);
                while (policyNum.length() < 5){ 
                    policyNum = '0' + policyNum; 
                }
                if(!pol.VG_Is_Renewal__c){
                    LatestPolicyNameUpdate = prt.Code__c+'/'+lob.Code__c+'/'+policyNum+'/'+pol.VG_Inception_Date__c.year()+'/1';//LatestPolicyNameUpdate = prt.Code__c+'/'+lob.Code__c+'/'+policyNum+'/'+year+'/1';
                    pol.Name = LatestPolicyNameUpdate;
                    LastCreatedPolicyName.DocumentId__c = LatestPolicyNameUpdate;

                    VG_Programme__c pgm = new VG_Programme__c();
                    pgm.Name = pol.Name;
                    pgmMap.put(pgm.Name,pgm);                    
                    Update LastCreatedPolicyName;
                }else{
                    String[] polName = pol.Name.split('/');
                    pol.Name = polName[0]+'/'+polName[1]+'/'+polName[2]+'/'+polName[3]+'/'+(Integer.valueOf(polName[4])+1);
                }
            }
            if(pgmMap.size() > 0)
                Insert pgmMap.values();
                
            for(Policy__c pol : TriggerNew){
                if(!pol.VG_Is_Renewal__c){
                    pol.VG_Programme_Reference_Number__c = pgmMap.get(pol.Name).id;
                }
            }
        }
    }
    
    Public Static Void updateSLAFields(List<Policy__c> TriggerNew, Map<Id, Policy__c> TriggerOldMap,Boolean IsInsert,Boolean IsUpdate){
        BusinessHours bizHours = [Select Id from BusinessHours where Name =: 'VG_UK'];
        for(Policy__c policy : TriggerNew){
            If(IsUpdate){
                if(policy.Policy_Status__c != null && TriggerOldMap.get(policy.Id).Policy_Status__c != null){
                    if(policy.Policy_Status__c <> TriggerOldMap.get(policy.Id).Policy_Status__c){
                        if(policy.Policy_Status__c == 'Quoted'){
                            policy.VG_Quoted_Time__c = System.Now();
                        } 
                        if(policy.Policy_Status__c == 'Bound'){
                            policy.VG_Bound_Time__c = System.Now();
                            if(policy.VG_Bound_Time__c != null && policy.VG_Quoted_Time__c != null)
                                policy.VG_Quoted_Bound__c = (BusinessHours.diff(bizHours.Id, policy.VG_Quoted_Time__c, policy.VG_Bound_Time__c))/(3600*1000);
                            
                        } 
                        if(policy.Policy_Status__c == 'Booked'){
                            policy.VG_Booked_Time__c = System.Now();
                            if(policy.VG_Booked_Time__c!=null&& policy.VG_Bound_Time__c!=null)
                                policy.VG_Bound_Booked__c = (BusinessHours.diff(bizHours.Id, policy.VG_Bound_Time__c, System.Now()))/(3600*1000);
                        } 
                    }
                }
            }else{
                if(policy.Policy_Status__c == 'Quoted'){
                    policy.VG_Quoted_Time__c = System.Now();
                } 
                if(policy.Policy_Status__c == 'Bound'){
                    policy.VG_Bound_Time__c = System.Now();
                    if(policy.VG_Bound_Time__c != null && policy.VG_Quoted_Time__c != null)
                        policy.VG_Quoted_Bound__c = (BusinessHours.diff(bizHours.Id, policy.VG_Quoted_Time__c, System.Now()))/(3600*1000);
                } 
                if(policy.Policy_Status__c == 'Booked'){
                    policy.VG_Booked_Time__c = System.Now();
                    if(policy.VG_Booked_Time__c != null&& policy.VG_Bound_Time__c != null)
                        policy.VG_Bound_Booked__c = (BusinessHours.diff(bizHours.Id, policy.VG_Bound_Time__c, System.Now()))/(3600*1000);
                } 
            }
        }
    }
        
  public static void UpdateRollUpAccountFields(List<Policy__c> TriggerNew){                
        List<CurrencyType> exchangeRates = [Select Id, ConversionRate, IsoCode from CurrencyType ];
        Map<String,CurrencyType> curMap=new Map<String,CurrencyType>();
        for(CurrencyType ct: exchangeRates){
            curMap.put(ct.IsoCode,ct);
        }
        Set<Id> accIds = new Set<Id>();        
        for (Policy__c pol : TriggerNew){
            accIds.add(pol.Insured__c);
        }       
        List<Policy__c> listOfAllPolicies = [select id, Name ,Insured__c,Total_claims_reserve__c,Insured__r.CurrencyIsoCode,CurrencyISOCode,VG_MGA_Commission_Amount__c,Actual_GWP__c from Policy__c where Insured__c IN :accIds];       
        List<Policy__c> subListOfAllPolicies;
        List<Account> AccountToBeUpdated = new List<Account>();
        Map<Id, List<Policy__c>> AccountPolicyMap = new Map<Id, List<Policy__c>>();
        for(Policy__c p: listOfAllPolicies){
            if(AccountPolicyMap.get(p.Insured__c) == null){
                subListOfAllPolicies = new List<Policy__c>();
            }else{
                subListOfAllPolicies = AccountPolicyMap.get(p.Insured__c);
            }
            subListOfAllPolicies.add(p);
            AccountPolicyMap.put(p.Insured__c, subListOfAllPolicies);
        }       
        for(Id AccountId : AccountPolicyMap.keySet()){
            Decimal ca = 0;
            Decimal gwp = 0;
            Decimal tc= 0;
            Decimal divFactor;
            for(Policy__c p: AccountPolicyMap.get(AccountId)){
                if(p.CurrencyISOCode==p.Insured__r.CurrencyIsoCode){
                    divFactor=1;
                }else{
                    divFactor=curMap.get(p.CurrencyISOCode).ConversionRate/curMap.get(p.Insured__r.CurrencyIsoCode).ConversionRate;
                }
                if(p.VG_MGA_Commission_Amount__c != null)
                    ca=ca+(p.VG_MGA_Commission_Amount__c/divFactor);
                
                if(p.Actual_GWP__c != null)
                    gwp=gwp+(p.Actual_GWP__c/divFactor);
                
                if(p.Total_claims_reserve__c !=null)
                    tc=tc+(p.Total_claims_reserve__c/divFactor);
            }
            Account tempAccount = new Account();
            tempAccount.Id = AccountId;
            tempAccount.VG_Total_MGA_Commission__c=ca;
            tempAccount.Total_Account_Claims__c=tc;
            tempAccount.VG_Total_Premium__c=gwp;
            AccountToBeUpdated.add(tempAccount);
        }
        if(!AccountToBeUpdated.IsEmpty()){
            Update AccountToBeUpdated;
        }                          
    }
    
    public static void setPolicyLloydsProducts(List<Policy__c> TriggerNew, Map<Id, Policy__c> TriggerOldMap){
        
        ID BID = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
        ID HID = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Horizon').getRecordTypeId();
        ID GID = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();
        ID VFPID = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
        
        Map<id,List<Policy_Schedule__c>> polPSMap = new Map<Id,List<Policy_Schedule__c>>();
        List<Policy_Schedule__c> pshList = new List<Policy_Schedule__c>([select id, Name, Policy__c,Actual_GWP__c,VG_Volante_Entities__c, Sum_Insured__c, Limit__c, Product__c, CurrencyIsoCode, VG_Lloyds_Product__c, Policy__r.Underwriter__c from Policy_Schedule__c where Policy__c IN: TriggerOldMap.keySet()]);

        for(Policy_Schedule__c ps : pshList){
            if(polPSMap.containsKey(ps.Policy__c)) {
                List<Policy_Schedule__c> psList = polPSMap.get(ps.Policy__c);
                psList.add(ps);
                polPSMap.put(ps.Policy__c, psList);
            } else {
                polPSMap.put(ps.Policy__c, new List<Policy_Schedule__c> { ps });
            }
        }
        Map<String,Authority_Approvals__c> baaMap = new Map<String,Authority_Approvals__c>();
        List<Authority_Approvals__c> baaList = new List<Authority_Approvals__c>([select id, Name, VFP_PI__c,CurrencyIsoCode, Pt_6T_Overseas_Legal_Terrorism_Property__c,Life_Sc_NA_GL_PL_excl_Claims_Made__c, Clinical_Trials__c, Crime_BB_Crime__c, D_and_O_D2_D_O_excl_FI_incl_USA__c, D_and_O_D3_D_O_excl_FI_excl_USA__c, PI_E8_PI_excl_Legal_Acc_Arch_Eng_FI_in__c, PI_E9_PI_excl_Legal_Acc_Arch_Eng_FI_ex__c, D_and_O_D4_D_O_FI_incl_USA__c, D_and_O_D5_D_O_FI_excl_USA__c, FI_PI_F2_PI_FI_incl_USA__c, FI_PI_F3_PI_FI_excl_USA__c, GLPL_7T_Terrorism_TPL__c, GLPL_NA_GL_PL_excl_Claims_Made_excl_USA__c, GLPL_NC_GL_PL_Claims_Made_excl_USA__c, GLPL_PB_Product_Recall__c, GLPL_UA_GL_PL_excl_Claims_Made_incl_USA__c, GLPL_UC_GL_PL_Claims_Made_incl_USA__c, Life_Sc_NC_GL_PL_Claims_Made_excl_USA__c, Life_Sc_UC_GL_PL_Claims_Made_incl_USA__c, Life_Sc_PB_Product_Recall__c, Life_Sc_UA_GL_PL_excl_Claims_Made__c, PG_Op_Power_Gen_Transmission_Util_excl__c, PI_E2_PI_Legal_incl_USA__c, PI_E3_PI_Legal_excl_USA__c, PI_E4_PI_Acc_incl_USA__c, PI_E5_PI_Acc_excl_USA__c, PI_E6_PI_Arch_Eng_incl_USA__c, PI_E7_PI_Arch_Eng_excl_USA__c, PI_F4_PI_Tech_TelCo_incl_USA__c, PI_F5_PI_Tech_TelCo_excl_USA__c, Pt_B5_PD_Binder_Comm_Prop_excl_USA__c, Pt_P3_PD_Primary_Layer_Property_excl_USA__c, Pt_P4_PD_Full_Value_Property_incl_USA__c, Pt_P5_PD_Full_Value_Property_excl_USA__c, Pt_P6_PD_XS_Layer_Property_incl_USA__c, Pt_P7_PD_XS_Layer_Property_excl_USA__c, Pt_PB_Product_Recall__c, Pt_TR_PD_Direct_Prop_RI__c, VG_User_Name__c, V_Cargo_All_Risks_incl_War_excl_War_Ri__c, X3_NM_Prop_or_Pecuniary_Loss_XL_on_XL_Re__c from Authority_Approvals__c]);
        for(Authority_Approvals__c baa : baaList){
            baaMap.put(baa.VG_User_Name__c+'_'+baa.CurrencyIsoCode,baa);
        }
        for(Policy__c pol: TriggerNew){ 
            boolean approvalSubmit=false;
            String LPs='';
            if(TriggerOldMap.get(pol.id).Policy_Status__c != pol.Policy_Status__c && (pol.Policy_Status__c == 'Quoted'||pol.Policy_Status__c == 'Booked')){
                if(polPSMap.containsKey(pol.id)){
                    for(Policy_Schedule__c ps : polPSMap.get(pol.id)){
                        if(pol.RecordTypeId == BID  && ps.Product__c != 'Commercial Combined'){
                            String key=ps.Policy__r.Underwriter__c+'_'+ps.CurrencyISOCode;
                            String val;
                            String LP=ps.VG_Lloyds_Product__c;
                            LP=LP.replace(' ','_').replace('/','_').replace('-','_').replace('&','_').replace('__','_');
                            if(pol.RecordTypeId == BID){
                                if(ps.Product__c == 'GLPL'){
                                    val='GLPL_'+LP+'__c';
                                }else if(ps.Product__c == 'Life Sciences'){
                                    if(ps.VG_Lloyds_Product__c=='NA-GL/ PL excl Claims Made excl USA'){
                                        val='Life_Sc_NA_GL_PL_excl_Claims_Made__c';
                                    }else{
                                        val='Life_Sc_'+LP+'__c';
                                    }
                                }else if(ps.Product__c == 'Clinical Trials'){
                                    val=LP+'__c';
                                }else if(ps.Product__c == 'D&O'){
                                    val='D_and_O_'+LP+'__c';
                                }else if(ps.Product__c == 'PI'){
                                    if(ps.VG_Lloyds_Product__c=='E8-PI excl Legal/ Acc / Arch/ Eng/ FI incl USA'){
                                        LP='E8_PI_excl_Legal_Acc_Arch_Eng_FI_in';
                                    }else if(ps.VG_Lloyds_Product__c=='E9-PI excl Legal/ Acc / Arch/ Eng/ FI excl USA'){
                                        LP='E9_PI_excl_Legal_Acc_Arch_Eng_FI_ex';
                                    }
                                    val='PI_'+LP+'__c';
                                }else if(ps.Product__c == 'FIPI'){
                                    val='FI_PI_'+LP+'__c';
                                }else if(ps.Product__c == 'Crime'){
                                    val='Crime_'+LP+'__c';
                                }else if(ps.Product__c == 'Property'){
                                    if(ps.VG_Lloyds_Product__c=='PG-Op Power Gen Transmission/ Util excl Const'){
                                        val='PG_Op_Power_Gen_Transmission_Util_excl__c';
                                    }else if(ps.VG_Lloyds_Product__c=='V-Cargo (All Risks incl War, excl War Risks only)'){
                                        val='V_Cargo_All_Risks_incl_War_excl_War_Ri__c';
                                    }else if(ps.VG_Lloyds_Product__c=='X3-NM Prop or Pecuniary Loss XL on XL Retrocession'){
                                        val='X3_NM_Prop_or_Pecuniary_Loss_XL_on_XL_Re__c';
                                    }else{
                                        val='Pt_'+LP+'__c';
                                    }
                                }
                            }  
                            Decimal userLimit=(Decimal)baaMap.get(key).get(val);
                            if( userlimit < ps.Sum_Insured__c){
                                approvalSubmit=true;
                                LPs+=ps.VG_Lloyds_Product__c+',';
                            }
                        }else if(pol.RecordTypeId == HID || pol.RecordTypeId == GID || pol.RecordTypeId == VFPID || (pol.RecordTypeId == BID && ps.Product__c == 'Commercial Combined') ){
                            pol.VG_Sub_Status__c = 'Approved';
                        }
                    }
                }
                if(approvalSubmit){
                    LPs=LPs.left(LPs.length()-1);
                    pol.VG_Lloyds_Products__c=LPs;
                }else{
                    pol.VG_Sub_Status__c = 'Approved';
                }
            }
        }
    }
    
    public static void checkEligibilityForApproval(List<Policy__c> TriggerNew, Map<Id, Policy__c> TriggerOldMap){ 
        if(!avoidRecursion){
            avoidRecursion = True;
            Map<id,List<Policy_Schedule__c>> polPSMap = new Map<Id,List<Policy_Schedule__c>>();
            Map<Id, Policy__c> policyToBeApproved = new Map<Id, Policy__c>();
            Map<Id, Policy__c> policyToBeBounded = new Map<Id, Policy__c>();
            List<Policy__c> policyToBeUpdated = new List<Policy__c>();
            List<Policy_Schedule__c> pshList = new List<Policy_Schedule__c>([select id, Name, Policy__c,Actual_GWP__c,Sum_Insured__c, Limit__c, Product__c, CurrencyIsoCode, VG_Lloyds_Product__c, Policy__r.Underwriter__c from Policy_Schedule__c where Policy__c IN: TriggerOldMap.keySet()]);
            ID BID = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
            ID VFPID = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
            for(Policy_Schedule__c ps : pshList){
                if(polPSMap.containsKey(ps.Policy__c)) {
                    List<Policy_Schedule__c> psList = polPSMap.get(ps.Policy__c);
                    psList.add(ps);
                    polPSMap.put(ps.Policy__c, psList);
                } else {
                    polPSMap.put(ps.Policy__c, new List<Policy_Schedule__c> { ps });
                }
            }
            Map<String,Authority_Approvals__c> baaMap = new Map<String,Authority_Approvals__c>();
            List<Authority_Approvals__c> baaList = new List<Authority_Approvals__c>([select id, Name,VFP_PI__c,Life_Sc_NA_GL_PL_excl_Claims_Made__c, CurrencyIsoCode, Pt_6T_Overseas_Legal_Terrorism_Property__c, Clinical_Trials__c, Crime_BB_Crime__c, D_and_O_D2_D_O_excl_FI_incl_USA__c, D_and_O_D3_D_O_excl_FI_excl_USA__c, PI_E8_PI_excl_Legal_Acc_Arch_Eng_FI_in__c, PI_E9_PI_excl_Legal_Acc_Arch_Eng_FI_ex__c, D_and_O_D4_D_O_FI_incl_USA__c, D_and_O_D5_D_O_FI_excl_USA__c, FI_PI_F2_PI_FI_incl_USA__c, FI_PI_F3_PI_FI_excl_USA__c, GLPL_7T_Terrorism_TPL__c, GLPL_NA_GL_PL_excl_Claims_Made_excl_USA__c, GLPL_NC_GL_PL_Claims_Made_excl_USA__c, GLPL_PB_Product_Recall__c, GLPL_UA_GL_PL_excl_Claims_Made_incl_USA__c, GLPL_UC_GL_PL_Claims_Made_incl_USA__c, Life_Sc_NC_GL_PL_Claims_Made_excl_USA__c, Life_Sc_UC_GL_PL_Claims_Made_incl_USA__c, Life_Sc_PB_Product_Recall__c, Life_Sc_UA_GL_PL_excl_Claims_Made__c, PG_Op_Power_Gen_Transmission_Util_excl__c, PI_E2_PI_Legal_incl_USA__c, PI_E3_PI_Legal_excl_USA__c, PI_E4_PI_Acc_incl_USA__c, PI_E5_PI_Acc_excl_USA__c, PI_E6_PI_Arch_Eng_incl_USA__c, PI_E7_PI_Arch_Eng_excl_USA__c, PI_F4_PI_Tech_TelCo_incl_USA__c, PI_F5_PI_Tech_TelCo_excl_USA__c, Pt_B5_PD_Binder_Comm_Prop_excl_USA__c, Pt_P3_PD_Primary_Layer_Property_excl_USA__c, Pt_P4_PD_Full_Value_Property_incl_USA__c, Pt_P5_PD_Full_Value_Property_excl_USA__c, Pt_P6_PD_XS_Layer_Property_incl_USA__c, Pt_P7_PD_XS_Layer_Property_excl_USA__c, Pt_PB_Product_Recall__c, Pt_TR_PD_Direct_Prop_RI__c, VG_User_Name__c, V_Cargo_All_Risks_incl_War_excl_War_Ri__c, X3_NM_Prop_or_Pecuniary_Loss_XL_on_XL_Re__c from Authority_Approvals__c]);
            for(Authority_Approvals__c baa : baaList){
                baaMap.put(baa.VG_User_Name__c+'_'+baa.CurrencyIsoCode,baa);
            }
            for(Policy__c pol: TriggerNew){ 
                boolean approvalSubmit=false;
                String postText='';
                String LPs='';
                if(TriggerOldMap.get(pol.id).Policy_Status__c != pol.Policy_Status__c && (pol.Policy_Status__c == 'Quoted'||pol.Policy_Status__c == 'Booked') && (pol.RecordTypeId == BID || pol.RecordTypeId == VFPID)  && pol.VG_Sub_Status__c != 'Approved'){
                    if(polPSMap.containsKey(pol.id) && pol.RecordTypeId == BID){
                        for(Policy_Schedule__c ps : polPSMap.get(pol.id)){
                            if(pol.RecordTypeId == BID && ps.Product__c != 'Commercial Combined'){
                                String key=ps.Policy__r.Underwriter__c+'_'+ps.CurrencyISOCode;
                                String val;
                                String LP=ps.VG_Lloyds_Product__c;
                                LP=LP.replace(' ','_').replace('/','_').replace('-','_').replace('&','_').replace('__','_');
                                if(pol.RecordTypeId == BID){
                                    if(ps.Product__c == 'GLPL'){
                                        val='GLPL_'+LP+'__c';
                                    }else if(ps.Product__c == 'Life Sciences'){
                                        if(ps.VG_Lloyds_Product__c=='NA-GL/ PL excl Claims Made excl USA'){
                                            val='Life_Sc_NA_GL_PL_excl_Claims_Made__c';
                                        }else{
                                            val='Life_Sc_'+LP+'__c';
                                        }
                                    }else if(ps.Product__c == 'Clinical Trials'){
                                        val=LP+'__c';
                                    }else if(ps.Product__c == 'D&O'){
                                        val='D_and_O_'+LP+'__c';
                                    }else if(ps.Product__c == 'PI'){
                                        if(ps.VG_Lloyds_Product__c=='E8-PI excl Legal/ Acc / Arch/ Eng/ FI incl USA'){
                                            LP='E8_PI_excl_Legal_Acc_Arch_Eng_FI_in';
                                        }else if(ps.VG_Lloyds_Product__c=='E9-PI excl Legal/ Acc / Arch/ Eng/ FI excl USA'){
                                            LP='E9_PI_excl_Legal_Acc_Arch_Eng_FI_ex';
                                        }
                                        val='PI_'+LP+'__c';
                                    }else if(ps.Product__c == 'FIPI'){
                                        val='FI_PI_'+LP+'__c';
                                    }else if(ps.Product__c == 'Crime'){
                                        val='Crime_'+LP+'__c';
                                    }else if(ps.Product__c == 'Property'){
                                        if(ps.VG_Lloyds_Product__c=='PG-Op Power Gen Transmission/ Util excl Const'){
                                            val='PG_Op_Power_Gen_Transmission_Util_excl__c';
                                        }else if(ps.VG_Lloyds_Product__c=='V-Cargo (All Risks incl War, excl War Risks only)'){
                                            val='V_Cargo_All_Risks_incl_War_excl_War_Ri__c';
                                        }else if(ps.VG_Lloyds_Product__c=='X3-NM Prop or Pecuniary Loss XL on XL Retrocession'){
                                            val='X3_NM_Prop_or_Pecuniary_Loss_XL_on_XL_Re__c';
                                        }else{
                                            val='Pt_'+LP+'__c';
                                        }
                                    }
                                }
                                Decimal userLimit=(Decimal)baaMap.get(key).get(val);
                                if( userlimit < ps.Sum_Insured__c ){
                                    approvalSubmit=true;
                                    postText+=ps.Name+',';
                                    LPs+=ps.VG_Lloyds_Product__c+',';
                                }
                                
                            }
                        }
                    }
                    if(approvalSubmit){
                        postText=postText.left(postText.length()-1);
                        LPs=LPs.left(LPs.length()-1);
                        if(pol.Policy_Status__c == 'Quoted'){
                            FeedItem post = new FeedItem();
                            post.ParentId = pol.id;
                            post.Body = 'Policy submitted for approval as sum insured exceeds limit..'+postText;
                            insert post;
                            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest(); 
                            req.setComments('Auto Submitted for approval');
                            if(pol.RecordTypeId == BID){
                                req.setProcessDefinitionNameOrId(Label.Nordics_100k_Approval_Process_External_Id);
                            }
                            req.setObjectId(pol.id);
                            req.setSubmitterId(pol.Underwriter__c);
                            Approval.ProcessResult result = Approval.process(req);
                        }else{
                            FeedItem post = new FeedItem();
                            post.ParentId = pol.id;
                            post.Body = 'Policy submitted for approval as sum insured exceeds limit..'+postText;
                            insert post;
                            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest(); 
                            req.setComments('Auto Submitted for approval');
                            req.setProcessDefinitionNameOrId(Label.Nordics_100k_Approval_Process_External_Id);
                            req.setObjectId(pol.id);
                            req.setSubmitterId(pol.Underwriter__c);
                            Approval.ProcessResult result = Approval.process(req);
                            policyToBeBounded.put(pol.id, pol);
                        }
                    }
                }
            }
            if(!policyToBeBounded.IsEmpty()){
                List<Policy__c> polList = [Select Id, VG_Sub_Status__c,Policy_Status__c  from Policy__c where Id IN: policyToBeBounded.keySet()];
                for(Policy__c pol: polList){ 
                    pol.Policy_Status__c = 'Bound';
                    pol.VG_Sub_Status__c = 'Awaiting Approval';
                    policyToBeUpdated.add(pol);
                }
            }
            if(!policyToBeUpdated.IsEmpty()){
                update policyToBeUpdated;
            }
        }
    }
    
    Public Static Void currencyUpdateOnChilds(List<Policy__c> TriggerNew, Map<Id, Policy__c> TriggerOldMap){
        Boolean allowUpdate=false;
        Map<Id,String> polCurMap=new Map<Id,String>();
        for(Policy__c pol: TriggerNew){
            if(pol.CurrencyIsoCode != TriggerOldMap.get(pol.id).CurrencyIsoCode){
                allowUpdate=True;
                polCurMap.put(pol.id,pol.CurrencyIsoCode);
            }
        }
        if(allowUpdate){
            Map<Id,Policy_Schedule__c> psMap=new Map<Id,Policy_Schedule__c>([select id,Name,CurrencyIsoCode,Policy__c from Policy_Schedule__c where Policy__c IN: polCurMap.keyset()]);
            List<VG_Policy_Schedule_Asset__c> psaList=new List<VG_Policy_Schedule_Asset__c>([select id,Name,CurrencyIsoCode,VG_Policy_Schedule__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psMap.keyset()]);
            List<VG_Policy_Schedule_Endorsement__c> pseList=new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,CurrencyIsoCode,VG_Policy_Schedule__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c IN: psMap.keyset()]);
            List<Risk_Capture__c> rcList=new List<Risk_Capture__c>([select id,Name,CurrencyIsoCode,Policy_Schedule__c from Risk_Capture__c where Policy_Schedule__c IN: psMap.keyset()]);
            List<VG_ReInsurance__c> reList=new List<VG_ReInsurance__c>([select id,Name,CurrencyIsoCode,VG_Policy_Schedule__c from VG_ReInsurance__c where VG_Policy_Schedule__c IN: psMap.keyset()]);
            List<VG_Taxes__c> taxList=new List<VG_Taxes__c>([select id,Name,CurrencyIsoCode,VG_Policy_Schedule__c from VG_Taxes__c where VG_Policy_Schedule__c IN: psMap.keyset()]);
            List<VG_Payment_Frequency__c> pfList=new List<VG_Payment_Frequency__c>([select id,Name,CurrencyIsoCode,VG_Policy_Schedule__c from VG_Payment_Frequency__c where VG_Policy_Schedule__c IN: psMap.keyset()]);
            for(Policy_Schedule__c ps: psMap.values()){
                ps.CurrencyIsoCode=polCurMap.get(ps.Policy__c);
                
                /*for(VG_ReInsurance__c re: reList){
                    re.CurrencyIsoCode=psMap.get(re.VG_Policy_Schedule__c).CurrencyIsoCode;                    
                }*/
                for(Risk_Capture__c rc:rcList){
                    rc.CurrencyIsoCode=psMap.get(rc.Policy_Schedule__c).CurrencyIsoCode;
                }
                for(VG_Policy_Schedule_Endorsement__c pse:pseList){
                    pse.CurrencyIsoCode=psMap.get(pse.VG_Policy_Schedule__c).CurrencyIsoCode;
                }
                for(VG_Policy_Schedule_Asset__c psa:psaList){
                    psa.CurrencyIsoCode=psMap.get(psa.VG_Policy_Schedule__c).CurrencyIsoCode;
                }
                for(VG_Taxes__c tax:taxList){
                    tax.CurrencyIsoCode=psMap.get(tax.VG_Policy_Schedule__c).CurrencyIsoCode;
                }
                for(VG_Payment_Frequency__c pf:pfList){
                    pf.CurrencyIsoCode=psMap.get(pf.VG_Policy_Schedule__c).CurrencyIsoCode;
                }                
            }
            if(psMap !=null){
                update psMap.values();
            }
            /*if(!reList.IsEmpty()){
                update reList;
            }*/
            if(!rcList.IsEmpty()){
                update rcList;
            }
            if(!pseList.IsEmpty()){
                update pseList;
            }
            if(!psaList.IsEmpty()){
                update psaList;
            }
            if(!taxList.IsEmpty()){
                update taxList;
            }
            if(!pfList.IsEmpty()){
                update pfList;
            }
        }
    }
    
    Public Static Void updateRIRecords(List<Policy__c> TriggerNew,Map<Id,Policy__c> TriggerOldMap){
        Boolean allowUpdate=false;
        Map<Id,String> polCurMap=new Map<Id,String>();
        Map<Id,Policy_Schedule__c> psMap =new Map<Id,Policy_Schedule__c>();
        List<VG_ReInsurance__c> RIList = new List<VG_ReInsurance__c>();
        Set<Id> psToBeUpdated = new Set<Id>();
            
        for(Policy__c pol: TriggerNew){
           if(pol.VG_Inception_Date__c != TriggerOldMap.get(pol.id).VG_Inception_Date__c){               
                psToBeUpdated.add(pol.Id);
            }
        }
        if(!psToBeUpdated.IsEmpty()){
            psMap = new Map<Id,Policy_Schedule__c>([select id, Policy__c, RecordTypeId, VG_Volante_Entities__c, Bordereaux_Override__c, VG_Capacity_Paper__c, VG_Is_MTA__c , Name, CurrencyIsoCode, Account_Id__c from Policy_Schedule__c where Policy__c IN: psToBeUpdated]);
            RIList = [Select Id from VG_ReInsurance__c where VG_Policy_Schedule__c IN : psMap.keySet()]; 
            if(!RIList.IsEmpty())
                delete RIList;      
            PolicyScheduleTriggerFunction.createRIRecords(psMap.values());      
        }
    }
    
    Public Static Void ValidateMandatoryFields(List<Policy__c> TriggerNew, Map<Id, Policy__c> TriggerOldMap){ 
        if(!Utilities.avoidRecursionCheck('ValidateMandatoryFields')){
            Id VFPId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('VFP').getRecordTypeId();
            Id HOZId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Horizon').getRecordTypeId();
            Id EDMId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Edison Motor').getRecordTypeId();
            Id AFSId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Affinity').getRecordTypeId();
            Id ASRId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Aesir').getRecordTypeId();
            Id BDGId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Bridge').getRecordTypeId();
            Id IMRId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Imara').getRecordTypeId();
            Id GENId = Schema.SObjectType.Policy__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();
            
            List<VG_Validations__c> valList = [Select Id, VG_Field_API__c, VG_Field_Label__c, VG_Level__c, VG_Policy_Status__c, VG_RecordTypeName__c, VG_Type__c, VG_Value__c from VG_Validations__c];
            Map<String,  Map<String,  List<VG_Validations__c>>> valListMap = new Map<String,  Map<String,  List<VG_Validations__c>>>();
            
            for(VG_Validations__c val : valList){
                if(val.VG_RecordTypeName__c == 'Edison Motor'){
                    Map<String,  List<VG_Validations__c>> edisontempMap = valListMap.get(EDMId) == null ? new Map<String,  List<VG_Validations__c>>() : valListMap.get(EDMId);
                    List<VG_Validations__c> tempList = edisontempMap.get(val.VG_Level__c) == null ? new List<VG_Validations__c>() : edisontempMap.get(val.VG_Level__c);
                    tempList.add(val);
                    edisontempMap.put(val.VG_Level__c,  tempList);
                    valListMap.put(EDMId,  edisontempMap);
                }else if(val.VG_RecordTypeName__c == 'Bridge'){
                    Map<String,  List<VG_Validations__c>> bridgetempMap = valListMap.get(BDGId) == null ? new Map<String,  List<VG_Validations__c>>() : valListMap.get(BDGId);
                    List<VG_Validations__c> tempList = bridgetempMap.get(val.VG_Level__c) == null ? new List<VG_Validations__c>() : bridgetempMap.get(val.VG_Level__c);
                    tempList.add(val);
                    bridgetempMap.put(val.VG_Level__c,  tempList);
                    valListMap.put(BDGId,  bridgetempMap);
                }else if(val.VG_RecordTypeName__c == 'Horizon'){
                    Map<String,  List<VG_Validations__c>> horizontempMap = valListMap.get(HOZId) == null ? new Map<String,  List<VG_Validations__c>>() : valListMap.get(HOZId);
                    List<VG_Validations__c> tempList = horizontempMap.get(val.VG_Level__c) == null ? new List<VG_Validations__c>() : horizontempMap.get(val.VG_Level__c);
                    tempList.add(val);
                    horizontempMap.put(val.VG_Level__c,  tempList);
                    valListMap.put(HOZId,  horizontempMap);
                }else if(val.VG_RecordTypeName__c == 'Imara'){
                    Map<String,  List<VG_Validations__c>> imaratempMap = valListMap.get(IMRId) == null ? new Map<String,  List<VG_Validations__c>>() : valListMap.get(IMRId);
                    List<VG_Validations__c> tempList = imaratempMap.get(val.VG_Level__c) == null ? new List<VG_Validations__c>() : imaratempMap.get(val.VG_Level__c);
                    tempList.add(val);
                    imaratempMap.put(val.VG_Level__c,  tempList);
                    valListMap.put(IMRId,  imaratempMap);
                }else if(val.VG_RecordTypeName__c == 'Aesir'){
                    Map<String,  List<VG_Validations__c>> aesirtempMap = valListMap.get(ASRId) == null ? new Map<String,  List<VG_Validations__c>>() : valListMap.get(ASRId);
                    List<VG_Validations__c> tempList = aesirtempMap.get(val.VG_Level__c) == null ? new List<VG_Validations__c>() : aesirtempMap.get(val.VG_Level__c);
                    tempList.add(val);
                    aesirtempMap.put(val.VG_Level__c,  tempList);
                    valListMap.put(ASRId,  aesirtempMap);
                }else if(val.VG_RecordTypeName__c == 'Affinity'){
                    Map<String,  List<VG_Validations__c>> affinitytempMap = valListMap.get(AFSId) == null ? new Map<String,  List<VG_Validations__c>>() : valListMap.get(AFSId);
                    List<VG_Validations__c> tempList = affinitytempMap.get(val.VG_Level__c) == null ? new List<VG_Validations__c>() : affinitytempMap.get(val.VG_Level__c);
                    tempList.add(val);
                    affinitytempMap.put(val.VG_Level__c,  tempList);
                    valListMap.put(AFSId,  affinitytempMap);
                }else if(val.VG_RecordTypeName__c == 'VFP'){
                    Map<String,  List<VG_Validations__c>> fidotempMap = valListMap.get(VFPId) == null ? new Map<String,  List<VG_Validations__c>>() : valListMap.get(VFPId);
                    List<VG_Validations__c> tempList = fidotempMap.get(val.VG_Level__c) == null ? new List<VG_Validations__c>() : fidotempMap.get(val.VG_Level__c);
                    tempList.add(val);
                    fidotempMap.put(val.VG_Level__c,  tempList);
                    valListMap.put(VFPId,  fidotempMap);
                }else if(val.VG_RecordTypeName__c == 'Gentium'){
                    Map<String,  List<VG_Validations__c>> gentiumtempMap = valListMap.get(GENId) == null ? new Map<String,  List<VG_Validations__c>>() : valListMap.get(GENId);
                    List<VG_Validations__c> tempList = gentiumtempMap.get(val.VG_Level__c) == null ? new List<VG_Validations__c>() : gentiumtempMap.get(val.VG_Level__c);
                    tempList.add(val);
                    gentiumtempMap.put(val.VG_Level__c,  tempList);
                    valListMap.put(GENId,  gentiumtempMap);
                }
                
            }
            
            Set<Id> accIds = new Set<Id>();  
            List <String> renewPolIds = new List<String>();
            Set<Id> accBrokerIds = new Set<Id>();
            Set<Id> PolBrokerIds = new Set<Id>(); 
            Set<Id> govIds = new Set<Id>();   
            for (Policy__c pol : TriggerNew){
                accIds.add(pol.Insured__c);
                renewPolIds.add(pol.VG_Renewal_Policy_Id__c);
                accBrokerIds.add(pol.VG_Surplus_Broker__c);
                govIds.add(pol.VG_Governance_Compliance__c);
                PolBrokerIds.add(pol.Broker_Name__c);
            }
            Map<Id, Policy_Schedule__c> psListMap = new Map<Id, Policy_Schedule__c>([select id, VG_Volante_Entities__c,  Name,VG_Status__c,VG_Type_Of_Operation__c, VG_D_O_Product__c, ILF_Layer__c,VG_Rate_Change__c, VG_MTA_Type__c, VG_Occupancy__c, VG_Structure__c, VG_Reinsurance_Type__c, Gross_Written_Premium__c,  VG_Technical_Model_Premium__c, VG_Deductible__c, Policy__c, Sum_Insured__c, Attachment__c, VG_Lloyds_Product__c, Limit__c, VG_Brokerage_Percent__c, Transaction_GWP__c, Written_share__c, Share__c, VG_Coverages__c, Product__c, MID_Check_Box__c, RecordTypeId from Policy_Schedule__c where Policy__c IN: TriggerOldMap.keySet()]);        
            Set<Id> psids = new Set<Id>();
            for(Policy_Schedule__c ps: psListMap.values()){
                if(!psids.contains(ps.id))
                    psids.add(ps.id);
            }
            String RenewPolName = ''; 
            for (Policy__c pol : TriggerNew){
                If(pol.VG_Is_Renewal__c == True){
                    String[] polName = pol.Name.split('/');
                    Integer lastnum = Integer.valueOf(polName[4]);
                    RenewPolName = polName[0]+'/'+polName[1]+'/'+polName[2]+'/'+polName[3]+'/'+String.valueOf(lastnum-1);                
                    renewPolIds.add(RenewPolName);                        
                } 
            }
            Map<Id,  Account> allAccMap = new Map<Id,  Account>([select id, Name, IsDeleted, MasterRecordId, Type, RecordTypeId, ParentId, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingLatitude, BillingLongitude, BillingGeocodeAccuracy, BillingAddress, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, ShippingLatitude, ShippingLongitude, ShippingGeocodeAccuracy, ShippingAddress, Phone, Fax, AccountNumber, Website, PhotoUrl, Sic, Industry, AnnualRevenue, NumberOfEmployees, Ownership, TickerSymbol, Description, Rating, Site, CurrencyIsoCode, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, AccountSource, SicDesc, Broker_Type__c, Street__c, City__c, Country__c, Post_Code_Zip_Code__c, E_mail_address__c, VG_Credit_Score__c, Broker_Distribution__c, Regulatory_Check__c, VG_Bankgiro__c, Rating_Agency__c, Intermediary_Role__c, Company_Registration_Number__c, Customer_Size_GBP_Revenue__c, Business_Description__c, Marketing_Consent__c, Bank_Name__c, Bank_Account_Number__c, Bank_Sort_Code__c, Bank_Swift_Code__c, Bank_IBAN_No__c, VG_TOBA_Uploaded__c, VG_Exchange_List__c, VG_Intermediary_Number__c, Billing_E_mail__c, Billing_Phone__c, VG_Total_Premium__c, Total_claims_reserve__c, Total_claims_paid__c, VG_Total_MGA_Commission__c, Total_claims_o_s__c, Loss_Ratio__c, Sanction_Check__c, VG_Trading_Name__c, Total_Account_Claims__c, Account_Loss_Ratio__c, VG_Insured_Policyholder_Type__c, VG_Surplus_Lines_Broker_License_No__c, Terms__c from Account where (Id IN :accIds) OR (Id IN :accBrokerIds) OR (Id IN :PolBrokerIds)]);                                        
            Map<Id,  Account> accListMap = new Map<Id,  Account>();        
            Map<Id,  Account> accBrokerListMap = new Map<Id,  Account>();        
            Map<Id,  Account> policyBrokerListMap = new Map<Id,  Account>();    
            for(Account acc: allAccMap.values()){
                if(accIds.contains(acc.id)){
                    accListMap.put(acc.id, acc);
                }
                if(accBrokerIds.contains(acc.id)){
                    accBrokerListMap.put(acc.id, acc);
                }
                if(PolBrokerIds.contains(acc.id)){
                    policyBrokerListMap.put(acc.id, acc);
                }
            }    
            Map<Id, Policy__c> renewalpolicymap = new Map<Id,  Policy__c>([select Id,  Name, VG_Renewal_Policy_Id__c, VG_Expiry_Date__c, VG_Inception_Date__c from Policy__c where Name IN:renewPolIds]);
            Map<ID,  VG_Governance_Compliance__c> govListMap = new Map<Id,  VG_Governance_Compliance__c>([select id, VG_Referral__c, VG_Referral_completed_By__c, VG_Peer_Review__c, VG_Policy_Issuance_Date__c, VG_Deadline__c, VG_Contact_Certainty_Date__c, VG_Reason_for_Referral__c, VG_Referred_to__c, Referred_to__c, VG_Rating_Considerations__c, VG_Proposed_Terms__c, VG_Referral_Underwirter_Comments__c, VG_Referral_Complete__c, VG_Documents_attached__c, VG_Contract_Certainty_Comments__c, VG_Contract_Certainty__c, Name, VG_Question_1__c, VG_Question_2__c, VG_Question_3__c, VG_Question_4__c, VG_Question_5__c, VG_Question_6__c, VG_Question_7__c, VG_Question_8__c, VG_Question_9__c, VG_Question_10__c, VG_Question_11__c, VG_Peer_Reviewer_2__c, VG_Peer_Reviewer_1__c, VG_Peer_Review_1_Comments__c, VG_Peer_Review_2_Comments__c, VG_Peer_Review_1_Complete__c, VG_Peer_Review_2_Complete__c, VG_Peer_Review_1_Date__c, VG_Peer_Review_2_Date__c, VG_Slip_Reference_No__c, VG_Loss_History__c, VG_Pricing_Rationale__c, VG_UW_Consideration__c, VG_Key_Clauses_Exclusions__c, VG_Conditions_Subjectivites__c from VG_Governance_Compliance__c where Id IN :govIds]);
            List<VG_Policy_Schedule_Asset__c> psaList = new List<VG_Policy_Schedule_Asset__c>([select id, Name, VG_Limit__c, VG_Technical_UW_Rate_Annual__c, VG_Deposit_Premium__c, VG_Limit_Precent__c, VG_Coverage__c, VG_Rate_Per_Vehicle__c, VG_Sum_Insured__c, VG_Number_of_Vehicles__c, VG_Vehicle_Type__c, VG_Use__c, VG_Vehicle_Make__c, VG_Deductible__c, VG_Policy_Schedule__c, VG_Gross_Written_Premium__c, VG_GNPI__c, VG_Minimum_Premium__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psids]);
            List<VG_Taxes__c> taxesList = [Select Id, Name, VG_Policy_Schedule__r.Split_Type__c, VG_Tax_Jurisdiction__c from VG_Taxes__c where VG_Policy_Schedule__c IN: psids];
            List<VG_ReInsurance__c> riList = new List<VG_ReInsurance__c>([select id, Name, CurrencyIsoCode, VG_Policy_Schedule__c from VG_ReInsurance__c where VG_Policy_Schedule__c IN: psids]);
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
            Map<id, List<VG_Taxes__c>> psTaxesMap = new Map<Id, List<VG_Taxes__c>>();
            for(VG_Taxes__c tx : taxesList){
                if(psTaxesMap.containsKey(tx.VG_Policy_Schedule__c)) {
                    List<VG_Taxes__c> txList = psTaxesMap.get(tx.VG_Policy_Schedule__c);
                    txList.add(tx);
                    psTaxesMap.put(tx.VG_Policy_Schedule__c,  txList);
                } else {
                    psTaxesMap.put(tx.VG_Policy_Schedule__c,  new List<VG_Taxes__c> { tx });
                }
            }
            
            List<Risk_Capture__c> rcList = new List<Risk_Capture__c>([select id, Name, Policy_Schedule__c, VG_Market_Cap__c, VG_Company_Type__c, VG_Rate_Type__c, VG_Fees_Current_Year__c, VG_Industry__c, VG_Revenue__c, VG_Total_Assets__c, VG_Territorial_Scope__c from Risk_Capture__c where Policy_Schedule__c IN: psids]);
            Map<id, List<Risk_Capture__c>> psRCMap = new Map<Id, List<Risk_Capture__c>>();
            for(Risk_Capture__c rc : rcList){
                if(psRCMap.containsKey(rc.Policy_Schedule__c)) {
                    List<Risk_Capture__c> rdList = psRCMap.get(rc.Policy_Schedule__c);
                    rdList.add(rc);
                    psRCMap.put(rc.Policy_Schedule__c,  rdList);
                } else {
                    psRCMap.put(rc.Policy_Schedule__c,  new List<Risk_Capture__c> { rc });
                }
            }
            
            List<VG_Payment_Frequency__c> pfList = new List<VG_Payment_Frequency__c>([select id, Name, CurrencyIsoCode, VG_Payment_Percent__c, VG_Due_Date__c, VG_Outstanding_taxes__c, VG_Policy_Schedule__c, VG_Comment__c, Is_Payment_Generated__c from VG_Payment_Frequency__c where VG_Policy_Schedule__c IN: psids]);
            Map<id, List<Policy_Schedule__c>> polPSMap = new Map<Id, List<Policy_Schedule__c>>();
            for(Policy_Schedule__c ps : psListMap.values()){
                if(polPSMap.containsKey(ps.Policy__c)) {
                    List<Policy_Schedule__c> psList = polPSMap.get(ps.Policy__c);
                    psList.add(ps);
                    polPSMap.put(ps.Policy__c,  psList);
                } else {
                    polPSMap.put(ps.Policy__c,  new List<Policy_Schedule__c> { ps });
                }
            }
            
            Map<id, List<VG_Payment_Frequency__c>> psPFMap = new Map<Id, List<VG_Payment_Frequency__c>>();
            for(VG_Payment_Frequency__c pf : pfList){
                if(psPFMap.containsKey(pf.VG_Policy_Schedule__c)) {
                    List<VG_Payment_Frequency__c> pfrList = psPFMap.get(pf.VG_Policy_Schedule__c);
                    pfrList.add(pf);
                    psPFMap.put(pf.VG_Policy_Schedule__c,  pfrList);
                } else {
                    psPFMap.put(pf.VG_Policy_Schedule__c,  new List<VG_Payment_Frequency__c> { pf });
                }
            }
            VG_Governance_Compliance__c gc;       
            for(Policy__c p :TriggerNew){   
                String message = ''; 
                If(!psTaxesMap.IsEmpty() && !polPSMap.IsEmpty() && p.RecordTypeId == VFPId && (p.Policy_Status__c == 'Booked' || p.Policy_Status__c == 'Bound')){
                    Set<String> eeaCountries = new Set<String>();
                    eeaCountries.addAll(Label.EEA_Countries.split(';'));
                    for(Policy_Schedule__c ps :  polPSMap.get(p.id)){ 
                        if(psTaxesMap.get(ps.Id) != null){
                            for(VG_Taxes__c tax : psTaxesMap.get(ps.Id)){
                                if(tax.VG_Policy_Schedule__r.Split_Type__c == 'EEA' && (!eeaCountries.contains(tax.VG_Tax_Jurisdiction__c))){
                                    message += 'Please check tax jurisdiction as policy schedule split is for EEA and tax jurisdiction is Non EEA for '+ps.Name+' ['+tax.Name+']<br/>';
                                }else if(tax.VG_Policy_Schedule__r.Split_Type__c == 'Non EEA' && (eeaCountries.contains(tax.VG_Tax_Jurisdiction__c))){
                                    message += 'Please check tax jurisdiction as policy schedule split is for Non EEA and tax jurisdiction is EEAfor '+ps.Name+' ['+tax.Name+']<br/>';
                                }
                            }
                        }
                    } 
                }
                If(p.VG_Ignore_Validation__c == false){
                    If(govListMap.IsEmpty() && p.Policy_Status__c == 'Booked'){
                        If(p.RecordTypeId  != BDGId){
                            message+= 'Please fill out the Governance and Compliance section for '+p.Name+'<br/>';
                        }else{
                            If(p.VG_Governance_Compliance__c == null){
                                gc = new VG_Governance_Compliance__c();
                                gc.Name = 'Governance Compliance for policy '+p.Name; 
                                insert gc;   
                                p.VG_Governance_Compliance__c = gc.id;                              
                            }else{
                                update gc;
                            }                     
                        }
                    }
                    If(!valListMap.IsEmpty()){
                        for(String level : valListMap.get(p.RecordTypeId).keySet()){
                            If(level == 'Capacity Bordereaux' && !polPSMap.IsEmpty()){ 
                                for(Policy_Schedule__c ps: polPSMap.get(p.id)){
                                    If(psRIMap.get(ps.id) == null && ((ps.VG_MTA_Type__c == null && p.Policy_Status__c=='Quoted') || (ps.VG_MTA_Type__c == null && p.Policy_Status__c=='Bound') || (ps.VG_MTA_Type__c == null && p.Policy_Status__c=='Booked') || (ps.VG_MTA_Type__c   != null && ps.VG_Status__c=='Booked'))){
                                        message+= 'Please make sure the policy attaches to an approved binder  '+ps.Name+'<br/>';                        
                                    }
                                }
                            }
                            if(level == 'Account'){
                                for(VG_Validations__c val : valListMap.get(p.RecordTypeId).get(level)){
                                    If(!accListMap.IsEmpty()){
                                        for(Account acc : accListMap.values()){
                                            if(val.VG_Policy_Status__c == p.Policy_Status__c){
                                                if(val.VG_Type__c == 'Null Check' && ((acc.get(val.VG_Field_API__c) == null) || (acc.get(val.VG_Field_API__c) == false))){
                                                    message+= 'Account Field: ['+val.VG_Field_Label__c+'] is a required field in '+ acc.Name + ' Account'+'<br/>';                   
                                                }                                                                                   
                                            }                                                                
                                        }                                                     
                                    }                            
                                }                   
                            }else If(level == 'Policy'){                                                      
                                for(VG_Validations__c val : valListMap.get(p.RecordTypeId).get(level)){
                                    if(val.VG_Policy_Status__c == p.Policy_Status__c){
                                        for(Policy__c basepol : renewalpolicymap.values()){
                                            If(p.VG_Is_Renewal__c == True){
                                                If((p.VG_Inception_Date__c  !=   (basepol.VG_Expiry_Date__c+1) && p.VG_Inception_Date__c  != (basepol.VG_Expiry_Date__c)) && val.VG_Type__c == 'Value Check' &&  val.VG_Value__c  ==  'Renew Policy Inception date'){
                                                    message+= 'Policy Field: [' +val.VG_Field_Label__c + '] should be next date of Base policy Expiry Date'+'<br/>';
                                                    
                                                }
                                            } 
                                        }         
                                        if(val.VG_Type__c == 'Null Check' && (p.get(val.VG_Field_API__c) == null)){
                                            message+= 'Policy Field: [' +val.VG_Field_Label__c + '] is required in '+ p.Name +'<br/>';
                                        }else if(val.VG_Type__c == 'Value Check' && (p.get(val.VG_Field_API__c) == null) && p.VG_LTA__c == 'Yes' && val.VG_Value__c == 'Yes'){
                                            message+= 'Policy Field: ['+val.VG_Field_Label__c+ '] is required in '+ p.Name +'<br/>';
                                        }else if(val.VG_Type__c == 'Value Check' && (p.get(val.VG_Field_API__c) == null) && p.CurrencyIsoCode == 'USD' && val.VG_Value__c == 'USD'){
                                            message+= 'Policy Field: ['+val.VG_Field_Label__c+ '] is required in '+ p.Name +'<br/>';
                                        }else if(val.VG_Type__c == 'Value Check' && (p.get(val.VG_Field_API__c) == null) && p.VG_US_Classification__c == 'US Surplus Lines' && val.VG_Value__c == 'US Surplus Lines'){
                                            message+= 'Policy Field: ['+ val.VG_Field_Label__c+ '] is required in '+ p.Name +'<br/>';
                                        }else if(val.VG_Type__c == 'Value Check' && (p.get(val.VG_Field_API__c) == null) && p.VG_US_Classification__c == 'US Reinsurance' && val.VG_Value__c == 'US Reinsurance'){
                                            message+= 'Policy Field: ['+val.VG_Field_Label__c+ '] is required in '+ p.Name +'<br/>';
                                        }else if(val.VG_Type__c == 'Value Check' && (p.get(val.VG_Field_API__c) == null) && p.VG_Retroactive_Date_Applicable__c == 'Yes' && val.VG_Value__c == 'RD_Yes'){
                                            message+= 'Policy Field: ['+val.VG_Field_Label__c+ '] is required in '+ p.Name +'<br/>';
                                        }
                                        If(!policyBrokerListMap.IsEmpty()){
                                            for(Account acc : policyBrokerListMap.values()){
                                                if(val.VG_Policy_Status__c == p.Policy_Status__c){
                                                    if(val.VG_Type__c == 'Value Check' && (acc.Terms__c == null) && (p.get(val.VG_Field_API__c) == null) && val.VG_Value__c == 'BrokerTerms'){
                                                        message+= 'Policy Field: ['+val.VG_Field_Label__c+ '] is required in '+ p.Name +'<br/>';                                        
                                                    }
                                                }                                
                                            }  
                                        }                                                                                          
                                    }                                               
                                }                                        
                            }else if(level == 'Broker'){
                                for(VG_Validations__c val : valListMap.get(p.RecordTypeId).get(level)){
                                    If(!accBrokerListMap.IsEmpty()){
                                        for(Account acc : accBrokerListMap.values()){
                                            if(val.VG_Policy_Status__c == p.Policy_Status__c){
                                                if(val.VG_Type__c == 'Value Check' && (acc.get(val.VG_Field_API__c) == null) && p.VG_US_Classification__c == 'US Surplus Lines' && val.VG_Value__c == 'US Surplus Lines'){
                                                    message+= 'Policy Surplus Broker Field: ['+val.VG_Field_Label__c+ '] is required in '+ acc.Name +'<br/>';                                        
                                                }                                 
                                            }                                
                                        }  
                                    }                          
                                }                     
                            }else If(level == 'Policy Schedule'){
                                If(!polPSMap.IsEmpty()){
                                    for(Policy_Schedule__c ps :  polPSMap.get(p.id)){ 
                                        if(ps.VG_Volante_Entities__c != null && (p.Policy_Status__c == 'Booked' || p.Policy_Status__c == 'Bound') && p.RecordTypeId == VFPId && (!p.VG_Volante_Entities__c.contains(ps.VG_Volante_Entities__c))){
                                            message+= 'Entity selected on Policy Schedule must match the entity on Policy for '+ps.Name+'<br/>';
                                        } 
                                    } 
                                }
                                for(VG_Validations__c val : valListMap.get(p.RecordTypeId).get(level)){                                                                                           
                                    If(!polPSMap.IsEmpty()  && p.RecordTypeId   != IMRId){
                                        for(Policy_Schedule__c ps :  polPSMap.get(p.id)){  
                                            If((val.VG_Policy_Status__c == p.Policy_Status__c) && p.VG_Is_Renewal__c == True){
                                                If(val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == '--None--') && val.VG_Value__c == 'Renew Policy'){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>';                                                   
                                                } 
                                            }                          
                                            if(ps.VG_MTA_Type__c == null && (val.VG_Policy_Status__c == p.Policy_Status__c)){
                                                if(val.VG_Type__c == 'Null Check' && (ps.get(val.VG_Field_API__c) == null || (ps.get(val.VG_Field_API__c) == 0.00) || ps.get(val.VG_Field_API__c) == '--None--') ){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == '--None--') && val.VG_Value__c == 'Accept_Zero' ){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }
                                                
                                                //AFS PS   
                                                if((p.RecordTypeId == AFSId && val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--')) && ps.Product__c != 'Property' && val.VG_Value__c == ''){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == AFSId && (val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--')) && ps.Product__c == 'Property' && val.VG_Value__c == 'Property'){
                                                    message+= 'Policy Schedule ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }
                                                
                                                //VFP PS
                                                if(p.RecordTypeId == VFPId && val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c != 'FI - Cyber'  && ps.Product__c != 'PI' && ps.ILF_Layer__c!='Primary') && val.VG_Value__c == 'Not (FI - Cyber AND PI)_Layer'){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == VFPId && val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c != 'FI - Cyber'  && ps.Product__c != 'PI') && val.VG_Value__c == 'Not (FI - Cyber AND PI)'){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == VFPId && val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c != 'FI - Cyber'  && ps.Product__c != 'PI' && ps.Product__c != 'W&I') && val.VG_Value__c == 'Not (FI - Cyber AND PI AND W&I)'){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == VFPId && val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c == 'PI') && val.VG_Value__c == 'PI'){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == VFPId && (val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c == 'D&O' && val.VG_Value__c == 'DO Product'))){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == VFPId && (val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') && ps.Product__c != 'W&I' &&  val.VG_Value__c == 'Check share')){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == VFPId && (val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') && ps.Product__c != 'W&I' && val.VG_Value__c == 'Not (FI - Cyber AND PI AND W&I) AND Check Share')){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == VFPId){
                                                    If((val.VG_Value__c == 'Check share') || (val.VG_Value__c == 'Not (FI - Cyber AND PI AND W&I) AND Check Share')){
                                                        If(ps.Share__c>ps.Written_share__c)
                                                            message+= 'Policy Schedule Field: [ Signed share ] should be lower than or equal to  [ Written share ] '+ps.name+'<br/>'; 
                                                    }
                                                }
                                                
                                                //ASR PS
                                                if(p.RecordTypeId == ASRId && (val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') &&  val.VG_Value__c == 'SignedShare')){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == ASRId && (val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') &&  val.VG_Value__c == 'WrittenShare')){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == ASRId){
                                                    If((val.VG_Value__c == 'SignedShare') || (val.VG_Value__c == 'WrittenShare')){
                                                        If(ps.Share__c.setScale(2) > ps.Written_share__c.setScale(2))
                                                            message+= 'Policy Schedule Field: [ Signed share ] should be lower than or equal to  [ Written share ] '+ps.name+'<br/>'; 
                                                    }
                                                }
                                                
                                                //HOZ PS
                                                if(p.RecordTypeId == HOZId && (val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') &&  val.VG_Value__c == 'SignedShare')){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == HOZId && (val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') &&  val.VG_Value__c == 'WrittenShare')){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == HOZId){
                                                    If((val.VG_Value__c == 'SignedShare') || (val.VG_Value__c == 'WrittenShare')){
                                                        If(ps.Share__c>ps.Written_share__c)
                                                            message+= 'Policy Schedule Field: [ Signed share ] should be lower than or equal to [ Written share ] '+ps.name+'<br/>'; 
                                                    }
                                                }
                                                
                                                //IMR PS
                                                if(p.RecordTypeId == IMRId && (val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') &&  val.VG_Value__c == 'SignedShare')){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == IMRId && (val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') &&  val.VG_Value__c == 'WrittenShare')){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }else if(p.RecordTypeId == IMRId){
                                                    If((val.VG_Value__c == 'SignedShare') || (val.VG_Value__c == 'WrittenShare')){
                                                        If(ps.Share__c>ps.Written_share__c)
                                                            message+= 'Policy Schedule Field: [ Signed share ] should be lower than or equal to  [ Written share ] '+ps.name+'<br/>'; 
                                                    }
                                                }
                                                
                                                //BDG PS 
                                                if((p.RecordTypeId == BDGId && (ps.Product__c == 'Commercial Combined' || ps.Product__c == 'Property')) && (ps.VG_Occupancy__c == null || ps.VG_Occupancy__c == '--Select--' || ps.VG_Occupancy__c == '--None--')){
                                                    p.addError('Policy Schedule Field: [Occupancy] is a required field in '+ps.Name + ' Policy Schedule');
                                                }else if(p.RecordTypeId == BDGId && val.VG_Type__c == 'Value Check' && (ps.get(val.VG_Field_API__c) == null || ps.get(val.VG_Field_API__c) == 0.00 || ps.get(val.VG_Field_API__c) == '--None--') && ((ps.Product__c != 'Commercial Combined' && ps.Product__c != 'Property' && ps.Product__c != 'D&O') && (val.VG_Value__c == '' || val.VG_Value__c == 'Not CC' ))){
                                                    message+= 'Policy Schedule Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                }                        
                                            }                            
                                        }
                                    }
                                }  
                                If((psListMap.size() == 0) && (p.Policy_Status__c == 'Quoted' || p.Policy_Status__c == 'Bound')){
                                    message+= 'Please add atleast one Policy Schedule for '+p.Name+'<br/>';  
                                }                
                            }else If(level == 'Governance & Compliance'){
                                for(VG_Validations__c val : valListMap.get(p.RecordTypeId).get(level)){ 
                                    If(!govListMap.IsEmpty()){ 
                                        for(VG_Governance_Compliance__c gov : govListMap.values()){
                                            if(val.VG_Policy_Status__c == p.Policy_Status__c){
                                                if(val.VG_Type__c == 'Null Check' && (gov.get(val.VG_Field_API__c) == null || gov.get(val.VG_Field_API__c) == 0.00 || gov.get(val.VG_Field_API__c) == '--None--')){
                                                    message+= 'Governance & Compliance Field: ['+val.VG_Field_Label__c+ '] is required in '+gov.Name+'<br/>'; 
                                                }else if(val.VG_Type__c == 'Value Check' && (gov.get(val.VG_Field_API__c) == null || gov.get(val.VG_Field_API__c) == 0.00 || gov.get(val.VG_Field_API__c) == '--None--') && gov.VG_Referral__c == 'Yes' && val.VG_Value__c == 'Ref_Yes'){
                                                    message+= 'Governance & Compliance Field: ['+val.VG_Field_Label__c+ ']  is required in '+gov.Name+'<br/>'; 
                                                }else if(val.VG_Type__c == 'Value Check' && (gov.get(val.VG_Field_API__c) == null || gov.get(val.VG_Field_API__c) == 0.00 || gov.get(val.VG_Field_API__c) == '--None--') && gov.VG_Peer_Review__c == 'Yes' && val.VG_Value__c == 'PR_Yes'){
                                                    message+= 'Governance & Compliance Field: ['+val.VG_Field_Label__c+ ']  is required in '+gov.Name+'<br/>'; 
                                                } 
                                            }                                                                  
                                        }                           
                                    }
                                }                            
                            }else If(level == 'Risk Rating' && !polPSMap.IsEmpty()  && p.RecordTypeId   != IMRId){
                                for(VG_Validations__c val : valListMap.get(p.RecordTypeId).get(level)){                        
                                    for(Policy_Schedule__c ps :  polPSMap.get(p.id)){
                                        If(psRRMap.get(ps.id) != null){
                                            for(VG_Policy_Schedule_Asset__c psa : psRRMap.get(ps.id)){                           
                                                if(ps.VG_MTA_Type__c == null && val.VG_Policy_Status__c == p.Policy_Status__c){
                                                    if(val.VG_Type__c == 'Null Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == 0.00 || psa.get(val.VG_Field_API__c) == '--None--')){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name + '<br/>'; 
                                                    }
                                                    //EDM RR
                                                    if(p.RecordTypeId == EDMId && p.Line_Of_Business__c != 'Motor' && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == '--None--') && val.VG_Value__c == 'Accept_Zero'){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name + '<br/>'; 
                                                    }
                                                    //EDM RR for Policy Motor
                                                    if(p.RecordTypeId == EDMId && p.Line_Of_Business__c == 'Motor' && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == '--None--') && val.VG_Value__c == 'For_Policy_Motor'){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name + '<br/>'; 
                                                    }
                                                    //AFS RR    
                                                    if(p.RecordTypeId == AFSId && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == 0.00 || psa.get(val.VG_Field_API__c) == '--None--') && ps.Product__c != 'Property' && val.VG_Value__c == ''){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name + '<br/>';
                                                    }else if(p.RecordTypeId == AFSId && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == 0.00 || psa.get(val.VG_Field_API__c) == '--None--') && ps.Product__c == 'Property' && val.VG_Value__c == 'Property'){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name + '<br/>'; 
                                                    }
                                                    //VFP RR
                                                    if(p.RecordTypeId == VFPId && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == 0.00 || psa.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c != 'FI - Cyber'  && ps.Product__c != 'PI') && val.VG_Value__c == 'Not (FI - Cyber AND PI)'){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name + '<br/>';
                                                    }else if(p.RecordTypeId == VFPId && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == 0.00 || psa.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c == 'PI') && val.VG_Value__c == 'PI'){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name + '<br/>';
                                                    }
                                                    
                                                    //BDG RR
                                                    if(p.RecordTypeId == BDGId && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c != 'Property') && val.VG_Value__c == 'Not Property'){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name + '<br/>';                                         
                                                    }  
                                                    
                                                    //HOZ RR
                                                    if(p.RecordTypeId == HOZId && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == 0.00 || psa.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c != 'AGG Stop Loss') && val.VG_Value__c == 'Not AGG Stop Loss'){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name + '<br/>'; 
                                                    }else if(p.RecordTypeId == HOZId && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == 0.00 || psa.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c == 'AGG Stop Loss') && val.VG_Value__c == 'AGG Stop Loss'){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name + '<br/>';
                                                    }
                                                    If(psRCMap.get(ps.id) != null){ 
                                                        for(Risk_Capture__c rc : psRCMap.get(ps.id)){ 
                                                            if(p.RecordTypeId == HOZId && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == 0.00 || psa.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c != 'AGG Stop Loss' && (rc.VG_Rate_Type__c != 'Flat Premium') && val.VG_Value__c == 'Not_Aggregate_Stop_Loss_Not Flat Premium')){
                                                                message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name+'<br/>'; 
                                                            }else if(p.RecordTypeId == HOZId && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == 0.00 || psa.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c == 'AGG Stop Loss') && val.VG_Value__c == 'Aggregate_Stop_Loss_All'){
                                                                message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+ '] is required in '+psa.Name+'<br/>'; 
                                                            } 
                                                        }
                                                    }
                                                    //GEN RR
                                                    if(p.RecordTypeId == GENId && val.VG_Type__c == 'Value Check' && (psa.get(val.VG_Field_API__c) == null || psa.get(val.VG_Field_API__c) == 0.00 || psa.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c == 'Fleet') && val.VG_Value__c == 'Fleet'){
                                                        message+= 'Risk Rating Field: ['+val.VG_Field_Label__c+'] is required in '+psa.Name + '<br/>'; 
                                                    }
                                                }                                   
                                            }                               
                                        }
                                    }
                                }                                           
                            }else If(level == 'Risk Capture' && !polPSMap.IsEmpty() && p.RecordTypeId   != IMRId){
                                for(VG_Validations__c val : valListMap.get(p.RecordTypeId).get(level)){                        
                                    for(Policy_Schedule__c ps : polPSMap.get(p.id)){ 
                                        If(psRCMap.get(ps.id) != null){ 
                                            for(Risk_Capture__c rc : psRCMap.get(ps.id)){                           
                                                if(ps.VG_MTA_Type__c == null && val.VG_Policy_Status__c == p.Policy_Status__c){
                                                    if(val.VG_Type__c == 'Null Check' && (rc.get(val.VG_Field_API__c) == null ||  rc.get(val.VG_Field_API__c) == '--None--' || rc.get(val.VG_Field_API__c) == 0.00)){
                                                        message+= 'Risk Capture Field: ['+val.VG_Field_Label__c+ '] is required in '+rc.Name+'<br/>'; 
                                                    }else if(val.VG_Type__c == 'Value Check' && (rc.get(val.VG_Field_API__c) == null || rc.get(val.VG_Field_API__c) == '--None--' || rc.get(val.VG_Field_API__c) == 0.00) && ps.Product__c == '' && val.VG_Value__c == ''){
                                                        message+= 'Risk Capture Field: ['+val.VG_Field_Label__c+ '] is required in '+rc.Name+'<br/>'; 
                                                    }
                                                    
                                                    //VFP RC
                                                    if(p.RecordTypeId == VFPId  && val.VG_Type__c == 'Value Check' && (rc.get(val.VG_Field_API__c) == null || rc.get(val.VG_Field_API__c) == '--None--' || rc.get(val.VG_Field_API__c) == 0.00) && (ps.Product__c != 'FI - Cyber'  && ps.Product__c != 'PI') && val.VG_Value__c == 'Not (FI - Cyber AND PI)'){
                                                        message+= 'Risk Capture Field: ['+val.VG_Field_Label__c+ '] is required in '+rc.Name+'<br/>'; 
                                                    }else if(p.RecordTypeId == VFPId && val.VG_Type__c == 'Value Check' && (rc.get(val.VG_Field_API__c) == null || rc.get(val.VG_Field_API__c) == '--None--' || rc.get(val.VG_Field_API__c) == 0.00) && (ps.Product__c == 'PI') && val.VG_Value__c == 'PI'){
                                                        message+= 'Risk Capture Field: ['+val.VG_Field_Label__c+ '] is required in '+rc.Name+'<br/>'; 
                                                    }else if(p.RecordTypeId == VFPId  && val.VG_Type__c == 'Value Check' && (rc.get(val.VG_Field_API__c) == null || rc.get(val.VG_Field_API__c) == '--None--' || rc.get(val.VG_Field_API__c) == 0.00) && (ps.Product__c != 'FI - Cyber'  && ps.Product__c != 'PI' && ps.Product__c != 'W&I') && val.VG_Value__c == 'Not (FI - Cyber AND PI AND W&I)'){
                                                        message+= 'Risk Capture Field: ['+val.VG_Field_Label__c+ '] is required in '+rc.Name+'<br/>'; 
                                                    }else if(p.RecordTypeId == VFPId && val.VG_Type__c == 'Value Check' && (rc.get(val.VG_Field_API__c) == null || rc.get(val.VG_Field_API__c) == 0.00 || rc.get(val.VG_Field_API__c) == '--None--') && (ps.Product__c != 'FI - Cyber'  && ps.Product__c != 'PI' && ps.Product__c != 'W&I' && ps.Product__c != 'D&O') && val.VG_Value__c == 'Not (FI - Cyber AND PI AND W&I AND DO)'){
                                                        message+= 'Risk Capture Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>'; 
                                                    }else if(p.RecordTypeId == VFPId  && val.VG_Type__c == 'Value Check' && (rc.get(val.VG_Field_API__c) == null || rc.get(val.VG_Field_API__c) == '--None--' || rc.get(val.VG_Field_API__c) == 0.00) && (ps.Product__c == 'D&O' || ps.Product__c == 'Commercial Crime') && rc.VG_Company_Type__c == 'Public' && val.VG_Value__c == 'Company_Public'){
                                                        message+= 'Risk Capture Field: ['+val.VG_Field_Label__c+ '] is required in '+rc.Name+'<br/>'; 
                                                    }else if(p.RecordTypeId == VFPId  && val.VG_Type__c == 'Value Check' && (rc.get(val.VG_Field_API__c) == null || rc.get(val.VG_Field_API__c) == '--None--' || rc.get(val.VG_Field_API__c) == 0.00) && (ps.Product__c == 'D&O' || ps.Product__c == 'Commercial Crime') && rc.VG_Company_Type__c == 'Private' && val.VG_Value__c == 'Company_Private'){
                                                        message+= 'Risk Capture Field: ['+val.VG_Field_Label__c+ '] is required in '+rc.Name+'<br/>'; 
                                                    }                                                                                                                                                   
                                                }                             
                                            }
                                        }
                                    }
                                }
                            }else If(level == 'Payment Frequency' && !polPSMap.IsEmpty()){
                                for(VG_Validations__c val : valListMap.get(p.RecordTypeId).get(level)){                        
                                    for(Policy_Schedule__c ps : polPSMap.get(p.id)){  
                                        If(psPFMap.get(ps.id) != null){
                                            for(VG_Payment_Frequency__c pf : psPFMap.get(ps.id)){                           
                                                if(ps.VG_MTA_Type__c == null && val.VG_Policy_Status__c == p.Policy_Status__c){                                         
                                                    If(val.VG_Type__c == 'Null Check' && (pf.get(val.VG_Field_API__c) == null || pf.get(val.VG_Field_API__c) == '0.00' || pf.get(val.VG_Field_API__c) == '--None--')){
                                                        message+= 'Payment Frequency Field: ['+val.VG_Field_Label__c+ '] is required in '+pf.Name+'<br/>';
                                                    }
                                                }                                  
                                            }
                                        }else{
                                            if(ps.VG_MTA_Type__c == null && val.VG_Policy_Status__c == p.Policy_Status__c)
                                                message+= 'Payment Frequency Field: ['+val.VG_Field_Label__c+ '] is required in '+ps.Name+'<br/>';
                                        }
                                    }
                                }                    
                            }              
                        }
                    }
                    if(message  != '')            
                        p.addError(message, false);              
                }     
            }  
        }     
    }
}