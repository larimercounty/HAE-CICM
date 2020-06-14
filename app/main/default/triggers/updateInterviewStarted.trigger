trigger updateInterviewStarted on HAE_Case_Interview__c (after insert) {

     
        for (HAE_Case_Interview__c theInterview : Trigger.new) 
        {

          HAE_Case__c caseRec =  [select Id, First_Contact_Attempt__c, Primary_Individual__c from HAE_Case__c where Id = : theInterview.HAE_Case__c];
             
          if(theInterview.HAE_Individual__c == caseRec.Primary_Individual__c)
          {
          
              caseRec.First_Contact_Attempt__c = System.now();
              update caseRec;
              
          }

        }


}