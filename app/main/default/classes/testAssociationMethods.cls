@isTest
global class testAssociationMethods 
{

    static testMethod void testSendPIN()
    {
    
        Test.setMock(HTTPCalloutMock.class, new WebServiceMockImpl());
        
        Testing_Association__c a = new Testing_Association__c();
        a.Association_Name__c = 'Test Association';
        insert a;
    
        Testing_Association_User__c u = new Testing_Association_User__c();
        u.Email__c = 'schreujs@co.larimer.co.us';
        u.Text_Message_Number__c = '3038345234';
        u.Testing_Association__c = a.Id;
        insert u;
        
        
        list<String> users = new list<String>();
        users.add(u.Id);
        AssociationLogin.sendPIN(users);
        
    }
    
}