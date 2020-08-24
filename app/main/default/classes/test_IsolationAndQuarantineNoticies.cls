@isTest
private class test_IsolationAndQuarantineNoticies{

    static testMethod void testUpdateInterviewStarted()
    {
        
        HAE_Individual__c Individual = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test', Correspondence_Language__c = 'English', Email_Address__c ='schreujs@co.larimer.co.us');        
        insert Individual;
        
        HAE_Case__c theCase = new HAE_Case__c(Primary_Individual__c = Individual.Id);
        insert theCase;
        
        HAE_Case_Interview__c theInterview = new HAE_Case_Interview__c(HAE_Individual__c = Individual.Id, HAE_Case__c = theCase.Id);
        insert theInterview;

        sendIndividualEmails.sendCorrectLetter(theInterview.Id );
        
        Individual.Correspondence_Language__c = 'Spanish';
        update Individual;
        
        sendIndividualEmails.sendCorrectLetter(theInterview.Id );
        
        theInterview.Current_Symptoms__c = true;
        Update theInterview;
 
        Individual.Correspondence_Language__c = 'English';
        update Individual;
        
        sendIndividualEmails.sendCorrectLetter(theInterview.Id );
        
        Individual.Correspondence_Language__c = 'Spanish';
        update Individual;
        
        sendIndividualEmails.sendCorrectLetter(theInterview.Id );
        
        
        


    }
}