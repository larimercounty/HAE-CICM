@isTest(SeeAllData=True)
private class test_notifyReassignedCase{

    static testMethod void testnotifyReassignedCase(){
    
//Create Standard User
Profile profileId = [SELECT Id FROM Profile WHERE profile.name = 'CICM User' LIMIT 1];
List<User> theUsers = new List<User>([Select Id from User where ProfileID =: profileId.Id]);




        HAE_Interview_Team__c interviewer1 = new HAE_Interview_Team__c(User__c = theUsers[0].Id);
        HAE_Interview_Team__c interviewer2 = new HAE_Interview_Team__c(User__c = theUsers[1].Id);
        
        insert interviewer1;
        insert interviewer2;


        //HAE_Case__c theCase = new HAE_Case__c(Case_Status__c = 'Assign', HAE_Interview_Team__c = interviewer1.Id);
        //List<HAE_Case_Contact__c> theContact = [Select Id from HAE_Case_Contact__c where HAE_Case__c = theCase.Id];
        HAE_Individual__c Individual = new HAE_Individual__c(Secondary_Interviewer__c = theUsers[0].Id, First_Name__c = 'Tim', Last_Name__c = 'Test');        
        
        //insert theCase;
        insert Individual;
        Individual.Secondary_Interviewer__c = theUsers[1].Id;
        update Individual;
       
    
        
    }
}