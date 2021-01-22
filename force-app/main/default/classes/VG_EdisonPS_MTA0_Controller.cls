public class VG_EdisonPS_MTA0_Controller {
    public List<SelectOption> MTAtypes {get; set;}
    public String seletedType {get; set;}
    public Id PSID {get; set;}
    public Id PID {get; set;}
    public List<Policy_Schedule__c> psListDup {get; set;}
    public List<VG_Policy_Schedule_Asset__c> psaListDup {get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseListDup {get;set;}
    public List<Risk_Capture__c> rcListDup {get;set;}
    public List<VG_ReInsurance__c> RIListDup {get; set;}
    public Map<Id, Policy_Schedule__c> psList {get; set;}
    public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    public List<VG_Policy_Schedule_Endorsement__c> pseList{get;set;}
    public List<VG_ReInsurance__c> RIList {get; set;}
    public List<Risk_Capture__c> rcList{get;set;}
    public Map<Id, Policy_Schedule__c> oldPSIdDupPSRecMap {get; set;}
    public Map<Id, List<VG_Policy_Schedule_Asset__c>> oldPSIdDupPSAMap {get; set;}
    public Map<Id, List<VG_Policy_Schedule_Endorsement__c>> oldPSIdDupPSEMap {get; set;}
    public Map<Id, List<VG_ReInsurance__c>> oldPSIdDupRIMap {get; set;}
    public Map<Id, List<Risk_Capture__c>> oldPSIdDupRCMap {get; set;}
    
    public VG_EdisonPS_MTA0_Controller (){
        PSId = apexpages.currentpage().getparameters().get('PSId');
        PID = apexpages.currentpage().getparameters().get('PId');
        
        MTATypes = new List<SelectOption>();
        MTATypes.add(new SelectOption('--Select--','--Select--'));
        if(PId != null){
            MTATypes.add(new SelectOption('Extension','Extension'));
            MTATypes.add(new SelectOption('Cancellation','Cancellation'));
        }
        if(PSId != null){
            MTATypes.add(new SelectOption('Revision of Cover','Revision of Cover'));
            MTATypes.add(new SelectOption('Declaration','Declaration'));
        }
    }
    
    public PageReference Next(){
        PageReference reference;
        if(seletedType == '--Select--'){
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select MTA type.')); 
            return null;
        }
        if(PSId != null){
            reference=new PageReference('/apex/VG_EdisonPS_Ins1');
            reference.getParameters().put('OriginalId',PSId);
            reference.getParameters().put('MTAType',seletedType );
            reference.setRedirect(true);
        }
        if(PId != null){
            /*psList = new Map<Id, Policy_Schedule__c>([select id,Name, IPT_Percent__c, Levies__c, Policy__c, Premium_Adjustment__c, Product__c, Policy__r.VG_Expiry_Date__c, MTA_Reason_for_Cancellation__c from Policy_Schedule__c Where Policy__c =: PID ]);
            psaList=[select id,Name,VG_Number_of_Vehicles__c,VG_Vehicle_Type__c,VG_Coverage__c,VG_Rate_Per_Vehicle__c,VG_Premium__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c IN: psList.keySet()];
            pseList = new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Title__c,VG_Premium__c,VG_Endorsement_Details__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c IN: psList.keySet()]);
            rcList = new List<Risk_Capture__c>([select Id,Name,Drivers_Name__c,Drivers_DOB__c,Drivers_Convictions__c,Drivers_Conviction_Points__c,Drivers_License_Ban_Details__c,Drivers_Claims__c,Drivers_Medical_Conditions__c from Risk_Capture__c where Policy_Schedule__c IN: psList.keySet()]);
            RIList = new List<VG_ReInsurance__c>([Select Id, VG_Policy_Schedule__c, VG_RI_Currency__c, VG_UMR__c from VG_ReInsurance__c where VG_Policy_Schedule__c IN: psList.keySet()]);
            oldPSIdDupPSRecMap = new Map<Id, Policy_Schedule__c>();
            oldPSIdDupPSAMap = new Map<Id, List<VG_Policy_Schedule_Asset__c>>();
            oldPSIdDupPSEMap = new Map<Id, List<VG_Policy_Schedule_Endorsement__c>>();
            oldPSIdDupRIMap = new Map<Id, List<VG_ReInsurance__c>>();
            oldPSIdDupRCMap = new Map<Id, List<Risk_Capture__c>>();
            for(Policy_Schedule__c ps : psList.values()){
                Policy_Schedule__c temp = ps.clone(false, true, false, false);
                temp.Id = null;
                temp.VG_Is_MTA__c = True;
                temp.VG_MTA_Type__c = seletedType;
                if(seletedType == 'Extension'){
                    temp.VG_MTA_Start_Date__c = temp.Policy__r.VG_Expiry_Date__c.addDays(1);
                }
                if(seletedType == 'Cancellation'){
                    temp.VG_Pre_MTA_Expiry_Date__c = temp.Policy__r.VG_Expiry_Date__c;
                }
                oldPSIdDupPSRecMap.put(ps.Id, temp);
            }
            Insert oldPSIdDupPSRecMap.values();
            for(VG_Policy_Schedule_Asset__c psa : psaList){
                VG_Policy_Schedule_Asset__c temp = psa.clone(false, true, false, false);
                temp.Id = null;
                temp.VG_Policy_Schedule__c = oldPSIdDupPSRecMap.get(psa.VG_Policy_Schedule__c).Id;
                psaListDup.add(temp);
            }
            for(VG_Policy_Schedule_Endorsement__c pse : pseList){
                VG_Policy_Schedule_Endorsement__c temp = pse.clone(false, true, false, false);
                temp.Id = null;
                temp.VG_Policy_Schedule__c = oldPSIdDupPSRecMap.get(pse.VG_Policy_Schedule__c).Id;
                pseListDup.add(temp);
            }
            for(Risk_Capture__c rc : rcList){
                Risk_Capture__c temp = rc.clone(false, true, false, false);
                temp.Id = null;
                temp.Policy_Schedule__c = oldPSIdDupPSRecMap.get(rc.Policy_Schedule__c).Id;
                rcListDup.add(temp);
            }
            for(VG_ReInsurance__c ri : RIList){
                VG_ReInsurance__c temp = ri.clone(false, true, false, false);
                temp.Id = null;
                temp.VG_Policy_Schedule__c = oldPSIdDupPSRecMap.get(ri.VG_Policy_Schedule__c).Id;
                RIListDup.add(temp);
            }*/
            if(seletedType != 'Change Broker'){
                reference = new PageReference('/apex/VG_EdisonPS_Ins4');
                reference.getParameters().put('OriginalId', PSId);
                reference.getParameters().put('MTAType', seletedType );
                reference.getParameters().put('policyid', PId);
                reference.setRedirect(true);
            }else{
                 return new PageReference('/apex/ChangeBroker?Id='+PID);
            }
        }
        return reference;
    }
    
    public PageReference Cancel(){
        //Code added by siddik on 26.2.2018 [if and else added,before there have no if and else]
        if(PID !=null){
            PageReference reference=new PageReference('/'+PID);
            reference.setRedirect(true);
            return reference;
        }else{
            PageReference reference=new PageReference('/'+PSID);
            reference.setRedirect(true);
            return reference;
        }
        //Code added finished on 26.2.2018
    }
}