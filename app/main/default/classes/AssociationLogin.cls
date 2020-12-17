global class AssociationLogin 
{

    @InvocableMethod(label='Association Login')
    webservice static void sendPIN(List <String> recId) {
    
    
        List<Testing_Association_User__c> selectedUser = new List<Testing_Association_User__c>([Select Id, Generated_Pin__c, Email__c,  Text_Message_Number__c from Testing_Association_User__c where Id =:recId[0]]);
        
        if(selectedUser.size()>0)
        {
            selectedUser[0].Generated_Pin__c = generatePin();
            update selectedUser;
            sendEmail(selectedUser[0].Generated_Pin__c,selectedUser[0].Email__c);
            if(selectedUser[0].Text_Message_Number__c != null) SMS_Processes.processPIN_Sms(selectedUser[0].Text_Message_Number__c, 'LC Testing PIN: ' + selectedUser[0].Generated_Pin__c);

            
        }
    
    }
    
    
    @future(callout = true)
    private static void SendEmail(String pin, String email) {

            String theBody = 'Here is your pin:';
            
            theBody += ' '+pin;
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[]{};
            toAddresses.add(email);
            mail.setToAddresses(toAddresses);
            mail.setSubject('LOGIN PIN');
            mail.setHtmlBody(theBody);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                mail
            });
   }
    
   private static string generatePin()
   {
       String thePin = '';
       
       Integer randomNumber = Integer.valueof((Math.random() * 100000 + 100000));
       
       return thePin + randomNumber;
   
   }
    
}