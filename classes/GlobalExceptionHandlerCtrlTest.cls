/**
* Represents test class for ErrorLogHandler
*/

@isTest(SeeAllData=false)
public class GlobalExceptionHandlerCtrlTest {
    public class My1Exception extends Exception {} 
    /**
* Checks the logSaveResult and LogSaveException
* @param N/A. 
* @return void                          
*/
    @isTest
    static void checkTestMehod() {
        Test.startTest();
        //List to store account objects
        List<Account> accountList = new List<Account>();
        //Iterating over the loop to create 5 accounts
        for(integer itr =0;itr<5;itr++){
            Account accObject = new Account();
          //Not setting any value so that the account insert would fail
            accountList.add(accObject);
        }
        //Using database.save result 
        Database.SaveResult[] result = Database.Insert(accountList, false);
        //exceptionType,String className,String methodName
        GlobalExceptionHandlerCtrl.createExceptionLogForSaveResults( result,'DML','GlobalExceptionHandlerCtrlTest','checkTestMehod');
        GlobalExceptionHandlerCtrl.logSaveException('TestClass',  throw new My1Exception('First exception'));
        Test.stopTest();
        
    }
}
