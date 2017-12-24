@isTest
public class AddPrimaryContactTest {
	@testSetup
    static void createData(){
        List<Account> accountsToBeInserted = new List<Account>();
        for(Integer i = 0; i < 50; i++){
            Account newAcc = new Account(name=string.valueOf(i),BillingState='NY');
            accountsToBeInserted.add(newAcc);
        }
        for(Integer i = 0; i < 50; i++){
            Account newAcc = new Account(name=string.valueOf(i),BillingState='CA');
            accountsToBeInserted.add(newAcc);
        }
        insert accountsToBeInserted;
    }
    
    public static testMethod void checkAddPrimaryContact(){
        Contact c = new contact(lastname='test');
		AddPrimaryContact con = new AddPrimaryContact(c,'CA');
        test.startTest();
        System.enqueueJob(con);
        test.stopTest();
        System.assertEquals(50, [SELECT ID FROM Contact].size());
    }
}