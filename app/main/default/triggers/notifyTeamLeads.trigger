trigger notifyTeamLeads on HAE_Case_Interview__c (after insert, after update) {
//This trigger notifys the Team Lead when an infectious student attended school.
    
    for(HAE_Case_Interview__c newRec : trigger.new)
    {
        //Probable Case Score above 2+, Or Primary Case Record
    
        if(newRec.Online__c == 'Yes' && (newRec.Probable_Case_Score__c > 1 || newRec.Primary_Case_Interview__c))
        {
            String subject;
            String school;
            
            HAE_Case__c caseRec = [SELECT Id, Event_Id__c FROM HAE_Case__c WHERE Id = :newRec.HAE_Case__c]; 
            HAE_Individual__c indRec = [SELECT Id, Full_Name__c FROM HAE_Individual__c WHERE Id = :newRec.HAE_Individual__c];
            
            //Go after the school name if exists
            if(newRec.School_Location__c != null)
            {
                HAE_Location__c locRec = [SELECT Id, Location_Name__c FROM HAE_Location__c WHERE Id = :newRec.School_Location__c];
                school = locRec.Location_Name__c;
                subject = 'A student was flagged for having been at ' + locRec.Location_Name__c + ' - See email for details';
            }
            else  //No school provided
            {
                subject = 'A student was flagged for having been at school - See email for details';
            }
            
            String body = 'Hello,';
            body += '\n<p/>';
            body += 'CEDRS Case ID# - ' + '(' + caseRec.Event_ID__c + '), involving "' + indRec.Full_Name__c + '", has been identified as having attended school.';
            body += '\n<p/>Please review the Case as soon as you are able.';
            body += '\n<p/>System Link: https://larimerhealth.lightning.force.com/';
            body += '\n<p/>';
            body += '\n<p/>';               
            body += '\n<p/>' + 'Thank you.';
            
            //Generate email if affected school is not CSU
            if(school != 'Colorado State University (CSU)')
            {
                //Build sendTo email
                List <String> sendTo = new List <String>();
                
                //sendTo.add('davidslm@co.larimer.co.us');
                sendTo.add('schoolscovid@co.larimer.co.us');
                
                emailService.sendToEmailList(sendTo,'Larimer CICM',body,subject);
            }
         }  
    }
 }