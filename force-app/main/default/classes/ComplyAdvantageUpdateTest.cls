@istest (SeeAllData = True)

Public Class ComplyAdvantageUpdateTest{

    static testMethod void myUnitTest1() {
         RestRequest req = new RestRequest(); 
         RestResponse res = new RestResponse();
         Account acc = [Select Id from Account limit 1];
         req.addHeader('httpMethod', 'POST');
         req.requestUri = '/services/apexrest/updateSearch/';       
         String postData = '{"event":"search_status_updated","data":{"changes":{"before":{"match_status":"potential_match"},"after":{"match_status":"false_positive"}},"ref":"1588778697-NM7D9dEn","client_ref":"'+acc.Id+'","terms":[{"name":"Testing","hits":1}],"filters":{"sources":["canada-osfi-entity-list","canada-osfi-person-list","europe-sanctions-list","hm-treasury-list","ofac-consolidated-list","swiss-seco-list","un-consolidated"],"types":[],"exact_match":false,"fuzziness":0.6},"search_id":315080004}}';
         Test.setMock(HttpCalloutMock.class, new ComplyAdvantageCheckMock()); 
         String JsonMsg=JSON.serialize(postData);
         req.requestBody = Blob.valueof(postData);
         RestContext.request = req; 
         RestContext.response= res;
         Test.startTest();
         complyAdvantageUpdate.doPost();
         Test.stopTest();
   }
   
   static testMethod void myUnitTest2() {
         RestRequest req = new RestRequest(); 
         RestResponse res = new RestResponse();
         Account acc = [Select Id from Account limit 1];
         req.addHeader('httpMethod', 'POST');
         req.requestUri = '/services/apexrest/updateSearch/';       
         String postData = '{"event":"monitored_search_updated", "id":"'+acc.Id+'"}';
         String JsonMsg=JSON.serialize(postData);
         req.requestBody = Blob.valueof(postData);
         RestContext.request = req; 
         RestContext.response= res;
         Test.startTest();
         complyAdvantageUpdate.doPost();
         Test.stopTest();
   }
   
   static testMethod void myUnitTest3() {
         RestRequest req = new RestRequest(); 
         RestResponse res = new RestResponse();
         Account acc = [Select Id from Account limit 1];
         req.addHeader('httpMethod', 'POST');
         req.requestUri = '/services/apexrest/updateSearch/';       
         String postData = '{"event":"other_event", "id":"'+acc.Id+'"}';
         String JsonMsg=JSON.serialize(postData);
         req.requestBody = Blob.valueof(postData);
         RestContext.request = req; 
         RestContext.response= res;
         Test.startTest();
         complyAdvantageUpdate.doPost();
         Test.stopTest();
   }
}