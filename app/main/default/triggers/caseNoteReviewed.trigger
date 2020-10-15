trigger caseNoteReviewed on HAE_Case_Activity__c (after update) {
//This trigger is meant to notify the last interviewer on a case that their case note has been reviewed by a team lead

Set<Id> caseHasActivity = new Set<Id>{};
for (HAE_Case_Activity__c newRec : trigger.new) 
    { 
        HAE_Case_Activity__c oldRec = trigger.oldMap.get(newRec.Id);                     //Get the last value of the field to check if we need to notify someone
        if(newRec.Id != null){caseHasActivity.add(newRec.Id);}
        
        Boolean notify = false;                                                          //The switch for sending a notification
        
        List <HAE_Case_Activity__c> theCase = new List <HAE_Case_Activity__c>([SELECT Interviewer_Email__c, CreatedById, Note_Reviewed__c, HAE_Case__r.Case_Status__c, Id FROM HAE_Case_Activity__c WHERE Id IN :caseHasActivity]);

                                   
        List <String > emailAddresses = new List <String>();
        if((newRec.Note_Reviewed__c == true) && (oldRec.Note_Reviewed__c == false)){ notify = true;}
        
            if(notify == true)                                                               //If we found someone to contact, the notify switch turns on
            {  
        
            emailaddresses.add (newRec.Interviewer_Email__c);
         
            String subject = 'A CICM Case note was just cleared - See email for details';

            String body = 'Hello,\n<p/>\n<p/>A Case Note on your interview has been cleared\n<p/>Case Details:\n<p/>CEDRS Case ID# - ' + '(' + newRec.CEDRS_ID__c + ')\n<p/>CICM Case Status - ' + '(' + newRec.Case_Status__c + ')\n<p/>System Link: https://larimerhealth.lightning.force.com/\n<p/>\n<p/>' + 'Thank you.';
            
            emailService.sendToEmailList(emailAddresses,'Larimer CICM',body,subject);
            
            }
    
        }
    }