global class sendDailySchoolNotices implements Schedulable{
    
    // Method definition for execute 
     global void execute(SchedulableContext sc) {
     
      //  System.debug('\n\n*************** Inside CopySentenceDataScheduler Class - Schedulable **************\t\n');  
        NotifyOfQIStudentsStaff batch = new NotifyOfQIStudentsStaff(); 
        
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(batch,10);
        

     }
  }