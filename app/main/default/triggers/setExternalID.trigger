trigger setExternalID on TestingSlot__c (before insert) {

    for(TestingSlot__c theTest : trigger.New)
    {
    
        theTest.Test_ExternalID__c = theTest.TestID__c;
    
    }

}