@isTest
private class test_notifyCaseAssigned{

    static testMethod void testnotifyCaseAssigned(){
    
    //Create Standard User
Profile profileId = [SELECT Id FROM Profile WHERE profile.name = 'CICM User' LIMIT 1];

User usr2 = new User(LastName = '2',
                   FirstName='Test',
                   Alias = 'test',
                   Email = 'usr1@co.larimer.co.us',
                   Username = 'usr1@co.larimer.co.us',
                   ProfileId = profileId.id,
                   TimeZoneSidKey = 'GMT',
                   LanguageLocaleKey = 'en_US',
                   EmailEncodingKey = 'UTF-8',
                   LocaleSidKey = 'en_US'
                   );

User usr1 = new User(LastName = '1',
                   FirstName='Test',
                   Alias = 'ttee',
                   Email = 'usr2@co.larimer.co.us',
                   Username = 'usr2@co.larimer.co.us',
                   ProfileId = profileId.id,
                   TimeZoneSidKey = 'GMT',
                   LanguageLocaleKey = 'en_US',
                   EmailEncodingKey = 'UTF-8',
                   LocaleSidKey = 'en_US'
                   );
                     
        insert usr1;
        insert usr2;
        
        HAE_Interview_Team__c interviewer1 = new HAE_Interview_Team__c(User__c = usr1.Id);
        HAE_Interview_Team__c interviewer2 = new HAE_Interview_Team__c(User__c = usr1.Id);
        
        insert interviewer1;
        insert interviewer2;


        HAE_Case__c theCase = new HAE_Case__c(Case_Status__c = 'Assign', HAE_Interview_Team__c = interviewer1.Id);
        insert theCase;
        
        system.debug('First case status after insert ' + theCase.Case_Status__c);
        system.debug('First Interview Team member after insert ' + theCase.HAE_Interview_Team__c);
    
        theCase.Case_Status__c = 'Assigned Interviewer';
        theCase.HAE_Interview_Team__c = interviewer2.Id;
        update theCase;
        system.debug('Case status after update ' + theCase.Case_Status__c);
    

        
        //}
    }
}