trigger sendLetter on HAE_Case_Interview__c (after update) {

  for (HAE_Case_Interview__c theInterview : Trigger.new) 
  {
        HAE_Case_Interview__c oldRec = trigger.oldMap.get(theInterview.Id);  
        List< HAE_Case_Interview__c > selectedInterview = new List< HAE_Case_Interview__c >([Select Id,LetterSent__c,LetterSent_Date__c  from HAE_Case_Interview__c where Id=:theInterview.Id]);   
        
        if(theInterview.EmailAddress__c!=null && oldRec.Completed_Date__c != theInterview.Completed_Date__c && (theInterview.Interview_Status__C == 'Complete'||theInterview.Interview_Status__C == 'Lost To Follow-Up'))
        {
            sendContactQuarantineEmail  theBatch = new sendContactQuarantineEmail();        
            theBatch.theId = theInterview.Id;
            
            ID theBatchJob = Database.executeBatch(theBatch,1);
            
            selectedInterview[0].LetterSent__c = true;
            selectedInterview[0].LetterSent_Date__c = System.now();
            update selectedInterview;

        }


  }


}