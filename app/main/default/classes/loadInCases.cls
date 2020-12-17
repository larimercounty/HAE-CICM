global class loadInCases implements Database.Batchable < String >
{
    public List<String> theList;
    public String theFileToProcess;
    
    public Iterable<String> start(Database.BatchableContext BC)
    {
        try{
        
            return new CSVIterator(theFileToProcess, '\n');
        }
        catch (Exception e)
        {
            return null;
        }
        
    }

    public void execute(Database.BatchableContext info, List<String> strings)
    {
   
       
       // List<String> theCSV = new List<String>();
       // theCSV = csvString.split('\n');
      
        for (String theRow : strings)
        {
           try
           { 
               CICMImportProcesses.loadCaseRecord(theRow, info.getJobId());
           }
           catch(Exception e)
           {
                 System_Case_Load__c recData = New System_Case_Load__c();
                 recData.JobID__c = info.getJobId();
                 recData.TextLine__c = theRow;
                 recData.Result__c = 'Error';
                 insert recData;
           }
        }
        
        
    }
    public void finish(Database.BatchableContext info) { 
    
    
        AsyncApexJob aJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =: info.getJobId()];

        SendEmail(aJob);
        
    }
    
    private void SendEmail(AsyncApexJob aJob) {

            String theBody = 'The batch job processed ' + aJob.TotalJobItems + ' batches with ' + aJob.NumberOfErrors + ' failures.';
            
            List <System_Case_Load__c> data = New List <System_Case_Load__c>([Select Id, JobID__c, TextLine__c, Result__c from System_Case_Load__c where JobID__c =:aJob.Id AND Result__c = 'Error' order by createddate]);
            
            AggregateResult[] groupedResults = [Select Count(Id) theSum from System_Case_Load__c Where (Result__c = 'Duplicate' OR Result__c = 'Success' OR Result__c = 'Matched LC Test Record') AND JobID__c =:aJob.Id];
            for (AggregateResult ar : groupedResults)  {     
                theBody += '<br /><br />Total Records Successfully Processed: ' + ar.get('theSum') + '';
            }
            AggregateResult[] groupedResultsNew = [Select Count(Id) theSum from System_Case_Load__c Where ( Result__c = 'Success') AND JobID__c =:aJob.Id];
            for (AggregateResult ar : groupedResultsNew)  {     
                theBody += '<br />Total New Records Successfully Processed: ' + ar.get('theSum') + '';
            }
            AggregateResult[] groupedResultsDup = [Select Count(Id) theSum from System_Case_Load__c Where (Result__c = 'Duplicate') AND JobID__c =:aJob.Id];
            for (AggregateResult ar : groupedResultsDup)  {     
                theBody += '<br />Total Duplicate Records Successfully Processed: ' + ar.get('theSum') + '';
            }
            AggregateResult[] groupedResultsMatched = [Select Count(Id) theSum from System_Case_Load__c Where (Result__c = 'Matched LC Test Record') AND JobID__c =:aJob.Id];
            for (AggregateResult ar : groupedResultsMatched)  {     
                theBody += '<br />Total Matched Records To LC Tests: ' + ar.get('theSum') + '<br /><br />';
            }

            theBody += '<table>';
            for(System_Case_Load__c theRecord : data)
            {
                theBody += '<tr><td>' + theRecord.TextLine__c + '</td><td> ' + theRecord.Result__c + '</td></tr>';
            }
            theBody += '</table>';
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {
                aJob.CreatedBy.Email
            };
            mail.setToAddresses(toAddresses);
            mail.setSubject('Status of Batch Job Loading Cases ' + aJob.Status);
            mail.setHtmlBody(theBody);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                mail
            });
   }
    
    
    
}