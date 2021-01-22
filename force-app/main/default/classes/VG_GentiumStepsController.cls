Public Class VG_GentiumStepsController{
    
    public String policyCurrency {get; set;}
    public String Product_Selected {get; set;}
    public String fileName {get;set;}
    public string nameFile{get;set;}
    public String[] filelines   =   new String[]{};
        public Id policyId {get; set;}
    public List<SelectOption> ProductList {get; set;}
    public List<RRWrapper> rrwList{get; set;}
    public Blob fileBody {get;set;}
    public Boolean pmsg {get; set;}
    public  Decimal TechnicalModelPremium{get;set;}
    public  Decimal ActualPremium{get;set;}
    public  Decimal BrokeragePrecent{get;set;}
    public  Decimal BrokerageAmount{get;set;}
    public  Decimal GWP {get;set;}
    public  Decimal IPTPrecent{get;set;}
    public  Decimal IPTAmount{get;set;}
    public  Decimal FeeIncome{get;set;}
    public  Decimal Levies{get;set;}
    public  Decimal CCPrecent{get;set;}
    public  Decimal CCAmount{get;set;}
    public  Decimal sumGWP{get;set;}
    public  Decimal sumBrokerage{get;set;}
    public  Decimal RateChange {get;set;}
    public  Decimal sumTP{get;set;}
    public  Decimal sumCC{get;set;}
    
    public VG_GentiumStepsController(){
        policyId   =   apexpages.currentpage().getparameters().get('Id');
        policyCurrency   =   apexpages.currentpage().getparameters().get('Currency');
        ProductList  =  new List<SelectOption>();
        ProductList.add(new SelectOption('Fleet', 'Fleet'));
        ProductList.add(new SelectOption('Schemes', 'Schemes'));
        pmsg  =  false;
        rrwList  =  new List<RRWrapper>();
        fileBody  =  blob.valueOf('');
        TechnicalModelPremium  =  ActualPremium  =  BrokeragePrecent  =  BrokerageAmount  =  GWP  =  IPTPrecent  =  IPTAmount  =  FeeIncome  =  Levies  =  CCPrecent  =  CCAmount  =  sumGWP  =  sumBrokerage  =  sumTP  =  sumCC  =  0;
    }
    Public PageReference Cancel(){
        return new PageReference('/'+policyId);
    }
    public PageReference gotostep1(){
        return new PageReference('/apex/VG_Gentium_Step1');
    }
    public PageReference gotostep2(){
        if(Product_Selected  ==  'Fleet'){
            return new PageReference('/apex/VG_Gentium_Step2a?Id='+policyId);
        }else{
            rrwList.clear();
            return new PageReference('/apex/VG_Gentium_Step2b');
        }
    }
    public void summaryCalc(){
        if(BrokeragePrecent !=  0)
            BrokerageAmount  =  (BrokeragePrecent/100) * sumGWP ;
        else
            BrokerageAmount  =  0;
        if(CCAmount !=  0 && sumGWP !=  0){
            CCPrecent  =  (CCAmount / sumGWP);
        }
        ActualPremium = sumGWP - BrokerageAmount - CCAmount;
        //if(IPTPrecent !=  0)
        //IPTAmount = (IPTPrecent/100) * sumGWP ;
    }
    public PageReference gotostep6(){
        if(fileBody  ==  null || fileBody  ==  blob.valueOf('')){
            System.debug('fileBody::'+fileBody); 
            pmsg = true;
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'Must select file.'));
            return null;
        }else{
            pmsg  =  false;
        }
        try{  
            nameFile  =  PaymentDetailsController.decode(fileBody, 'ISO-8859-1'); //fileBody.toString();
            RRWrapper rrw;
            fileBody  =  blob.valueOf('');
            filelines =  nameFile.split('\n'); 
            for (Integer i  =  1;i<filelines.size();i++){
                String[] inputvalues   =   new String[]{};
                String[] headervalues  =   new String[]{};
                rrw  =  new RRWrapper();
                headervalues   =   filelines[0].split(',');
                inputvalues    =   filelines[i].split(',');
                if(!('Scheme Name' ==  headervalues[0].trim() &&'Binder Ref' ==  headervalues[1].trim() &&'Policy No' ==  headervalues[2].trim() &&'Transaction Type' ==  headervalues[3].trim() &&'Bordereax Date' ==  headervalues[4].trim() &&'Policy Cover Start Date' ==  headervalues[5].trim() &&  'Policy Cover End Date' ==  headervalues[6].trim() &&'Transaction Effective date' ==  headervalues[7].trim() && 'Insured Name' ==  headervalues[8].trim() && 'Date of Birth' == headervalues[9].trim()  &&'Address' ==  headervalues[10].trim() && 'Address2' ==  headervalues[11].trim() && 'Address3' ==  headervalues[12].trim() && 'Postcode' ==  headervalues[13].trim() &&'Country' ==  headervalues[14].trim() &&'Vehicle Make' ==  headervalues[15].trim() &&'Vehicle Model' ==  headervalues[16].trim() && 'Vehicle Type' ==  headervalues[17].trim() && 'Registration Plate' ==  headervalues[18].trim() && 'Sub broker' ==  headervalues[19].trim() &&'Coverage' ==  headervalues[20].trim() &&'Currency' ==  headervalues[21].trim() &&'Sum Insured' ==  headervalues[22].trim() && 'Deductible' ==  headervalues[23].trim() &&'Gross Written Premium' ==  headervalues[24].trim() &&'Brokerage' ==  headervalues[25].trim() &&'Tax on Premium' ==  headervalues[26].trim() &&'CH Commission' ==  headervalues[27].trim() &&'Payment Terms' ==  headervalues[28].trim() &&'Payment Ref' ==  headervalues[29].trim())){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'file header mis match please check the file.'));
                    return null;
                }
                if(inputvalues[0] != null && inputvalues[0] != '' )
                    rrw.psa.VG_Scheme_Name__c = inputvalues[0].trim();
                if(inputvalues[1] != null && inputvalues[1] != '' )
                    rrw.psa.VG_Binder_Ref__c = inputvalues[1].trim();
                if(inputvalues[2] != null && inputvalues[2] != '' )
                    rrw.psa.VG_Policy_No__c = inputvalues[2].trim();
                if(inputvalues[3] != null && inputvalues[3] != '' )
                    rrw.psa.VG_Transaction_Type__c = inputvalues[3].trim();
                if(inputvalues[4] != null && inputvalues[4] != '' ){
                    inputvalues[4] = inputvalues[4].trim().replace('-', '/');
                    rrw.psa.VG_Bordereax_Date__c = Date.parse(inputvalues[4].trim());
                }
                if(inputvalues[5] != null && inputvalues[5] != '' ){
                    inputvalues[5] = inputvalues[5].trim().replace('-', '/');
                    rrw.psa.VG_Policy_Cover_Start_Date__c = Date.parse(inputvalues[5].trim());
                }
                if(inputvalues[6] != null && inputvalues[6] != '' ){
                    inputvalues[6] = inputvalues[6].trim().replace('-', '/');
                    rrw.psa.VG_Policy_Cover_End_Date__c = Date.parse(inputvalues[6].trim());
                }
                if(inputvalues[7] != null && inputvalues[7] != '' ){
                    inputvalues[7] = inputvalues[7].trim().replace('-', '/');
                    rrw.psa.VG_Transaction_Effective_date__c = Date.parse(inputvalues[7].trim());  
                }                                                    
                if(inputvalues[8] != null && inputvalues[8] != '' )
                    rrw.psa.VG_Insured_Name__c = inputvalues[8].trim();
                if(inputvalues[9] != null && inputvalues[9] != '' ){
                    inputvalues[9] = inputvalues[9].trim().replace('-', '/');
                    rrw.psa.VG_Date_of_Birth__c = Date.parse(inputvalues[9].trim());
                }
                if(inputvalues[10] != null && inputvalues[10] != '' )
                    rrw.psa.VG_Address__c = inputvalues[10].trim();
                if(inputvalues[11] != null && inputvalues[11] != '' )
                    rrw.psa.VG_Address2__c = inputvalues[11].trim();    
                if(inputvalues[12] != null && inputvalues[12] != '' )
                    rrw.psa.VG_Address3__c = inputvalues[12].trim();    
                if(inputvalues[13] != null && inputvalues[13] != '' )
                    rrw.psa.VG_Postcode__c = inputvalues[13].trim();                    
                if(inputvalues[14] != null && inputvalues[14] != '' )
                    rrw.psa.VG_Country__c = inputvalues[14].trim();
                if(inputvalues[15] != null && inputvalues[15] != '' )
                    rrw.psa.VG_Vehicle_Make__c = inputvalues[15].trim();
                if(inputvalues[16] != null && inputvalues[16] != '' )
                    rrw.psa.VG_Vehicle_Model__c = inputvalues[16].trim();
                if(inputvalues[17] != null && inputvalues[17] != '' )
                    rrw.psa.VG_Vehicle_Type__c = inputvalues[17].trim();    
                if(inputvalues[18] != null && inputvalues[18] != '' )
                    rrw.psa.VG_Registration_Plate__c = inputvalues[18].trim();    
                if(inputvalues[19] != null && inputvalues[19] != '' )
                    rrw.psa.VG_Sub_broker__c = inputvalues[19].trim();                        
                if(inputvalues[20] != null && inputvalues[20] != '' )
                    rrw.psa.VG_Coverage__c = inputvalues[20].trim();
                if(inputvalues[21] != null && inputvalues[21] != '' )
                    rrw.psa.CurrencyISOCode = inputvalues[21].trim();
                if(inputvalues[22] != null && inputvalues[22] != '' )
                    rrw.psa.VG_Sum_Insured__c = Decimal.valueOf(inputvalues[22].trim());
                if(inputvalues[23] != null && inputvalues[23] != '' )
                    rrw.psa.VG_Deductible__c = Decimal.valueOf(inputvalues[23].trim());
                if(inputvalues[24] != null && inputvalues[24] != '' )
                    rrw.psa.VG_Gross_Written_Premium__c = Decimal.valueOf(inputvalues[24].trim());
                if(inputvalues[25] != null && inputvalues[25] != '' )
                    rrw.psa.VG_Brokerage__c = Decimal.valueOf(inputvalues[25].trim());
                if(inputvalues[26] != null && inputvalues[26] != '' )
                    rrw.psa.VG_Tax_on_Premium__c = Decimal.valueOf(inputvalues[26].trim());
                if(inputvalues[27] != null && inputvalues[27] != '' )
                    rrw.psa.VG_CH_Commission__c = Decimal.valueOf(inputvalues[27].trim());
                if(inputvalues[28] != null && inputvalues[28] != '' )
                    rrw.psa.VG_Payment_Terms__c = inputvalues[28].trim();
                if(inputvalues[29] != null && inputvalues[29] != '' )
                    rrw.psa.VG_Payment_Ref__c = inputvalues[29].trim();
                rrw.counter = i-1;
                rrwList.add(rrw);
            }
        }catch(Exception e){       
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Error ::'+e));
            return null;
        }
        return new PageReference('/apex/VG_Gentium_Step6');
    }
    public PageReference gotostep7(){
        sumGWP = sumBrokerage = sumTP = sumCC = 0;
        for(RRWrapper rrw : rrwList){
            if(rrw.psa.VG_Gross_Written_Premium__c !=  null)
                sumGWP = rrw.psa.VG_Gross_Written_Premium__c+sumGWP;
            if(rrw.psa.VG_Brokerage__c !=  null)
                sumBrokerage = rrw.psa.VG_Brokerage__c+sumBrokerage;
            if(rrw.psa.VG_Tax_on_Premium__c !=  null)
                sumTP = rrw.psa.VG_Tax_on_Premium__c+sumTP;
            if(rrw.psa.VG_CH_Commission__c !=  null)
                sumCC = rrw.psa.VG_CH_Commission__c+sumCC;
        }
        //GWP  =  sumGWP - sumTP - sumBrokerage ;
        CCAmount  =   sumCC;
        if(CCAmount !=  0 && sumGWP !=  0){
            CCPrecent   =   CCAmount / sumGWP;
        }
        return new PageReference('/apex/VG_Gentium_Step7');
    }
    public PageReference gotostep2b(){
        rrwList.clear();
        System.debug('rrwList::'+rrwList.size());
        return new PageReference('/apex/VG_Gentium_Step2b');
    }
    public PageReference finish(){
        Policy__c pol  =  [select id, Name, VG_Inception_Date__c, VG_Expiry_Date__c from Policy__c where Id  =  :policyId limit 1];
        List<VG_Policy_Schedule_Asset__c> assetsToBeInserted   =   new List<VG_Policy_Schedule_Asset__c>();
        List<Policy_Schedule__c> psList  =  new List<Policy_Schedule__c>([SELECT Id, Name, Policy__c FROM Policy_Schedule__c WHERE Policy__c  =  :policyId ORDER BY CreatedDate DESC]);                                 
        Policy_Schedule__c ps  =  new Policy_Schedule__c();
        ps.Policy__c   =   policyId;
        List<Integer> psNumList  =  new List<Integer>();
        if(psList.size()>0){
            for(Policy_Schedule__c ps2: psList){
                psNumList.add(Integer.valueOf(ps2.Name.split('/PS/')[1]));
            }
            psNumList.sort();
            ps.Name  =  pol.Name+'/PS/'+((psNumList[psNumList.size()-1])+1); 
            System.debug('ps.Name::'+ps.Name);       
        }else{
            ps.Name  =  pol.Name+'/PS/0';       
        }                        
        ps.Product__c  =  Product_Selected;
        ps.VG_Base_Policy__c  =  true;
        ps.Gross_Written_Premium__c   =  sumGWP ;
        ps.VG_Gross_Written_Premium_100__c   =   sumGWP;       
        ps.VG_Is_MTA__c   =   False;
        ps.VG_Technical_Model_Premium__c  =  TechnicalModelPremium;
        ps.VG_Brokerage_Percent__c   =   BrokeragePrecent;
        ps.Actual_GWP__c  =  actualPremium;
        ps.VG_Rate_Change__c   =   RateChange;
        ps.VG_Brokerage_Amount__c  =  brokerageAmount;
        ps.IPT__c  =  IPTAmount;
        ps.IPT_Percent__c   =   IPTPrecent;
        ps.Levies__c   =   Levies;
        ps.VG_Fee_Income__c   =   FeeIncome;
        ps.VG_Base_Policy__c   =   True;
        ps.Base_Creation_Start_Date__c   =   pol.VG_Inception_Date__c;
        ps.Base_Creation_End_Date__c   =   pol.VG_Expiry_Date__c;
        ps.RecordTypeId  =  Schema.SObjectType.Policy_Schedule__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();
        Insert ps;
        Integer psacount  =  1;
        for(RRWrapper rrw : rrwList){
            rrw.psa.Name   =   ps.Name + '/RR/' + psacount;
            rrw.psa.CurrencyIsoCode  =  policyCurrency;
            rrw.psa.RecordTypeId  =  Schema.SObjectType.VG_Policy_Schedule_Asset__c.getRecordTypeInfosByName().get('Gentium').getRecordTypeId();
            rrw.psa.VG_Policy_Schedule__c  =  ps.id;           
            //rrw.psa.VG_Bordereax_Date__c  =  date.newinstance(rrw.psa.VG_Bordereax_Date__c.year(), rrw.psa.VG_Bordereax_Date__c.month(),  rrw.psa.VG_Bordereax_Date__c.day());            
            //rrw.psa.VG_Policy_Cover_Start_Date__c  =  date.newinstance(rrw.psa.VG_Policy_Cover_Start_Date__c.year(), rrw.psa.VG_Policy_Cover_Start_Date__c.month(),  rrw.psa.VG_Policy_Cover_Start_Date__c.day());
            //rrw.psa.VG_Policy_Cover_End_Date__c  =  date.newinstance(rrw.psa.VG_Policy_Cover_End_Date__c.year(), rrw.psa.VG_Policy_Cover_End_Date__c.month(),  rrw.psa.VG_Policy_Cover_End_Date__c.day());
            assetsToBeInserted.add(rrw.psa);
            psacount++;
        }
        if(!assetsToBeInserted.IsEmpty()){
            Insert assetsToBeInserted;
        }
        return new PageReference('/'+ps.id);
    }
    Public Class RRWrapper{
        public VG_Policy_Schedule_Asset__c psa{get;set;}
        public Integer counter{get;set;}
        public RRWrapper(){
            psa  =  new VG_Policy_Schedule_Asset__c();
            counter  =  0;
        }
    }
}