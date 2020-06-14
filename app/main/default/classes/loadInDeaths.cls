global class loadInDeaths implements Database.Batchable < String >
{
    public List<String> theList;
    public String theFileToProcess;
    
    public Iterable<String> start(Database.BatchableContext BC)
    {
        //return theList;
        try{
        
            return new CSVIterator(theFileToProcess, '\n');
        }
        catch (Exception e)
        {
            //addToLog('Exception ...  step: start()' + ' . Error ' + e.getMessage() + ' line# ' + e.getLineNumber());
            return null;
        }
        
    }

    public void execute(Database.BatchableContext info, List<String> strings)
    {
   
       
       // List<String> theCSV = new List<String>();
       // theCSV = csvString.split('\n');
      
        for (String theRow : strings)
        {
           CICMImportProcesses.loadDeathRecord(theRow);
        }
        
        
    }
    public void finish(Database.BatchableContext info) { 
    
    
        AsyncApexJob aJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =: info.getJobId()];

        SendEmail(aJob);
        
    }
    
    private void SendEmail(AsyncApexJob aJob) {


            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {
                aJob.CreatedBy.Email
            };
            mail.setToAddresses(toAddresses);
            mail.setSubject('Status of Batch Job Load Reported Deaths' + aJob.Status);
            mail.setPlainTextBody ('The batch job processed ' + aJob.TotalJobItems + ' batches with ' + aJob.NumberOfErrors + ' failures.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                mail
            });
   }
    
    
    
}