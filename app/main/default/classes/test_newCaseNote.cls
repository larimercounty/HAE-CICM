<<<<<<< HEAD
@isTest(SeeAllData=True)
=======
@isTest
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
private class test_newCaseNote{

    static testMethod void newCaseNote(){
    
    //Create Standard User
Profile profileId = [SELECT Id FROM Profile WHERE profile.name = 'CICM User' LIMIT 1];
<<<<<<< HEAD
List<User> theUsers = new List<User>([Select Id from User where ProfileID =: profileId.Id]);



        HAE_Interview_Team__c IntView1 = new HAE_Interview_Team__c(User__c = theUsers[0].Id);
        HAE_Interview_Team__c IntView2 = new HAE_Interview_Team__c(User__c = theUsers[1].Id);
=======

User usr2 = new User(LastName = '2',
                   FirstName='Test',
                   Alias = 'test',
                   Email = 'usr2@co.larimer.co.us',
                   Username = 'usr2@co.larimer.co.us',
                   ProfileId = profileId.id,
                   TimeZoneSidKey = 'GMT',
                   LanguageLocaleKey = 'en_US',
                   EmailEncodingKey = 'UTF-8',
                   LocaleSidKey = 'en_US'
                   );

User usr1 = new User(LastName = '1',
                   FirstName='Test',
                   Alias = 'ttee',
                   Email = 'usr1@co.larimer.co.us',
                   Username = 'usr1@co.larimer.co.us',
                   ProfileId = profileId.id,
                   TimeZoneSidKey = 'GMT',
                   LanguageLocaleKey = 'en_US',
                   EmailEncodingKey = 'UTF-8',
                   LocaleSidKey = 'en_US'
                   );
                     
        insert usr1;
        insert usr2;

        HAE_Interview_Team__c IntView1 = new HAE_Interview_Team__c(User__c = usr1.Id);
        HAE_Interview_Team__c IntView2 = new HAE_Interview_Team__c(User__c = usr2.Id);
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
        
        insert IntView1;
        insert IntView2;
        system.debug(IntView1);

<<<<<<< HEAD
        HAE_Individual__c Individual = new HAE_Individual__c(Secondary_Interviewer__c = theUsers[1].Id, First_Name__c = 'Tim', Last_Name__c = 'Test');        
=======
        HAE_Individual__c Individual = new HAE_Individual__c(Secondary_Interviewer__c = usr1.Id, First_Name__c = 'Tim', Last_Name__c = 'Test');        
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854

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