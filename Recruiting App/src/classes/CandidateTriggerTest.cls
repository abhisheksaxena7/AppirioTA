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