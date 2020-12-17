global class sendOrderSMS implements Queueable
{
    public String theId ='';
    public String query = 'Select Id,HAE_Individual__r.Id,HAE_Individual__r.Individual_Phone__c,LetterToken__c from HAE_Case_Interview__c where Id =:theId';
    /* Start Method */

    public void execute(QueueableContext context)
    {
        
        list<HAE_Case_Interview__c> theInterviews = new list<HAE_Case_Interview__c>([Select Id,HAE_Individual__r.Id,HAE_Individual__r.Individual_Phone__c,LetterToken__c from HAE_Case_Interview__c where Id =:theId]);
        Organization org = [SELECT IsSandbox, TrialExpirationDate FROM Organization];
        
        for (HAE_Case_Interview__c theInterview : theInterviews)
        {
                 String message;
                 
             
                if(!org.isSandbox)  message = 'Your covid isolation order is available here: https://larimerhealth.secure.force.com/viewOrder?tk='+theInterview.LetterToken__c;
                if(org.isSandbox) message = 'Your covid isolation order is available here: http://training-larimerhealth.cs197.force.com/viewOrder?tk='+theInterview.LetterToken__c;
                
                SMS_Processes.processPIN_Sms(theInterview.HAE_Individual__r.Individual_Phone__c, message);

        }
        
    }

}