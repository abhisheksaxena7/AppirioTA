@isTest(SeeAllData=true)
public class AccountManagerTest {
    @IsTest
    public static void testaccountmanager() {
        RestRequest request = new RestRequest();
        Contact c = [SELECT ID, accountId FROM Contact WHERE accountID != '' LIMIT 1][0];
        request.requestUri = 'https://mannharleen-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+c.accountID+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
		system.debug('test account result = '+ AccountManager.getAccount());


        
    }
    

}