Public Class ErrorTrace{
    
    public static string insertLog(Exception e,String RecordID){
        Error_Log__c error = new Error_Log__c();
        error.Name = e.getTypeName();
        error.Error__c = e.getMessage();
        error.Error_Occurred__c = System.Now();
        error.Stack_Trace__c = e.getStackTraceString();
        error.User__c = UserInfo.getUserId();
        error.VG_Record_ID__c = RecordID;
        Insert error;
        return error.id;
        
    }
}