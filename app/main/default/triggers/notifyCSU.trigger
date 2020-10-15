trigger notifyCSU on TestingSlot__c (after update) {


 for(TestingSlot__c theTest : trigger.New)
 {
    
       TestingSlot__c priorData = trigger.oldMap.get(theTest.Id);
       
       //Identify that a positive test was received
       if((theTest.Lab_Result__c != priorData.Lab_Result__c) && theTest.CSULab__c == True && (theTest.Lab_Result__c == 'Positive'||theTest.Lab_Result__c == 'Negative'))
       {
       
       
            sendCSUEmail  theBatch = new sendCSUEmail();        
            theBatch.theId = theTest.Id;
            
            ID theBatchJob = Database.executeBatch(theBatch,1);
       
       }
 }
 
}