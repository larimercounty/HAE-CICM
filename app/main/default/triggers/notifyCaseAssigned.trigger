trigger notifyCaseAssigned on HAE_Case__c (after update) {
    
    for (HAE_Case__c newRec : trigger.new) 
    { 
        HAE_Case__c oldRec = trigger.oldMap.get(newRec.Id);  //Get the last value of the field to check if we need to notify someone
        
        
        Boolean notify = false; //The switch for sending a notification
        List <String> emailAddresses = new List <String>();               
            
        system.debug(newRec);
        system.debug(newRec.Case_Status__c);
        system.debug('Old Email: ' + oldRec.Case_Status__c);
        

        //HAE_Case__c info = [select Id, Reported_Date__c, HAE_Case_Id__c, Sample_Collection_Date__c from HAE_Case__c where Id = : HAE_Case__c.Id]; // Pull information about the case
            
        if((newRec.case_status__C != oldRec.case_status__c) && (newRec.interviewer_email__c != null) && (newRec.Case_Status__c == 'Assigned Interviewer')){ //Check to see if there is someone we need to notify
            notify = true;
        }
        
        if(notify == true)   
        {  //If we found someone to contact, the notify switch turns on
        
            
            emailaddresses.add (newRec.interviewer_email__c);
         
            String subject = 'A CICM Case was just assigned to you - See email for details';
            
            
            String body = 'Hello,';
            body += '\n<p/>';
            body += '\n<p/>You have been assigned a CICM case';
            body += '\n<p/>Please call and conduct an interview for the following case';
            body += '\n<p/>';
            body += '\n<p/>Case Details:';                
            body += '\n<p/>CICM Case ID - ' + '(' + newRec.Event_Id__c + ')';
            body += '\n<p/>Case Reported Date - ' + '(' + newRec.Reported_Date__c +')';
            body += '\n<p/>Sample Collection Date - '+ '(' + newRec.Specimen_Collection_Date__c +')';
            body += '\n<p/>System Link: https://larimerhealth.lightning.force.com/';
            body += '\n<p/>';
            body += '\n<p/>If for some reason you are unable to do the initial contact within the next two hours, please contact the Case Contacting Team Lead.'; 
            body += '\n<p/>';               
            body += '\n<p/>' + 'Thank you.';
            
            emailService.sendToEmailList(emailAddresses,'Larimer CICM',body,subject);
            
        }
    
    }
}