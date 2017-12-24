public class AddPrimaryContact implements Queueable{

    Contact contact;
    String stateAbbr;
    
    public AddPrimaryContact(Contact contact, String stateAbbr){
    	this.contact = contact;
        this.stateAbbr = stateAbbr;
    }
    public void execute(QueueableContext context){
        List<Contact> insertContacts = new List<Contact>();
        for(Account account : [SELECT ID, BillingState FROM Account WHERE BillingState =: this.stateAbbr LIMIT 200]){
            Contact newContact = new Contact();
            newContact = this.contact.clone(false, false, false, false);
            newContact.AccountId = account.ID;
            insertContacts.add(newContact);
        }
        insert insertContacts;
    }
}