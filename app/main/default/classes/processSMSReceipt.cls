global class processSMSReceipt implements Database.Batchable < sObject >,Database.AllowsCallouts
{

    public String theId = '';
    public String query = 'SELECT Id, TwilioSF__Body__c, TwilioSF__From_Number__c from TwilioSF__Message__c where Id =:theId' ;


    global Database.QueryLocator start(Database.BatchableContext BC) {

        return Database.getQueryLocator(query);
    }


    public void execute(Database.BatchableContext info, List<TwilioSF__Message__c> theMessage)
    {
   

       for ( TwilioSF__Message__c message : theMessage)
       {
           
         String response = message.TwilioSF__Body__c;
         response = response.toUpperCase();
         
         
         if(response == '1' || response == 'YES')
         {
            SMS_Processes.processSms(message.TwilioSF__From_Number__c,'Test Message Response - YES',false);
         }
         if(response == '2' || response == 'NO')
         {
            SMS_Processes.processSms(message.TwilioSF__From_Number__c,'Test Message Response - NO',false);
         }
         if(!(response == '1' || response == 'YES' || response == '2' || response == 'NO'))
         {
            //Do not respond
            //SMS_Processes.processSms(message.TwilioSF__From_Number__c,'Unknown Response',false);
         }
       
       }
       
        
    }
    public void finish(Database.BatchableContext info) { 
    
    }
    
    
    
    
}