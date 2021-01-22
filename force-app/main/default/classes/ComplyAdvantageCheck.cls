Public Class ComplyAdvantageCheck{
    
    @future (callout=true)
    public static void check(Set<Id> accountIds) {
        Map<String, String> statusMap = new Map<String, String>();
        String certificateRef = 'https://api.complyadvantage.com/searches/search_id/certificate?api_key='+Label.Comply_Advantage_API_Key;
        statusMap.put('unknown', 'Unknown');
        statusMap.put('no_match', 'No Match');
        statusMap.put('potential_match', 'Potential Match');
        statusMap.put('false_positive', 'False Positive');
        statusMap.put('true_positive', 'True Positive');
        statusMap.put('true_positive_approve', 'True Positive – Approve');
        statusMap.put('true_positive_reject', 'True Positive – Reject');
        Map<Id, Account> accounts = new Map<Id, Account>([Select Id, Name from Account where Id IN: accountIds]);
        List<Attachment> attToBeInserted = new List<Attachment>();
        Map<Id, String> accountCertificateMap = new Map<Id, String>();
        Map<Id, String> accountsCheck = new Map<Id, String>();
        Map<Id, String> accountsCheckRef = new Map<Id, String>();
        Map<Id, String> accoutsCertificates = new Map<Id, String>();
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');     
        req.setEndpoint('https://api.complyadvantage.com/searches?api_key='+Label.Comply_Advantage_API_Key);
        for(Account acc : accounts.values()){
            String jsonBody = '{"search_term": "'+acc.Name+'","client_ref": "'+acc.Id+'","search_profile": "vtx-compliance-profile","fuzziness":'+Decimal.valueOf(Label.Comply_Advantage_Fuzziness)+'}';
            System.debug(jsonBody);
            req.setBody(jsonBody);
            try{
                HTTPResponse res = http.send(req);  
                String body = res.getBody();
                System.debug(body);
                String ref = body.split('"id":')[1].split(',')[0];
                String search_Status = body.split('"match_status":"')[1].split('"')[0];
                accountsCheck.put(acc.Id, search_Status);
                accountsCheckRef.put(acc.Id, ref);
                String cRef = certificateRef.replace('search_id', ref);
                accoutsCertificates.put(acc.Id, cRef);
            }catch(System.CalloutException e){
                //Exception handling goes here..
                system.debug(e);
            }
        }
        HttpRequest req2 = new HttpRequest();
        req2.setMethod('GET'); 
        for(Id accId : accoutsCertificates.keySet()){
            req2.setTimeout(60000); 
            req2.setCompressed(true); 
            req2.setHeader('Content-Type', 'application/pdf');
            req2.setEndpoint(accoutsCertificates.get(accId));
            HTTPResponse res = http.send(req2);  
            system.debug('Response from Server: ' + res.getBody()); 
            Blob body = res.getBodyAsBlob();
            Attachment att = new Attachment();
            att.ParentId = accId;
            att.body = body;
            att.Name = 'ComplyAdvantage Certificate('+accounts.get(accId).Name+' - '+ statusMap.get(accountsCheck.get(accId)) +').pdf';
            attToBeInserted.add(att);
        }
        for(Id accId : accountsCheck.keySet()){
            Account acc = accounts.get(accId);
            acc.Comply_Advantage_Search_Id__c = accountsCheckRef.get(accId);
            if(accountsCheck.get(accId) != null){
                acc.Comply_Advantage_Match_Status__c = statusMap.get(accountsCheck.get(accId));
            }else{
                acc.Comply_Advantage_Match_Status__c = 'Pending';
            }
        }
        Update accounts.values();
        if(!attToBeInserted.IsEmpty()){
            Insert attToBeInserted;
        }
    }
    
}