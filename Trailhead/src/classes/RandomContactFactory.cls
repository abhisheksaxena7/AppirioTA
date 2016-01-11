public with sharing class RandomContactFactory 
{
	public static List<Contact> generateRandomContacts(Integer numOfCont, String lName)
	{
		List<Contact> cons = new List<Contact>();
		for(Integer i = 1; i <= numOfCont; i++)
		{
			cons.add(new Contact(FirstName = 'Test '+i, LastName = lName ));
		}
		return cons;
	}
}