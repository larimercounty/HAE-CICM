global class sendCSUEmail implements Database.Batchable < sObject >
{
    public String theId ='';
    public String query = 'Select Id,EmailToSendTo__c,Lab_Result__c, CSULab__c, CSU_Result__c from TestingSlot__c where CSULab__c = true and Id =:theId';
    /* Start Method */
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext info, List < TestingSlot__c> theTests)
    {
   
      
      
        for (TestingSlot__c theTest : theTests)
        {
            sendIndividualEmails.sendLabResultsCSU(theTest);
        }
        
        
    }
    public void finish(Database.BatchableContext info) { 
    
    
    }

}