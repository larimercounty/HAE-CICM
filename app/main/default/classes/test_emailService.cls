@isTest(SeeAllData=true)
private class test_emailService{

static testmethod void test_emailServices(){

    List <String> emailAddresses = new List <String>();
    List <String> sendCcList = new List <String> ();
    List <String> sendBcList = new List <String> ();
    String Uid = UserInfo.getUserId();

    /*Create System Admin User
    User sysAdmin = new User(ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
                             FirstName = 'First',
                             LastName = 'Last',
                             Email = 'test@co.larimer.co.us',
                             Username = 'test@co.larimer.co.us'
                            );
                            
    //Create Standard User
    User CMIM = new User(ProfileId = [SELECT Id FROM Profile WHERE Name = 'CICM User'].Id,
                             FirstName = 'Regular',
                             LastName = 'User',
                             Email = 'userr@co.larimer.co.us',
                             Username = 'userr@co.larimer.co.us'
                            );     */                       

    //Create External Email                         
      
    emailAddresses.add ('test@co.larimer.co.us');
    sendCcList.add ('');
    sendBcList.add ('fake@co.larimer.co.us');

    system.debug('The list of email addresses ' + emailAddresses);

    String subject1 = 'Test1';
    String subject2 = 'Test2';
    String subject3 = 'Test3';
    
    String body1 = 'Hi';
    String body2 = 'There';
    String body3= 'Friend';
    
    //Create Email Groups
    Email_Group__c adminGroup = new Email_Group__c(Email_Receiver__c = Uid, Notification_Type__c = 'CICM Developer'); //- Commented out as this is group creation, with (SeeAllData=true) this is not necessary
    //Email_Group__c testGroup = new Email_Group__c(External_Address__c = 'fake1@co.larimer.co.us', Notification_Type__c = 'Test'); //- Commented out as this is group creation, with (SeeAllData=true) this is not necessary
    Email_Group__c emptyGroup = new Email_Group__c(External_Address__c = '', Address_Type__c = 'External Address', Notification_Type__c = 'CICM Admin Group');
    insert adminGroup;
    insert emptyGroup;
     
     //Create and send email
               
                
                emailService.sendToEmailList(emailAddresses,'Larimer CICM',body2,subject2);
                emailService.sendToEmailGroup('CICM Developer','Larimer CICM',body1,subject1);
                emailService.sendEmail('CICM Developer','Larimer CICM',body1,subject1);
                emailService.sendEmail('','Larimer CICM',body1,subject1);

         }        
   
public static testMethod void testBatchTestingNotification(){

    
        String CRON_EXP = '0 0 0 15 3 ? 2022';
        
                 String jobId = System.schedule('batchTestNotification', 
                     CRON_EXP,  
                        new sendDailyTestingRemindersSchedule()); 

}

public static testMethod void testNotification(){

    
        NotificationForTesting  theBatch = new NotificationForTesting();
        
         theBatch.query = 'SELECT Id, sendNotification__c, EmailToSendTo__c from TestingSlot__c where sendNotification__c = true limit 5';
        
       ID theBatchJob = Database.executeBatch(theBatch,9);
    

}
   
}