public with sharing class NewCaseListController {

	List<Case> newCases{get;set;}
	public NewCaseListController() {
		newCases = getNewCases();
	}

	public List<Case> getNewCases()
	{
		return [SELECT Id, CaseNumber FROM Case WHERE status = 'New'];
	}
}