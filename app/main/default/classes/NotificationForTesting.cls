global class NotificationForTesting implements Database.Batchable < sObject >
{

    public String query = 'SELECT Id, sendNotification__c, EmailToSendTo__c from TestingSlot__c where sendNotification__c = true';


    global Database.QueryLocator start(Database.BatchableContext BC) {

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List < TestingSlot__c > timeSlot) {
        
        for ( TestingSlot__c theSlot : timeSlot)
        {
        
        
            List<String> EmailIds = new List<String>();
            EmailIds.add(theSlot.EmailToSendTo__c);
            
            OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Health FollowUp'];
    
            PageReference theDoc = Page.receipt_Testing;
            theDoc.getParameters().put('Id',theSlot.Id);
            Blob b;
    
             if(Test.isRunningTest()){
                    b = blob.valueOf('Unit.Test');
                }else{
                    b = theDoc.getContentAsPDF();}
                    
            String body ='Hello<br /><br />';
            body += 'This is a reminder of your testing appointment for tomorrow, please see the attachement for more information<br/><br/>';
           
    
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
     
            Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
            efa1.setFileName('testingAppointment.pdf');
            efa1.setBody(b);
     
            String addresses;
            email.setSubject( 'Testing Followup from Larimer County Department of Health and Environment');
            email.setToAddresses( EmailIds  );
            email.setHtmlBody(body);
            email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
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