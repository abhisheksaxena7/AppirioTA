public with sharing class AccountHandler 
{
	public static Account insertNewAccount(String accountName)
	{
		try
		{
		    Account acct = new Account(Name = accountName);
		    insert acct;
		    return acct;
		} 
		catch (DmlException e) 
		{
		    return null;
		}

	}

}