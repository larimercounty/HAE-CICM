public with sharing class extObtainOrder {

    public extObtainOrder() {

    }
  
    
    public extObtainOrder(ApexPages.StandardController controller) {

    }
  
    public List< HAE_Case_Interview__c > getOrder() {

            String theTk = ApexPages.currentPage().getParameters().get('tk');
            String theId = ApexPages.currentPage().getParameters().get('id');
            
            
            list < HAE_Case_Interview__c > theInterview = new list <HAE_Case_Interview__c>([Select Id,
                                                                                            Iso_Quar_Until__c,
                                                                                            HAE_Individual__r.First_Name__c,
                                                                                            HAE_Individual__r.Last_Name__c,
                                                                                            HAE_Individual__r.Address1__c,
                                                                                            HAE_Individual__r.City__c,
                                                                                            HAE_Individual__r.State__c,
                                                                                            HAE_Individual__r.Zip__c,
                                                                                            LetterSent_Date__c,
                                                                                            Letter_Type_To_Send__c
                                                                                          from HAE_Case_Interview__c WHERE LetterToken__c = :theTk OR Id =:theId]);
            
            if(theInterview.size()>0)
            {
                return theInterview;
            }
            else
            {
                return null;
            }
        }
        
   }