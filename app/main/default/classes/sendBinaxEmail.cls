global class sendBinaxEmail implements Database.Batchable < sObject >
{
    public String theId ='';
    public String query = 'Select Id,EmailToSendTo__c,Lab_Result__c from TestingSlot__c where Id =:theId';
    /* Start Method */
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext info, List < TestingSlot__c> theTests)
    {
   
      
      
        for (TestingSlot__c theTest : theTests)
        {
            sendIndividualEmails.sendLabResultsBINAX(theTest);
        }
        
        
    }
    public void finish(Database.BatchableContext info) { 
    
    
    }

}