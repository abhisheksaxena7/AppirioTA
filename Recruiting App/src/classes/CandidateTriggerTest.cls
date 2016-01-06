@isTest
private class CandidateTriggerTest 
{
	
	static testMethod void testAge() 
	{
		test.startTest();
		insert createData(10);
		List<Candidate__c> result = [SELECT Id, Age__c FROM Candidate__c];
		for(Integer i = 0; i < result.size(); i++)
		{
			System.assertEquals(result[i].Age__c,22);
			result[i].DOB__c = null;
		}
		try
		{
			update result;
		}
		catch(Exception e)
		{
			Boolean expectedExceptionThrown =  e.getMessage().contains(Label.DOB_cant_be_null) ? true : false;
			System.AssertEquals(expectedExceptionThrown, true);
			result = [SELECT Id, Age__c FROM Candidate__c];
			for(Integer i = 0; i < result.size(); i++)
            {
                if(i < 5)
                {
                    result[i].DOB__c =  Date.newInstance(1992,12,2);
                }
                else if(i >= 5 && i < 8)
                {
                    result[i].Age__c = null;
                }
            }
			update result;	
		}
		result = [SELECT Id, Age__c FROM Candidate__c];
		for(Integer i = 0; i < result.size(); i++)
		{
            System.debug('result['+i+'].Age__c = '+result[i].Age__c);
			if(i<5)
			{
				System.assertEquals(result[i].Age__c,23);
			}
			else
				System.assertEquals(result[i].Age__c,22);
		}

		test.stopTest();
	}


	static testMethod void testDuplicateCandidates()
	{
		//List<Candidate__c> can = createData(9);
		/*Candidate__c duplicateCan = new Candidate__c();
		duplicateCan.First_Name__c = 'Test First Name '+0;
		duplicateCan.Last_name__c = 'Test Last name '+0;
		duplicateCan.DOB__c = Date.newInstance(1993,12,2);
		duplicateCan.Email__c = 'Test'+0+'@mail.com';
		duplicateCan.Mobile__c = '1234567890';*/
		//can.add(duplicateCan);
		test.startTest();
		insert createData(10);
		
		try
		{
			insert createData(10);
		}
		catch(Exception e)
		{
			Boolean expectedExceptionThrown =  e.getMessage().contains(Label.Candidate_Exists) ? true : false;
            System.debug(e.getMessage());
			System.AssertEquals(expectedExceptionThrown, true);
		}
		
		Candidate__c recToUpdate = [SELECT Id, First_Name__c,Email__c,Mobile__c 
									FROM Candidate__c 
									WHERE First_Name__c = 'Test First Name 2'];
		recToUpdate.First_Name__c = 'Test First Name '+0;
		recToUpdate.Email__c = 'Test'+0+'@mail.com';
		recToUpdate.Mobile__c = '1234567890';
		try
		{
			update recToUpdate;
		}
		catch(Exception e)
		{
			Boolean expectedExceptionThrown =  e.getMessage().contains(Label.Candidate_Exists) ? true : false;
            System.debug(e.getMessage());
			System.AssertEquals(expectedExceptionThrown, true);
		}
		test.stopTest();
	}

	static List<Candidate__c> createData(Integer j)
	{
		List<Candidate__c> can = new List<Candidate__c>();
		for(Integer i = 0; i < j; i++)
		{
			can.add(Util.createCandidates(false, i));
		}
		return can;
	}
}