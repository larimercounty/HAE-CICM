trigger notifyReassignedCase on HAE_Individual__c (before update) {
    //This trigger is meant to contact a new assignment when an interviewer needs to pass it to someone else
    
    for (HAE_Individual__c newRec : trigger.new) 
    { 
        HAE_Individual__c oldRec = trigger.oldMap.get(newRec.Id);  //Get the last value of the field to check if we need to notify someone
        
        
        Boolean notify = false; //The switch for sending a notification
        List <String> emailAddresses = new List <String>();                      
            
        if(newRec.Secondary_Interviewer__c != oldRec.Secondary_Interviewer__c){ //Check to see if there is someone we need to notify
            notify = true;
        }    
        
        if(notify == true)   
        {  //If we found someone to contact, the notify switch turns on
        
            
            emailaddresses.add (newRec.Secondary_Email__c);
         
            String subject = 'A CICM Case was just Reassigned to you - See email for details';
            
            
            String body = 'Hello,';
            body += '\n<p/>';
            body += '\n<p/>A CICM Individual has been Reassigned to you';
            body += '\n<p/>Please conduct an interview for the following case';
            body += '\n<p/>';
            body += '\n<p/>Individual Details:';                
            body += '\n<p/>Individual Name - ' + '(' + newRec.Full_Name__c + ')';
            body += '\n<p/>Individual ID# - ' + '(' + newRec.Name +')';
            body += '\n<p/>Individual Age - '+ '(' + newRec.Age__c +')';
            body += '\n<p/>System Link: https://larimerhealth.lightning.force.com/';
            body += '\n<p/>';
            body += '\n<p/>If for some reason you are unable to contact this individual within the next two hours, please contact the Case Contacting Team Lead.'; 
            body += '\n<p/>';               
            body += '\n<p/>' + 'Thank you.';
            
            emailService.sendToEmailList(emailAddresses,'Larimer CICM',body,subject);
            
        }
    
    }
}