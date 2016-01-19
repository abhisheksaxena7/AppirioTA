public with sharing class AccountCustomController {

	public List<Account> acc{get;set;}

    public AccountCustomController() {
        acc = [SELECT Id, Name, Phone, Rating FROM Account LIMIT 10];

    }
}