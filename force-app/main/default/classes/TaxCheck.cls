global class TaxCheck implements Database.Batchable<sobject>, Schedulable, Database.Stateful{
    String errorCode = '';
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Name, IPT__c, RecordType.Name, CreatedDate, VG_Tax_Amount_GWP_100__c FROM Policy_Schedule__c');
    }
    
    global void execute(Database.BatchableContext bc, List<Policy_Schedule__c> listPS){
        Set<Id> psIds = new Set<Id>();
        Map<Id,  List<VG_Taxes__c>> PSTaxMap  =  new Map<Id,  List<VG_Taxes__c>>();
        List<VG_Taxes__c> subListOfAllTaxes;
        for(Policy_Schedule__c ps : listPS){
            psIds.add(ps.Id);  
        }
        List<VG_Taxes__c> listOfAlltaxes  =  [select id,  Name , VG_Tax_Amount_GWP_100__c ,VG_Is_Temp_Delete__c, VG_Tax_Administered_By__c, VG_Tax_Paid_By__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.RecordTypeId, VG_Policy_Schedule__r.RecordType.Name, VG_Policy_Schedule__r.CreatedDate, VG_Taxable_Amount__c, VG_Tax_Amount__c from VG_Taxes__c where VG_Policy_Schedule__c IN :psIds];       
        for(VG_Taxes__c tx: listOfAlltaxes){
            if(PSTaxMap.get(tx.VG_Policy_Schedule__c)  ==  null){
                subListOfAllTaxes  =  new List<VG_Taxes__c>();
            }else{
                subListOfAllTaxes  =  PSTaxMap.get(tx.VG_Policy_Schedule__c);
            }
            subListOfAllTaxes.add(tx);
            PSTaxMap.put(tx.VG_Policy_Schedule__c,  subListOfAllTaxes);
        }
        
        for(Policy_Schedule__c ps : listPS){
            Id psId = ps.Id;
            Decimal IPT =  0;
            Decimal IPTHun =  0;
            If(!PSTaxMap.IsEmpty()){
                if(PSTaxMap.get(PsId) != null){
                    for(VG_Taxes__c tx: PSTaxMap.get(PsId)){ 
                        if(tx.VG_Tax_Amount__c  !=  null){
                            if((tx.VG_Tax_Administered_By__c == 'Insured' && tx.VG_Tax_Paid_By__c=='Insurer') || (tx.VG_Tax_Administered_By__c == 'Broker' && tx.VG_Tax_Paid_By__c=='Insurer') || (tx.VG_Tax_Administered_By__c == 'Insurer' && tx.VG_Tax_Paid_By__c=='Insured') || (tx.VG_Tax_Administered_By__c == 'MGA' && tx.VG_Tax_Paid_By__c=='Insured')){
                                IPT = IPT+tx.VG_Tax_Amount__c;
                                IPTHun = IPTHun + (tx.VG_Tax_Amount_GWP_100__c !=null ? tx.VG_Tax_Amount_GWP_100__c : 0) ;
                            }             
                        }                             
                    }  
                }else{
                    IPT = 0;
                    IPTHun = 0;
                }
            }      
            String inpputString = '2020-04-22T00:00:00.000Z';
            DateTime edisonReferenceDateTime = DateTime.ValueofGmt(inpputString.replace('T', ' '));    
            if(PS.IPT__c != null && IPT != null && ps.VG_Tax_Amount_GWP_100__c != null && IPTHun != null && (PS.IPT__c.setScale(2) != IPT.setScale(2)  || ps.VG_Tax_Amount_GWP_100__c.setScale(2)  != IPTHun.setScale(2))){
                if(ps.RecordType.Name != 'Edison Motor' || (ps.RecordType.Name == 'Edison Motor' && ps.CreatedDate > edisonReferenceDateTime)){
                    errorCode = errorCode + ps.Name + '(Expected:'+IPT+', Actual:'+PS.IPT__c+'),\n';
                }
            }else if((PS.IPT__c == null && IPT != null && IPT != 0) || (ps.VG_Tax_Amount_GWP_100__c == null && IPTHun != null && IPTHun != 0) || (PS.IPT__c != null && PS.IPT__c != 0 && IPT == 0) || (ps.VG_Tax_Amount_GWP_100__c != null && ps.VG_Tax_Amount_GWP_100__c != 0 && IPTHun == 0)){
                if(ps.RecordType.Name != 'Edison Motor' || (ps.RecordType.Name == 'Edison Motor' && ps.CreatedDate > edisonReferenceDateTime)){
                    errorCode = errorCode + ps.Name + '(Expected:'+IPT+', Actual:'+PS.IPT__c+'),\n';
                }
            }     
            
        }
    }
    
    global void finish(Database.BatchableContext bc){
        List<messaging.Email> emailsList = new List<messaging.Email>();
        string[]toAdd=new string[]{Label.EmailID_DuplicatePolicyNumberDetector};
        string []ccAdd=new string[]{Label.EmailID2_DuplicatePolicyNumberDetector};
        messaging.SingleEmailMessage email1=new messaging.SingleEmailMessage();
        if(errorCode != ''){ 
            email1.setToAddresses(toAdd);
            email1.setCcAddresses(ccAdd);
            email1.setSubject('Tax Issue');
            email1.setPlainTextBody(errorCode);
            email1.setSenderDisplayName('Developer Team');
            emailsList.add(email1);
            messaging.sendEmail(emailsList);
        }
    }
    
    global void execute(SchedulableContext ctx) {
        TaxCheck taxCheckSchedule= new TaxCheck();
        database.executebatch(taxCheckSchedule ,100);
    }
}