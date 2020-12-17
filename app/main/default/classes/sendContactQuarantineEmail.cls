global class sendContactQuarantineEmail implements Database.Batchable < sObject >
{
    public String theId ='';
    public String query = 'Select Id,HAE_Individual__r.Id,LetterToken__c from HAE_Case_Interview__c where Id =:theId';
    /* Start Method */
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext info, List < HAE_Case_Interview__c > theInterviews)
    {
   
      
      
        for (HAE_Case_Interview__c theInterview : theInterviews)
        {
            List< HAE_Individual__c > thePerson = new List <HAE_Individual__c> ([Select Id,Email_Address__c,Individual_Phone__c from HAE_Individual__c where Id =: theInterview.HAE_Individual__r.Id]);
       
            if(thePerson[0].Email_Address__c!=null)
            {
                sendIndividualEmails.sendCorrectLetter(theInterview.Id);
            }
            else if (thePerson[0].Individual_Phone__c!=null)
            {
                String message = 'Your covid isolation order is avaiable here: https://larimerhealth.secure.force.com/viewOrder?tk='+theInterview.LetterToken__c;
                SMS_Processes.processSms(thePerson[0].Individual_Phone__c, message,true);
            }
          
        }
        
        
    }
    public void finish(Database.BatchableContext info) { 
    
    
    }

}