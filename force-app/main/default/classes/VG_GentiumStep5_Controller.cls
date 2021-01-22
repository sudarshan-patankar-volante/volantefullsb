Public Class VG_GentiumStep5_Controller{
    public Map<Id,  Policy_Schedule__c> psList {get; set;}
    public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    public List<VG_ReInsurance__c> RIList {get; set;}
    public Decimal TechUWPre{get;set;}
    public List<VG_Policy_Schedule_Asset__c> psaListDup {get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseListDup {get;set;}
    public List<VG_ReInsurance__c> RIListDup {get; set;}
    public List<Risk_Capture__c> rcListDup {get;set;}
    public Policy_Schedule__c pschedule {get; set;}
    public List<Risk_Capture__c> rcList{get;set;}
    public String PSId{get;set;}
    public String policyid{get;set;}
    public decimal riskPremium{get;set;}
    public decimal endPremium {get;set;}
    public decimal riskPremiumPro {get;set;}
    public decimal endPremiumPro {get;set;}
    public decimal actPremium{get;set;}
    public decimal grossWrittenPremium{get;set;}
    public decimal iptCal{get;set;}
    public decimal brokerageAmount{get;set;}
    public decimal vatAmount{get;set;}
    public decimal RateChange {get;set;}
    public decimal technicalPremium {get;set;}
    public decimal technicalPremiumPro {get;set;}
    public Boolean hasAssets {get; set;}
    public Boolean showErr {get; set;} //This line added by siddik on 26.2.2018   
    public Boolean hasRCs {get; set;}
    public Boolean hasEndorsements {get; set;}
    public Id OriginalId {get; set;}
    public String MTAType {get; set;}
    public Boolean IsCancellation {get; set;}
    public Boolean IsExtension {get; set;}
    public Boolean IsRevision {get; set;}
    public Boolean IsDeclaration {get; set;}
    Public Map<Id,  Policy_Schedule__c > oldPSIdDupPSRecMap {get; set;}
    public Map<Id,  List<VG_Policy_Schedule_Asset__c>> oldPSIdDupPSAMap {get; set;}
    public Map<Id,  List<VG_Policy_Schedule_Endorsement__c>> oldPSIdDupPSEMap {get; set;}
    public Map<Id,  List<VG_ReInsurance__c>> oldPSIdDupRIMap {get; set;}
    public Map<Id,  List<Risk_Capture__c>> oldPSIdDupRCMap {get; set;}
    public List<PSWrapper> PSWrapperList {get; set;}
    public List<Policy_Schedule__c> psListTemp {get; set;}
    public List<Policy_Schedule__c> mtaListTemp {get; set;}
    
    public VG_GentiumStep5_Controller(){   
        showErr = false;//This line added by siddik on 26.2.2018     
        PSId = apexpages.currentpage().getparameters().get('Id');
        policyid = apexpages.currentpage().getparameters().get('policyid');
        OriginalId = apexpages.currentpage().getparameters().get('OriginalId');
        MTAType = apexpages.currentpage().getparameters().get('MTAType');
        TechUWPre= 0;
        if(MTAType == 'Extension'){
            IsExtension = True;
            IsCancellation = IsRevision = IsDeclaration = False;
        }else if(MTAType == 'Cancellation'){
            IsCancellation = True;
            IsExtension = IsRevision = IsDeclaration = False;
        }else if(MTAType == 'Revision of Cover'){
            IsRevision = True;
            IsCancellation = IsExtension = IsDeclaration = False;
        }else if(MTAType == 'Declaration'){
            IsDeclaration = True;
            IsCancellation = IsRevision = IsExtension = False;
        }else{
            IsExtension = IsCancellation = IsRevision = IsDeclaration = False;
        }
        
        if(IsCancellation || IsExtension){
            oldPSIdDupPSAMap = new Map<Id,  List<VG_Policy_Schedule_Asset__c>>();
            oldPSIdDupPSEMap = new Map<Id,  List<VG_Policy_Schedule_Endorsement__c>>();
            oldPSIdDupRCMap = new Map<Id,  List<Risk_Capture__c>>();
            psList = new Map<Id,  Policy_Schedule__c>();
            mtaListTemp = new List<Policy_Schedule__c>();
            psListTemp = [select id, Name,  Policy__r.Name, Gross_Written_Premium__c,  VG_Risk_Premium__c ,  VG_Declaration_Type_percent__c,  VG_Fee_Income__c, VG_MTA_Start_Date__c,  VG_MTA_End_Date__c,  VG_Brokerage_Percent__c ,  Endorsement_GWP__c ,  VG_Is_MTA__c,  VG_MTA_Type__c,  VG_Brokerage_Amount__c ,  Actual_GWP__c,  Base_Creation_End_Date__c,  VG_Adjustment_Reason__c,  Transaction_GWP__c,  IPT_Percent__c,  Levies__c,  Policy__c,  Premium_Adjustment__c, VG_Technical_Model_Premium__c,  Product__c,  Policy__r.VG_Expiry_Date__c,  MTA_Reason_for_Cancellation__c,  VG_Base_Policy__c from Policy_Schedule__c Where Policy__c =: policyid];
            
            for(Policy_Schedule__c ps : psListTemp){
                ps.Levies__c = 0;
                ps.VG_Fee_Income__c = 0;
                ps.Premium_Adjustment__c = 0;
                System.debug('Policy Exp.Date:'+ps.Policy__r.VG_Expiry_Date__c+':'+ps.Policy__r.Name);
                psList.put(ps.Id,  ps);
                if(!ps.VG_Base_Policy__c){
                    mtaListTemp.add(ps);
                }  
            }
            //psList = new Map<Id,  Policy_Schedule__c>([select id, Name,  Policy__r.Name,  VG_Risk_Premium__c ,  VG_Fee_Income__c,  VG_Brokerage_Percent__c ,  Endorsement_GWP__c ,  VG_Brokerage_Amount__c ,  Actual_GWP__c,  VG_Adjustment_Reason__c,  Transaction_GWP__c,  IPT_Percent__c,  Levies__c,  Policy__c,  Premium_Adjustment__c, VG_Technical_Model_Premium__c,  Product__c,  Policy__r.VG_Expiry_Date__c,  MTA_Reason_for_Cancellation__c,  VG_Base_Policy__c from Policy_Schedule__c Where Policy__c =: policyid AND VG_Base_Policy__c = TRUE]);
            psaList=[select id, Name, VG_Policy_Schedule__c ,  VG_Deductible__c ,  VG_Number_of_Vehicles__c, VG_Vehicle_Type__c, VG_Coverage__c, VG_Rate_Per_Vehicle__c, VG_Premium__c, VG_Technical_UW_Rate_Annual__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psList.keySet()];
            pseList = new List<VG_Policy_Schedule_Endorsement__c>([select id, Name, VG_Title__c, VG_Premium__c, VG_Endorsement_Details__c,  VG_Policy_Schedule__c  from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c IN: psList.keySet()]);
            rcList = new List<Risk_Capture__c>([select Id, Name, VG_IsTempDelete__c, Drivers_Name__c, Drivers_DOB__c, Drivers_Convictions__c, Policy_Schedule__c , Drivers_Conviction_Points__c, Drivers_License_Ban_Details__c, Drivers_Claims__c, Drivers_Medical_Conditions__c from Risk_Capture__c where Policy_Schedule__c IN: psList.keySet()]);
            for(VG_Policy_Schedule_Asset__c psa : psaList){
                if(oldPSIdDupPSAMap.get(psa.VG_Policy_Schedule__c) == null){
                    psaListDup = new List<VG_Policy_Schedule_Asset__c>();
                }else{
                    psaListDup = oldPSIdDupPSAMap.get(psa.VG_Policy_Schedule__c);
                }
                
                psaListDup.add(psa);
                oldPSIdDupPSAMap.put(psa.VG_Policy_Schedule__c,  psaListDup);
            }
            for(VG_Policy_Schedule_Endorsement__c pse : pseList){
                if(oldPSIdDupPSEMap.get(pse.VG_Policy_Schedule__c) == null){
                    pseListDup = new List<VG_Policy_Schedule_Endorsement__c>();
                }else{
                    pseListDup = oldPSIdDupPSEMap.get(pse.VG_Policy_Schedule__c);
                }
                pseListDup.add(pse);
                oldPSIdDupPSEMap.put(pse.VG_Policy_Schedule__c,  pseListDup);
            }
            for(Risk_Capture__c rc : rcList){
                if(oldPSIdDupRCMap.get(rc.Policy_Schedule__c) == null){
                    rcListDup = new List<Risk_Capture__c >();
                }else{
                    rcListDup = oldPSIdDupRCMap.get(rc.Policy_Schedule__c);
                }
                rcListDup.add(rc);
                oldPSIdDupRCMap.put(rc.Policy_Schedule__c,  rcListDup);
            }
            
            PSWrapperList = new List<PSWrapper>();
            for(Policy_Schedule__c ps : psList.values()){
                PSWrapper PSW = new PSWrapper();
                PSW.ps = ps;
                if(oldPSIdDupPSAMap.get(ps.Id) != null && !oldPSIdDupPSAMap.get(ps.Id).IsEmpty()){
                    PSW.psaList = oldPSIdDupPSAMap.get(ps.Id);
                    PSW.hasAssets = True; 
                }else{
                    PSW.hasAssets = False; 
                    PSW.psaList = new List<VG_Policy_Schedule_Asset__c >();
                }   
                if(oldPSIdDupPSEMap.get(ps.Id) != null && !oldPSIdDupPSEMap.get(ps.Id).IsEmpty()){
                    System.debug('DupPSE::'+oldPSIdDupPSEMap.get(ps.Id));
                    PSW.pseList = oldPSIdDupPSEMap.get(ps.Id);
                    PSW.hasEndorsements = True; 
                }else{
                    PSW.hasEndorsements = False; 
                    PSW.pseList = new List<VG_Policy_Schedule_Endorsement__c>();
                } 
                if(oldPSIdDupRCMap.get(ps.Id) != null && !oldPSIdDupRCMap.get(ps.Id).IsEmpty()){
                    System.debug('DupRc::'+oldPSIdDupRCMap.get(ps.Id));
                    PSW.rcList = oldPSIdDupRCMap.get(ps.Id);
                    PSW.hasRCs = True; 
                }else{
                    PSW.hasRCs = False; 
                    PSW.rcList = new List<Risk_Capture__c>();
                }   
                PSWrapperList.add(PSW);
                System.debug('==='+PSW.hasAssets+' '+PSW.hasEndorsements+' '+PSW.hasRCs);
            }
            System.debug(PSWrapperList.Size()); 
            //Added By siddik on 21.2.2018
            for(PSWrapper psw:PSWrapperList){
                for(VG_Policy_Schedule_Asset__c psa:psw.psaList){
                    if(psa.VG_Technical_UW_Rate_Annual__c != null && psa.VG_Number_of_Vehicles__c!=null){
                        psw.techUWPre = psw.techUWPre+(psa.VG_Technical_UW_Rate_Annual__c*psa.VG_Number_of_Vehicles__c);
                    }
                }
                psw.ps.Technical_UW_Premium__c = psw.techUWPre;
            }
            //End Code Adding By siddik on 21.2.2018
            Policy__c p = [Select Id, Name,  VG_Expiry_Date__c from Policy__c where Id=: policyid];
            pSchedule = new Policy_Schedule__c();
            pSchedule.VG_VAT__c = 0;
            pSchedule.VG_VAT_Amount__c = 0;
            pSchedule.VG_MTA_Start_Date__c = p.VG_Expiry_Date__c.addDays(1);
            pSchedule.VG_Pre_MTA_Expiry_Date__c = p.VG_Expiry_Date__c;
            System.debug('Expairy, Ps MTA Start, Ps MTA End Dates'+p.VG_Expiry_Date__c+pSchedule.VG_MTA_Start_Date__c+pSchedule.VG_Pre_MTA_Expiry_Date__c );
        }else{
            System.debug('inside else ::');
            pSchedule = [Select Id,  VG_Brokerage_Percent__c, Gross_Written_Premium__c,  Policy__r.Name, VG_VAT__c, VG_VAT_Amount__c,  VG_Pre_MTA_Expiry_Date__c,  VG_Declaration_Type_percent__c,  Base_Creation_End_Date__c,  Base_Creation_Start_Date__c,  VG_MTA_Start_Date__c,  VG_MTA_End_Date__c,  MTA_Reason_for_Cancellation__c,  VG_MTA_Cancellation_Date__c,  VG_Fee_Income__c,  Premium_Adjustment__c, VG_Technical_Model_Premium__c,  Levies__c ,  IPT_Percent__c ,  VG_Adjustment_Reason__c from Policy_Schedule__c where Id =:PSId];
            if(pSchedule.VG_Fee_Income__c>0){
                VAT_Setting__mdt [] vs   =   [SELECT VG_VAT__c FROM VAT_Setting__mdt];
                If(vs!=null)
                	pSchedule.VG_VAT__c = (vs[0].VG_VAT__c!=null?vs[0].VG_VAT__c:0);               
            }else{
                pSchedule.VG_VAT__c = 0;
                pSchedule.VG_VAT_Amount__c = 0;
            }
            psaList = new List<VG_Policy_Schedule_Asset__c>([select id, Name, VG_Number_of_Vehicles__c, VG_Vehicle_Type__c, VG_Deductible__c, VG_Coverage__c, VG_Rate_Per_Vehicle__c, VG_Premium__c, VG_Technical_UW_Rate_Annual__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c=:PSId]);
            pseList = new List<VG_Policy_Schedule_Endorsement__c>([select id, Name, VG_Title__c, VG_Premium__c, VG_Endorsement_Details__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c=:PSId]);
            rcList = new List<Risk_Capture__c>([select Id, Name, Drivers_Name__c, Drivers_DOB__c, Drivers_Convictions__c, Drivers_Conviction_Points__c, Drivers_License_Ban_Details__c, Drivers_Claims__c, Drivers_Medical_Conditions__c from Risk_Capture__c where Policy_Schedule__c=:PSId]);
        //Added By siddik on 20.2.2018
            TechUWPre=0;
            for(VG_Policy_Schedule_Asset__c psa:psaList){
                if(psa.VG_Technical_UW_Rate_Annual__c != null && psa.VG_Number_of_Vehicles__c!=null){
                    System.debug('Technical Annual::'+psa.VG_Technical_UW_Rate_Annual__c+'vehi::'+PSA.VG_Number_of_Vehicles__c);
                    techUWPre = techUWPre+(psa.VG_Technical_UW_Rate_Annual__c*psa.VG_Number_of_Vehicles__c);
                }
            }
        //End Code Adding By siddik on 20.2.2018
            //techUWPre = techUWPre*Decimal.valueOf(pSchedule.Base_Creation_Start_Date__c.daysBetween(pSchedule.Base_Creation_End_Date__c)+1)/365;
            pSchedule.Technical_UW_Premium__c = techUWPre;
            hasAssets = (!psaList.IsEmpty());
            hasRCs = (!rcList.IsEmpty());
            hasEndorsements = (!pseList.IsEmpty());
            riskPremium = 0;
            pSchedule.VG_Fee_Income__c = 0;
            if(pSchedule.IPT_Percent__c == null)
                pSchedule.IPT_Percent__c = 0;
            pSchedule.Premium_Adjustment__c = 0;
            pSchedule.Levies__c = 0;
            if(pSchedule.VG_Brokerage_Percent__c == null)
                pSchedule.VG_Brokerage_Percent__c = 0;
            brokerageAmount = 0;
            for(VG_Policy_Schedule_Asset__c psa:psaList){
                riskPremium = riskPremium+psa.VG_Premium__c;
            }
            endPremium = 0;
            for(VG_Policy_Schedule_Endorsement__c pse:pseList){
                endPremium = endPremium +pse.VG_Premium__c;
            }  
            technicalPremium = riskPremium+endPremium;
            updateCalc();
        }
    }
    
    public PageReference updateCalc(){
        if(pSchedule.VG_Fee_Income__c>0){
            VAT_Setting__mdt [] vs = [SELECT VG_VAT__c FROM VAT_Setting__mdt];
            pSchedule.VG_VAT__c = vs[0].VG_VAT__c;
            pSchedule.VG_VAT_Amount__c = (pSchedule.VG_VAT__c/100)*pSchedule.VG_Fee_Income__c;    
         }else{
             pSchedule.VG_VAT__c = 0;
             pSchedule.VG_VAT_Amount__c = 0;
         }
        Decimal proratingfator = 1;
        if(MTAType == null){
            proratingfator = Decimal.valueOf(pSchedule.Base_Creation_Start_Date__c.daysBetween(pSchedule.Base_Creation_End_Date__c)+1)/365;
        }else{
            if(MTAType == 'Revision of Cover'){
                proratingfator = Decimal.valueOf(pSchedule.Base_Creation_Start_Date__c.daysBetween(pSchedule.Base_Creation_End_Date__c)+1)/365;
            }else if(MTAType == 'Declaration'){
                proratingfator = (pSchedule.VG_Declaration_Type_percent__c/100)*(Decimal.valueOf(pSchedule.Base_Creation_Start_Date__c.daysBetween(pSchedule.Base_Creation_End_Date__c)+1)/365);
            }
        }
        techUWPre = pSchedule.Technical_UW_Premium__c * proratingfator ;
        riskPremiumPro = riskPremium * proratingfator;
        endPremiumPro = endPremium * proratingfator;
        technicalPremium = (riskPremium + endPremium )*proratingfator;
        if(pSchedule.Premium_Adjustment__c != null)
            grossWrittenPremium = technicalPremium+ pSchedule.Premium_Adjustment__c;
        else
            grossWrittenPremium = technicalPremiumPro + 0;
        if(pSchedule.VG_Brokerage_Percent__c != null){
            brokerageAmount = grossWrittenPremium * (pSchedule.VG_Brokerage_Percent__c/100);
        }else{
            brokerageAmount = 0;
        }
        actPremium = grossWrittenPremium - brokerageAmount;
        /*if(pSchedule.IPT_Percent__c != null){
            IPTCal = grossWrittenPremium * (pSchedule.IPT_Percent__c/100);
        }else{
            IPTCal = 0;
        }*/
        
        if(pSchedule.VG_VAT__c != null && pSchedule.VG_Fee_Income__c != null){
            vatAmount = pSchedule.VG_Fee_Income__c * (pSchedule.VG_VAT__c/100);
        }else{
            vatAmount = 0;
        }
        return null;
    }
    
    
    public PageReference updateCancelExtendCalc(){
        Decimal IPTCal;
        Decimal proratingfator = 1;
        if(MTAType == 'Extension'){
            if(pSchedule.VG_MTA_End_Date__c == null){
                proratingfator = -99;
            }else{
                proratingfator = Decimal.valueOf(pSchedule.VG_MTA_Start_Date__c.daysBetween(pSchedule.VG_MTA_End_Date__c)+1)/365;
            }
        }
        if(MTAType == 'Cancellation'){
            if(pSchedule.VG_MTA_Cancellation_Date__c == null){
                proratingfator = -99;
            }else{
                proratingfator = 1;//-1*(Decimal.valueOf(pSchedule.VG_MTA_Cancellation_Date__c.daysBetween(pSchedule.VG_Pre_MTA_Expiry_Date__c)+1)/365);
            }
        }
        
        for(PSWrapper PSW:PSWrapperList){   
            System.Debug('proratingfator::'+proratingfator );
            if(proratingfator != -99){
                if(MTAType == 'Cancellation'){
                    System.debug('MTA Type is '+PSW.ps.VG_MTA_Type__c);
                    if(PSW.ps.VG_Is_MTA__c && PSW.ps.VG_MTA_Type__c != 'Revision of Cover'){
                        System.debug('IF Cancellation:PS Details::'+PSW.ps.Name+':'+pSchedule.VG_MTA_Cancellation_Date__c+':'+PSW.ps.VG_MTA_End_Date__c+':'+PSW.ps.VG_MTA_Start_Date__c);
                        if(pSchedule.VG_MTA_Cancellation_Date__c > PSW.ps.VG_MTA_End_Date__c){
                            proratingfator = 0;
                        }else if(pSchedule.VG_MTA_Cancellation_Date__c < PSW.ps.VG_MTA_Start_Date__c){
                            Decimal numDays = Decimal.valueOf(PSW.ps.VG_MTA_Start_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                            System.debug('numDays1::'+numDays+'::'+PSW.ps.VG_MTA_Start_Date__c+PSW.ps.VG_MTA_End_Date__c);
                            if(numDays <= 0)
                                proratingfator = 0;
                            else
                                proratingfator = -1*((numDays+1)/365);
                        }else{
                            System.debug('numDays2::'+pSchedule.VG_MTA_Cancellation_Date__c+PSW.ps.VG_MTA_End_Date__c);                            
                            Decimal numDays = Decimal.valueOf(pSchedule.VG_MTA_Cancellation_Date__c.daysBetween(PSW.ps.VG_MTA_End_Date__c));
                            System.debug('numDays2::'+numDays+pSchedule.VG_MTA_Cancellation_Date__c+PSW.ps.VG_MTA_End_Date__c);
                            if(numDays <= 0)
                                proratingfator = 0;
                            else
                                proratingfator = -1*((numDays)/365);
                        }
                    }else{
                        System.debug('numDays::'+PSW.ps.Base_Creation_End_Date__c+'::'+pSchedule.VG_MTA_Cancellation_Date__c);
                        Decimal numDays = Decimal.valueOf(pSchedule.VG_MTA_Cancellation_Date__c.daysBetween(PSW.ps.Base_Creation_End_Date__c));
                        if(numDays <= 0)
                            proratingfator = 0;
                        else
                            proratingfator = -1*((numDays)/365);
                    }
                    if(PSW.ps.VG_MTA_Type__c == 'Declaration'){
                        proratingfator = proratingfator * (PSW.ps.VG_Declaration_Type_percent__c/100);
                    }
                }
                PSW.techUWPre = psw.ps.Technical_UW_Premium__c*proratingfator;
                System.debug('IF:PS Details::'+PSW.ps.Name+PSW.Ps.VG_Risk_Premium__c+PSW.Ps.Endorsement_GWP__c+proratingfator);
                PSW.technicalPremium = (PSW.Ps.VG_Risk_Premium__c + PSW.Ps.Endorsement_GWP__c)*proratingfator;
                PSW.riPro = PSW.Ps.VG_Risk_Premium__c * proratingfator;
                PSW.endPro =  PSW.Ps.Endorsement_GWP__c * proratingfator;
                if(PSW.Ps.Premium_Adjustment__c == null){
                    PSW.actualPremium = PSW.technicalPremium + 0;
                }else{
                    PSW.actualPremium = PSW.technicalPremium + PSW.Ps.Premium_Adjustment__c;
                }
                /*if(PSW.Ps.IPT_Percent__c != null){
                    IPTCal = PSW.actualPremium * (PSW.Ps.IPT_Percent__c/100);
                }else{
                    IPTCal = 0;
                }*/
                if(PSW.Ps.VG_Brokerage_Percent__c != null){
                    PSW.brokerageAmount = PSW.actualPremium * (PSW.Ps.VG_Brokerage_Percent__c/100);
                }else{
                    PSW.brokerageAmount = 0;
                }
                System.debug('PS Lev and Fee Detail::'+PSW.Ps.Levies__c+', '+PSW.Ps.VG_Fee_Income__c);
                if(PSW.Ps.Levies__c != null && PSW.Ps.VG_Fee_Income__c != null){
                    PSW.transactionalPremium = PSW.actualPremium + PSW.Ps.Levies__c+PSW.Ps.VG_Fee_Income__c-PSW.brokerageAmount ;
                }else if(PSW.Ps.Levies__c != null) {
                    PSW.transactionalPremium = PSW.actualPremium + PSW.Ps.Levies__c+0-PSW.brokerageAmount ;
                }else if(PSW.Ps.VG_Fee_Income__c != null) {
                    PSW.transactionalPremium = PSW.actualPremium + 0+PSW.Ps.VG_Fee_Income__c-PSW.brokerageAmount ;
                }else{
                    PSW.transactionalPremium = PSW.actualPremium + 0+0-PSW.brokerageAmount ;
                }
                System.Debug(PSW.transactionalPremium);
            }else{
                System.debug('Else:PS Details::'+PSW.ps.Name);
                PSW.technicalPremium  = 0;
                PSW.actualPremium = 0;
                PSW.brokerageAmount = 0;
                PSW.transactionalPremium = 0;
                PSW.techUWPre = 0;
            }
        }
        return null;
    }
    
    
    public PageReference Cancel(){
        List<Policy_Schedule__c> ps = [select id, Name from Policy_Schedule__c where id=:PSId];
        List<VG_Policy_Schedule_Asset__c> psaList = [select id, Name, VG_Number_of_Vehicles__c, VG_Vehicle_Type__c, VG_Coverage__c, VG_Rate_Per_Vehicle__c, VG_Premium__c, VG_Technical_UW_Rate_Annual__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c=:PSId];
        List<VG_Policy_Schedule_Endorsement__c> pseList = new List<VG_Policy_Schedule_Endorsement__c>([select id, Name, VG_Title__c, VG_Premium__c, VG_Endorsement_Details__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c=:PSId]);
        List<Risk_Capture__c> rcList = new List<Risk_Capture__c>([select Id, Name, Drivers_Name__c, Drivers_DOB__c, Drivers_Convictions__c, Drivers_Conviction_Points__c, Drivers_License_Ban_Details__c, Drivers_Claims__c, Drivers_Medical_Conditions__c from Risk_Capture__c where Policy_Schedule__c=:PSId]);
        if(!psaList.IsEmpty()){
            Delete psaList;
        }
        if(!pseList.IsEmpty()){
            Delete pseList;
        }
        if(!rcList.IsEmpty()){
            Delete rcList;
        }
        if(ps!=null){
            Delete ps;
        }
        return new PageReference('/'+policyid);
    }
    
    public PageReference Previous(){
        PageReference reference=new PageReference('/apex/VG_Gentium_Step4b');
        reference.getParameters().put('Id', PSId);
        reference.getParameters().put('policyid', policyid);
        if(MTAType !=null){
            reference.getParameters().put('MTAType', MTAType);
            reference.getParameters().put('OriginalId', OriginalId);
        }
        reference.setRedirect(true);
        return reference;
    }
    
    public PageReference Finish(){
        //Code added by siddik on 26.2.2018
        if(IsCancellation){
           if(pSchedule.VG_Pre_MTA_Expiry_Date__c<pSchedule.VG_MTA_Cancellation_Date__c){
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Cancellation Date Can\'t be greater than Current Expiry date..'));    
                showErr = true;
                return null;  
           }else if(pSchedule.VG_MTA_Cancellation_Date__c == null){
               showErr = True;
               ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Please fill Cancellation Date..'));    
               return null;
               
           }else{
               showErr = false;
           }
        }
        //Code added finished  on 26.2.2018
        if(!IsCancellation && !IsExtension){
            PolicyScheduleTriggerFunction.allowInsertRI=true;
            pSchedule.Technical_UW_Premium__c = techUWPre;
            pSchedule.Risk_Premium_Pro__c = riskPremiumPro;
            pSchedule.Endorsement_Premium_Pro__c = endPremiumPro;
            pSchedule.Gross_Written_Premium__c = grossWrittenPremium; 
            pSchedule.VG_Gross_Written_Premium_100__c = grossWrittenPremium;          
            //below 3 lines added by Anu 30.8.2018
            pSchedule.Actual_GWP__c = actPremium;
            pSchedule.VG_Brokerage_Amount__c = brokerageAmount;
            pSchedule.IPT__c = IPTCal;
            pSchedule.VG_Rate_Change__c = RateChange;
            pSchedule.VG_VAT_Amount__c = vatAmount;
            Update pSchedule;
            return new PageReference('/'+PSId);
        }else{
            psaList = new List<VG_Policy_Schedule_Asset__c >();
            pseList = new List<VG_Policy_Schedule_Endorsement__c >();
            rcList = new List<Risk_Capture__c >();
            for(PSWrapper PSW:PSWrapperList){
                psw.ps.Technical_UW_Premium__c = PSW.techUWPre;
                psw.ps.Risk_Premium_Pro__c = PSW.RIPro;
                psw.ps.Endorsement_Premium_Pro__c = PSW.endPro;
                psaList.addAll(PSW.psaList );
                pseList.addAll(PSW.pseList );
                rcList.addAll(PSW.rcList );
            }
            /*psList = new Map<Id,  Policy_Schedule__c>([select id, Name,  IPT_Percent__c,  Levies__c,  Policy__c,  Premium_Adjustment__c,  Product__c,  Policy__r.VG_Expiry_Date__c,  MTA_Reason_for_Cancellation__c from Policy_Schedule__c Where Policy__c =: policyid AND VG_Base_Policy__c = True]);
              psaList=[select id, Name, VG_Number_of_Vehicles__c, VG_Vehicle_Type__c, VG_Policy_Schedule__c ,  VG_Coverage__c, VG_Rate_Per_Vehicle__c, VG_Premium__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psList.keySet()];
              pseList = new List<VG_Policy_Schedule_Endorsement__c>([select id, Name, VG_Title__c, VG_Policy_Schedule__c ,  VG_Premium__c, VG_Endorsement_Details__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c IN: psList.keySet()]);
              rcList = new List<Risk_Capture__c>([select Id, Name, Drivers_Name__c, Drivers_DOB__c, Policy_Schedule__c , Drivers_Convictions__c, Drivers_Conviction_Points__c, Drivers_License_Ban_Details__c, Drivers_Claims__c, Drivers_Medical_Conditions__c from Risk_Capture__c where Policy_Schedule__c IN: psList.keySet()]);*/
            RIList = new List<VG_ReInsurance__c>([Select Id,  VG_Policy_Schedule__c,  VG_RI_Currency__c,  VG_UMR__c from VG_ReInsurance__c where VG_Policy_Schedule__c IN: psList.keySet()]);
            System.debug('RiList:'+RIList.size());
            oldPSIdDupPSRecMap = new Map<Id,  Policy_Schedule__c>();
            oldPSIdDupPSAMap = new Map<Id,  List<VG_Policy_Schedule_Asset__c>>();
            oldPSIdDupPSEMap = new Map<Id,  List<VG_Policy_Schedule_Endorsement__c>>();
            oldPSIdDupRIMap = new Map<Id,  List<VG_ReInsurance__c>>();
            oldPSIdDupRCMap = new Map<Id,  List<Risk_Capture__c>>();
            Integer countPS = mtaListTemp.size();
            
            for(Policy_Schedule__c ps : psList.values()){
                countPS++;
                Policy_Schedule__c temp = ps.clone(false,  true,  false,  false);
                temp.Id = null;
                temp.Name = ps.Policy__r.Name + '/MTA/'+countPS;
                temp.VG_Is_MTA__c = True;
                temp.VG_MTA_Type__c = MTAType ;
                if(MTAType == 'Extension'){
                    System.debug('Finish() Extension if::'+psList.get(ps.id).Policy__r.VG_Expiry_Date__c +':'+temp.Policy__r.Name+ps.Policy__r.Name+psList.get(ps.id).Policy__r.Name);
                    if(temp.Policy__r.VG_Expiry_Date__c != null)
                        temp.VG_MTA_Start_Date__c = temp.Policy__r.VG_Expiry_Date__c.addDays(1);
                    temp.VG_MTA_End_Date__c = pSchedule.VG_MTA_End_Date__c;
                    temp.VG_Base_Policy__c = False;
                }
                if(MTAType == 'Cancellation'){
                    temp.VG_Pre_MTA_Expiry_Date__c = temp.Policy__r.VG_Expiry_Date__c;
                    temp.VG_MTA_Cancellation_Date__c = pSchedule.VG_MTA_Cancellation_Date__c;
                    temp.MTA_Reason_for_Cancellation__c = pSchedule.MTA_Reason_for_Cancellation__c;
                    temp.VG_Base_Policy__c = False;
                }
                oldPSIdDupPSRecMap.put(ps.Id,  temp);
            }
            Policy__c p = new Policy__c();
            p.Id = policyid;
            if(MTAType == 'Extension'){
                p.VG_Expiry_Date__c = pSchedule.VG_MTA_End_Date__c;
            }
            if(MTAType == 'Cancellation'){
                p.VG_Expiry_Date__c = pSchedule.VG_MTA_Cancellation_Date__c;
            }
            Insert oldPSIdDupPSRecMap.values();
            System.debug('Expiry date::'+p.VG_Expiry_Date__c +'::'+pSchedule.VG_MTA_Cancellation_Date__c);
            Update p;
            psaListDup = new List<VG_Policy_Schedule_Asset__c >();
            pseListDup = new List<VG_Policy_Schedule_Endorsement__c >();
            rcListDup = new List<Risk_Capture__c >();
            RIListDup = new List<VG_ReInsurance__c>();
            for(VG_Policy_Schedule_Asset__c psa : psaList){
                VG_Policy_Schedule_Asset__c temp = psa.clone(false,  true,  false,  false);
                temp.Id = null;
                temp.VG_Policy_Schedule__c = oldPSIdDupPSRecMap.get(psa.VG_Policy_Schedule__c).Id;
                psaListDup.add(temp);
            }
            for(VG_Policy_Schedule_Endorsement__c pse : pseList){
                VG_Policy_Schedule_Endorsement__c temp = pse.clone(false,  true,  false,  false);
                temp.Id = null;
                temp.VG_Policy_Schedule__c = oldPSIdDupPSRecMap.get(pse.VG_Policy_Schedule__c).Id;
                pseListDup.add(temp);
            }
            for(Risk_Capture__c rc : rcList){
                Risk_Capture__c temp = rc.clone(false,  true,  false,  false);
                temp.Id = null;
                temp.Policy_Schedule__c = oldPSIdDupPSRecMap.get(rc.Policy_Schedule__c).Id;
                rcListDup.add(temp);
                
            }
            for(VG_ReInsurance__c ri : RIList){
                VG_ReInsurance__c temp = ri.clone(false,  true,  false,  false);
                temp.Id = null;
                temp.VG_Policy_Schedule__c = oldPSIdDupPSRecMap.get(ri.VG_Policy_Schedule__c).Id;
                RIListDup.add(temp);
            }          
            Insert psaListDup;
            Insert pseListDup;
            Insert rcListDup;
            Insert RIListDup;
            return new PageReference('/'+policyid);
        }
    }
    
    Public Class PSWrapper{
        public Policy_Schedule__c ps {get; set;}
        public List<VG_Policy_Schedule_Asset__c> psaList{get; set;}
        public List<VG_Policy_Schedule_Endorsement__c> pseList{get; set;}
        public List<Risk_Capture__c> RCList {get; set;}
        public Boolean hasAssets {get; set;}    
        public Boolean hasRCs {get; set;}
        public Boolean hasEndorsements {get; set;}
        public Decimal technicalPremium {get; set;}
        public Decimal actualPremium {get; set;}
        public Decimal transactionalPremium {get; set;}
        public Decimal brokerageAmount {get; set;}
        public Decimal RIPro {get; set;}
        public Decimal endPro {get; set;}
        public Decimal techUWPre{get;set;}
        Public PSWrapper(){
            ps = new Policy_Schedule__c();
            psaList = new List<VG_Policy_Schedule_Asset__c>();
            pseList = new List<VG_Policy_Schedule_Endorsement__c>();
            RCList = new List<Risk_Capture__c>();
            hasAssets = False;
            hasRCs = False;
            hasEndorsements = False;
            endPro = 0;
            RIPro = 0;
            technicalPremium = 0;
            actualPremium = 0;
            transactionalPremium = 0;
            brokerageAmount = 0;
            techUWPre = 0;
        }
        
    } 
    
}