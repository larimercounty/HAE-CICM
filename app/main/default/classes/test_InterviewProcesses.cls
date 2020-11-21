//@isTest
@isTest(SeeAllData=true)
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
    
    
     static testMethod void testnotifyTeamLeads()
    {
        
        HAE_Individual__c ind = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test');        
        insert ind;
        
        HAE_Case__c theCaseRec = new HAE_Case__c(Primary_Individual__c = Ind.Id);
        insert theCaseRec;
        
        HAE_Case_Interview__c theInt = new HAE_Case_Interview__c(HAE_Individual__c = Ind.Id, HAE_Case__c = theCaseRec.Id, Student__c = true, Online__c = 'Yes');
        insert theInt;  
        
    }
    
    static testMethod void testAllLetters()
    {
        extAllLettersToSend x = new extAllLettersToSend();
        x.getLetters();
    }
    
}