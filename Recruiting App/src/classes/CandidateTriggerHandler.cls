public class CandidateTriggerHandler 
{
    
    public void beforeInsert(List<Candidate__c> newCandidate) 
    {
        calculateAge(newCandidate);
        duplicate(newCandidate);
    }

    public void beforeUpdate(List<Candidate__c> newCandidate, Map<Id, Candidate__c> oldCandidateMap) 
    {
        calculateAge(newCandidate, oldCandidateMap);
        duplicate(newCandidate, oldCandidateMap);
    }
    
    public static void calculateAge(List<Candidate__c> newCandidate) 
    {
        for(Candidate__c can : newCandidate) 
        {
            if(can.DOB__c != null) 
            {
                can.Age__c = math.FLOOR(can.DOB__c.daysBetween(system.today())/365); 
            }
        }    
    }
    
    public static void calculateAge(List<Candidate__c> newCandidate, Map<Id, Candidate__c> oldCandidateMap) 
    {
        for(Candidate__c can : newCandidate) 
        {
            if((can.DOB__c != oldCandidateMap.get(can.Id).DOB__c
              	&& can.DOB__c != null) || (can.DOB__c == oldCandidateMap.get(can.Id).DOB__c && can.Age__c == null && can.DOB__c != null )) 
            {
                can.Age__c = math.FLOOR(can.DOB__c.daysBetween(system.today())/365);
            } 
            else if (can.DOB__c == null) 
            {
                can.DOB__c.addError(Label.DOB_cant_be_null);
            }

        }
    }

    public static void duplicate(List<Candidate__c> newCandidate)
    {
    	for(Candidate__c can : newCandidate) 
    	{
    		try
    		{
                //This approach is wrong because if there are 100 records then 100 query would be fired but if there are 101
                // then our code will break because the governer limit of SOQL queries is 100.
    			Candidate__c rec = [SELECT First_Name__c, Mobile__c, Email__c FROM Candidate__c 
    								WHERE First_Name__c =:can.First_Name__c 
    								AND Mobile__c = :can.Mobile__c 
    								AND Email__c = :can.Email__c];
    			can.addError(Label.Candidate_Exists);
    		}
    		catch(System.QueryException e)
    		{
    			//Unique Candidate do nothing
    		}
    	}
    }

    public static void duplicate(List<Candidate__c> newCandidate, Map<Id, Candidate__c> oldCandidateMap) 
    {
        for(Candidate__c can : newCandidate) 
        {
        	if(can.First_Name__c != oldCandidateMap.get(can.Id).First_Name__c || can.Mobile__c != oldCandidateMap.get(can.Id).Mobile__c || can.Email__c != oldCandidateMap.get(can.Id).Email__c)
        	{
        		try
    			{
    				Candidate__c rec = [SELECT First_Name__c, Mobile__c, Email__c FROM Candidate__c 
    									WHERE First_Name__c =:can.First_Name__c 
    									AND Mobile__c = :can.Mobile__c 
    									AND Email__c = :can.Email__c];
    				can.addError(Label.Candidate_Exists);
    			}
    			catch(System.QueryException e)
    			{
	    			//Unique Candidate do nothing
    			}	
    		}	
		}  
	}	     	
}