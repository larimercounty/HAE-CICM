trigger setExternalID on TestingSlot__c (after insert) {

    for(TestingSlot__c theTest : trigger.New)
    {
    
        TestingSlot__c setExternalID = [select Id, Test_ExternalID__c, Test_Type__c from TestingSlot__c where Id =: theTest.Id];
        setExternalID.Test_ExternalID__c = theTest.TestID__c;
        
        if(theTest.TestingDay__r.Testing_Type__c != 'BOTH') setExternalID.Test_Type__c = theTest.TestingDay__r.Testing_Type__c;
        
        update setExternalID;
    }

}