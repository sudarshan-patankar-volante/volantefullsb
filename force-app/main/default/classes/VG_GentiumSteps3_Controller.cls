Public Class VG_GentiumSteps3_Controller{
    Public List<Risk_Capture__c> rcList{get;set;}
    public String Index{get;set;}
    Public Policy_Schedule__c ps{get;set;}
    Public List<WrapperRisk> wrcList{get;set;}
    Public Risk_Capture__c rc{get;set;}
    Public String policyid{get;set;}
    public Integer counter{get;set;}
    Public String psid{get;set;}
    public Id OriginalId {get; set;}
    public String MTAType {get; set;}
    public Boolean IsCancellation {get; set;}
    public Boolean IsExtension {get; set;}
    public Boolean IsRevision {get; set;}
    public Boolean IsDeclaration {get; set;}
    
    Public VG_GentiumSteps3_Controller(){
        counter=0;
        policyid=apexpages.currentpage().getparameters().get('policyid');
        psid=apexpages.currentpage().getparameters().get('id');
        OriginalId = apexpages.currentpage().getparameters().get('OriginalId');
        MTAType = apexpages.currentpage().getparameters().get('MTAType');
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
        }
        ps=[select id,Name,CurrencyIsoCode from Policy_Schedule__c where id=:psid];
        rcList=new List<Risk_Capture__c>();
        wrcList=new List<WrapperRisk>();
        rc=new Risk_Capture__c();
        if(MTAType == null){
            rcList=new List<Risk_Capture__c>([select id,Name,VG_IsTemp__c, VG_IsTempDelete__c,Drivers_Claims__c,Drivers_Conviction_Points__c,Drivers_Convictions__c,Drivers_DOB__c,Drivers_License_Ban_Details__c,Drivers_Medical_Conditions__c,Drivers_Name__c,Policy_Schedule__c from Risk_Capture__c where Policy_Schedule__c=:psid]);
        }else{
            System.debug('TestrcList::'+rcList.size()+'::psid::'+psid+'::'+rcList);
            rcList=new List<Risk_Capture__c>([select id,Name,VG_IsTemp__c, VG_IsTempDelete__c,Drivers_Claims__c,Drivers_Conviction_Points__c,Drivers_Convictions__c,Drivers_DOB__c,Drivers_License_Ban_Details__c,Drivers_Medical_Conditions__c,Drivers_Name__c,Policy_Schedule__c from Risk_Capture__c where Policy_Schedule__c=:OriginalId]);        
        }              
        if(!rcList.IsEmpty()){ 
            System.debug('rcList::'+rcList.size()+'::psid::'+psid+'::'+rcList);                       
            for(Risk_Capture__c rc:rcList){
                rc.Policy_Schedule__c=psid;  //this line Added by Anu 3.2.2018
                WrapperRisk wrc=new WrapperRisk(); 
                if(MTAType == null){
                    wrc.rc=rc;               
                }else{
                    wrc.rc=rc.clone(false, true, false, false);
                }
                System.debug('wrc::'+wrc.rc.Policy_Schedule__c);
                wrc.Counter=String.valueOf(counter);
                wrcList.add(wrc);
                System.debug('Cntrcounter::'+counter);
                counter++;
                System.debug('Cntrcounter::'+counter);
                System.debug('wrcList::'+wrcList);
            }
        }
    }
    
    
    public class WrapperRisk{
        public Risk_Capture__c rc{get;set;}
        public String Counter{get;set;}
    }
    
    
    public void AddRisk(){        
        WrapperRisk wrc=new WrapperRisk();
        rc.VG_IsTemp__c = True;
        wrc.rc=rc;
        wrc.Counter=String.valueOf(counter);
        wrcList.add(wrc);
        counter++;
        rc=new Risk_Capture__c();
    }
    
    
    public void RemoveRisk(){
        //wrcList.remove(integer.valueOf(Index));
        counter=0;
        for(WrapperRisk wrc:wrcList){
            wrc.Counter=String.valueOf(counter);
            if(counter == integer.valueOf(Index)){
                wrc.rc.VG_IsTempDelete__c = True;
            }
            counter++;
        }
    }
    
    
    public void EditRisk(){
        rc=wrcList[integer.valueOf(Index)].rc;
        System.debug('rc::'+rc.Policy_Schedule__c);        
        wrcList.remove(integer.valueOf(Index));
        //counter--;
        counter=0;
        for(WrapperRisk wrc:wrcList){
            wrc.Counter=String.valueOf(counter);
            counter++;
        }
    }
    
    
    public PageReference Cancel(){
        Policy_Schedule__c ps =[select id,Name from Policy_Schedule__c where id=:psid];
        List<VG_Policy_Schedule_Asset__c> psaList=[select id,Name,VG_Number_of_Vehicles__c,VG_Vehicle_Type__c,VG_Coverage__c,VG_Rate_Per_Vehicle__c,VG_Premium__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c=:psid];
        List<VG_Policy_Schedule_Endorsement__c> pseList=new List<VG_Policy_Schedule_Endorsement__c>([select id,Name,VG_Title__c,VG_Premium__c,VG_Endorsement_Details__c from VG_Policy_Schedule_Endorsement__c where VG_Policy_Schedule__c=:psid]);
        List<Risk_Capture__c> rcList=new List<Risk_Capture__c>([select Id,Name,Drivers_Name__c,Drivers_DOB__c,Drivers_Convictions__c,Drivers_Conviction_Points__c,Drivers_License_Ban_Details__c,Drivers_Claims__c,Drivers_Medical_Conditions__c from Risk_Capture__c where Policy_Schedule__c=:psid]);
        if(!psaList.IsEmpty()){
            Delete psaList;
        }
        if(!pseList.IsEmpty()){
            Delete pseList;
        }
        if(!rcList.IsEmpty()){
            Delete rcList;
        }
        return new PageReference('/'+policyid);
    }
    
    
    public PageReference Next(){
        List<Risk_Capture__c> rcInsList=new List<Risk_Capture__c>();
        for(WrapperRisk wrc:wrcList){
            wrc.rc.Name=ps.Name+'/RD/'+wrc.Counter;
            wrc.rc.CurrencyIsoCode=ps.CurrencyIsoCode;
            if(!wrc.rc.VG_IsTempDelete__c){
                    rcInsList.add(wrc.rc);
             }            
        }
        System.debug('rcInsList::'+rcInsList);
        if(!rcInsList.IsEmpty()){
             
            for(Risk_Capture__c rc:rcInsList){
                if(rc.Policy_schedule__c ==null){
                    rc.Policy_schedule__c=ps.id;
                }
            }
            Upsert rcInsList;
            System.debug('rcInsList2::'+rcInsList);
        }
        if(MTAType == null){
            return new PageReference('/apex/VG_Gentium_Step4?policyid='+policyid+'&id='+psid);
        }else{
            return new PageReference('/apex/VG_Gentium_Step4?MTAType='+MTAType+'&OriginalId='+OriginalId+'&id='+ps.id+'&policyid='+policyid);
        }        
    }
    
    
    public PageReference previous(){
        if(MTAType == null){
            return new PageReference('/apex/VG_Gentium_Step2a?id='+policyid+'&psid='+psid);
        }else{
            return new PageReference('/apex/VG_Gentium_Step2a?MTAType='+MTAType+'&OriginalId='+OriginalId);
        }   
    }
}