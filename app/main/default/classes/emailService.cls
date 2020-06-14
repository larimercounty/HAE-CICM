global class emailService {
  //webservice static Boolean runningInASandbox() {
    //return [SELECT Id, IsSandbox FROM Organization LIMIT 1].IsSandbox;
  //}
    

  webservice static String sendEmail(String emailGroup, String mailFrom, String body, String subject) {
    
    String returnMessage ='';
    
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

    mail.setSenderDisplayName(mailFrom);

    mail.setSubject(subject);

    List < String > sendTo = new List < String > ();

    List<Email_Group__c> receivers = [select Id, Email_Receiver__r.Email, Notification_Type__c from Email_Group__c where Notification_Type__c =:emailGroup];
    List<Email_Group__c> adminList = [select Id, Email_Receiver__r.Email, Notification_Type__c from Email_Group__c where Notification_Type__c = 'CICM Developer'];

    if (receivers.size() > 0) 
    {
        for (Email_Group__c aReceiver : receivers) {
            sendTo.add(aReceiver.Email_Receiver__r.Email);
        }
    }
    else
    {
        for (Email_Group__c Admins : adminList) {
            sendTo.add(Admins.Email_Receiver__r.Email);
        }
    }

    mail.setToAddresses(sendTo);

    mail.setHtmlBody(body);

    mails.add(mail);

    Messaging.sendEmail(mails);
                
    return returnMessage;        
          
  }
  
   webservice static String sendToEmailList(List <String> emailList, String mailFrom, String body, String subject) {
    
    List<Email_Group__c> adminList = [select Id, Email_Receiver__r.Email, Notification_Type__c from Email_Group__c where Notification_Type__c = 'CICM Developer'];
    String returnMessage ='';
    
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

    mail.setSenderDisplayName(mailFrom);

    mail.setSubject(subject);

    mail.setToAddresses(emailList);

    mail.setHtmlBody(body);

    mails.add(mail);

    Messaging.sendEmail(mails);
                
    return returnMessage;        
          
  }
  
   /*webservice static String sendTolListFromOWEA(List <String> emailList, String oweaDisplayName, String body, String subject) {
   //Uses "Organization-Wide Email Addresses" (see SF Setup). OWEA replaces SenderDisplayName/mailFrom
  
    String returnMessage ='';
    
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

    OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : oweaDisplayName
                                or Id = : oweaDisplayName]; // Id may be passed where Name may change

    mail.setOrgWideEmailAddressId(owea.Id);

    mail.setSubject(subject);

    mail.setToAddresses(emailList);

    mail.setHtmlBody(body);

    mails.add(mail);

    Messaging.sendEmail(mails);
                
    return returnMessage;        
          
  }*/

  webservice static String sendToEmailGroup(String emailGroup, String mailFrom, String body, String subject) {
    // This is a clone of sendEmail. 
    // Recipients are selected by Notification Type using the emailGroup parameter.
    // Recipients with values in Copy Addressee Type will be added to the CC: or BCC: headers instead of To:
  
    String returnMessage ='';
    
    List<Email_Group__c> adminList = [select Id, Email_Receiver__r.Email, Notification_Type__c from Email_Group__c where Notification_Type__c = 'CICM Developer'];
    List<Messaging.SingleEmailMessage> mailsList = new List<Messaging.SingleEmailMessage>();

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

    mail.setSenderDisplayName(mailFrom);

    mail.setSubject(subject);

    List < String > sendToList = new List < String > ();
    List < String > sendCcList = new List < String > ();
    List < String > sendBcList = new List < String > ();

    List<Email_Group__c> receivers = [select Id, Email_Receiver__r.Email, Copied_Addressee_Type__c 
                                        from Email_Group__c where Notification_Type__c =:emailGroup];
    
    List < String > sendTo = new List < String > ();

    if (receivers.size() > 0) 
    {
        for (Email_Group__c aReceiver : receivers) {
            if (aReceiver.Copied_Addressee_Type__c == 'Cc: Carbon Copy') {
                sendCcList.add(aReceiver.Email_Receiver__r.Email);
            }
            else {
                if (aReceiver.Copied_Addressee_Type__c == 'Bc: Blind Copy') {
                    sendBcList.add(aReceiver.Email_Receiver__r.Email);
                }
                else {
                    sendToList.add(aReceiver.Email_Receiver__r.Email);
                }
            }
        }
    }
    else
    {        
            for (Email_Group__c Admins : adminList) {
            sendTo.add(Admins.Email_Receiver__r.Email);
        }
    }

    if (sendToList.size() == 0) {
            for (Email_Group__c Admins : adminList) {
            sendTo.add(Admins .Email_Receiver__r.Email);
        }
        body += '\n\nThere is no primary recipient for this email group.';
    }

    mail.setToAddresses(sendToList);
    mail.setCcAddresses(sendCcList);
    mail.setBccAddresses(sendBcList);

    mail.setHtmlBody(body);

    mailsList.add(mail);

    Messaging.sendEmail(mailsList);
                
    return returnMessage;        
          
  }

}