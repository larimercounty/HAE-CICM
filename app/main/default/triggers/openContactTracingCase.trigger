trigger openContactTracingCase on TestingSlot__c (after update) {

    for(TestingSlot__c theTest : trigger.New)
    {
    
       TestingSlot__c priorData = trigger.oldMap.get(theTest.Id);
       
       //Identify that a positive test was received
       if((theTest.Lab_Result__c != priorData.Lab_Result__c) && theTest.Lab_Result__c == 'Positive')
       {
           
           //Pull Up The Registration Record
           TestingRegistration__c theRegistration = [Select Id, First_Name__c, Last_Name__c, DOB__c, Email_Address__c, 
                                                     Middle_Name__c, Address__c, City__c, State__c, Zip_Code__c, Date_of_Symptoms__c,School__r.Id,
                                                     Gender__c, Race__c, Phone_Number__c,Ethnicity__c, Language__c, Employer__c,School__c  
                                                     from TestingRegistration__c where Id =: theTest.TestingRegistration__c limit:1];
           
           system.debug(theRegistration.Email_Address__c);
           
           
           //Create the new case record if the patient doesn't already have an active case
           
           //Look for a case with this criteria
           List <HAE_Case__c> matchedCases = new List<HAE_Case__c>([Select Id from HAE_Case__c where Specimen_Collection_Date__c > :theTest.PriorPositveCheck__c AND 
                                                                                               Primary_Individual__r.Last_Name__c =: theRegistration.Last_Name__c AND
                                                                                               Primary_Individual__r.First_name__c =: theRegistration.First_Name__c AND
                                                                                               Primary_Individual__r.Date_of_Birth__c =: theRegistration.DOB__c]); 
           If(matchedCases.size()>0)
           {
               //There is already an active investigation
           }
           else
           {
           
               HAE_Individual__c newIndividual = new HAE_Individual__c();
               newIndividual.First_Name__c = theRegistration.First_Name__c;
               newIndividual.Middle_Name__c = theRegistration.Middle_Name__c;
               newIndividual.Last_Name__c = theRegistration.Last_Name__c;
               newIndividual.Date_Of_Birth__c = theRegistration.DOB__c;
               newIndividual.Address1__c = theRegistration.Address__c;
               newIndividual.City__c = theRegistration.City__c;
               newIndividual.Gender__C = theRegistration.Gender__c;
               
               If(theRegistration.Ethnicity__c == 'Hispanic' ) newIndividual.Ethnicity__c = 'Yes';
               If(theRegistration.Ethnicity__c == 'Not Hispanic' ) newIndividual.Ethnicity__c = 'No';
               
               if(theRegistration.Language__c == 'Spanish') newIndividual.Correspondence_Language__c = 'Spanish';
               if(theRegistration.Language__c != 'Spanish') newIndividual.Correspondence_Language__c = 'English';
               
               
               newIndividual.Race__c = theRegistration.Race__c;
               newIndividual.Zip__c  = theRegistration.Zip_Code__c;
               newIndividual.Individual_Phone__c = theRegistration.Phone_Number__c;
               newIndividual.Email_Address__c = theRegistration.Email_Address__c;
               
               insert newIndividual;
               
               HAE_Case__c newCase = new HAE_Case__c();
               newCase.Event_ID__c = theTest.TestID__c;
               newCase.Primary_Individual__c = newIndividual.Id;
               newCase.Specimen_Collection_Date__c = theTest.Test_Day__c;
               newCase.Reported_Date__c = system.today();
               newCase.Result_Date__c = system.today();
               if(theTest.Test_Type__c == null || theTest.Test_Type__c == 'BOTH') {newCase.Specimen__c = 'RT-PCR';}
               else {newCase.Specimen__c = theTest.Test_Type__c;}
               
               newCase.CEDRS_Case_Status__c = 'Confirmed';
               insert newCase; 
                   
               HAE_Case_Contact__c newCaseContact = new HAE_Case_Contact__c();
               newCaseContact.HAE_Individual__c = newIndividual.Id;
               newCaseContact.HAE_Case__c = newCase.Id;
               newCaseContact.Primary_Individual__c = True;
               newCaseContact.Contact_Type__c = 'Case';
               insert newCaseContact;
               
               String theNote = 'New Case Added.';
               if(theRegistration.Employer__c != null) theNote += ' Employer: ' + theRegistration.Employer__c;
               if(theRegistration.School__c != null) theNote += ' School: ' + theRegistration.School__c;
              
               
               HAE_Case_Activity__c newNote = new HAE_Case_Activity__c();
               newNote.HAE_Individual__c = newIndividual.Id;
               newNote.HAE_Case__c = newCase.Id;
               newNote.Case_Note__c = theNote;
               insert newNote;
               
               HAE_Case_Interview__c newInterview = new HAE_Case_Interview__c();
               newInterview.Date_of_Symptoms__c = theRegistration.Date_of_Symptoms__c;
               newInterview.HAE_Individual__c = newIndividual.Id;
               newInterview.HAE_Case__c = newCase.Id;
               newInterview.Primary_Case_Interview__c = True;
               if(theRegistration.School__c != null) newInterview.School_Location__c = theRegistration.School__r.Id;
               insert newInterview;
               
             /*             
               //Send Isolation Order
               if(theTest.Test_Type__c == 'BINAX')
               {
                  sendContactQuarantineEmail  theBatch = new sendContactQuarantineEmail();        
                  theBatch.theId = newInterview.Id;
                  ID theBatchJob = Database.executeBatch(theBatch,1);
               }
           */
           
           }
       
       
       
       }
      
    }

}