Public Class companyDetailController{
    
    @AuraEnabled
    public Static StockDetails getCompanyDetails(String key){
        Http h = new Http();
        Account acc=[select Id,Name,Stock_Code__c from Account where Id=: key];
        System.debug('acc::'+key);
        String url = 'https://financialmodelingprep.com/api/company/profile/'+acc.Stock_Code__c;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        System.debug('Res::'+res.toString()+'::'+res.getBody());
        String result=res.getBody().remove('<pre>{').remove('}<pre>');
        result=result.substringBetween('{', '}');
        result='{'+result+'}';
        System.debug('Res::'+res.toString()+'::'+result);
        StockDetails sd = (StockDetails) JSON.deserialize(result, StockDetails.class);
        sd.image ='https://financialmodelingprep.com/images-New/'+acc.Stock_Code__c+'.png';
        return sd;
    }
    
    
    public Class StockDetails{
        @AuraEnabled
        public String Price{get;set;}
        @AuraEnabled
        public String Beta{get;set;}
        @AuraEnabled
        public String VolAvg{get;set;}
        @AuraEnabled
        public String MktCap{get;set;}
        @AuraEnabled
        public String LastDiv{get;set;}
        @AuraEnabled
        public String Range{get;set;}
        @AuraEnabled
        public String Changes{get;set;}
        @AuraEnabled
        public String ChangesPerc{get;set;}
        @AuraEnabled
        public String companyName{get;set;}
        @AuraEnabled
        public String exchange{get;set;}
        @AuraEnabled
        public String industry{get;set;}
        @AuraEnabled
        public String website{get;set;}
        @AuraEnabled
        public String description{get;set;}
        @AuraEnabled
        public String CEO{get;set;}
        @AuraEnabled
        public String sector{get;set;}
        @AuraEnabled
        public String date_is_filed{get;set;}
        @AuraEnabled
        public String date_bs_filed{get;set;}
        @AuraEnabled
        public String date_cs_filed{get;set;}
        @AuraEnabled
        public String image{get;set;}
    }
}