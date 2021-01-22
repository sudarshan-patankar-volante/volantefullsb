Public Class TaxTriggerFunction{
    
    Public Static Void Handler(List<VG_Taxes__c > TriggerNew, List<VG_Taxes__c > TriggerOld, Map<Id, VG_Taxes__c> TriggerNewMap, Map<Id, VG_Taxes__c> TriggerOldMap, Boolean IsBefore, Boolean IsAfter, Boolean IsInsert, Boolean IsUpdate, Boolean IsDelete){
        if(IsBefore && (IsInsert||IsUpdate)){
            ValidateJurisdiction(TriggerNew);
        }
        if(IsBefore && IsUpdate){          
            
        }
        if(IsAfter && (IsInsert || IsUpdate || IsDelete)){
            UpdatePSIPTField(TriggerNew, TriggerOld, IsInsert, IsUpdate, IsDelete);
        }
        if(IsAfter && IsUpdate){
            
        }
        if(IsBefore && IsDelete){
            
        }
    }
    
    public static void ValidateJurisdiction(List<VG_Taxes__c> TriggerNew){
        Set<Id> psId = new Set<Id>();
        Set<String> eeaCountries = new Set<String>();
        eeaCountries.addAll(Label.EEA_Countries.split(';'));
        for(VG_Taxes__c tax : TriggerNew){
            psId.add(tax.VG_Policy_Schedule__c);
        }
        Map<Id, Policy_Schedule__c> psMap = new Map<Id, Policy_Schedule__c>([Select Id, RecordType.Name, Split_Type__c from Policy_Schedule__c where Id IN: psId]);
        for(VG_Taxes__c tax : TriggerNew){
            if(psMap.get(tax.VG_Policy_Schedule__c).RecordType.Name == 'VFP' && psMap.get(tax.VG_Policy_Schedule__c).Split_Type__c == 'EEA' && (!eeaCountries.contains(tax.VG_Tax_Jurisdiction__c))){
                tax.addError('Please check tax jurisdiction as policy schedule split is for EEA and tax jurisdiction is Non EEA');
            }else if(psMap.get(tax.VG_Policy_Schedule__c).RecordType.Name == 'VFP' && psMap.get(tax.VG_Policy_Schedule__c).Split_Type__c == 'Non EEA' && (eeaCountries.contains(tax.VG_Tax_Jurisdiction__c))){
                tax.addError('Please check tax jurisdiction as policy schedule split is for Non EEA and tax jurisdiction is EEA');
            }
        }
    }
    
    public static void UpdatePSIPTField(List<VG_Taxes__c> TriggerNew,  List<VG_Taxes__c> TriggerOld, Boolean IsInsert, Boolean IsUpdate, Boolean IsDelete){
        Set<Id> psIds  =  new Set<Id>();                
        If(IsInsert || IsUpdate){  
            for (VG_Taxes__c tax : TriggerNew){          
                psIds.add(tax.VG_Policy_Schedule__c);
            } 
        }
        If(IsDelete){        
            for (VG_Taxes__c tax : TriggerOld){          
                psIds.add(tax.VG_Policy_Schedule__c);
            } 
        }
        System.debug('accIds::'+psIds);         
        List<VG_Taxes__c> listOfAlltaxes  =  [select id,  Name , VG_Tax_Amount_GWP_100__c ,VG_Is_Temp_Delete__c, VG_Tax_Administered_By__c, VG_Tax_Paid_By__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.RecordTypeId, VG_Taxable_Amount__c, VG_Tax_Amount__c from VG_Taxes__c where VG_Policy_Schedule__c IN :psIds];       
        List<VG_Taxes__c> subListOfAllTaxes;
        List<Policy_Schedule__c> PSToBeUpdated  =  new List<Policy_Schedule__c>();
        Map<Id,  List<VG_Taxes__c>> PSTaxMap  =  new Map<Id,  List<VG_Taxes__c>>();
        for(VG_Taxes__c tx: listOfAlltaxes){
            if(PSTaxMap.get(tx.VG_Policy_Schedule__c)  ==  null){
                subListOfAllTaxes  =  new List<VG_Taxes__c>();
            }else{
                subListOfAllTaxes  =  PSTaxMap.get(tx.VG_Policy_Schedule__c);
            }
            subListOfAllTaxes.add(tx);
            System.debug('Test3::'+tx.VG_Policy_Schedule__c);
            PSTaxMap.put(tx.VG_Policy_Schedule__c,  subListOfAllTaxes);
        }
        Map<Id, Policy_Schedule__c> psMap = new Map<Id, Policy_Schedule__c>([select id, Name, Transaction_GWP__c,Levies__c,VG_Fee_Income__c,VG_Brokerage_Amount__c ,Gross_Written_Premium__c  ,RecordType.Name, IPT__c, RecordTypeId from Policy_Schedule__c where Id IN:psIds]);
        
        for(Id PsId : psMap.keySet()){
            Decimal IPT =  0;
            Decimal IPTHun =  0;
            If(!PSTaxMap.IsEmpty()){
                for(VG_Taxes__c tx: PSTaxMap.get(PsId)){ 
                    System.debug('tax::'+tx);            
                    if(tx.VG_Tax_Amount__c  !=  null){
                        if((tx.VG_Tax_Administered_By__c == 'Insured' && tx.VG_Tax_Paid_By__c=='Insurer') || (tx.VG_Tax_Administered_By__c == 'Broker' && tx.VG_Tax_Paid_By__c=='Insurer') || (tx.VG_Tax_Administered_By__c == 'Insurer' && tx.VG_Tax_Paid_By__c=='Insured')){
                            IPT = IPT+tx.VG_Tax_Amount__c;
                            IPTHun = IPTHun + (tx.VG_Tax_Amount_GWP_100__c !=null ? tx.VG_Tax_Amount_GWP_100__c : 0) ;
                        }             
                    }
                    System.debug('taxamount::'+IPT);                               
                }  
            }          
            Policy_Schedule__c tempPS  =  new Policy_Schedule__c();
            tempPS.Id  =  PsId;
            tempPS.IPT__c = IPT;
            tempPs.VG_Tax_Amount_GWP_100__c = IPTHun;
            System.Debug('IPT::'+IPT); 
            tempPS.VG_Last_Tax_Modified__c = System.now();
            If(psMap.get(PsId).RecordType.Name=='Edison Motor'){
                tempPS.Transaction_GWP__c = (psMap.get(PsId).Gross_Written_Premium__c != null? psMap.get(PsId).Gross_Written_Premium__c : 0)+(psMap.get(PsId).Levies__c != null? psMap.get(PsId).Levies__c : 0)+(psMap.get(PsId).VG_Fee_Income__c != null? psMap.get(PsId).VG_Fee_Income__c : 0)-(psMap.get(PsId).VG_Brokerage_Amount__c != null? psMap.get(PsId).VG_Brokerage_Amount__c : 0 );            
                tempPS.Transaction_GWP__c= tempPS.Transaction_GWP__c+IPT;
            }else{
                tempPS.Transaction_GWP__c = psMap.get(PsId).Transaction_GWP__c ;          
            }
            /*If(!PSTaxMap.IsEmpty()){
                for(VG_Taxes__c tx: PSTaxMap.get(PsId)){  
                System.debug('GWP1::'+tempPS.Transaction_GWP__c+'::'+tempPS.IPT__c);
                        
                    If(tx.VG_Tax_Paid_By__c=='Broker' || tx.VG_Tax_Paid_By__c=='Insured'){
                        System.debug('GWP3::'+psMap.get(PsId).Transaction_GWP__c+'::'+tx.VG_Tax_Amount__c);
                        tempPS.Transaction_GWP__c=(psMap.get(PsId).Transaction_GWP__c != null ? psMap.get(PsId).Transaction_GWP__c: 0)-IPT;           
                    }else If(tx.VG_Tax_Paid_By__c=='Insurer'){
                        System.debug('GWP4::'+tempPS.Transaction_GWP__c+'::'+tempPS.IPT__c);           
                        tempPS.Transaction_GWP__c=(psMap.get(PsId).Transaction_GWP__c != null ? psMap.get(PsId).Transaction_GWP__c: 0)+IPT;
                    }
                }
            }
            System.debug('GWP2::'+tempPS.Transaction_GWP__c+'::'+tempPS.IPT__c);*/
            PSToBeUpdated.add(tempPS);                  
        }
        
        if(!PSToBeUpdated.IsEmpty()){
            Update PSToBeUpdated;
            System.debug('update::'+PSToBeUpdated);
        }                          
    }
    
}