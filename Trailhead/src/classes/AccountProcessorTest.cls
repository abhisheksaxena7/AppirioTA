@isTest(SeeAllData=true)
public class AccountProcessorTest {
	static testmethod void testMyFutureMethod() {
        Test.startTest();
        Map<ID, Account> accountsMap = new Map<ID, Account>([SELECT Id, Name FROM Account LIMIT 10]);
        AccountProcessor.countContacts(new List<ID>(accountsMap.keySet()));
        Test.stopTest();
    }
}