global class TestingProcesses
{
 

  webservice static void sendEmailNotification(String theRecord, String emailAddress) {
  
        List<String> EmailIds = new List<String>();
        EmailIds.add(EmailAddress);
        
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Testing'];
        List <TestingSlot__c> slots = new List <TestingSlot__c>([Select TestID__c from TestingSlot__c where Id =:theRecord]);
        
        if(slots.size()>0)
        {
        
        
            PageReference theDoc = Page.receipt_Testing;
            theDoc.getParameters().put('Id',theRecord);
            Blob b;
    
             if(Test.isRunningTest()){
                    b = blob.valueOf('Unit.Test');
                }else{
                    b = theDoc.getContentAsPDF();}
                    
            String body ='Hello<br /><br />';
            body += 'This is your follow up email with your registration ticket for COVID Testing<br/><br/>';
            body += '<hr /><a href="https://larimerhealth.secure.force.com/RegisterForTest/cancelTest?tk=' + slots[0].TestID__c+'">Click This Link To Cancel Appointment</a><br />';
            
    
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
     
            Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
            efa1.setFileName('RegistrationTicket.pdf');
            efa1.setBody(b);
     
            String addresses;
            email.setSubject( 'Followup from Larimer County Department of Health and Environment');
            email.setToAddresses( EmailIds  );
            email.setHtmlBody(body);
            email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
            email.setOrgWideEmailAddressId(owea.Id);
           
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
  
  }
  
  }