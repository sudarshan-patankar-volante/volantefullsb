@RestResource(urlMapping='/updateSearch/*')
global without sharing class complyAdvantageUpdate{

    global class JSONResult {
        global Map<String,String> nameValuePairs = new Map<String,String>();
    }

    @HttpPost
    global static void doPost()
    {    
        Map<String, String> statusMap = new Map<String, String>();
        statusMap.put('unknown', 'Unknown');
        statusMap.put('no_match', 'No Match');
        statusMap.put('potential_match', 'Potential Match');
        statusMap.put('false_positive', 'False Positive');
        statusMap.put('true_positive', 'True Positive');
        statusMap.put('true_positive_approve', 'True Positive – Approve');
        statusMap.put('true_positive_reject', 'True Positive – Reject');
        System.debug(RestContext.request.requestBody.toString());
        Boolean isAfter = False;
        String fieldValue = null;
        String accountId = null;
        String searchId = null;
        String newStatus = null;
        String eventName = null;
        JSONParser p2 = JSON.createParser(RestContext.request.requestBody.toString());
        while (p2.nextToken() != null) {
            //get email address from request body
            if ((p2.getCurrentToken() == JSONToken.FIELD_NAME)) {
                String fieldName = p2.getText();
                p2.nextToken();
                if(fieldName == 'event') {
                    fieldValue = p2.getText();
                    if(fieldValue != 'search_status_updated' && fieldValue != 'monitored_search_updated'){
                        Break;
                    }else{
                        eventName = fieldValue;
                    }
                }
                if(fieldName == 'id'){
                    searchId = p2.getText();
                }
                if(fieldName == 'after') {
                    isAfter = True;
                }
                if(isAfter && fieldName == 'match_status') {
                    newStatus = p2.getText();
                }
                if(isAfter && fieldName == 'client_ref') {
                    accountId = p2.getText();
                }
            }
        }
        if(eventName == 'search_status_updated'){
            Account acc = [Select Id, Name, Comply_Advantage_Search_Id__c from Account where Id =: accountId];
            String certificateRef = 'https://api.complyadvantage.com/searches/search_id/certificate?api_key='+Label.Comply_Advantage_API_Key;
            String cRef = certificateRef.replace('search_id', acc.Comply_Advantage_Search_Id__c == null? '' : acc.Comply_Advantage_Search_Id__c);
            Http http = new Http();
            HttpRequest req2 = new HttpRequest();
            req2.setMethod('GET'); 
            req2.setTimeout(60000); 
            req2.setCompressed(true); 
            req2.setHeader('Content-Type', 'application/pdf');
            req2.setEndpoint(cRef);
            HTTPResponse res = http.send(req2);  
            system.debug('Response from Server: ' + res.getBody()); 
            Blob body = res.getBodyAsBlob();
            Attachment att = new Attachment();
            att.ParentId = accountId;
            att.body = body;
            att.Name = 'ComplyAdvantage Certificate('+acc.Name+' - '+ statusMap.get(newStatus) +').pdf';
            acc.Comply_Advantage_Match_Status__c = statusMap.get(newStatus);
            Update acc;
            Insert att;
        }else if(eventName == 'monitored_search_updated'){
            List<Account> accountList = [Select Id, Name, Comply_Advantage_Search_Id__c from Account where Comply_Advantage_Search_Id__c =: searchId];
            if(!accountList.IsEmpty()){
                Set<Id> accIds = new Set<Id>();
                accIds.add(accountList[0].Id);
                ComplyAdvantageCheck.check(accIds);
            }
            Note n = new Note();
            n.title = 'CompyAdvantage search';
            n.ParentId = Label.Comply_Advantage_Test_Account;
            n.Body = RestContext.request.requestBody.toString();
            Insert n;
        }else{
            Note n = new Note();
            n.title = 'CompyAdvantage search';
            n.ParentId = Label.Comply_Advantage_Test_Account;
            n.Body = RestContext.request.requestBody.toString();
            Insert n;
        }
    }
}