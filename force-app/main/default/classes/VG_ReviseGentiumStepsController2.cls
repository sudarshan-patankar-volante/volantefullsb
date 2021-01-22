Public Class VG_ReviseGentiumStepsController2{
    
    public String fileName {get;set;}
    public string nameFile{get;set;}
    public String[] filelines  =  new String[]{};
        public String MTAType{get;set;}
    public String MTAStartDate{get;set;}
    
    public Policy__c policy{get; set;}
    public Policy_Schedule__c ps{get;set;}
    
    public Id psid {get; set;}
    
    public Boolean DMLAlert{get;set;}
    
    public List<RRWrapper> rrwList{get; set;}
    public List<VG_Policy_Schedule_Asset__c> psaList{get;set;}
    
    public Blob fileBody {get;set;}
    
    public  Decimal TechnicalModelPremium{get;set;}
    public  Decimal ActualPremium{get;set;}
    public  Decimal BrokeragePrecent{get;set;}
    public  Decimal BrokerageAmount{get;set;}
    public  Decimal GWP {get;set;}
    public  Decimal RateChange {get;set;}
    public  Decimal IPTPrecent{get;set;}
    public  Decimal IPTAmount{get;set;}
    public  Decimal FeeIncome{get;set;}
    public  Decimal Levies{get;set;}
    public  Decimal CCPrecent{get;set;}
    public  Decimal CCAmount{get;set;}
    public  Decimal sumGWP{get;set;}
    public  Decimal sumBrokerage{get;set;}
    public  Decimal sumTP{get;set;}
    public  Decimal sumCC{get;set;}
    
    public VG_ReviseGentiumStepsController2(){
        psid  =  apexpages.currentpage().getparameters().get('PSID');
        MTAType = apexpages.currentpage().getparameters().get('MTAType');
        MTAStartDate = apexpages.currentpage().getparameters().get('MTAStartDate');        
        TechnicalModelPremium = ActualPremium = BrokeragePrecent = BrokerageAmount = GWP = IPTPrecent = IPTAmount = FeeIncome = Levies = CCPrecent = CCAmount = sumGWP = sumBrokerage = sumTP = sumCC = 0;
        ps = [select id, Name, Policy__r.Name, Policy__r.VG_Inception_Date__c, Policy__r.VG_Expiry_Date__c, VG_Rate_Change__c, VG_MTA_Start_Date__c, VG_MTA_Type__c, VG_Is_MTA__c, VG_Technical_Model_Premium__c, VG_MTA_End_Date__c, Policy__c, Transaction_GWP__c, Gross_Written_Premium__c, VG_Brokerage_Percent__c, Actual_GWP__c, VG_Brokerage_Amount__c, IPT__c, IPT_Percent__c, Levies__c, VG_Fee_Income__c from Policy_Schedule__c where id = :psid limit 1];
        policy = [select id, Name, CurrencyIsoCode from Policy__c where id = :ps.Policy__c limit 1];
        psaList =  new List<VG_Policy_Schedule_Asset__c>([select id, Name, VG_Scheme_Name__c, VG_Binder_Ref__c, VG_Policy_No__c, VG_Transaction_Type__c, VG_Bordereax_Date__c, VG_Policy_Cover_Start_Date__c, VG_Policy_Cover_End_Date__c, VG_Transaction_Effective_date__c, VG_Insured_Name__c, VG_Date_of_Birth__c, VG_Address__c, VG_Address2__c, VG_Address3__c, VG_Postcode__c, VG_Country__c, VG_Vehicle_Make__c, VG_Vehicle_Model__c, VG_Vehicle_Type__c, VG_Registration_Plate__c, VG_Sub_broker__c, VG_Coverage__c, CurrencyISOCode, VG_Sum_Insured__c, VG_Deductible__c, VG_Gross_Written_Premium__c, VG_Brokerage__c, VG_Tax_on_Premium__c, VG_CH_Commission__c, VG_Payment_Terms__c, VG_Payment_Ref__c from VG_Policy_Schedule_Asset__c where VG_Policy_Schedule__c  = : psid]);
        If(MTAType !=  null && MTAType !=  '')
            psaList.clear();
        sumGWP = ps.Gross_Written_Premium__c;  
        TechnicalModelPremium = ps.VG_Technical_Model_Premium__c; 
        actualPremium = ps.Actual_GWP__c;
        BrokeragePrecent  = ps.VG_Brokerage_Percent__c;         
        brokerageAmount = ps.VG_Brokerage_Amount__c;
        System.debug('BrokeragePrecent::'+ps.VG_Brokerage_Percent__c+'::'+ps.VG_Brokerage_Amount__c+TechnicalModelPremium+'::p:'+BrokeragePrecent );
        IPTAmount = ps.IPT__c;
        IPTPrecent = ps.IPT_Percent__c;  
        Levies = ps.Levies__c;  
        FeeIncome = ps.VG_Fee_Income__c;
        RateChange = ps.VG_Rate_Change__c;  
        rrwList = new List<RRWrapper>();
        DMLAlert = false;
        Integer counter = 0;
        for(VG_Policy_Schedule_Asset__c psa: psaList){
            RRWrapper rrw = new RRWrapper();
            rrw.psa = psa;
            rrw.counter = counter;
            rrwList.add(rrw);
            counter++;
        }
        fileBody = blob.valueOf('');
        
    }
    Public PageReference Cancel(){
        return new PageReference('/'+psid);
    }
    public PageReference gotostep5(){
        return new PageReference('/apex/VG_Revise_Gentium_Edit5');
    }
    public void summaryCalc(){
        if(BrokeragePrecent  !=   0){
            BrokerageAmount = (BrokeragePrecent/100) * sumGWP;
            BrokerageAmount = BrokerageAmount.setScale(2);
        }else{
            BrokerageAmount = 0;
        }
        if(CCAmount  !=   0 && sumGWP  !=   0){
            CCPrecent  =  CCAmount / sumGWP;
        }
        ActualPremium =  sumGWP - BrokerageAmount - CCAmount;
        //if(IPTPrecent  !=   0)
        //IPTAmount = (IPTPrecent/100) * sumGWP ;
    }
    public PageReference gotostep6(){
        try{  
            if(fileBody  !=   blob.valueOf('')){
                rrwList.clear();
                DMLAlert = True;
            }else{
                DMLAlert = false;
            }
            if(DMLAlert){
                nameFile = PaymentDetailsController.decode(fileBody, 'ISO-8859-1'); //fileBody.toString();
                System.debug('nameFile::'+nameFile);
                RRWrapper rrw;
                fileBody = blob.valueOf('');
                filelines  =  nameFile.split('\n');
                System.debug('filelines::'+filelines+'::'+filelines.size());
                for (Integer i = 1;i<filelines.size();i++){
                    String[] inputvalues  =  new String[]{};
                        String[] headervalues  =  new String[]{};
                            System.debug('RRWLIst::'+rrwList.size());
                    rrw = new RRWrapper();
                    headervalues  =  filelines[0].split(',');
                    inputvalues  =  filelines[i].split(',');
                    if('Scheme Name' ==  headervalues[0] &&'Binder Ref' ==  headervalues[1] &&'Policy No' ==  headervalues[2] &&'Transaction Type' ==  headervalues[3] &&'Bordereax Date' ==  headervalues[4] &&'Policy Cover Start Date' ==  headervalues[5] &&    'Policy Cover End Date' ==  headervalues[6] &&
                       'Transaction Effective date' ==  headervalues[7] && 'Insured Name' ==  headervalues[8] && 'Date of Birth' == headervalues[9]  &&'Address' ==  headervalues[10] && 'Address2' ==  headervalues[11] && 'Address3' ==  headervalues[12] && 'Postcode' ==  headervalues[13] &&'Country' ==  headervalues[14] &&'Vehicle Make' ==  headervalues[15] &&'Vehicle Model' ==  headervalues[16] && 'Vehicle Type' ==  headervalues[17] && 'Registration Plate' ==  headervalues[18] && 'Sub broker' ==  headervalues[19] &&'Coverage' ==  headervalues[20] &&'Currency' ==  headervalues[21] &&'Sum Insured' ==  headervalues[22] && 'Deductible' ==  headervalues[23] &&'Gross Written Premium' ==  headervalues[24] &&'Brokerage' ==  headervalues[25] &&'Tax on Premium' ==  headervalues[26] &&'CH Commission' ==  headervalues[27] &&'Payment Terms' ==  headervalues[28] &&'Payment Ref' ==  headervalues[29]){
                           ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,   'file header mis match please check the file.'));
                           return null;
                       }
                    System.debug('inputvalues[4]::'+inputvalues[4]);
                    if(inputvalues[0]  !=  null && inputvalues[0]  !=  '' )
                        rrw.psa.VG_Scheme_Name__c = inputvalues[0].trim();
                    if(inputvalues[1]  !=  null && inputvalues[1]  !=  '' )
                        rrw.psa.VG_Binder_Ref__c = inputvalues[1].trim();
                    if(inputvalues[2]  !=  null && inputvalues[2]  !=  '' )
                        rrw.psa.VG_Policy_No__c = inputvalues[2].trim();
                    if(inputvalues[3]  !=  null && inputvalues[3]  !=  '' )
                        rrw.psa.VG_Transaction_Type__c = inputvalues[3].trim();
                    if(inputvalues[4]  !=  null && inputvalues[4]  !=  '' ){
                        inputvalues[4] = inputvalues[4].trim().replace('-', '/');
                        rrw.psa.VG_Bordereax_Date__c = Date.parse(inputvalues[4].trim());
                    }
                    if(inputvalues[5]  !=  null && inputvalues[5]  !=  '' ){
                        inputvalues[5] = inputvalues[5].trim().replace('-', '/');
                        rrw.psa.VG_Policy_Cover_Start_Date__c = Date.parse(inputvalues[5].trim());
                    }
                    if(inputvalues[6]  !=  null && inputvalues[6]  !=  '' ){
                        inputvalues[6] = inputvalues[6].trim().replace('-', '/');
                        rrw.psa.VG_Policy_Cover_End_Date__c = Date.parse(inputvalues[6].trim());
                    }
                    if(inputvalues[7]  !=  null && inputvalues[7]  !=  '' ){
                        inputvalues[7] = inputvalues[7].trim().replace('-', '/');
                        rrw.psa.VG_Transaction_Effective_date__c = Date.parse(inputvalues[7].trim());  
                    }                                                    
                    if(inputvalues[8]  !=  null && inputvalues[8]  !=  '' )
                        rrw.psa.VG_Insured_Name__c = inputvalues[8].trim();
                    if(inputvalues[9]  !=  null && inputvalues[9]  !=  '' ){
                        inputvalues[9] = inputvalues[9].trim().replace('-', '/');
                        rrw.psa.VG_Date_of_Birth__c = Date.parse(inputvalues[9].trim());
                    }
                    if(inputvalues[10]  !=  null && inputvalues[10]  !=  '' )
                        rrw.psa.VG_Address__c = inputvalues[10].trim();
                    if(inputvalues[11]  !=  null && inputvalues[11]  !=  '' )
                        rrw.psa.VG_Address2__c = inputvalues[11].trim();    
                    if(inputvalues[12]  !=  null && inputvalues[12]  !=  '' )
                        rrw.psa.VG_Address3__c = inputvalues[12].trim();    
                    if(inputvalues[13]  !=  null && inputvalues[13]  !=  '' )
                        rrw.psa.VG_Postcode__c = inputvalues[13].trim();                    
                    if(inputvalues[14]  !=  null && inputvalues[14]  !=  '' )
                        rrw.psa.VG_Country__c = inputvalues[14].trim();
                    if(inputvalues[15]  !=  null && inputvalues[15]  !=  '' )
                        rrw.psa.VG_Vehicle_Make__c = inputvalues[15].trim();
                    if(inputvalues[16]  !=  null && inputvalues[16]  !=  '' )
                        rrw.psa.VG_Vehicle_Model__c = inputvalues[16].trim();
                    if(inputvalues[17]  !=  null && inputvalues[17]  !=  '' )
                        rrw.psa.VG_Vehicle_Type__c = inputvalues[17].trim();    
                    if(inputvalues[18]  !=  null && inputvalues[18]  !=  '' )
                        rrw.psa.VG_Registration_Plate__c = inputvalues[18].trim();    
                    if(inputvalues[19]  !=  null && inputvalues[19]  !=  '' )
                        rrw.psa.VG_Sub_broker__c = inputvalues[19].trim();                        
                    if(inputvalues[20]  !=  null && inputvalues[20]  !=  '' )
                        rrw.psa.VG_Coverage__c = inputvalues[20].trim();
                    if(inputvalues[21]  !=  null && inputvalues[21]  !=  '' )
                        rrw.psa.CurrencyISOCode = inputvalues[21].trim();
                    if(inputvalues[22]  !=  null && inputvalues[22]  !=  '' )
                        rrw.psa.VG_Sum_Insured__c = Decimal.valueOf(inputvalues[22].trim());
                    if(inputvalues[23]  !=  null && inputvalues[23]  !=  '' )
                        rrw.psa.VG_Deductible__c = Decimal.valueOf(inputvalues[23].trim());
                    if(inputvalues[24]  !=  null && inputvalues[24]  !=  '' )
                        rrw.psa.VG_Gross_Written_Premium__c = Decimal.valueOf(inputvalues[24].trim());
                    if(inputvalues[25]  !=  null && inputvalues[25]  !=  '' )
                        rrw.psa.VG_Brokerage__c = Decimal.valueOf(inputvalues[25].trim());
                    if(inputvalues[26]  !=  null && inputvalues[26]  !=  '' )
                        rrw.psa.VG_Tax_on_Premium__c = Decimal.valueOf(inputvalues[26].trim());
                    if(inputvalues[27]  !=  null && inputvalues[27]  !=  '' )
                        rrw.psa.VG_CH_Commission__c = Decimal.valueOf(inputvalues[27].trim());
                    if(inputvalues[28]  !=  null && inputvalues[28]  !=  '' )
                        rrw.psa.VG_Payment_Terms__c = inputvalues[28].trim();
                    if(inputvalues[29]  !=  null && inputvalues[29]  !=  '' )
                        rrw.psa.VG_Payment_Ref__c = inputvalues[29].trim();
                    rrw.counter = i-1;
                    rrwList.add(rrw);
                    System.debug('RRWLIst::'+rrwList.size());
                }
            }
            DMLAlert = True;
            System.debug('RRWLIst::'+rrwList);
        }catch(Exception e){       
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  'Error ::'+e));
            return null;
        }
        return new PageReference('/apex/VG_Revise_Gentium_Edit6');
    }
    public PageReference gotostep7(){
        sumGWP = sumBrokerage = sumTP = sumCC = 0;
        for(RRWrapper rrw : rrwList){
            if(rrw.psa.VG_Gross_Written_Premium__c  !=   null)
                sumGWP = rrw.psa.VG_Gross_Written_Premium__c+sumGWP;
            if(rrw.psa.VG_Brokerage__c  !=   null)
                sumBrokerage = rrw.psa.VG_Brokerage__c+sumBrokerage;
            if(rrw.psa.VG_Tax_on_Premium__c  !=   null)
                sumTP = rrw.psa.VG_Tax_on_Premium__c+sumTP;
            if(rrw.psa.VG_CH_Commission__c  !=   null)
                sumCC = rrw.psa.VG_CH_Commission__c+sumCC;
        }
        //GWP = sumGWP - sumTP - sumBrokerage ;
        CCAmount =  sumCC;
        if(CCAmount  !=   0 && sumGWP  !=   0){
            CCPrecent  =  CCAmount / sumGWP;
        }
        return new PageReference('/apex/VG_Revise_Gentium_Edit7');
    }
    public PageReference finish(){
        List<VG_Policy_Schedule_Asset__c> assetsToBeInserted  =  new List<VG_Policy_Schedule_Asset__c>();
        List<VG_Policy_Schedule_Asset__c> assetsToBeUpdated  =  new List<VG_Policy_Schedule_Asset__c>();
        ps.id = psid;
        ps.Gross_Written_Premium__c  =  sumGWP ;
        ps.VG_Gross_Written_Premium_100__c = sumGWP ;
        ps.VG_Is_MTA__c  =  False;
        ps.Base_Creation_Start_Date__c  =  ps.Policy__r.VG_Inception_Date__c;
        ps.Base_Creation_End_Date__c  =  ps.Policy__r.VG_Expiry_Date__c;
        ps.VG_Brokerage_Percent__c  =  BrokeragePrecent;
        ps.Actual_GWP__c = actualPremium;
        ps.VG_Brokerage_Amount__c = brokerageAmount;
        ps.VG_Technical_Model_Premium__c = TechnicalModelPremium;
        ps.IPT__c = IPTAmount;
        ps.VG_Rate_Change__c  =  RateChange;
        ps.IPT_Percent__c  =  IPTPrecent;
        ps.Levies__c  =  Levies;
        ps.VG_Fee_Income__c  =  FeeIncome;
        if(MTAType  !=   'Revision of Cover')
            Update ps;
        Integer psacount = 1;
        for(RRWrapper rrw : rrwList){
            rrw.psa.Name  =  ps.Name + '/RR/' + psacount;
            rrw.psa.CurrencyIsoCode = policy.CurrencyIsoCode;
            rrw.psa.VG_Policy_Schedule__c = ps.id;    
            if(rrw.psa.id ==  null)       
                assetsToBeInserted.add(rrw.psa);
            else
                assetsToBeUpdated .add(rrw.psa);
            psacount++;
        }
        if(MTAType  !=   'Revision of Cover'){
            if(!assetsToBeInserted.IsEmpty()){
                Insert assetsToBeInserted;
                if(!psaList.IsEmpty()){
                    delete psaList;
                }
            }else{
                if(!assetsToBeUpdated .IsEmpty())
                    Update assetsToBeUpdated ;
            }
            return new PageReference('/'+ps.id);
        }else{
            List<Policy_Schedule__c> psList = new List<Policy_Schedule__c>([select id, Name, Policy__r.Name from Policy_Schedule__c where Policy__c = :ps.Policy__c]);
            Policy_Schedule__c rocps = new Policy_Schedule__c();
            rocps = ps;
            rocps.VG_Is_MTA__c = true;
            rocps.VG_Base_Policy__c = true;
            rocps.VG_MTA_Type__c = 'Revision of Cover';
            rocps.Product__c = 'Schemes';
            rocps.id = null;
            rocps.Gross_Written_Premium__c  =  sumGWP ;
            rocps.VG_Gross_Written_Premium_100__c = sumGWP ;
            rocps.VG_Brokerage_Percent__c  =  BrokeragePrecent;
            rocps.Actual_GWP__c = actualPremium;
            rocps.VG_Brokerage_Amount__c = brokerageAmount;
            rocps.VG_MTA_Start_Date__c = Date.valueOf(MTAStartDate);
            rocps.VG_MTA_End_Date__c = ps.Policy__r.VG_Expiry_Date__c;
            rocps.Base_Creation_Start_Date__c = rocps.VG_MTA_Start_Date__c;
            rocps.Base_Creation_End_Date__c = rocps.VG_MTA_End_Date__c;
            rocps.IPT__c = null;
            rocps.IPT_Percent__c = null;
            rocps.MTA_Parent_Policy_Schedule__c = psid;           
            integer tmp;
            String[] tempDetail;
            if(psList.size()>0){
                List<Integer> nums = new List<Integer>();
                for(Policy_Schedule__c ps : psList){
                    If(ps.Name.contains('/PS/')) 
                        tempDetail = ps.Name.split('/PS/');
                    else If(ps.Name.contains('/MTA/'))
                        tempDetail = ps.Name.split('/MTA/');
                    tmp = Integer.valueOf(tempDetail[1]);
                    nums.add(tmp);
                }
                nums.sort();
                System.debug('max::'+nums[0]+'::'+nums[nums.size()-1]);
                rocps.Name = ps.Policy__r.Name+'/PS/'+(nums[nums.size()-1]+1);
            }
            Insert rocps;
            List<Policy_Schedule__c> TriggerNew  =  new List<Policy_Schedule__c>();
            TriggerNew.add(rocps);
            PolicyScheduleTriggerFunction.allowInsertRI  =  True;
            PolicyScheduleTriggerFunction.createRIRecords(TriggerNew);
            List<VG_Policy_Schedule_Asset__c> rocpsa =  new List<VG_Policy_Schedule_Asset__c>();
            rocpsa.addAll(assetsToBeInserted);
            Integer psacounter = 1;
            if(!rocpsa.IsEmpty()){
                for(VG_Policy_Schedule_Asset__c  psa : rocpsa){
                    psa.id = null;
                    psa.VG_Policy_Schedule__c = rocps.id;
                    psa.Name = rocps.Name+'/RR/'+psacounter;
                    psacounter++;                   
                }
                Insert rocpsa;
            }     
            return new PageReference('/'+rocps.Id);
        }
    }
    Public Class RRWrapper{
        public VG_Policy_Schedule_Asset__c psa{get;set;}
        public Integer counter{get;set;}
        public RRWrapper(){
            psa = new VG_Policy_Schedule_Asset__c();
            counter = 0;
        }
    }
}