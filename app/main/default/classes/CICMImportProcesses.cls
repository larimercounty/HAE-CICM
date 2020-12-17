global class CICMImportProcesses 
{
 

  webservice static String loadTestRecord(String theRecord) {
  
  
    String returnMsg ='';
    TestsPerformed__c res = new TestsPerformed__c();
    Date collectionDate;
    Date dateOfBirth;
    
  
    if (theRecord != null)
    {
    
    
    
    system.debug('Passed String: ' + theRecord);
    if(theRecord.length() > 50)
    {
   
        List<List<String>> data = RT_CSVReader.read(theRecord);
        List<String> fields = data[0];
    
    
     
        Integer count = 0;
        for( String field : fields)
        {
           System.debug('' + count + ' ' + field);
           count++; 
        }
                

    if(fields.size()>0)
    {
        try
        {
        
            List<String> days = new List<String>();
            days = fields[13].split('/');
            if(days.size()==3)
            {
                collectionDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                res.Collection_Date__c = collectionDate;
            }
            else
            {
               CalloutException ex = new CalloutException();
               ex.setMessage('Missing Collection Date');
               throw ex;
            }
            
            
            List<String> DOBdays = new List<String>();
            DOBdays = fields[2].split('/');
            
            if(DOBdays.size()==3)
            {
                dateOfBirth = Date.newInstance(integer.valueof(DOBdays[2]), integer.valueof(DOBdays[0]),integer.valueof(DOBdays[1]));
                res.Date_of_Birth__c = dateOfBirth;
            }
            else
            {
               CalloutException ex2 = new CalloutException();
               ex2.setMessage('Missing Date of Birth');
               throw ex2;
            }
            
            String lastName = fields[0];
            String firstName = fields[1];
            String ELRResult = fields[17];
            String MappedResult = fields[19];
            String calcResult ='';
            
            
            if(MappedResult == 'Negative' || MappedResult == 'NotDetected' || MappedResult == 'Not Detected' || MappedResult == 'Non-Reactive' || MappedResult == 'Nonreactive'  || MappedResult == 'UNDETECTED'   || MappedResult == 'Not detected (qualifier value)'){ calcResult = 'Negative';}
            
            if(MappedResult == 'Detected' || MappedResult == 'Reactive' || MappedResult == 'Positive'){calcResult = 'Positive';}
            
            if(MappedResult == 'Inconclusive'){calcResult = 'Inconclusive';}
            
            if(MappedResult == 'Test Not Performed'){calcResult = 'Exclude';}

            
            List< TestsPerformed__c > existingTest = new List< TestsPerformed__c >([Select Id,
                                                                                    ELR_Result__c,
                                                                                    First_Name__c,
                                                                                    Last_Name__c,
                                                                                    Mapped_Result__c,
                                                                                    Provider__c,
                                                                                    Specimen_Type__c,
                                                                                    Submitted__c,
                                                                                    Test_Type__c,
                                                                                    Date_of_Birth__c,
                                                                                    Calc_Result__c,
                                                                                    Collection_Date__c 
                                                                                    from TestsPerformed__c where 
                                                                                    First_Name__c =: firstName AND 
                                                                                    Last_Name__c=:lastName AND 
                                                                                    Collection_Date__c = : collectionDate AND 
                                                                                    Date_of_Birth__c = :dateOfBirth AND
                                                                                    ELR_Result__c = : ELRResult]);   
      
            If(existingTest.size()>0)
            {
                
                existingTest[0].Date_of_Birth__c = dateOfBirth;
                existingTest[0].Collection_Date__c = collectionDate;
                existingTest[0].ELR_Result__c = ELRResult;
                existingTest[0].First_Name__c = fields[1];
                existingTest[0].Last_Name__c = fields[0];
                existingTest[0].Mapped_Result__c = MappedResult;
                existingTest[0].Provider__c = fields[14];
                existingTest[0].Specimen_Type__c = fields[12];
                existingTest[0].Submitted__c = fields[15];
                existingTest[0].Test_Type__c = fields[17];
                existingTest[0].Calc_Result__c = calcResult;            
                existingTest[0].Address__c = fields[3];
                existingTest[0].City__c = fields[4];
                existingTest[0].State__c = 'Colorado';
                existingTest[0].Zip__c = fields[6];
                existingTest[0].Latitide__c = Decimal.valueOf(fields[8]);
                existingTest[0].Longitude__c= Decimal.valueOf(fields[9]);                

                update existingTest;
                
                returnMsg = 'Record Updated';          
             }
            else
            {
           
                res.Date_of_Birth__c = dateOfBirth;
                res.Collection_Date__c = collectionDate;
                res.ELR_Result__c = ELRResult;
                res.First_Name__c = fields[1];
                res.Last_Name__c = fields[0];
                res.Mapped_Result__c = MappedResult;
                res.Provider__c = fields[14];
                res.Specimen_Type__c = fields[12];
                res.Submitted__c = fields[15];
                res.Test_Type__c = fields[17];
                res.Calc_Result__c = calcResult;
                res.Address__c = fields[3];
                res.City__c = fields[4];
                res.State__c = 'Colorado';
                res.Zip__c = fields[6];
                res.Latitide__c = Decimal.valueOf(fields[8]);
                res.Longitude__c= Decimal.valueOf(fields[9]);
                               
                insert res;
                
                returnMsg = 'Record Inserted';
            }
            
         }
         catch(Exception e){}
      }
    
    
    }
    
  }
  
      return returnMsg;
  }
  
webservice static String loadDeathRecord(String theRecord) {
  
  
    String returnMsg ='';
    DeathsReported__c res = new DeathsReported__c();
    Date reportedDate;
    Date dateOfBirth;
    Date admitDate;
    Date dischargeDate;
    Date dateOfDeath;
    
  
    if (theRecord != null)
    {
    
    
    
    system.debug('Passed String: ' + theRecord);
    if(theRecord.length() > 50)
    {
   
        List<List<String>> data = RT_CSVReader.read(theRecord);
        List<String> fields = data[0];
    
    
     
        Integer count = 0;
        for( String field : fields)
        {
           System.debug('' + count + ' ' + field);
           count++; 
        }
                

    if(fields.size()>0)
    {
        try
        {
        
            List<String> days = new List<String>();
            days = fields[3].split('/');
            if(days.size()==3)
            {
                reportedDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                res.Reported_Date__c = reportedDate;
            }
            else
            {
               CalloutException ex = new CalloutException();
               ex.setMessage('Missing Reported Date');
               throw ex;
            }
            
            
            List<String> DOBdays = new List<String>();
            DOBdays = fields[9].split('/');
            
            if(DOBdays.size()==3)
            {
                dateOfBirth = Date.newInstance(integer.valueof(DOBdays[2]), integer.valueof(DOBdays[0]),integer.valueof(DOBdays[1]));
                res.Birth_Date__c = dateOfBirth;
            }
            else
            {
               CalloutException ex2 = new CalloutException();
               ex2.setMessage('Missing Date of Birth');
               throw ex2;
            }
            
            List<String> DeathDays = new List<String>();
            DeathDays = fields[11].split('/');
            
            if(DeathDays.size()==3)
            {
                dateOfDeath = Date.newInstance(integer.valueof(DeathDays[2]), integer.valueof(DeathDays[0]),integer.valueof(DeathDays[1]));
                res.Date_of_Death__c = dateOfDeath;
            }
            else
            {
               CalloutException ex2 = new CalloutException();
               ex2.setMessage('Missing Date of Birth');
               throw ex2;
            }
            
            
            List<String> AdmitDays = new List<String>();
            AdmitDays = fields[23].split('/');
            
            if(AdmitDays.size()==3)
            {
                admitDate = Date.newInstance(integer.valueof(AdmitDays[2]), integer.valueof(AdmitDays[0]),integer.valueof(AdmitDays[1]));
                res.Hospital_Admit__c = admitDate;
            }
            
            List<String> DischargeDays = new List<String>();
            DischargeDays = fields[24].split('/');
            
            if(DischargeDays.size()==3)
            {
                dischargeDate = Date.newInstance(integer.valueof(DischargeDays[2]), integer.valueof(DischargeDays[0]),integer.valueof(DischargeDays[1]));
                res.Hospital_Discharge__c = dischargeDate;
            }
            
            
            
            
            String lastName = fields[6];
            String firstName = fields[7];
            String EventId = fields[0];
            
            List< DeathsReported__c > existingDeath = new List< DeathsReported__c >([Select Id
                                                                                    from DeathsReported__c where 
                                                                                    First_Name__c =: firstName AND 
                                                                                    Last_Name__c=:lastName AND 
                                                                                    Birth_Date__c = :dateOfBirth]);   
      
            If(existingDeath.size()>0)
            {
               
                returnMsg = 'Already Reported';

                
             }
            else
            {
            

                res.Event_ID__c = EventId;
                res.Ethnicity__c =fields[15];
                res.First_Name__c = firstName;
                res.Last_Name__c = lastName;
                res.Address__c = fields[16];
                res.City__c = fields[18];
                res.State__c = fields[19];
                res.Zip__c = fields[20];
                res.Case_Status__c =fields[2];
                res.Gender__c =fields[8];
                res.Homeless__c =fields[25];
                res.Hospital__c =fields[22];
                res.Hospitalized__c =fields[21];
                res.Institution__c = fields[26];
                res.Institution_Name__c = fields[28];
                res.Institution_Type__c = fields[27];
                res.Race__c = fields[14];
                
                
                insert res;
                
                returnMsg = 'Record Inserted';
            }
            
         }
         catch(Exception e)
         {
            
         }
        }
    
    
    }
    
  }
  
      return returnMsg;
  }  
  
webservice static String loadCaseRecord(String theRecord, String JobId) {

     System_Case_Load__c recData = New System_Case_Load__c();
     recData.JobID__c = JobId;
     recData.TextLine__c = theRecord;
     insert recData;
    
    
    String returnMsg ='';
    system.debug('Passed String: ' + theRecord);
    if(theRecord.length() > 50)
    {
   
      
        List<List<String>> data = RT_CSVReader.read(theRecord);
        List<String> fields = data[0];
        
        system.debug('******* Start Field Split *******');
        Integer count = 0;
        for( String field : fields)
        {
           System.debug('' + count + ' ' + field);
           count++; 
        }
        system.debug('******* End Field Split *******');
        
        HAE_Case__c newCase = new HAE_Case__c();
        HAE_Individual__c newIndividual = new HAE_Individual__c();
        HAE_Case_Contact__c newCaseContact = new HAE_Case_Contact__c();            
        
        if(fields.size()>0)
        {
            String eventId = fields[0];
            System.debug(eventId);
            
            List< HAE_Case__c > existingCase = new List< HAE_Case__c >([Select Id from HAE_Case__c where Event_ID__c=:eventId]);  
              
            If(existingCase.size()>0)
            {
                returnMsg = 'Case Already Logged';
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Record Already Exists For: ' + fields[0]+ ' : ' + fields[13] + ',' + fields[14] + ' skipping entry'));
                recData.Result__c = 'Duplicate';
                update recData;
              
            }
            else
            {
            
               
                    try
                    {
   
                        if (fields[15]=='Gender') //If this happens, it is a header row
                        { 
                           CalloutException ex = new CalloutException();
                           ex.setMessage('Header Row - Do Not Process');
                           throw ex;

                        }
                    
                         List<String> days = new List<String>();
                        
                       
                
                            days = fields[68].split('/');
                            Date collectionDate;
                            if(days.size()==3)
                            {
                                
                                collectionDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                                newCase.Specimen_Collection_Date__c = collectionDate;
                            }
                            
                            List< HAE_Case__c > LCTestCase = new List< HAE_Case__c >([Select Id, Event_ID__c, Specimen_Collection_Date__c, Primary_Individual__r.Last_Name__c, Primary_Individual__r.First_Name__c from HAE_Case__c where Primary_Individual__r.Last_Name__c=:fields[13] AND Primary_Individual__r.First_Name__c =:fields[14] AND Specimen_Collection_Date__c =:collectionDate AND Event_ID__c LIKE 'LC%']);  
              
                            if( LCTestCase.Size() > 0)
                            {
                               //There is a LCTestRecordMatch
                               
                               LCTestCase[0].Event_ID__c = eventId;
                               update LCTestCase;
                               CalloutException ex = new CalloutException();
                               ex.setMessage('Matched To A LCTestRecord');
                               throw ex;
                               
                            }
            
                            
                            days = new List<String>();
                            days = fields[3].split('/');
                            if(days.size()==3)
                            {
                                Date reportedDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                                newCase.Reported_Date__c = reportedDate;
                            }
                            
                            
                            days = new List<String>();
                            days = fields[4].split('/');
                            if(days.size()==3)
                            {
                                Date resultDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                                newCase.Result_Date__c = resultDate;
                                
                            }
                            
                            days = new List<String>();
                            days = fields[16].split('/');
                            if(days.size()==3)
                            {
                                Date dateOfBirth = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                                newIndividual.Date_of_Birth__c = dateOfBirth;
                            }
                              
                            
            
            
                            newCase.Event_ID__c = fields[0];
                            newCase.Case_Status__c = 'New';
                            newCase.Case_Type__c = 'CEDRS';
                            newCase.CEDRS_Case_Status__c = fields[2];
                            newCase.Disease__c = fields[1];
                            newCase.Specimen__c = fields[74];
                            newIndividual.Last_Name__c = fields[13];
                            newIndividual.First_Name__c = fields[14];
                            newIndividual.Gender__c = fields[15];          
                            newIndividual.Individual_Phone__c = fields[28];
                            newIndividual.address1__c = fields[29];
                            newIndividual.city__c = fields[31];
                            //newIndividual.Longitude__c = Decimal.valueOf(fields[108]);
                            //newIndividual.Latitude__c = Decimal.valueOf(fields[107]);
                            if(fields[32]=='Colorado' || fields[32]=='Colorado') { newIndividual.State__c = 'Colorado';}
                            newIndividual.zip__c = fields[33];
                            
                            insert newIndividual;
                            
                            newCase.Primary_Individual__c = newIndividual.Id;
                            
                            insert newCase;
                            
                            newCaseContact.HAE_Individual__c = newIndividual.Id;
                            newCaseContact.HAE_Case__c = newCase.Id;
                            newCaseContact.Primary_Individual__c = True;
                            newCaseContact.Contact_Type__c = 'Case';
                            
                           // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Inserting Records: ' + fields[0]+ ' : ' + fields[13] + ',' + fields[14]));
                                  
                            
                            insert newCaseContact;
                            
                            recData.Result__c = 'Success';
                            update recData;
                        
        
                     }
                     catch(Exception e)
                     {
                         
                         if(e.getMessage() == 'Matched To A LCTestRecord')
                         {
                             recData.Result__c = 'Matched LC Test Record';
                         }
                         else if(recData.TextLine__c=='",,,,,,,,,,No') 
                         {
                             recData.Result__c = 'Left Over';
                         }
                         else
                         {
                             recData.Result__c = 'Error';
                         }
                         
                         update recData;
                     }
                 }
        }
  
  
    }
    
  
   
    
    return returnMsg;
  
  }

webservice static String loadHistoricalCaseRecord(String theRecord) {

/* NO LONGER NEEDED
    String returnMsg ='';
    system.debug('Passed String: ' + theRecord);
    if(theRecord.length() > 10)
    {
   
      
        List<List<String>> data = RT_CSVReader.read(theRecord);
        List<String> fields = data[0];
        
        system.debug('******* Start Field Split *******');
        Integer count = 0;
        for( String field : fields)
        {
           System.debug('' + count + ' ' + field);
           count++; 
        }
        system.debug('******* End Field Split *******');
        
        HAE_Case__c newCase = new HAE_Case__c();
        HAE_Individual__c newIndividual = new HAE_Individual__c();
        HAE_Case_Contact__c newCaseContact = new HAE_Case_Contact__c();            
        
        if(fields.size()>0)
        {
            String eventId = fields[0];
            System.debug(eventId);
            
            List< HAE_Case__c > existingCase = new List< HAE_Case__c >([Select Id from HAE_Case__c where Event_ID__c=:eventId]);   
              
            If(existingCase.size()>0)
            {
                returnMsg = 'Case Already Logged';
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Record Already Exists For: ' + fields[0]+ ' : ' + fields[7] + ',' + fields[8] + ' skipping entry'));
              
            }
            else
            {
            
               
                    try
                    {
                        if (fields[9]=='Gender') //If this happens, it is a header row
                        { 
                           CalloutException ex = new CalloutException();
                           ex.setMessage('Header Row - Do Not Process');
                           throw ex;

                        }
                    
                        system.debug('collectiondate: ' + fields[4]);
                        List<String> days = new List<String>();
                        days = fields[4].split('/');
                        if(days.size()==3)
                        {
                            
                            Date collectionDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                            newCase.Specimen_Collection_Date__c = collectionDate;
                        }
                        
                        //days = new List<String>();
                        //days = fields[3].split('/');
                        if(days.size()==3)
                        {
                            Date reportedDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                            newCase.Reported_Date__c = reportedDate;
                        }
                        
                        
                        //days = new List<String>();
                        //days = fields[4].split('/');
                        if(days.size()==3)
                        {
                            Date resultDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                            newCase.Result_Date__c = resultDate;
                            
                        }
                        
                        days = new List<String>();
                        days = fields[10].split('/');
                        if(days.size()==3)
                        {
                            Date dateOfBirth = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                            newIndividual.Date_of_Birth__c = dateOfBirth;
                        }
                          
                       
        
        
                        newCase.Event_ID__c = fields[0];
                        newCase.Case_Status__c = 'History';
                        newCase.CEDRS_Case_Status__c = fields[6];
                        newCase.Disease__c = fields[2];
                        //newCase.Specimen__c = fields[2];
                        newIndividual.Last_Name__c = fields[7];
                        newIndividual.First_Name__c = fields[8];
                        newIndividual.Gender__c = fields[9];
                        if(fields[13]=='Unknown') 
                         {
                             newIndividual.Race__c = 'Declined to answer';
                         }
                         else
                          {
                            if(fields[13]=='Other Race') 
                            {
                                newIndividual.Race__c = 'Declined to answer';
                            }
                            else
                            {
                                if(fields[13]=='Native Hawaiian or Other Pacific Islander')
                                {
                                     newIndividual.Race__c = 'Native Hawaiian/Other Pacific Islander';
                                }
                                else
                                {
                                    newIndividual.Race__c = fields[13];
                                }
                            }
                         }
                        
                        //newIndividual.Race__c = fields[14];
                        if(fields[15] == 'Not Hispanic or Latino') NewIndividual.Ethnicity__c = 'No';
                        if(fields[15] == 'Hispanic or Latino') NewIndividual.Ethnicity__c = 'Yes';
                        if(fields[15] == 'Unknown') NewIndividual.Ethnicity__c = '';   
                                            
                        //newIndividual.Ethnicity__c = fields[15];
                        //newIndividual.Individual_Phone__c = fields[28];
                        //newIndividual.address1__c = fields[29];
                        //newIndividual.city__c = fields[31];
                        //newIndividual.Longitude__c = Decimal.valueOf(fields[108]);
                        //newIndividual.Latitude__c = Decimal.valueOf(fields[107]);
                        //if(fields[32]=='Colorado' || fields[32]=='Colorado') { newIndividual.State__c = 'Colorado';}
                        //newIndividual.zip__c = fields[33];
                        
                        insert newIndividual;
                        
                        newCase.Primary_Individual__c = newIndividual.Id;
                        
                        insert newCase;
                        
                        newCaseContact.HAE_Individual__c = newIndividual.Id;
                        newCaseContact.HAE_Case__c = newCase.Id;
                        newCaseContact.Primary_Individual__c = True;
                        newCaseContact.Contact_Type__c = 'Case';
                        
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Inserting Records: ' + fields[0]+ ' : ' + fields[7] + ',' + fields[8]));
                              
                        
                        insert newCaseContact;
        
                     }
                     catch(Exception e)
                     {
                     
                     }
                 }
        }
  
  
    }
    
  
   */
    
    return '';
  
  }


webservice static String loadCaseRecord_UniPath(String theRecord) {


    String returnMsg ='';
    system.debug('Passed String: ' + theRecord);
    if(theRecord.length() > 50)
    {
   
      
        List<List<String>> data = RT_CSVReader.read(theRecord);
        List<String> fields = data[0];
        
        system.debug('******* Start Field Split *******');
        Integer count = 0;
        for( String field : fields)
        {
           System.debug('' + count + ' ' + field);
           count++; 
        }
        system.debug('******* End Field Split *******');
                  
        
        if(fields.size()>0)
        {
            String eventId = fields[1];
            String TestResult = fields[27];
            System.debug(eventId);
            
            //LOCATE TEST SLOT AND BRING IN FIELDS
            List< TestingSlot__c > existingCase = new List< TestingSlot__c >([Select Id, Lab_Result__c, Result_Sent__c, TestID__c, EmailToSendTo__c from TestingSlot__c where TestID__c=:eventId AND Lab_Result__c = null]);
            
            
            
            If(existingCase.size()>0)
            {
                //UPDATE THE TEST RESULT
                
                String Status ='';
                String EmailAddress = existingCase[0].EmailToSendTo__c;

                If (TestResult == 'DETECTED') Status = 'Positive';
                If (TestResult == 'NOT DETECTED') Status = 'Negative';
                
                
                If (Status == 'Positive' || Status == 'Negative') 
                {
                
                    returnMsg = 'Test Found';
                
                    existingCase[0].Lab_Result__c = Status;
                    existingCase[0].Result_Sent__c = System.now();
                    
                    update existingCase;
                    
                    //SEND LAB RESULT
                    sendIndividualEmails.sendLabResults(EmailAddress, Status );
                }  
            }
            else
            {
                returnMsg = 'Test Not Located';
                CalloutException ex = new CalloutException();
                ex.setMessage('Test Not Located');
                throw ex;
            }
        }
  
  
    }
    
    return returnMsg;
  
  }

<<<<<<< HEAD

    webservice static String loadCaseContactRecord(String theRecord) {

    String returnMsg ='';
    system.debug('Passed String: ' + theRecord);


=======
webservice static String loadHistoricalCaseRecord(String theRecord) {


    String returnMsg ='';
    system.debug('Passed String: ' + theRecord);
    if(theRecord.length() > 10)
    {
   
      
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
        List<List<String>> data = RT_CSVReader.read(theRecord);
        List<String> fields = data[0];
        
        system.debug('******* Start Field Split *******');
        Integer count = 0;
        for( String field : fields)
        {
           System.debug('' + count + ' ' + field);
           count++; 
        }
        system.debug('******* End Field Split *******');
        
<<<<<<< HEAD
        HAE_Contact_Review__c newIndividual = new HAE_Contact_Review__c();

        String eventId = fields[0];
=======
        HAE_Case__c newCase = new HAE_Case__c();
        HAE_Individual__c newIndividual = new HAE_Individual__c();
        HAE_Case_Contact__c newCaseContact = new HAE_Case_Contact__c();            
        
        if(fields.size()>0)
        {
            String eventId = fields[0];
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
            System.debug(eventId);
            
            List< HAE_Case__c > existingCase = new List< HAE_Case__c >([Select Id from HAE_Case__c where Event_ID__c=:eventId]);   
              
            If(existingCase.size()>0)
            {
<<<<<<< HEAD
                returnMsg = 'Case Found';
                 List<String> days = new List<String>();
                        
                        days = fields[4].split('/');
                        if(days.size()==3)
                        
                        {
                            Date dateOfBirth = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                            newIndividual.Date_of_Birth__c = dateOfBirth;
                        }
                        
                        days = fields[15].split('/');
                        if(days.size()==3)
                        
                        {
                            Date exposure = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                            newIndividual.Last_Exposure__c = exposure;
                        }
                        
                        newIndividual.Notification_Type__c = fields[1];
                        newIndividual.First_Name__c = fields[2];
                        newIndividual.Last_Name__c = fields[3];
                        newIndividual.Parent_or_Guardian_Email__c = fields[6];
                        newIndividual.Street__c = fields[9];
                        newIndividual.City__c = fields[10];
                        newIndividual.State__c = fields[11];
                        newIndividual.ZipCode__c = fields[12];
                        //newIndividual.Last_Exposure__c = fields[15];    
                        newIndividual.Phone__c = fields[13];
                        
                        if(fields.size()>16) newIndividual.Language__c = fields[16];


                        if(fields[10]=='Colorado' || fields[10]=='Colorado') { newIndividual.State__c = 'Colorado';}

                        
                        newIndividual.EventID__c = existingCase[0].Id;
                        
                        insert newIndividual;
                                                                    
                        
                        //newCaseContact.HAE_Individual__c = newIndividual.Id;
                        //newCaseContact.HAE_Case__c = existingCase[0].Id;
                        //newCaseContact.Primary_Individual__c = False;
                        //newCaseContact.Contact_Type__c = '';  //make a new field
                        
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Inserting Records: ' + fields[0]+ ' : ' + fields[2] + ',' + fields[1]));
                              
                        
                        
                        
                }
              return returnMsg;
            }



 @InvocableMethod(label='Attach To Case')
 webservice static void attachContactsToCaseWS(List <String> recId) {
   
        String theRecord = recId[0];
    
        HAE_Contact_Review__c newContact = [Select Id, First_Name__c,Last_Name__c, Language__c, Notification_Type__c, Last_Exposure__c , Phone__c,City__c, Parent_or_Guardian_Email__c, State__c,Street__c, ZipCode__c, Date_of_Birth__c, EventID__c from HAE_Contact_Review__c where Id =:theRecord];
        
        List< HAE_Case__c > selectedCase = new List< HAE_Case__c >([Select Id from HAE_Case__c where Id=:newContact.EventID__c]);   
        HAE_Individual__c newIndividual = new HAE_Individual__c();
        HAE_Case_Contact__c newCaseContact = new HAE_Case_Contact__c();    
        HAE_Case_Interview__c newInterview = new HAE_Case_Interview__c();

        newIndividual.Date_of_Birth__c = newContact.Date_of_Birth__c;
        newIndividual.Last_Name__c = newContact.Last_Name__c;
        newIndividual.First_Name__c = newContact.First_Name__c;
        newIndividual.Email_Address__c = newContact.Parent_or_Guardian_Email__c;          
        newIndividual.Individual_Phone__c = newContact.Phone__c;
        newIndividual.address1__c = newContact.Street__c ;
        newIndividual.city__c = newContact.City__c;
        newIndividual.State__c = newContact.State__c;
        newIndividual.zip__c = newContact.ZipCode__c;
        newIndividual.Date_of_Last_Exposure__c = newContact.Last_Exposure__c;
        newIndividual.Monitoring_Type__c = 'Text';
        newIndividual.Txt_Phone_1__c = true;
        newIndividual.Correspondence_Language__c = newContact.Language__c;
        
        insert newIndividual;
                        
        
        newCaseContact.HAE_Individual__c = newIndividual.Id;
        newCaseContact.HAE_Case__c = selectedCase[0].Id;
        newCaseContact.Primary_Individual__c = False;
        newCaseContact.Contact_Type__c = '';  //make a new field
        
        insert newCaseContact;
        
        newInterview.HAE_Case__c = selectedCase[0].Id;
        newInterview.HAE_Individual__c = newIndividual.Id;
        newInterview.Exposure_Date__c = newContact.Last_Exposure__c;

        
        insert newInterview;
        
        String notificationType;
        if (newContact.Notification_Type__c == null)
        {
            notificationType = 'Low';
        }
        else
        {
            notificationType = newContact.Notification_Type__c;
        }

        if(newIndividual.Email_Address__c!=null && (notificationType.toUpperCase() != 'HIGH'))
        {
            sendContactQuarantineEmail  theBatch = new sendContactQuarantineEmail();        
            theBatch.theId = newInterview.Id;
            
            ID theBatchJob = Database.executeBatch(theBatch,1);
            
            newInterview.Interview_Status__C = 'Not Needed';
            newInterview.Interview_Not_Needed_Status__c = 'Electronically Contacted';
            newInterview.Completed_Date__c = System.Today();
            newInterview.LetterSent__c = true;
            newInterview.LetterSent_Date__c = System.now();
            newInterview.LetterSent_Type__c = 'Quarantine Letter - English';
            update newInterview;
        }


        newContact.Imported__C = true;
        update newContact;
        
        


   }
=======
                returnMsg = 'Case Already Logged';
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Record Already Exists For: ' + fields[0]+ ' : ' + fields[7] + ',' + fields[8] + ' skipping entry'));
              
            }
            else
            {
            
               
                    try
                    {
                        if (fields[9]=='Gender') //If this happens, it is a header row
                        { 
                           CalloutException ex = new CalloutException();
                           ex.setMessage('Header Row - Do Not Process');
                           throw ex;

                        }
                    
                        system.debug('collectiondate: ' + fields[4]);
                        List<String> days = new List<String>();
                        days = fields[4].split('/');
                        if(days.size()==3)
                        {
                            
                            Date collectionDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                            newCase.Specimen_Collection_Date__c = collectionDate;
                        }
                        
                        //days = new List<String>();
                        //days = fields[3].split('/');
                        if(days.size()==3)
                        {
                            Date reportedDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                            newCase.Reported_Date__c = reportedDate;
                        }
                        
                        
                        //days = new List<String>();
                        //days = fields[4].split('/');
                        if(days.size()==3)
                        {
                            Date resultDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                            newCase.Result_Date__c = resultDate;
                            
                        }
                        
                        days = new List<String>();
                        days = fields[10].split('/');
                        if(days.size()==3)
                        {
                            Date dateOfBirth = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                            newIndividual.Date_of_Birth__c = dateOfBirth;
                        }
                          
                       
        
        
                        newCase.Event_ID__c = fields[0];
                        newCase.Case_Status__c = 'History';
                        newCase.CEDRS_Case_Status__c = fields[6];
                        newCase.Disease__c = fields[2];
                        //newCase.Specimen__c = fields[2];
                        newIndividual.Last_Name__c = fields[7];
                        newIndividual.First_Name__c = fields[8];
                        newIndividual.Gender__c = fields[9];
                        if(fields[13]=='Unknown') 
                         {
                             newIndividual.Race__c = 'Declined to answer';
                         }
                         else
                          {
                            if(fields[13]=='Other Race') 
                            {
                                newIndividual.Race__c = 'Declined to answer';
                            }
                            else
                            {
                                if(fields[13]=='Native Hawaiian or Other Pacific Islander')
                                {
                                     newIndividual.Race__c = 'Native Hawaiian/Other Pacific Islander';
                                }
                                else
                                {
                                    newIndividual.Race__c = fields[13];
                                }
                            }
                         }
                        
                        //newIndividual.Race__c = fields[14];
                        if(fields[15] == 'Not Hispanic or Latino') NewIndividual.Ethnicity__c = 'No';
                        if(fields[15] == 'Hispanic or Latino') NewIndividual.Ethnicity__c = 'Yes';
                        if(fields[15] == 'Unknown') NewIndividual.Ethnicity__c = '';   
                                            
                        //newIndividual.Ethnicity__c = fields[15];
                        //newIndividual.Individual_Phone__c = fields[28];
                        //newIndividual.address1__c = fields[29];
                        //newIndividual.city__c = fields[31];
                        //newIndividual.Longitude__c = Decimal.valueOf(fields[108]);
                        //newIndividual.Latitude__c = Decimal.valueOf(fields[107]);
                        //if(fields[32]=='Colorado' || fields[32]=='Colorado') { newIndividual.State__c = 'Colorado';}
                        //newIndividual.zip__c = fields[33];
                        
                        insert newIndividual;
                        
                        newCase.Primary_Individual__c = newIndividual.Id;
                        
                        insert newCase;
                        
                        newCaseContact.HAE_Individual__c = newIndividual.Id;
                        newCaseContact.HAE_Case__c = newCase.Id;
                        newCaseContact.Primary_Individual__c = True;
                        newCaseContact.Contact_Type__c = 'Case';
                        
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Inserting Records: ' + fields[0]+ ' : ' + fields[7] + ',' + fields[8]));
                              
                        
                        insert newCaseContact;
        
                     }
                     catch(Exception e)
                     {
                     
                     }
                 }
        }
  
  
    }
    
  
   
    
    return returnMsg;
  
  }




>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
}