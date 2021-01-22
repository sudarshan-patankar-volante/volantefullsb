@IsTest
global class FakeWebservices implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{\"status\":\"ok\",\"totalResults\":10,\"articles\":[{\"author\":\"Will Martin\",\"title\":\"Ethereum price jumps again as it approaches a new all-time high\",\"description\":\"Digital currency ethereum gains more than 7% to...\",\"url\":\"http://uk.businessinsider.com/ethereum-price-approaches-a-fresh-all-time-high-on-january-8-2018-1\",\"urlToImage\":\"http://static3.uk.businessinsider.com/image/5a547d51718d3625008b472f-1190-625/ethereum-price-jumps-again-as-it-approaches-a-new-all-time-high.jpg\",\"publishedAt\":\"2018-01-09T08:44:18Z\"}]}');
        res.setStatusCode(200);
        return res;
    }
}