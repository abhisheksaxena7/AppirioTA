public with sharing class Util 
{
	Public static Candidate__c createCandidates(Boolean insertCan, Integer i)
	{
		Candidate__c can = new Candidate__c();
		can.First_Name__c = 'Test First Name '+i;
		can.Last_name__c = 'Test Last name '+i;
		can.DOB__c = Date.newInstance(1993,12,2);
		can.Email__c = 'Test'+i+'@mail.com';
		can.Mobile__c = '1234567890';
		System.debug(can);
		if(insertCan)
		{
			insert can;
		}
		return can;
	}

	Public static Contact createContacts(Boolean insertCon, Integer i)
	{
		Contact con = new Contact();
		con.LastName = 'Test Last Name '+i;
		if(insertCon)
		{
			insert con;
		} 
		return con;
	}

}