global class NotifyOfQIStudentsStaff implements Database.Batchable < sObject >
{

    public String query = 'SELECT Id,ContactEmail__c,ContactName__c from HAE_Location__c where ContactEmail__c != null';


    global Database.QueryLocator start(Database.BatchableContext BC) {

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List < HAE_Location__c > locations) {
        
        for ( HAE_Location__c theLocation : locations)
        {
        
            List<String> EmailIds = new List<String>();
            EmailIds.add(theLocation.ContactEmail__c);
            
            List <HAE_Case_Interview__c> students = new List <HAE_Case_Interview__c>([Select Id,
                                                                                             HAE_Individual__r.Full_Name__c,
                                                                                             Primary_Case_Interview__c,
                                                                                             Current_Symptoms__c,
                                                                                             Isolate_Until__c,
                                                                                             Quarantine_Until__c
                                                                                             FROM
                                                                                             HAE_Case_Interview__c
                                                                                             Where 
                                                                                             ( Isolate_Until__c >= TODAY
                                                                                               OR 
                                                                                               Quarantine_Until__c >= TODAY  
                                                                                             )
                                                                                             AND
                                                                                             (
                                                                                               Employeer_Location__c =:theLocation.Id
                                                                                               OR
                                                                                               Employer_2__c =:theLocation.Id
                                                                                               OR
                                                                                               School_Location__c =:theLocation.Id
                                                                                               OR
                                                                                               School_Location_2__c =:theLocation.Id
                                                                                               OR
                                                                                               School_Location_2__c =:theLocation.Id
                                                                                               OR
                                                                                               Daycare__c =:theLocation.Id
                                                                                             )
                                                                                             ORDER BY HAE_Individual__r.Full_Name__c]);
                                                                                              
            OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Health FollowUp'];
    
            String body ='Hello<br /><br />';
            body += 'Here is the list of individuals<br/><br/>';
            
            for(HAE_Case_Interview__c theCase : students)
            {
                Date theDateToUse;
                String theDay;
                
                IF(theCase.Primary_Case_Interview__c || theCase.Current_Symptoms__c)
                {
                  theDateToUse = theCase.Isolate_Until__c;
                }
                else
                {
                  theDateToUse = theCase.Quarantine_Until__c;
                }
                
                Datetime dt = datetime.newInstance(theDateToUse.year(), theDateToUse.month(),theDateToUse.day());
                theDay = dt.format('MM/dd/YYYY');

                body += theCase.HAE_Individual__r.Full_Name__c + ' until ' +theDay+ '<br />';
            }
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
     
            String addresses;
            email.setSubject( 'Students/Staff Who Should Not Be In School/Work');
            email.setToAddresses( EmailIds  );
            email.setHtmlBody(body);
            email.setOrgWideEmailAddressId(owea.Id);
           
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            
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
            mail.setSubject('Status of Batch Job Notification of Testing' + aJob.Status);
            mail.setPlainTextBody ('The batch job processed ' + aJob.TotalJobItems + ' batches with ' + aJob.NumberOfErrors + ' failures.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                mail
            });
   }
    
    
    
}