global class sendDailyTestingRemindersSchedule implements Schedulable{
    
    // Method definition for execute 
     global void execute(SchedulableContext sc) {
     
      //  System.debug('\n\n*************** Inside CopySentenceDataScheduler Class - Schedulable **************\t\n');  
        NotificationForTesting batch = new NotificationForTesting(); 
        
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(batch,9);
        

     }
  }