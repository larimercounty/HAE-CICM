global class duplicateChecker implements Database.Batchable < sObject >
{

    public String status = 'New';
    public String secondStatus = 'Assign';
    public String ct = 'CEDRS';
    public String query = 'SELECT Id, Event_ID__c, Primary_Individual__r.DupCheck__c from HAE_Case__c where (Case_Status__c =: status OR Case_Status__c =: secondStatus) AND (Case_Type__c =: ct OR Case_Type__c = null)' ;



    @InvocableMethod(label='Check For Duplicates')
    webservice static void runProcess(List <String> recId) {
        duplicateChecker  theBatch = new duplicateChecker();       
        ID theBatchJob = Database.executeBatch(theBatch,1);
    }


    global Database.QueryLocator start(Database.BatchableContext BC) {

        return Database.getQueryLocator(query);
    }


    public void execute(Database.BatchableContext info, List<HAE_Case__c> cases)
    {
   
       
       
       
       for ( HAE_Case__c theCaseToCheck : cases)
       {
           
           List<HAE_Case__c> matchedCases = new List<HAE_Case__c>([Select Id, Event_ID__c from HAE_Case__c where Primary_Individual__r.DupCheck__c =:theCaseToCheck.Primary_Individual__r.DupCheck__c AND Id <>: theCaseToCheck.Id]);
               for(HAE_Case__c AMatch : matchedCases)
               {
                   System_Case_Load__c recData = New System_Case_Load__c();
                   recData.JobID__c = info.getJobId();
                   recData.TextLine__c = 'Match Found For: ' + theCaseToCheck.Event_ID__c + ' -- Possible Duplicate Case Is: ' + AMatch.Event_ID__c;
                   recData.Result__c = 'Match Found';
                   insert recData;    
               }
       
       }
       
        
    }
    public void finish(Database.BatchableContext info) { 
    
    
        AsyncApexJob aJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =: info.getJobId()];

        SendEmail(aJob);
        
    }
    
    private void SendEmail(AsyncApexJob aJob) {

            String theBody = 'Total Cases Checked ' + aJob.TotalJobItems + ' with ' + aJob.NumberOfErrors + ' failures.';
            
            List <System_Case_Load__c> data = New List <System_Case_Load__c>([Select Id, JobID__c, TextLine__c, Result__c from System_Case_Load__c where JobID__c =:aJob.Id AND Result__c = 'Match Found' order by createddate]);
            
            AggregateResult[] groupedResults = [Select Count(Id) theSum from System_Case_Load__c Where Result__c = 'Match Found' AND JobID__c =:aJob.Id];
            for (AggregateResult ar : groupedResults)  {     
                theBody += '<br /><br /># of Matches Found: ' + ar.get('theSum') + '<hr />';
            }
           

            theBody += '<table border="1">';
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