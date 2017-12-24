@isTest
public class DailyLeadProcessorTest {
    
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

	@testSetup
    static void createLeads(){
    	List<Lead> leads = new List<Lead>();
        Lead lead;
        for(integer i=0; i<200; i++){
            lead = new Lead();
            lead.LastName = 'test'+i;
            lead.Company = 'testCompany'+i;
            leads.add(lead);
        }
        insert leads;
    }
    static testMethod void testMyScheduledClass(){
        test.startTest();
        DailyLeadProcessor myLeadProcessor = new DailyLeadProcessor();
        String jobId = System.schedule('ScheduledApexTest',
                                       CRON_EXP, 
                                       new DailyLeadProcessor()); 
        test.stopTest();
        List<Lead> leads = [SELECT ID, LeadSource FROM Lead];
        System.assertEquals('Dreamforce', leads[10].LeadSource);
    }
}