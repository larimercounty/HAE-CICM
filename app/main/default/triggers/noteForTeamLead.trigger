trigger noteForTeamLead on HAE_Case_Activity__c (after insert, after update) {
//This trigger is meant to notify the Team Lead if an interviewer has flagged a case note.
    

    for (HAE_Case_Activity__c newRec : trigger.new) 
    { 
        //HAE_Case_Activity__c oldRec = trigger.oldMap.get(newRec.Id);  //Get the last value of the field to check if we need to notify someone

       
        Boolean notify = false; //The switch for sending a notification                      
            
        if((newRec.Team_Lead_FollowUp__c == true) && (newRec.Note_Reviewed__c == false)) { //Check to see if there is someone we need to notify
            notify = true;
        }    
        
        if(notify == true)   
        {  //If we found someone to contact, the notify switch turns on
                    
         
            String subject = 'A CICM Case Note was just flagged for Team Lead Review - See email for details';
            
            
            String body = 'Hello,';
            body += '\n<p/>';
            body += '\n<p/>A CICM Case Note has been flagged for review';
            body += '\n<p/>Please review the note as soon as you are able';
            body += '\n<p/>';
            body += '\n<p/>Case Note Details:';
            body += '\n<p/>Case Note Entered - '+ '(' + newRec.Case_Note__c +')';               
            body += '\n<p/>Case Status - ' + '(' + newRec.Case_Status__c + ')';
            body += '\n<p/>Case ID# - ' + '(' + newRec.Case_ID__c +')';
            body += '\n<p/>System Link: https://larimerhealth.lightning.force.com/';
            body += '\n<p/>';
            //body += '\n<p/>If for some reason you are unable to contact this individual within the next two hours, please contact the Case Contacting Team Lead.'; 
            body += '\n<p/>';               
            body += '\n<p/>' + 'Thank you.';
            
            emailService.sendEmail('Team Lead','Larimer CICM',body,subject);
        }
    
    }
}