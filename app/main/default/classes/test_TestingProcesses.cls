<<<<<<< HEAD
@isTest(SEEALLDATA=TRUE)
=======
@isTest
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
private class test_TestingProcesses{

    static testMethod void testReceipt()
    {
        Date today = System.today();
    
        TestingDay__c theDay = new TestingDay__c(Available_Registrations__c = 10, Available_Walk_Ins__c = 10 , Day__c = today, Location__c = 'Fort Collins', Time__c = '09:00 am');
        insert theDay;
        
<<<<<<< HEAD
        TestingRegistration__c theReg = new TestingRegistration__c(First_Name__c = 'Joseph',Last_name__c = 'Schreurs',Language__c = 'English', Zip_Code__c ='80504', Day__c = '10', Month__c = '1', Year__c = 1970, Email_Address__c = 'schreujs@co.larimer.co.us', Phone_Number__c = '3038345234', Address__c = '200 West Oak');
        insert theReg;
        
        TestingSlot__c theSlot = new TestingSlot__c(TestingRegistration__c = theReg.Id, TestingDay__c = theDay.Id, Checked_In__c = true, Test_Type__c = 'BINAX');      
        insert theSlot;
        TestingSlot__c theSlot1 = new TestingSlot__c(TestingRegistration__c = theReg.Id, TestingDay__c = theDay.Id, Checked_In__c = true, Test_Type__c = 'RT-PCR');      
        insert theSlot1;
        TestingSlot__c theSlot2 = new TestingSlot__c(TestingRegistration__c = theReg.Id, TestingDay__c = theDay.Id, Checked_In__c = true);      
        insert theSlot2;
          
=======
        TestingRegistration__c theReg = new TestingRegistration__c(Zip_Code__c ='80504', Day__c = '10', Month__c = '1', Year__c = 1970, Email_Address__c = 'schreujs@co.larimer.co.us', Phone_Number__c = '3038345234');
        insert theReg;
        
        TestingSlot__c theSlot = new TestingSlot__c(TestingRegistration__c = theReg.Id, TestingDay__c = theDay.Id);      
        insert theSlot;
         
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
        TestingProcesses.sendEmailNotification(theSlot.Id, theReg.Email_Address__c);
        
        TestingProcesses.sendEmailNotification(theSlot.Id, theReg.Email_Address__c);
        
        sendIndividualEmails.sendLabResults('schreujs@co.larimer.co.us','1');
        
        testingProcessesCSV.generateLabCSV(theDay.Day__c,theDay.Location__c,theReg.Email_Address__c);
<<<<<<< HEAD
        testingProcessesCSV.generateLabCSV_BINAX(theDay.Day__c,theDay.Location__c,theReg.Email_Address__c);
        
        
        theSlot.Lab_Result__c = 'Positive';
        update theSlot;
        
        theSlot1.CSU_Result__c = 'Detected';
        theSlot1.Lab_Result__c = 'Negative';
        theSlot1.CSULab__c = True;
        update theSlot1;
        
        theSlot2.CSU_Result__c = 'Detected';
        theSlot2.Lab_Result__c = 'Negative';
        theSlot2.CSULab__c = false;
        theSlot2.Test_Type__c = 'BINAX';
        update theSlot2;
        

    }
    
    static testMethod void testCSULabBatch()
    {
     
            sendCSUEmail  theBatch = new sendCSUEmail();        
            theBatch.theId = 'ABC';
            
            ID theBatchJob = Database.executeBatch(theBatch,1);

    }
    
    static testMethod void testExtension()
    {
    
        extAllRegistrations ext = new extAllRegistrations();
        
        ext.getRegistrations();
        
    
    }
    
    static testMethod void testExtensionOrders()
    {
    
        extObtainOrder ext = new extObtainOrder();
        
        ext.getOrder();
        
    
    }
    
    
     static testMethod void testSchoolNotification()
    {
     
     
         String CRON_EXP = '0 0 0 15 3 ? 2022'; 

         String jobId = System.schedule('sendDailySchoolNotices', 
                     CRON_EXP,  
                        new sendDailySchoolNotices()); 
     
            NotifyOfQIStudentsStaff  theBatch = new NotifyOfQIStudentsStaff();        
            theBatch.query = 'SELECT Id,ContactEmail__c,ContactName__c from HAE_Location__c where ContactEmail__c != null LIMIT 1';
            
            ID theBatchJob = Database.executeBatch(theBatch,1);

    }
    
     static testMethod void testDuplicationChecker()
    {
     
     

     
            duplicateChecker  theBatch = new duplicateChecker(); 
            
            String status = 'New';
            String ct = 'CEDRS';
            String query = 'SELECT Id, Event_ID__c, Primary_Individual__r.DupCheck__c from HAE_Case__c where Case_Status__c =: status AND (Case_Type__c =: ct OR Case_Type__c = null) LIMIT 25' ;
       
            theBatch.query = query;
            
            ID theBatchJob = Database.executeBatch(theBatch,50);

    }
    
    static testMethod void testSMSOrder()
    {
    
    
        sendOrderSMS  theBatch = new sendOrderSMS();        
        theBatch.theId = '';
             
        Test.startTest();        
        System.enqueueJob(theBatch);
        Test.stopTest(); 

    }
    
    
=======
        
        

    }
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
}