/**
* @description  : Class to capture custom exceptions to logs
* @author Utpal Utkalit
* @date 07/20/2021
* Name : NSP_CustomException
*/

public class NSP_CustomException extends Exception {
    public static Id apexExceptionRectypeId = Schema.SObjectType.NSP_Exception_Log__c.getRecordTypeInfosByName().get('Apex Exception').getRecordTypeId();
    
    public static void LogException(Exception e)
       {
           LogException(e,'','');
       }
     public static void LogException(Exception e, String ObjectName)
       {
           LogException(e,'',ObjectName);
       }
    private static void LogException(Exception e,String optionalOtherProcess,String ObjectName)
       {
       
       try
       {
           String stackTrace = e.getStackTraceString().substringBefore('\n');
           String className = stackTrace.substringAfter('.').substringBefore('.');  
           String methodName = stackTrace.substringBefore(':').substringAfter(className).substringAfter('.');
                //Log information in object
                   NSP_Exception_Log__c exc = new NSP_Exception_Log__c();
                   exc.RecordTypeId= apexExceptionRectypeId;
                   exc.NSP_Error_Message__c = e.getMessage() + 'Exception Type: ' +e.getTypeName();
                   exc.NSP_ErrorSource__c=optionalOtherProcess +'Class: '+className+'**Method: '+methodName;
                  // exc.Line_Number__c = e.getLineNumber();
                   exc.NSP_StackTrace__c = e.getStackTraceString();
                   database.insert(exc);            
       }
           finally
           {
       
       }
   
   }
}