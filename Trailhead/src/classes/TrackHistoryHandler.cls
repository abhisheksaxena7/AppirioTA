public with sharing class TrackHistoryHandler 
{
	public static void trackFieldsOnUpdate(List<Contact> newContact, Map<Id, Contact> oldContactMap)
	{
		trackFields(newContact, oldContactMap);
	}

	public static void trackFields(List<Contact> newContact, Map<Id, Contact> oldContactMap)
	{
		List<Contact> contactsWithtrackHistoryValue = new List<Contact>();
		
		Set<Id> contactWithChangedNameorEmail = new Set<Id>();
		for(Contact c : newContact)
		{
			if(c.FirstName != oldContactMap.get(c.Id).FirstName || c.Email != oldContactMap.get(c.Id).Email)
			{
				contactWithChangedNameorEmail.add(c.Id);
			}
		}

		contactsWithtrackHistoryValue = [SELECT FirstName, Email, Track_History__c from Contact WHERE Id IN :contactWithChangedNameorEmail];

		for(Contact c : contactsWithtrackHistoryValue)
		{
			if(c.FirstName != oldContactMap.get(c.Id).FirstName)
			{
				if(c.FirstName != null && oldContactMap.get(c.Id).FirstName != null)
				{
					if(c.Track_History__c != null)
						c.Track_History__c = 'Name value changed from "'+oldContactMap.get(c.Id).FirstName+'" to "'+c.FirstName+'" on '+DateTime.now().format('MMM d,  yyyy')+'\n'+c.Track_History__c;
					else
						c.Track_History__c = 'Name value changed from "'+oldContactMap.get(c.Id).FirstName+'" to "'+c.FirstName+'" on '+DateTime.now().format('MMM d,  yyyy')+'\n';
				}
			}
			if(c.Email != oldContactMap.get(c.Id).Email)
			{
				if(c.Email != null && oldContactMap.get(c.Id).Email != null)
				{
					if(c.Track_History__c != null)
						c.Track_History__c = 'Email value changed from "'+oldContactMap.get(c.Id).Email+'" to "'+c.Email+'" on '+DateTime.now().format('MMM d,  yyyy')+'\n'+c.Track_History__c;
					else
						c.Track_History__c = 'Email value changed from "'+oldContactMap.get(c.Id).Email+'" to "'+c.Email+'" on '+DateTime.now().format('MMM d,  yyyy')+'\n';
				}
			}
            update contactsWithtrackHistoryValue;
		}

	}
}