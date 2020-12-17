@isTest(SEEALLDATA=TRUE)
private class test_SMSProcesses{

    static testMethod void testSMS()
    {
      Test.setMock(HTTPCalloutMock.class, new WebServiceMockImpl());
      SMS_Processes.processSms('13038345234','Test Message',false);
    }
    
    
    static testMethod void testSMSOrder()
    {
    
    
        sendOrderSMS  theBatch = new sendOrderSMS();        
        theBatch.theId = '';
             
        Test.startTest();        
        System.enqueueJob(theBatch);
        Test.stopTest(); 

    }
}