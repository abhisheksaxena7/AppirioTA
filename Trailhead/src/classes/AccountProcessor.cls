public class AccountProcessor {
    @future
    public static void countContacts(List<ID> accountIds){
        List<Account> accounts = [SELECT ID, Number_of_Contacts__c, (SELECT ID FROM Contacts) FROM Account WHERE ID IN: accountIds];
        Map<Id, Account> accToUpdate = new Map<Id, Account>();
        for(Account acc : accounts){
            acc.Number_of_Contacts__c = acc.Contacts.size();
            accToUpdate.put(acc.id, acc);
        }
        if(accToUpdate.size() > 0){
            update accToUpdate.values();
        }
    }
}