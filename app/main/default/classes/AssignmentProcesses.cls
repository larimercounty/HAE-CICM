global class AssignmentProcesses 
{

    @InvocableMethod(label='Assign Next Case To Me')
    webservice static void attachCasesToMe(List <String> recId) {
    
       String myEmployeeId = recId[0];
       Boolean caseFound = False;
       HAE_Case__c theCase = new HAE_Case__c();
       
       List <HAE_Interview_Team__c> interviewer = new List < HAE_Interview_Team__c>([Select Id from HAE_Interview_Team__c where User__c =: myEmployeeId]);
       
       
       List <HAE_Case__c> binaxCase = new List <HAE_Case__c>([Select ID, Primary_Individual__r.Age__c, Case_Status__c, Primary_Individual__r.Address1__c,Primary_Individual__r.Last_Name__c,HAE_Interview_Team__c from HAE_Case__c where Specimen__c ='BINAX' AND Primary_Individual__r.Correspondence_Language__c <>'Spanish' AND Case_Status__c = 'Assign' AND Primary_Individual__r.Individual_Phone__c <> null order by Primary_Individual__r.Age__c, Specimen_Collection_Date__c desc]);
       System.debug('binaxCase ' + binaxCase.size());
       
       List <HAE_Case__c> under19 = new List <HAE_Case__c>([Select ID, Primary_Individual__r.Age__c, Case_Status__c, Primary_Individual__r.Address1__c,Primary_Individual__r.Last_Name__c,HAE_Interview_Team__c from HAE_Case__c where Primary_Individual__r.Age__c < 19 AND Primary_Individual__r.Correspondence_Language__c <>'Spanish' AND Case_Status__c = 'Assign' AND Primary_Individual__r.Individual_Phone__c <> null order by Specimen_Collection_Date__c desc]);
       System.debug('under19 ' + under19.size());
       List <HAE_Case__c> over69 = new List <HAE_Case__c>([Select ID, Primary_Individual__r.Age__c,Case_Status__c, Primary_Individual__r.Address1__c, Primary_Individual__r.Last_Name__c,HAE_Interview_Team__c from HAE_Case__c where Primary_Individual__r.Age__c > 69 AND Primary_Individual__r.Correspondence_Language__c <>'Spanish' AND Case_Status__c = 'Assign' AND Primary_Individual__r.Individual_Phone__c <> null order by Specimen_Collection_Date__c desc]);
       System.debug('over69 ' + over69.size());
       List <HAE_Case__c> remainingCases = new List <HAE_Case__c>([Select ID, Primary_Individual__r.Age__c,Case_Status__c, Primary_Individual__r.Address1__c, Primary_Individual__r.Last_Name__c, HAE_Interview_Team__c from HAE_Case__c where ((Primary_Individual__r.Age__c > 18 AND Primary_Individual__r.Age__c < 70) OR Primary_Individual__r.Age__c = null) AND Primary_Individual__r.Correspondence_Language__c <>'Spanish' AND Case_Status__c = 'Assign' AND Primary_Individual__r.Individual_Phone__c <> null order by Specimen_Collection_Date__c desc]);
       System.debug('remainingCases ' + remainingCases.size());
       List <HAE_Case__c> allCases = new List <HAE_Case__c>([Select ID, Event_Id__c, Primary_Individual__r.Age__c,Case_Status__c, Primary_Individual__r.Address1__c, Primary_Individual__r.Last_Name__c, HAE_Interview_Team__c from HAE_Case__c where Case_Status__c = 'Assign' order by Specimen_Collection_Date__c desc]);
       System.debug('allCases ' + allCases.size());
       
       
       if(binaxCase.Size() > 0 && !caseFound)
       {
           caseFound = True;
           for(HAE_Case__c thisCase : allCases)
           {
           
               if(binaxCase[0].Primary_Individual__r.Address1__c == thisCase.Primary_Individual__r.Address1__c && binaxCase[0].Primary_Individual__r.Last_Name__c == thisCase.Primary_Individual__r.Last_Name__c)
               {
                   if(interviewer.size()>0) thisCase.HAE_Interview_Team__c = interviewer[0].Id;
                   thisCase.Case_Status__c = 'Assigned Interviewer';
               }
           
           }
       
       }
       
       if(under19.Size() > 0 && !caseFound)
       {
           caseFound = True;
           for(HAE_Case__c thisCase : allCases)
           {
           
               if(under19[0].Primary_Individual__r.Address1__c == thisCase.Primary_Individual__r.Address1__c && under19[0].Primary_Individual__r.Last_Name__c == thisCase.Primary_Individual__r.Last_Name__c)
               {
                   if(interviewer.size()>0) thisCase.HAE_Interview_Team__c = interviewer[0].Id;
                   thisCase.Case_Status__c = 'Assigned Interviewer';
               }
           
           }
       
       }
       
       if(over69.Size() > 0 && !caseFound)
       {
           caseFound = True;
           
           for(HAE_Case__c thisCase : allCases)
           {
               if(over69[0].Primary_Individual__r.Address1__c == thisCase.Primary_Individual__r.Address1__c && over69[0].Primary_Individual__r.Last_Name__c == thisCase.Primary_Individual__r.Last_Name__c)
               {
                   if(interviewer.size()>0) thisCase.HAE_Interview_Team__c = interviewer[0].Id;
                   thisCase.Case_Status__c = 'Assigned Interviewer'; 
               }
           
           }
       
       }
       
       if(remainingCases.Size() > 0 && !caseFound)
       {
           caseFound = True;     
           for(HAE_Case__c thisCase : allCases)
           {
               if(remainingCases[0].Primary_Individual__r.Address1__c == thisCase.Primary_Individual__r.Address1__c && remainingCases[0].Primary_Individual__r.Last_Name__c == thisCase.Primary_Individual__r.Last_Name__c)
               {
                   if(interviewer.size()>0) thisCase.HAE_Interview_Team__c = interviewer[0].Id;
                   thisCase.Case_Status__c = 'Assigned Interviewer';
               }
           }
       
       }
  
      update allCases;
       

    }

}