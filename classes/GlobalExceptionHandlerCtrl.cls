/**************************************************************************************************   
Apex Class Name 	 :  GlobalExceptionHandlerCtrl
Version              :  1.0                                                                          
Created Date         :  Nov 27,2020                                                        
Function             :  This class handles exception message and once exception is thrown, this class will log the message in exception log custom object
Modification Log     :                                                                              
*--------------------------------------------------------------------------------------------------  
* Developer                   Date                   Description                                    
* -------------------------------------------------------------------------------------------------  
* dinesh                  Nov 27,2020             First Iteration
***************************************************************************************************/

public with sharing class GlobalExceptionHandlerCtrl {

    public static void logExceptions(String optional, Exception exceptionObject){
        List <Exception_Log__c> exLog = new List<Exception_Log__c>();
        if(exceptionObject.getTypeName() == 'System.DmlException'){
            Integer numErrors = exceptionObject.getNumDml();
             System.debug('getNumDml=' + numErrors);
                for(Integer i=0;i<numErrors;i++) {
                    String addInfo= 'getDmlFieldNames=' + exceptionObject.getDmlFieldNames(i) + '/n getDmlMessage=' + exceptionObject.getDmlMessage(i);
                    exLog.add( prepareExceptionLog(addInfo,exceptionObject));
                }
       }else{
        exLog.add( prepareExceptionLog(optional,exceptionObject));
       }
        Insert exLog;
    }
    

          /**
     * @methodName - createExceptionLogForSaveResults
     * @params -  records,exceptionMsg,exceptionType,stackTrace,className,methodName           
     * @return Type - void
     * @decription - this method used to create record in exception object if any error occurs during the transation.
     **/
    public static void createExceptionLogForSaveResults( List<Database.SaveResult> resultsList,String exceptionType,String className,String methodName){
        List<Exception_Log__c> exceptionList = new List<Exception_Log__c>();
        for(Database.SaveResult eachsr : resultsList){

          //Identifying the error records and stored in the Map Variable as ErrorMsg Key and record Ids Values 
            if (!eachsr.isSuccess()){
                Database.Error error = eachsr.getErrors().get(0); 
                      Exception_Log__c ex = new Exception_Log__c(); 
                      //error.getFields()
                      ex.Additional_Details__c ='record id' + eachsr.getId();
                      ex.Exception_Message__c = error.getMessage();
                      ex.Exception_Type__c= exceptionType;
                      ex.Apex_Component__c = className;
                      ex.Apex_Method__c = methodName; 
                      exceptionList.add(ex); 
              }
          } 
        if(!exceptionList.isEmpty()){
          insert exceptionList; 
       }
    }  


        public static  Exception_Log__c prepareExceptionLog(String optional, Exception exceptionObject){
            String stackTrace = exceptionObject.getStackTraceString().substringBefore('\n');
            String className = stackTrace.substringAfter('.').substringBefore('.');  
            String methodName = stackTrace.substringBefore(':').substringAfter(className).substringAfter('.');

            Exception_Log__c ex = new Exception_Log__c();
                    ex.Apex_Component__c       = className;
                    ex.Apex_Method__c          = methodName;
                    ex.Exception_Message__c    = exceptionObject.getMessage();
                    ex.Line_Number__c          = exceptionObject.getLineNumber().toString();
                    ex.StackTrace__c          = exceptionObject.getStackTraceString();
                    ex.Exception_Type__c       = exceptionObject.getTypeName();
                    //ex.Running_User__c         = UserInfo.getUserId();
                  if(optional != null){
                    ex.Additional_Details__c      = optional;
                  }       
            return ex;
        
    }

}