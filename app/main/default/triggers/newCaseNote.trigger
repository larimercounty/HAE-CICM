trigger newCaseNote on HAE_Case_Activity__c (after insert) {
//This trigger is meant to notify the interviewer of ANY new case note EXCEPT ones they have created


for (HAE_Case_Activity__c newRec : trigger.new) 
    {
    
    Boolean notify = false;                                     //Switch to toggle if we need to contact the interviewer
    List <String > emailRec = new List <String>();              //Email list of people we want to contact that there is a new case note
    List <String > emailSend = new List <String>();             //Email of creator of the note
    
    //if((newRec.Interviewer__c != newRec.CreatedById) && (newRec.Case_Note__c =! null))  //This isnt the interviewers own note AND that the record being inserted is a case note
        {
        
        //notify = true;
        
        }
    
    if(notify == true)
        {
        
        
        
        }
    
    }
}