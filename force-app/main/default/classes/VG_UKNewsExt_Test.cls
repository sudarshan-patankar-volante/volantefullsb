@IsTest(SeeAllData=False)
public class VG_UKNewsExt_Test {
    public static testmethod void method1(){
        Test.setMock(HttpCalloutMock.class, new FakeWebservices());
        VG_UKNewsExt un=new VG_UKNewsExt();
        VG_UKNewsExt.Articles ua = new VG_UKNewsExt.Articles();
        VG_UKNewsExt.News unw = new VG_UKNewsExt.News();
        VG_UKNewsExt.getNews();
        ua.author='';
        ua.title='';
        ua.description='';
        ua.urlToImage='';
        ua.publishedAt='';
        ua.url='';
    }
}