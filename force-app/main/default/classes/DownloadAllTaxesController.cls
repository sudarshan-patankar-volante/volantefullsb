Public Class DownloadAllTaxesController{

    public ID psId{get;set;}
    
    public String psName{get;set;}
    public String header{get;set;}
    
    public boolean isVFP{get;set;}
    
    public List<VG_Taxes__c> taxList{get;set;}
    
    public DownloadAllTaxesController(){
        
        psId = apexpages.currentpage().getparameters().get('Id');
        isVFP = false;
        taxList = new List<VG_Taxes__c >([select id, Name, VG_Override__c,VG_Tax_Amount_GWP_100__c,VG_Policy_Schedule__r.RecordType.Name, CurrencyIsoCode, VG_Is_Temp_Delete__c, VG_Taxable_Amount__c, VG_Tax_Amount__c, VG_Tax_Paid_By__c, VG_Comment__c, VG_Tax_Percent__c, VG_Tax_Administered_By__c, VG_Policy_Schedule__c, VG_Policy_Schedule__r.Name, VG_Tax_Jurisdiction__c from VG_Taxes__c where VG_Policy_Schedule__c =: psid ]); 
        psName = taxList[0].VG_Policy_Schedule__r.Name;
        if(taxList[0].VG_Policy_Schedule__r.RecordType.Name == 'VFP'){
            header = 'Tax Type,Tax (%),Taxable Amount,Tax Amount,Tax Amount GWP 100%,Tax Jurisdcition,Tax Administered By,Tax Paid By,Comment,Override';
            isVFP = true;
        }else{
            header = 'Tax Type,Tax (%),Taxable Amount,Tax Amount,Tax Jurisdcition,Tax Administered By,Tax Paid By,Comment,Override';
        }
        
    }

}