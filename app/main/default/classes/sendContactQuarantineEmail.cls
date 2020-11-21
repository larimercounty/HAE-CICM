global class sendContactQuarantineEmail implements Database.Batchable < sObject >
{
    public String theId ='';
    public String query = 'Select Id from HAE_Case_Interview__c where Id =:theId';
    /* Start Method */
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext info, List < HAE_Case_Interview__c > theInterviews)
    {
   
      
      
        for (HAE_Case_Interview__c theInterview : theInterviews)
        {
            sendIndividualEmails.sendCorrectLetter(theInterview.Id);
        }
        
        
    }
    public void finish(Database.BatchableContext info) { 
    
    
    }

}