//@isTest
@isTest(SeeAllData=true)
private class test_InterviewProcesses{

    static testMethod void testUpdateInterviewStarted()
    {
        
        HAE_Individual__c Individual = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test');        
        insert Individual;
        
        HAE_Case__c theCase = new HAE_Case__c(Primary_Individual__c = Individual.Id);
        insert theCase;
        
        HAE_Case_Interview__c theInterview = new HAE_Case_Interview__c(HAE_Individual__c = Individual.Id, HAE_Case__c = theCase.Id);
        insert theInterview;

    }
    
    
     static testMethod void testnotifyTeamLeads()
    {
        
        HAE_Individual__c ind = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test');        
        insert ind;
        
        HAE_Case__c theCaseRec = new HAE_Case__c(Primary_Individual__c = Ind.Id);
        insert theCaseRec;
        
        HAE_Case_Interview__c theInt = new HAE_Case_Interview__c(HAE_Individual__c = Ind.Id, HAE_Case__c = theCaseRec.Id, Student__c = true, Online__c = 'Yes');
        insert theInt;  
        
    }
    
    static testMethod void testAllLetters()
    {
        extAllLettersToSend x = new extAllLettersToSend();
        x.getLetters();
    }
    
    
     static testMethod void skipCase()
    {
        
        HAE_Individual__c ind = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test',Email_Address__c = 'schreujs@co.larimer.co.us');        
        insert ind;
        
        HAE_Case__c theCaseRec = new HAE_Case__c(Primary_Individual__c = Ind.Id);
        insert theCaseRec;
        
        List <String> ids = new List<String>();
        ids.add(theCaseRec.Id);
        caseManagementProcesses.skipCaseProcessing(ids);
   
        
        
        
    }
    
     static testMethod void skipCaseExisting()
    {
        
        HAE_Individual__c ind = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test',Email_Address__c = 'schreujs@co.larimer.co.us');        
        insert ind;
        
        HAE_Case__c theCaseRec = new HAE_Case__c(Primary_Individual__c = Ind.Id);
        insert theCaseRec;
        
        
        HAE_Case_Interview__c theInt = new HAE_Case_Interview__c(HAE_Individual__c = Ind.Id, HAE_Case__c = theCaseRec.Id, Student__c = true, Online__c = 'Yes');
        insert theInt;  
                
        List <String> ids = new List<String>();
        ids.add(theCaseRec.Id);
        caseManagementProcesses.skipCaseProcessing(ids);
        
        
        
    }
    
    static testMethod void assignCase()
    {
    
        Date theDay = System.Today();
        theDay = theDay.addYears(-1);
        HAE_Individual__c Individual = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test', Individual_Phone__c = '3038345234', Correspondence_Language__c = 'English', Date_of_Birth__c = theDay);        
        insert Individual;
        
        HAE_Case__c theCase = new HAE_Case__c(Primary_Individual__c = Individual.Id, Case_Status__c = 'Assign');
        insert theCase;
        
        HAE_Case_Interview__c theInterview = new HAE_Case_Interview__c(HAE_Individual__c = Individual.Id, HAE_Case__c = theCase.Id);
        insert theInterview;
    
        List <String> ids = new List<String>();
        ids.add('TESTID');
        AssignmentProcesses.attachCasesToMe(ids);
        
        theDay = theDay.addYears(-70);
        
        Individual = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test', Correspondence_Language__c = 'English',  Individual_Phone__c = '3038345234', Date_of_Birth__c = theDay);        
        insert Individual;
        
        theCase = new HAE_Case__c(Primary_Individual__c = Individual.Id, Case_Status__c = 'Assign');
        insert theCase;
        
        theInterview = new HAE_Case_Interview__c(HAE_Individual__c = Individual.Id, HAE_Case__c = theCase.Id);
        insert theInterview;
    

        AssignmentProcesses.attachCasesToMe(ids);
        
        theDay = System.Today();
        theDay = theDay.addYears(20);
        
        Individual = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test', Correspondence_Language__c = 'English',  Individual_Phone__c = '3038345234');        
        insert Individual;
        
        theCase = new HAE_Case__c(Primary_Individual__c = Individual.Id, Case_Status__c = 'Assign');
        insert theCase;
        
        theInterview = new HAE_Case_Interview__c(HAE_Individual__c = Individual.Id, HAE_Case__c = theCase.Id);
        insert theInterview;
    

        AssignmentProcesses.attachCasesToMe(ids);
    
    }
    
    static testMethod void assignCaseSpanish()
    
    {
    
        Date theDay = System.Today();
        theDay = theDay.addYears(-1);
        HAE_Individual__c Individual = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test', Individual_Phone__c = '3038345234', Correspondence_Language__c = 'Spanish', Date_of_Birth__c = theDay);        
        insert Individual;
        
        HAE_Case__c theCase = new HAE_Case__c(Primary_Individual__c = Individual.Id, Case_Status__c = 'Assign');
        insert theCase;
        
        HAE_Case_Interview__c theInterview = new HAE_Case_Interview__c(HAE_Individual__c = Individual.Id, HAE_Case__c = theCase.Id);
        insert theInterview;
    
        List <String> ids = new List<String>();
        ids.add('TESTID');
        AssignmentProcessesSpanish.attachCasesToMeSpanish(ids);
        
        theDay = theDay.addYears(-70);
        
        Individual = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test', Correspondence_Language__c = 'Spanish',  Individual_Phone__c = '3038345234', Date_of_Birth__c = theDay);        
        insert Individual;
        
        theCase = new HAE_Case__c(Primary_Individual__c = Individual.Id, Case_Status__c = 'Assign');
        insert theCase;
        
        theInterview = new HAE_Case_Interview__c(HAE_Individual__c = Individual.Id, HAE_Case__c = theCase.Id);
        insert theInterview;
    

        AssignmentProcessesSpanish.attachCasesToMeSpanish(ids);
        
        theDay = System.Today();
        theDay = theDay.addYears(20);
        
        Individual = new HAE_Individual__c(First_Name__c = 'Tim', Last_Name__c = 'Test', Correspondence_Language__c = 'Spanish',  Individual_Phone__c = '3038345234');        
        insert Individual;
        
        theCase = new HAE_Case__c(Primary_Individual__c = Individual.Id, Case_Status__c = 'Assign');
        insert theCase;
        
        theInterview = new HAE_Case_Interview__c(HAE_Individual__c = Individual.Id, HAE_Case__c = theCase.Id);
        insert theInterview;
    

        AssignmentProcessesSpanish.attachCasesToMeSpanish(ids);
        
        
    
    
    }
    
}