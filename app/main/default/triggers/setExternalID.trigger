trigger setExternalID on TestingSlot__c (after insert) {

    for(TestingSlot__c theTest : trigger.New)
    {
    
        TestingSlot__c setExternalID = [select Id, Test_ExternalID__c from TestingSlot__c where Id =: theTest.Id];
        setExternalID.Test_ExternalID__c = theTest.TestID__c;
        update setExternalID;
    }

}