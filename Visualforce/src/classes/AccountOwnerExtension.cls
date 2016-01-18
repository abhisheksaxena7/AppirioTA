public with sharing class AccountOwnerExtension {

    private List<Account> acc;
    public User u{get;set;}

    // The extension constructor initializes the private member
    // variable acc by using the getRecord method from the standard
    // controller.
    public AccountOwnerExtension(ApexPages.StandardController stdController) {
        //stdController.addFields('Owner');
        this.acc = [SELECT Id, OwnerId FROM Account WHERE Id = : stdController.getRecord().Id];
        if(acc.size() != 0 && acc[0] != null && acc[0].Id != null)
        {
            u =  [SELECT Id, name, phone, email FROM User WHERE Id =: acc[0].OwnerId];
        }
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Can\'t display values of an Account that does not exist'));
        }

    }
}