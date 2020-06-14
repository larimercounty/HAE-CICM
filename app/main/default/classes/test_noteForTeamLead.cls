@isTest(SeeAllData=true)
private class test_noteForTeamLead{

    static testMethod void testnotifyCaseAssigned(){
    
    Profile profileId = [SELECT Id FROM Profile WHERE profile.name = 'CICM User' LIMIT 1];
    
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
                   
    //insert usr1; // Add the user into the system
    
    HAE_Interview_Team__c interviewer1 = new HAE_Interview_Team__c(User__c = usr1.Id); //Make the user an available interviewer
    //insert interviewer1; //Add the interviewer into the system
    
    HAE_Case__c theCase = new HAE_Case__c(Case_Status__c = 'Assign'); //Create a case to manipulate
    insert theCase;  //Add the case into the system
    system.debug(theCase.Id);
    
    HAE_Case_Activity__c caseActivity = new HAE_Case_Activity__c(HAE_Case__c = theCase.Id, Team_Lead_FollowUp__c = false);
    //HAE_Case_Activity__c caseActivity = [SELECT Id, Team_Lead_FollowUp__c, HAE_Case__c FROM HAE_Case_Activity__c where HAE_Case__c.Id = theCase.Id]; //Pull the Case Activity related to the case in question
    
    system.debug(caseActivity.Team_Lead_FollowUp__c);
    insert caseActivity; //Add the case activity into the system so we can test the trigger

    
    
    caseActivity.Team_Lead_FollowUp__c = true; //Update the field
    caseActivity.Case_Note__c = 'This is a test Note'; // A test note to include in the email
    system.debug(caseActivity.Team_Lead_FollowUp__c);
    
    update caseActivity; //Push the update and fire off the trigger
    
    }
}