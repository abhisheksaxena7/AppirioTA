public class CandidateTriggerHandler 
{
    public void beforeInsert(List<Candidate__c> newCandidate) 
    {
        calculateAge(newCandidate,null);
        duplicate(newCandidate, null);
    }

    public void beforeUpdate(List<Candidate__c> newCandidate, Map<Id, Candidate__c> oldCandidateMap) 
    {
        calculateAge(newCandidate, oldCandidateMap);
        duplicate(newCandidate, oldCandidateMap);
    }
    
    public static void calculateAge(List<Candidate__c> newCandidate, Map<Id, Candidate__c> oldCandidateMap) 
    {
        Boolean isInsert = (oldCandidateMap==null?true:false);
        for(Candidate__c can : newCandidate) 
        {
            if(isInsert || (can.DOB__c != oldCandidateMap.get(can.Id).DOB__c && can.DOB__c != null) 
                        || (can.DOB__c == oldCandidateMap.get(can.Id).DOB__c && can.Age__c == null && can.DOB__c != null )) 
            {
                can.Age__c = math.FLOOR(can.DOB__c.daysBetween(system.today())/365);
            } 
            else if (can.DOB__c == null) 
            {
                can.DOB__c.addError(Label.DOB_cant_be_null);
            }

        }
    }

    public static void duplicate(List<Candidate__c> newCandidate, Map<Id, Candidate__c> oldCandidateMap)
    {
        Set<String> sName = new Set<String>();
        Set<String> sEmail = new Set<String>();
        Set<String> sMobile = new Set<String>();

        Boolean isInsert = (oldCandidateMap==null?true:false);
    	for(Candidate__c can : newCandidate) 
    	{
            if(isInsert || (can.First_Name__c != oldCandidateMap.get(can.Id).First_Name__c 
                        || can.Mobile__c != oldCandidateMap.get(can.Id).Mobile__c 
                        || can.Email__c != oldCandidateMap.get(can.Id).Email__c) )
            {
        		sName.add(can.First_Name__c);
                sEmail.add(can.Email__c);
                sMobile.add(can.Mobile__c);
            }
    	}

        List<Candidate__c> recordList = [SELECT First_Name__c, Mobile__c, Email__c FROM Candidate__c 
                                        WHERE First_Name__c IN :sName 
                                        AND Mobile__c IN :sMobile 
                                        AND Email__c IN :sEmail];

        Set<String> setA = new Set<String>();
        for(Candidate__c can : recordList)
        {
            setA.add(can.First_Name__c+'*'+can.Email__c+'*'+can.Mobile__c);
        }

        for(Candidate__c can : newCandidate)
        {
            if(setA.contains(can.First_Name__c+'*'+can.Email__c+'*'+can.Mobile__c))
            {
                can.addError(Label.Candidate_Exists);
            }
            else
            {
                setA.add(can.First_Name__c+'*'+can.Email__c+'*'+can.Mobile__c);
            }
        }
    }
}