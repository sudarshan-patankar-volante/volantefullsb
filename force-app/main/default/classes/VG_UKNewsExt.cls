public with sharing class VG_UKNewsExt{
    
    @AuraEnabled
    public Static List<Articles> getNews(){
        List<Articles> articles;
        Http h = new Http();
        string url = 'https://newsapi.org/v2/top-headlines?sources=business-insider-uk&apiKey=8bd84a6efea44019aa0e36f29a6aca70';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        System.debug('Res::'+res.toString());
        String str=res.getBody();
        News data = (News)JSON.deserialize(res.getBody(), News.class);
        System.debug('data::'+data);
        articles=new List<Articles>();
        for(Articles item: data.Articles) {
            articles.add(item);
        }
        return articles;
    }
    public Class Articles{
        //public Source source{get;set;}
        @AuraEnabled
        public String author{get;set;}
        @AuraEnabled
        public String title{get;set;}
        @AuraEnabled
        public String description{get;set;}
        @AuraEnabled
        public String url{get;set;}
        @AuraEnabled
        public String urlToImage{get;set;}
        @AuraEnabled
        public String publishedAt{get;set;}
    }
    public Class News{
        public Articles[] articles{get;set;}
    }
    /*public Class Source{
        public String Id{get;set;}
        public String Name{get;set;}
    }*/
}