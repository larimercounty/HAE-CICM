global class caseManagementProcesses
{

@InvocableMethod(label='Skip Case Processing And Email Letter')
webservice static void skipCaseProcessing(List <String> recId) {
   
        String theRecord = recId[0];
    
        List< HAE_Case__c > selectedCase = new List< HAE_Case__c >([Select Id, Order_Sent_By__c ,Primary_Individual__c, Primary_Individual__r.Id from HAE_Case__c where Id=:theRecord]); 
        List< HAE_Individual__c > thePerson = new List <HAE_Individual__c> ([Select Id,Email_Address__c,Individual_Phone__c from HAE_Individual__c where Id =: selectedCase[0].Primary_Individual__r.Id]);
        List< HAE_Case_Interview__c > existingInterview = new List <HAE_Case_Interview__c> ([Select Id,HAE_Individual__r.Id from HAE_Case_Interview__c where HAE_Case__c =:theRecord AND HAE_Individual__c =: thePerson[0].Id]);
        HAE_Case_Interview__c newInterview = new HAE_Case_Interview__c();
        

        
        if(existingInterview.size() > 0)
        {
       
            existingInterview[0].Interview_Status__C = 'Not Needed';
            existingInterview[0].Interview_Not_Needed_Status__c = 'Electronically Contacted';
            existingInterview[0].Primary_Case_Interview__c =  true;
            existingInterview[0].Completed_Date__c = System.Today();
            update existingInterview;
            
            
            
            if(thePerson[0].Email_Address__c!=null)
            {
                sendContactQuarantineEmail  theBatch = new sendContactQuarantineEmail();        
                theBatch.theId = existingInterview[0].Id;
                ID theBatchJob = Database.executeBatch(theBatch,1);
                

                existingInterview[0].LetterSent__c = true;
                existingInterview[0].LetterSent_Date__c = System.now();
                existingInterview[0].LetterSent_Type__c = 'Isolation Letter';
                update existingInterview;
                
                selectedCase[0].Order_Sent_By__c = 'Email';
                
            }
            else if (thePerson[0].Individual_Phone__c!=null)
            {
                sendOrderSMS  theBatch = new sendOrderSMS();        
                theBatch.theId = existingInterview[0].Id;
                System.enqueueJob(theBatch);
                //ID theBatchJob = Database.executeBatch(theBatch,1);
                

                existingInterview[0].LetterSent__c = true;
                existingInterview[0].LetterSent_Date__c = System.now();
                existingInterview[0].LetterSent_Type__c = 'Isolation Letter';
                update existingInterview;
                
                selectedCase[0].Order_Sent_By__c = 'Text Message';
            
            }
        }
        else
        {
            newInterview.HAE_Case__c = selectedCase[0].Id;
            newInterview.HAE_Individual__c = thePerson[0].Id;
            newInterview.Primary_Case_Interview__c =  true;
            newInterview.Interview_Status__C = 'Not Needed';
            newInterview.Interview_Not_Needed_Status__c = 'Electronically Contacted';
            newInterview.Completed_Date__c = System.Today(); 
            insert newInterview;
    
            
            if(thePerson[0].Email_Address__c!=null || thePerson[0].Individual_Phone__c!=null)
            {
                sendContactQuarantineEmail  theBatch = new sendContactQuarantineEmail();        
                theBatch.theId = newInterview.Id;
                
                ID theBatchJob = Database.executeBatch(theBatch,1);
                
                newInterview.LetterSent__c = true;
                newInterview.LetterSent_Date__c = System.now();
                newInterview.LetterSent_Type__c = 'Isolation Letter';
                update newInterview;
                
                selectedCase[0].Order_Sent_By__c = 'Email';
            }
            else if(thePerson[0].Individual_Phone__c!=null)
            {
            
                sendOrderSMS  theBatch = new sendOrderSMS();        
                theBatch.theId = newInterview.Id;
                
                System.enqueueJob(theBatch);
                //ID theBatchJob = Database.executeBatch(theBatch,1);
                
                newInterview.LetterSent__c = true;
                newInterview.LetterSent_Date__c = System.now();
                newInterview.LetterSent_Type__c = 'Isolation Letter';
                update newInterview;
                
                selectedCase[0].Order_Sent_By__c = 'Text Message';
            
            }

        }
        
        selectedCase[0].Case_Status__c = 'Interview Not Needed';
        update selectedCase;

   }

}