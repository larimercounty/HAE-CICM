@isTest(SeeAllData=True)
private class test_newCaseNote{

    static testMethod void newCaseNote(){
    
    //Create Standard User
Profile profileId = [SELECT Id FROM Profile WHERE profile.name = 'CICM User' LIMIT 1];
List<User> theUsers = new List<User>([Select Id from User where ProfileID =: profileId.Id]);



        HAE_Interview_Team__c IntView1 = new HAE_Interview_Team__c(User__c = theUsers[0].Id);
        HAE_Interview_Team__c IntView2 = new HAE_Interview_Team__c(User__c = theUsers[1].Id);
        
        insert IntView1;
        insert IntView2;
        system.debug(IntView1);

        HAE_Individual__c Individual = new HAE_Individual__c(Secondary_Interviewer__c = theUsers[1].Id, First_Name__c = 'Tim', Last_Name__c = 'Test');        

        insert Individual;

        HAE_Case__c theCase = new HAE_Case__c(Case_Status__c = 'Assign'); //Create a case to manipulate
        insert theCase;  //Add the case into the system
        theCase.Case_Status__c = 'Assigned Interviewer';
        theCase.HAE_Interview_Team__c = IntView1.id;  //Why doesn't this work? illegal assignment User to Id
        update theCase;
        system.debug(theCase.HAE_Interview_Team__c);        


        HAE_Case_Activity__c caseNote = new HAE_Case_Activity__c(Case_Note__c = 'Test Case Note', HAE_Case__c = theCase.Id);
        insert caseNote;

    }
}