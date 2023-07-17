/**
* Represents test class for NSP_ErrorLogHandler
*/

@isTest(SeeAllData=false)
public class NSP_ErrorLogHandlerTest {
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
        NSP_ErrorLogHandler.logSaveResult('TestClass','TestMethod',result);
        NSP_ErrorLogHandler.logSaveException('TestClass','TestMethod','result');
        Test.stopTest();
        
    }
}