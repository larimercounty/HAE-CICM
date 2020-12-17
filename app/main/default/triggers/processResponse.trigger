trigger processResponse on TwilioSF__Message__c (after insert) {


    for (TwilioSF__Message__c rec : trigger.new){

       processSMSReceipt processMessage = new processSMSReceipt();
       processMessage.theId = rec.Id;
       ID theBatchJob = Database.executeBatch(processMessage,1);
        
    }

}