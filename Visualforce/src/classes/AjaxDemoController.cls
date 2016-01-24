public class AjaxDemoController {
	public List<SelectOption> accountList{get;set;}
	public String accountId{get;set;}
	public boolean showDetails{get;set;}
	public String message{get;set;}
	public Account obj{get;set;}
	public Map<String,Account> accountIdtoObjMap = new Map<String,Account>();
	public AjaxDemoController(){
		message ='Initial Message';
		obj = new Account();
		showDetails = false;
		accountList = new List<SelectOption>();
		accountId='';
		accountList.add(new SelectOption('','None'));
		for(Account acc : [Select Name,AccountNumber,Phone,AnnualRevenue from Account LIMIT 10]){
			accountList.add(new SelectOption(acc.Id,acc.Name));
			accountIdtoObjMap.put(acc.Id,acc);
		}
	}
	public void submit(){
		message = 'final message';
		if(validateData()){
			showDetails = false;
		}
		else{
			obj = accountIdtoObjMap.get(accountId);
			showDetails = true;
		}
	}
	public void clearData(){
		showDetails = false;
	}
	public PageReference cancel(){
			 PageReference homePage = new PageReference('/apex/test');  
        	return homePage;
	}
	public boolean validateData(){
		 String errorMsg='';
		 boolean isValidationFailedForInitializeData=false;
		 if(accountId == ''){
		 	errorMsg = 'Please select values from Dropdown';
		 	isValidationFailedForInitializeData = true;
		 	ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, errorMsg);
        	ApexPages.addMessage(myMsg);
		 }
        return isValidationFailedForInitializeData;
	}
}