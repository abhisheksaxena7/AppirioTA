global class DailyLeadProcessor implements Schedulable {
	global void execute(SchedulableContext ctx) {
		list<Lead> leadsToBeUpdated = new list<Lead>();
        for(Lead lead : [SELECT ID, LeadSource FROM Lead WHERE LeadSource = '' LIMIT 200]){
            lead.LeadSource = 'Dreamforce';
            leadsToBeUpdated.add(lead);
        }
        update leadsToBeUpdated;
    }
}