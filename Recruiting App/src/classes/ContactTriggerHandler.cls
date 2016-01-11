public class ContactTriggerHandler 
{
    public void afterInsert(List<Contact> newContact)
    {
        calculateGT(newContact,null);
    }
    public void afterUpdate(List<Contact> newContact, Map<Id, Contact> oldContactMap)
    {
        calculateGT(newContact, oldContactMap);
    }
    
    public void afterDelete(Map<Id, Contact> oldContactMap)
    {
        calculateGT(null,oldContactMap);
    }
   
    public static void calculateGT(List<Contact> newContact, Map<Id, Contact> oldContactMap) 
    {
        Boolean isInsert = (oldContactMap==null?true:false);
        Boolean isDelete = (newContact==null?true:false);

        Set<Id> newContactAccountId = new Set<Id>();
        
        if(!isDelete)
        {
            for(Contact c : newContact)
            {
                if(isInsert || c.Total__c != oldContactMap.get(c.Id).Total__c || c.AccountId != oldContactMap.get(c.Id).AccountId)
                {
                    if(c.AccountId != null)
                    {    newContactAccountId.add(c.AccountId);
                         if(!isInsert && c.AccountId != oldContactMap.get(c.Id).AccountId)
                            newContactAccountId.add(oldContactMap.get(c.Id).AccountId);
                    }

                }        
            }   
        }
        else
        {
            for(Contact c : oldContactMap.values())
            {
                if(c.AccountId != null)
                    newContactAccountId.add(oldContactMap.get(c.Id).AccountId);
            }
        }
        
        List<Account> acc;
        acc = [SELECT Id, Grand_Total__c, (SELECT Total__c FROM Contacts) FROM Account where Id in :newContactAccountId];
         
        for(Integer i = 0; i< acc.size(); i++)
        {
            if(acc[i].Contacts != null)
            {
                acc[i].Grand_Total__c = 0;
                for(Contact c : acc[i].Contacts)
                {
                    acc[i].Grand_Total__c += c.Total__c; 
                }
                System.debug(acc[i].Grand_Total__c);
            }
        }
        update acc;   
    }
}