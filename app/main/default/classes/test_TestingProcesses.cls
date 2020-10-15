@isTest
private class test_TestingProcesses{

    static testMethod void testReceipt()
    {
        Date today = System.today();
    
        TestingDay__c theDay = new TestingDay__c(Available_Registrations__c = 10, Available_Walk_Ins__c = 10 , Day__c = today, Location__c = 'Fort Collins', Time__c = '09:00 am');
        insert theDay;
        
        TestingRegistration__c theReg = new TestingRegistration__c(First_Name__c = 'Joseph',Last_name__c = 'Schreurs',Zip_Code__c ='80504', Day__c = '10', Month__c = '1', Year__c = 1970, Email_Address__c = 'schreujs@co.larimer.co.us', Phone_Number__c = '3038345234');
        insert theReg;
        
        TestingSlot__c theSlot = new TestingSlot__c(TestingRegistration__c = theReg.Id, TestingDay__c = theDay.Id);      
        insert theSlot;
         
        TestingProcesses.sendEmailNotification(theSlot.Id, theReg.Email_Address__c);
        
        TestingProcesses.sendEmailNotification(theSlot.Id, theReg.Email_Address__c);
        
        sendIndividualEmails.sendLabResults('schreujs@co.larimer.co.us','1');
        
        testingProcessesCSV.generateLabCSV(theDay.Day__c,theDay.Location__c,theReg.Email_Address__c);
        
        theSlot.Lab_Result__c = 'Positive';
        update theSlot;
        
        theSlot.CSU_Result__c = 'Detected';
        theSlot.Lab_Result__c = 'Negative';
        theSlot.CSULab__c = True;
        update theSlot;
        
        

    }
    
    static testMethod void testCSULabBatch()
    {
     
            sendCSUEmail  theBatch = new sendCSUEmail();        
            theBatch.theId = 'ABC';
            
            ID theBatchJob = Database.executeBatch(theBatch,1);

    }
    
    
    
}