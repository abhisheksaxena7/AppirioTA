trigger ClosedOpportunityTrigger on Opportunity (before insert) 
{
	List<Task> t = new List<Task>();
	for(Opportunity o : trigger.new)
	{
		if(o.StageName == 'Closed Won')
		{
			t.add(new Task(Subject = 'Follow Up Test Task', WhatId = o.Id));
		}
	}
	if(t.size()>0)
		insert t;
}