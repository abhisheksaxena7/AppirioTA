@RestResource(urlMapping='/Accounts/*/contacts')
global class AccountManager {
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')-18,
                                                        request.requestURI.lastIndexOf('/'));
        return ([select id, name, (select id, name from contacts) from account where id = :accountId][0]);
    }
    
}