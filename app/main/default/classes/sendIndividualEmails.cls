global class sendIndividualEmails {

    webservice static void sendIsolationEmail(String theIndividual ){

        List<String> EmailIds = new List<String>();
        EmailIds.add('schreujs@co.larimer.co.us');
        EmailIds.add('alamont@larimer.org');
        
        HAE_Individual__c thePerson = [Select Id, Full_Name__c from HAE_Individual__c where Id =:theIndividual];
        
        PageReference theDoc = Page.letter_Isolation;
        theDoc.getParameters().put('Id',theIndividual);
        Blob b = theDoc.getContentAsPDF();

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
 
        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName('isolationOrder.pdf');
        efa1.setBody(b);
 
        String addresses;
        email.setSubject( 'Health Department Isolation Order For: ' +thePerson.Full_Name__c);
        email.setToAddresses( EmailIds  );
        email.setPlainTextBody('Attached the isolation order for ' + thePerson.Full_Name__c + '.\nYou are required to follow all of the information in this order'  );
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
}