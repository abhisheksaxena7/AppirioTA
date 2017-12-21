@isTest
public class LeadProcessorTest {
    @testSetup
    static void createLeads(){
      List<Lead> leads = new List<Lead>();
        Lead lead;
        for(integer i=0; i<200; i++){
            lead = new Lead();
            lead.LastName = 'test'+i;
            lead.Company = 'testCompany'+i;
            lead.LeadSource = 'Open - Not Contacted';
            leads.add(lead);
        }
        insert leads;
    }
    
    static testMethod void testMyBatchClass(){
      test.startTest();
        LeadProcessor myLeadProcessor = new LeadProcessor();
        Id batchId = Database.executeBatch(myLeadProcessor);
        test.stopTest();
        List<Lead> leads = [SELECT ID, LeadSource FROM Lead];
        System.assertEquals('Dreamforce', leads[10].LeadSource);
    }
}