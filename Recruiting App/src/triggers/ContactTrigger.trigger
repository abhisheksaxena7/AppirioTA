trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) 
{
	ContactTriggerHandler handler = new ContactTriggerHandler();
	
	if(Trigger.isAfter && Trigger.isInsert) 
	{
    	handler.afterInsert(Trigger.new);
    } 
    else if(Trigger.isAfter && Trigger.isUpdate) 
    {
    	handler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
    else if(Trigger.isAfter && Trigger.isDelete)
    {
        handler.afterDelete(Trigger.oldMap);
    }    
}