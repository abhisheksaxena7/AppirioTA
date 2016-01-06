public with sharing class Util 
{
	Public static Candidate__c createCandidates(Boolean insertCan, Integer i)
	{
		Candidate__c can = new Candidate__c();
		can.First_Name__c = 'Test First Name '+i;
		can.Last_name__c = 'Test Last name '+i;
		can.DOB__c = Date.newInstance(1993,12,2);
		System.debug(can);
		if(insertCan)
		{
			insert can;
		}
		return can;
	} 	

}