trigger TrackHistory on Contact (after update) {

	if(trigger.isAfter && trigger.isUpdate)
	{
		TrackHistoryHandler.trackFieldsOnUpdate(trigger.new, trigger.oldMap);
	}
}