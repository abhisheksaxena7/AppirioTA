@isTest
public class TestTrackHistory 
{
	@isTest private static void checkTrackHistory()
	{
		List<Contact> testContactData = createContactData(10);
		insert testContactData;
		testContactData[2].FirstName = 'FName';
		testContactData[4].Email = 'Email@Email.com';
		test.startTest();
		update testContactData;
		testContactData = [SELECT FirstName, Email, Track_History__c FROM Contact];
		System.assert(testContactData[2].Track_History__c.contains('Name value changed from "Test First Name 2" to "FName"'));
		System.debug(testContactData[4].Track_History__c);
		System.assert(testContactData[4].Track_History__c.contains('Email value changed from "test4@test.com" to "email@email.com"'));
		testContactData[2].FirstName = 'abhi';
		testContactData[4].Email = 'ab@abab.com';
		update testContactData;
		testContactData = [SELECT FirstName, Email, Track_History__c FROM Contact];
		System.assert(testContactData[2].Track_History__c.contains('Name value changed from "FName" to "abhi"'));
		System.assert(testContactData[4].Track_History__c.contains('Email value changed from "email@email.com" to "ab@abab.com"'));
		test.stopTest();
	}

	public static List<Contact> createContactData(Integer numberOfContacts)
	{
		List<Contact> con = new List<Contact>();
		for(Integer i = 0; i < numberOfContacts; i++)
		{
			con.add(Util.createContacts(false,i));
		}
		return con;
	}
}