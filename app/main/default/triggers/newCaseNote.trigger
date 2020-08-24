trigger newCaseNote on HAE_Case_Activity__c (after insert) {
    //This trigger is meant to notify an interviewer of a new case note added onto one of their cases
     
    for (HAE_Case_Activity__c newRec : trigger.new){
        List <String> emailAddresses = new List <String>();         //Create custom list of people involved to email
        Boolean notify = false;
        

        List<HAE_Case_Activity__c> hasActivity = [Select HAE_Case__r.Id, HAE_Case__r.CEDRS_Case_Status__c, HAE_Case__r.Interviewer_Email__c, HAE_Case__r.Event_ID__c, HAE_Case__r.HAE_Interview_Team__c FROM HAE_Case_Activity__c WHERE Id =: newRec.id LIMIT 1];  //Make sure I have the appropriate information on the case available
            
        if((newRec.Case_Note__c != null) && (newRec.createdBy.Id != hasActivity[0].HAE_Case__r.HAE_Interview_Team__c)){     //Make sure that there is a case note and that the person entering it is not the interviewer on the case
         notify = true;       
        }

        //request to stop notification of a new case note 7-13-2020
/*
        if(notify == true){
            
                    emailAddresses.add (hasActivity[0].HAE_Case__r.Interviewer_Email__c);
                    
                    system.debug(emailAddresses);

                    String subject = 'A new case note has been added to one of your cases - See email for details';
            
            
                    String body = 'Hello,';
                    body += '\n<p/>';
                    body += '\n<p/>A new case note has been added to one of your cases';
                    body += '\n<p/>Please review the case note as soon as you are able.';
                    body += '\n<p/>';
                    body += '\n<p/>Case Details:';                
                    body += '\n<p/>CEDRS Case ID# - ' + '(' + hasActivity[0].HAE_Case__r.Event_ID__c + ')';
                    body += '\n<p/>CEDRS Case Status - ' + '(' + hasActivity[0].HAE_Case__r.CEDRS_Case_Status__c +')';
                    body += '\n<p/>CICM Case Status - '+ '(' + newRec.Case_Status__c +')';
                    body += '\n<p/>System Link: https://larimerhealth.lightning.force.com/';
                    body += '\n<p/>';
                    body += '\n<p/>Please contact your team lead if there are any questions.'; 
                    body += '\n<p/>';               
                    body += '\n<p/>' + 'Thank you.';
            
                    emailService.sendToEmailList(emailAddresses,'Larimer CICM',body,subject);
                    system.debug(body);
                    system.debug(subject);
                }
      */          

              

            

    }
}