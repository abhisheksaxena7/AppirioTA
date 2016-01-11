@isTest
private class TestRestrictContactByName 
{
	@isTest static void checkContact()
	{
		List<Contact> con = new List<Contact>();
		for(Integer i = 0; i < 10; i++)
		{
			con.add(Util.createContacts(false,i));
		}
		con[7].LastName = 'INVALIDNAME';
		test.startTest();
		List<Database.SaveResult> result = Database.insert(con, false);
		for(Integer i=0;i<result.size();i++)
		{
			if (!result.get(i).isSuccess())
			{
				//System.assert(!result.isSuccess());
		        System.assert(result.get(i).getErrors().size() > 0);
		        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',
		                             result.get(i).getErrors()[0].getMessage());
		    }
	    }

        con = [SELECT LastName from Contact];
        con[2].LastName = 'INVALIDNAME';
        List<Database.SaveResult> resultUp = Database.update(con, false);
		for(Integer i=0;i<resultUp.size();i++)
		{
			if (!resultUp.get(i).isSuccess())
			{
				//System.assert(!result.isSuccess());
		        System.assert(resultUp.get(i).getErrors().size() > 0);
		        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',
		                             resultUp.get(i).getErrors()[0].getMessage());
		    }
	    }
        test.stopTest();
	}	
}