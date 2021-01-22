@isTest
global class ComplyAdvantageCheckMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"code":200,"status":"success","content":{"data":[{"id":304347122,"ref":"1586437955-wD04oJkn","searcher_id":8918,"assignee_id":8918,"filters":{"country_codes":[],"remove_deceased":0,"types":["sanction"],"exact_match":false,"fuzziness":0.6},"match_status":"no_match","risk_level":"unknown","search_term":"Ckre Ltd","submitted_term":"Ckre Ltd","client_ref":null,"total_hits":0,"updated_at":"2020-04-09 13:12:35","created_at":"2020-04-09 13:12:35","tags":[],"limit":100,"offset":0}]}}');
        response.setStatusCode(200);
        return response;
    }
}