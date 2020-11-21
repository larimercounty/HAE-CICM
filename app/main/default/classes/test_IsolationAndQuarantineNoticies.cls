@isTest
private class test_IsolationAndQuarantineNoticies{

    static testMethod void testUpdateInterviewStarted()
    {
        
        HAE_Individual__c Individual = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test', Correspondence_Language__c = 'English', Email_Address__c ='schreujs@co.larimer.co.us');        
        insert Individual;
        
        HAE_Case__c theCase = new HAE_Case__c(Primary_Individual__c = Individual.Id);
        insert theCase;
        
        HAE_Case_Interview__c theInterview = new HAE_Case_Interview__c(HAE_Individual__c = Individual.Id, HAE_Case__c = theCase.Id);
        insert theInterview;

        sendIndividualEmails.sendCorrectLetter(theInterview.Id );
        
        Individual.Correspondence_Language__c = 'Spanish';
        update Individual;
        
        sendIndividualEmails.sendCorrectLetter(theInterview.Id );
        
        theInterview.Current_Symptoms__c = true;
        theInterview.Abdominal_Pain__c = true;
        theInterview.Chronic_Liver_Disease__c = true;
        theInterview.Chronic_Renal_Disease__c = true;
        theInterview.Fatigue__c = true;
        theInterview.Fever__c = true;
        Update theInterview;
 
        Individual.Correspondence_Language__c = 'English';
        update Individual;
        
        sendIndividualEmails.sendCorrectLetter(theInterview.Id );
     
        
        Individual.Correspondence_Language__c = 'Spanish';
       
        update Individual;
        
        sendIndividualEmails.sendCorrectLetter(theInterview.Id );
        
        HAE_Contact_Review__c newContact = new HAE_Contact_Review__c(First_Name__c='Joe',Last_Name__c='Test', Last_Exposure__c=System.Today() , Phone__c='3038345234',City__c='Fort Collins', Parent_or_Guardian_Email__c='schreujs@co.larimer.co.us', 
                                                                    State__c='CO',Street__c='100 West Oak', ZipCode__c='80524', Date_of_Birth__c=System.Today(), EventID__c=theCase.Id);
        
        insert newContact;
        
        List<String> idToSend = new List<String>();
        idToSend.add(newContact.Id);
        
        CICMImportProcesses.attachContactsToCaseWS(idToSend);
 
        


    }
}