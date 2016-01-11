@isTest
private class TestVerifyDate 
{
	
	@isTest static void checkd() 
	{
		System.assertEquals(VerifyDate.CheckDates(Date.newInstance(2015,1,1), Date.newInstance(2015,2,2)), 
												  Date.newInstance(2015,1,31));

		System.assertEquals(VerifyDate.CheckDates(Date.newInstance(2015,1,1), Date.newInstance(2015,1,5)),
												  Date.newInstance(2015,1,5));
	}
	
}