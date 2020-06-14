@isTest
private class test_InterviewProcesses{

    static testMethod void testUpdateInterviewStarted()
    {
        
        HAE_Individual__c Individual = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test');        
        insert Individual;
        
        HAE_Case__c theCase = new HAE_Case__c(Primary_Individual__c = Individual.Id);
        insert theCase;
        
        HAE_Case_Interview__c theInterview = new HAE_Case_Interview__c(HAE_Individual__c = Individual.Id, HAE_Case__c = theCase.Id);
        insert theInterview;

    }
}