global class testingProcessesCSV {

     webservice static Boolean runningInASandbox() {
        return [SELECT Id, IsSandbox FROM Organization LIMIT 1].IsSandbox;
      }
    

      webservice static String generateLabCSV(Date theDay, String theLocation, String requestorEmail) {
      
<<<<<<< HEAD
          
          runningInASandbox();
          
=======
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
          String returnMessage = '';
          
          List <TestingSlot__c> pendingTests = new List<TestingSlot__c>([Select Id, 
                                                                      TestId__c,
                                                                      TestingDay__r.Day__c, 
                                                                      TestingRegistration__r.Last_Name__c,
                                                                      TestingRegistration__r.First_Name__c,
                                                                      TestingRegistration__r.Middle_Name__c,
                                                                      TestingRegistration__r.DOB__c,
                                                                      TestingRegistration__r.Gender__c,
                                                                      TestingRegistration__r.Address__c,
                                                                      TestingRegistration__r.City__c,
                                                                      TestingRegistration__r.State__c,
                                                                      TestingRegistration__r.Zip_Code__c,
                                                                      TestingRegistration__r.County_Of_Residence__c,
                                                                      TestingRegistration__r.Phone_Number__c,
                                                                      TestingRegistration__r.Email_Address__c,
                                                                      TestingRegistration__r.Race__c,
                                                                      TestingRegistration__r.Ethnicity__c,
                                                                      TestingRegistration__r.Reason_For_Testins__c,
                                                                      TestingRegistration__r.Employer__c,
                                                                      TestingRegistration__r.Local_Provider__c,
                                                                      TestingRegistration__r.Date_of_Symptoms__c
                                                                      from TestingSlot__c
                                                                      Where
                                                                      TestingDay__r.Day__c =: theDay AND
                                                                      TestingDay__r.Location__c =: theLocation AND
<<<<<<< HEAD
                                                                      Checked_In__c = true AND
                                                                      Test_Type__c <> 'BINAX'
                                                                      Order By 
                                                                      TestID__c,
=======
                                                                      Checked_In__c = true
                                                                      Order By 
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
                                                                      TestingRegistration__r.Last_Name__c,
                                                                      TestingRegistration__r.First_Name__c
                                                                      ]);
         String s = line(new String[] {
                format('Cust_ID'),
                format('Sample_ID'),
                format('Collect_Date'),
                format('Collector'),
                format('Patient_First_Name'),
                format('Patient_Middle_Name'),
                format('Patient_Last_Name'),
                format('Patient_Maiden_Name'),
                format('Patient DOB'),
                format('Patient_Gender'),
                format('Patient_Street_Addr'),
                format('Patient_City'),
                format('Patient State'),
                format('Patient_Zip'),
                format('Patient_County'),
                format('Patient_Country'),
                format('Patient_Phone'),
                format('Patient_E-Mail'),
                format('Patient_Race'),
                format('Patient_Ethnicity'),
                format('Notes'),
                format('Test_Reason'),
                format('Symptom_Onset'),
                format('Employer'),
                format('Provider')
                });
          
         for(TestingSlot__c theRecord : pendingTests)
         {
         
             String Gender ='';
             if(theRecord.TestingRegistration__r.Gender__c=='Female') Gender = 'F';
             if(theRecord.TestingRegistration__r.Gender__c=='Male') Gender = 'M';
             if(theRecord.TestingRegistration__r.Gender__c=='Unknown') Gender = 'U';
             if(theRecord.TestingRegistration__r.Gender__c=='Other') Gender = 'O';
             if(theRecord.TestingRegistration__r.Gender__c=='Ambiguous') Gender = 'A';
             if(theRecord.TestingRegistration__r.Gender__c=='Not-Applicable') Gender = 'N';
             
             String Ethnicity='';
             if(theRecord.TestingRegistration__r.Ethnicity__c=='Not Hispanic') Ethnicity='N';
             if(theRecord.TestingRegistration__r.Ethnicity__c=='Hispanic') Ethnicity='H';
             if(theRecord.TestingRegistration__r.Ethnicity__c=='Unknown') Ethnicity='U';
             
             String Race='';
             if(theRecord.TestingRegistration__r.Race__c == 'American Indian or Alaska Native') Race ='AmInd_AlaNat';
             if(theRecord.TestingRegistration__r.Race__c == 'Asian') Race ='Other';
             if(theRecord.TestingRegistration__r.Race__c == 'Black or African American') Race ='Black';
             if(theRecord.TestingRegistration__r.Race__c == 'Hispanic or Latino') Race ='';
             if(theRecord.TestingRegistration__r.Race__c == 'Native Hawaiian/Pac. Islander') Race ='Hawaii';
             if(theRecord.TestingRegistration__r.Race__c == 'White') Race ='White';
             If(Race=='') Race = 'Other';
   
             String theFixedAddress = theRecord.TestingRegistration__r.Address__c;
<<<<<<< HEAD
             if(theFixedAddress != null) theFixedAddress=theFixedAddress.replaceAll(',', ';');
=======
             theFixedAddress=theFixedAddress.replaceAll(',', ';');
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
   
             s += line(new String[] {
                    '38',
                    format(theRecord.TestID__c),
                    format(theRecord.TestingDay__r.Day__c),
                    format('Larimer County Health Department'),
                    format(theRecord.TestingRegistration__r.First_Name__c),
                    format(theRecord.TestingRegistration__r.Middle_Name__c),
                    format(theRecord.TestingRegistration__r.Last_Name__c),
                    format(''),                    
                    format(theRecord.TestingRegistration__r.DOB__c),
                    format(Gender),
                    format(theFixedAddress),
                    format(theRecord.TestingRegistration__r.City__c),
                    format(theRecord.TestingRegistration__r.State__c),
                    format(theRecord.TestingRegistration__r.Zip_Code__c),
                    format(theRecord.TestingRegistration__r.County_Of_Residence__c),
                    format('USA'),                    
                    format(theRecord.TestingRegistration__r.Phone_Number__c),
                    format(theRecord.TestingRegistration__r.Email_Address__c),
                    format(Race),
                    format(Ethnicity),
                    format(''),
                    format(theRecord.TestingRegistration__r.Reason_For_Testins__c),
                    format(theRecord.TestingRegistration__r.Date_of_Symptoms__c),
                    format(theRecord.TestingRegistration__r.Employer__c),
                    format(theRecord.TestingRegistration__r.Local_Provider__c)
                    });

         } 
          System.Debug(s);
<<<<<<< HEAD

          return s;
      
      
      }
      
        webservice static String generateLabCSVBiodesix(Date theDay, String theLocation, String requestorEmail) {
      
          
          runningInASandbox();
          
          String returnMessage = '';
          
          List <TestingSlot__c> pendingTests = new List<TestingSlot__c>([Select Id, 
                                                                      TestId__c,
                                                                      TestingDay__r.Day__c, 
                                                                      TestingRegistration__r.Last_Name__c,
                                                                      TestingRegistration__r.First_Name__c,
                                                                      TestingRegistration__r.Middle_Name__c,
                                                                      TestingRegistration__r.DOB__c,
                                                                      TestingRegistration__r.Gender__c,
                                                                      TestingRegistration__r.Address__c,
                                                                      TestingRegistration__r.City__c,
                                                                      TestingRegistration__r.State__c,
                                                                      TestingRegistration__r.Zip_Code__c,
                                                                      TestingRegistration__r.County_Of_Residence__c,
                                                                      TestingRegistration__r.Phone_Number__c,
                                                                      TestingRegistration__r.Email_Address__c,
                                                                      TestingRegistration__r.Race__c,
                                                                      TestingRegistration__r.Ethnicity__c,
                                                                      TestingRegistration__r.Reason_For_Testins__c,
                                                                      TestingRegistration__r.Employer__c,
                                                                      TestingRegistration__r.Local_Provider__c,
                                                                      TestingRegistration__r.Date_of_Symptoms__c
                                                                      from TestingSlot__c
                                                                      Where
                                                                      TestingDay__r.Day__c =: theDay AND
                                                                      TestingDay__r.Location__c =: theLocation AND
                                                                      Checked_In__c = true
                                                                      AND
                                                                      Test_Type__c <> 'BINAX'
                                                                      Order By 
                                                                      TestID__c,
                                                                      TestingRegistration__r.Last_Name__c,
                                                                      TestingRegistration__r.First_Name__c
                                                                      ]);
         String s = line(new String[] {
                format('CustID'),
                format('Sample ID'),
                format('Collect Date'),
                format('Location'),
                format('Patient First Name'),
                format('Patient Middle Name'),
                format('Patient Last Name'),
                format('Patient Maiden Name'),
                format('Patient DOB'),
                format('Patient Gender'),
                format('Patient Address'),
                //format('PatientCity'),
                //format('PatientState'),
                //format('PatientZip'),
                format('Patient County'),
                format('Patient Country'),
                format('Patient Phone'),
                format('Patient E-Mail'),
                format('Patient Race'),
                format('Patient Ethnicity'),
                format('Notes'),
                format('Test Reason'),
                format('Symptom Onset'),
                format('Employer'),
                format('Provider')
                });
          
         for(TestingSlot__c theRecord : pendingTests)
         {
         
             String Gender ='';
             if(theRecord.TestingRegistration__r.Gender__c=='Female') Gender = 'F';
             if(theRecord.TestingRegistration__r.Gender__c=='Male') Gender = 'M';
             if(theRecord.TestingRegistration__r.Gender__c=='Unknown') Gender = 'U';
             if(theRecord.TestingRegistration__r.Gender__c=='Other') Gender = 'O';
             if(theRecord.TestingRegistration__r.Gender__c=='Ambiguous') Gender = 'A';
             if(theRecord.TestingRegistration__r.Gender__c=='Not-Applicable') Gender = 'N';
             
             String Ethnicity='';
             if(theRecord.TestingRegistration__r.Ethnicity__c=='Not Hispanic') Ethnicity='N';
             if(theRecord.TestingRegistration__r.Ethnicity__c=='Hispanic') Ethnicity='H';
             if(theRecord.TestingRegistration__r.Ethnicity__c=='Unknown') Ethnicity='U';
             
             String Race='';
             if(theRecord.TestingRegistration__r.Race__c == 'American Indian or Alaska Native') Race ='AmInd_AlaNat';
             if(theRecord.TestingRegistration__r.Race__c == 'Asian') Race ='Other';
             if(theRecord.TestingRegistration__r.Race__c == 'Black or African American') Race ='Black';
             if(theRecord.TestingRegistration__r.Race__c == 'Hispanic or Latino') Race ='';
             if(theRecord.TestingRegistration__r.Race__c == 'Native Hawaiian/Pac. Islander') Race ='Hawaii';
             if(theRecord.TestingRegistration__r.Race__c == 'White') Race ='White';
             If(Race=='') Race = 'Other';
   
             String theFixedAddress = theRecord.TestingRegistration__r.Address__c;
             if(theFixedAddress != null) theFixedAddress=theFixedAddress.replaceAll(',', ';');
   
             s += line(new String[] {
                    '38',
                    format(theRecord.TestID__c),
                    format(theRecord.TestingDay__r.Day__c),
                    format('Larimer County Health Department'),
                    format(theRecord.TestingRegistration__r.First_Name__c),
                    format(theRecord.TestingRegistration__r.Middle_Name__c),
                    format(theRecord.TestingRegistration__r.Last_Name__c),
                    format(''),                    
                    format(theRecord.TestingRegistration__r.DOB__c),
                    format(Gender),
                    format(theFixedAddress + ' ' +theRecord.TestingRegistration__r.City__c + ' ' + theRecord.TestingRegistration__r.State__c + ' ' + theRecord.TestingRegistration__r.Zip_Code__c ),
                    format(theRecord.TestingRegistration__r.County_Of_Residence__c),
                    format('USA'),                    
                    format(theRecord.TestingRegistration__r.Phone_Number__c),
                    format(theRecord.TestingRegistration__r.Email_Address__c),
                    format(Race),
                    format(Ethnicity),
                    format(''),
                    format(theRecord.TestingRegistration__r.Reason_For_Testins__c),
                    format(theRecord.TestingRegistration__r.Date_of_Symptoms__c),
                    format(theRecord.TestingRegistration__r.Employer__c),
                    format(theRecord.TestingRegistration__r.Local_Provider__c)
                    });

         } 
          System.Debug(s);
        
 
          return s;
=======
          
        List<String> EmailIds = new List<String>();
        EmailIds.add(requestorEmail);
        
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Health FollowUp'];
        Blob b;
        b = blob.valueOf(s);

                
        String body ='Hello<br /><br />';
        body += 'This is your requested LAB CSV<br/><br/>';
        

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
 
        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName('labExport.csv');
        efa1.setBody(b);
 
        String addresses;
        email.setSubject( 'LAB Export from Larimer County Department of Health and Environment');
        email.setToAddresses( EmailIds  );
        email.setHtmlBody(body);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
        email.setOrgWideEmailAddressId(owea.Id);
       
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
          
 
          return returnMessage;
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
      
      
      }
      
<<<<<<< HEAD
  
     webservice static String generateLabCSV_BINAX(Date theDay, String theLocation, String requestorEmail) {
      
          
          runningInASandbox();
          
          String returnMessage = '';
          
          List <TestingSlot__c> pendingTests = new List<TestingSlot__c>([Select Id, 
                                                                      TestId__c,
                                                                      TestingDay__r.Day__c, 
                                                                      TestingRegistration__r.Last_Name__c,
                                                                      TestingRegistration__r.First_Name__c,
                                                                      TestingRegistration__r.Middle_Name__c,
                                                                      TestingRegistration__r.DOB__c,
                                                                      TestingRegistration__r.Gender__c,
                                                                      TestingRegistration__r.Address__c,
                                                                      TestingRegistration__r.City__c,
                                                                      TestingRegistration__r.State__c,
                                                                      TestingRegistration__r.Zip_Code__c,
                                                                      TestingRegistration__r.County_Of_Residence__c,
                                                                      TestingRegistration__r.Phone_Number__c,
                                                                      TestingRegistration__r.Email_Address__c,
                                                                      TestingRegistration__r.Race__c,
                                                                      TestingRegistration__r.Ethnicity__c,
                                                                      TestingRegistration__r.Reason_For_Testins__c,
                                                                      TestingRegistration__r.Employer__c,
                                                                      TestingRegistration__r.Local_Provider__c,
                                                                      TestingRegistration__r.Date_of_Symptoms__c,
                                                                      Test_Type__c,
                                                                      Lab_Result__c,
                                                                      Lot_Number__c,
                                                                      Expiration_Date__c,
                                                                      Passed_QC__c
                                                                      from TestingSlot__c
                                                                      Where
                                                                      TestingDay__r.Day__c =: theDay AND
                                                                      TestingDay__r.Location__c =: theLocation AND
                                                                      Checked_In__c = true AND
                                                                      Test_Type__c = 'BINAX'
                                                                      Order By 
                                                                      TestID__c,
                                                                      TestingRegistration__r.Last_Name__c,
                                                                      TestingRegistration__r.First_Name__c
                                                                      ]);
         String s = line(new String[] {
                format('Cust_ID'),
                format('Sample_ID'),
                format('Test_Type'),
                format('Test_Result'),
                format('Lot_Number__c'),
                format('Expiration_Date__c'),
                format('Passed_QC__c'),
                format('Collect_Date'),
                format('Collector'),
                format('Patient_First_Name'),
                format('Patient_Middle_Name'),
                format('Patient_Last_Name'),
                format('Patient_Maiden_Name'),
                format('Patient DOB'),
                format('Patient_Gender'),
                format('Patient_Street_Addr'),
                format('Patient_City'),
                format('Patient State'),
                format('Patient_Zip'),
                format('Patient_County'),
                format('Patient_Country'),
                format('Patient_Phone'),
                format('Patient_E-Mail'),
                format('Patient_Race'),
                format('Patient_Ethnicity'),
                format('Notes'),
                format('Test_Reason'),
                format('Symptom_Onset'),
                format('Employer'),
                format('Provider')
                });
          
         for(TestingSlot__c theRecord : pendingTests)
         {
         
             String Gender ='';
             if(theRecord.TestingRegistration__r.Gender__c=='Female') Gender = 'F';
             if(theRecord.TestingRegistration__r.Gender__c=='Male') Gender = 'M';
             if(theRecord.TestingRegistration__r.Gender__c=='Unknown') Gender = 'U';
             if(theRecord.TestingRegistration__r.Gender__c=='Other') Gender = 'O';
             if(theRecord.TestingRegistration__r.Gender__c=='Ambiguous') Gender = 'A';
             if(theRecord.TestingRegistration__r.Gender__c=='Not-Applicable') Gender = 'N';
             
             String Ethnicity='';
             if(theRecord.TestingRegistration__r.Ethnicity__c=='Not Hispanic') Ethnicity='N';
             if(theRecord.TestingRegistration__r.Ethnicity__c=='Hispanic') Ethnicity='H';
             if(theRecord.TestingRegistration__r.Ethnicity__c=='Unknown') Ethnicity='U';
             
             String Race='';
             if(theRecord.TestingRegistration__r.Race__c == 'American Indian or Alaska Native') Race ='AmInd_AlaNat';
             if(theRecord.TestingRegistration__r.Race__c == 'Asian') Race ='Other';
             if(theRecord.TestingRegistration__r.Race__c == 'Black or African American') Race ='Black';
             if(theRecord.TestingRegistration__r.Race__c == 'Hispanic or Latino') Race ='';
             if(theRecord.TestingRegistration__r.Race__c == 'Native Hawaiian/Pac. Islander') Race ='Hawaii';
             if(theRecord.TestingRegistration__r.Race__c == 'White') Race ='White';
             If(Race=='') Race = 'Other';
   
             String QC ='';
             if(theRecord.Passed_QC__c) {QC = 'True';} else{ QC = 'False';}
           
   
   
             String theFixedAddress = theRecord.TestingRegistration__r.Address__c;
             if(theFixedAddress != null) theFixedAddress=theFixedAddress.replaceAll(',', ';');
   
             s += line(new String[] {
                    '38',
                    format(theRecord.TestID__c),
                    format(theRecord.Test_Type__c),
                    format(theRecord.Lab_Result__c), 
                    format(theRecord.Lot_Number__c),
                    format(theRecord.Expiration_Date__c),
                    format(QC),       
                    format(theRecord.TestingDay__r.Day__c),
                    format('Larimer County Health Department'),
                    format(theRecord.TestingRegistration__r.First_Name__c),
                    format(theRecord.TestingRegistration__r.Middle_Name__c),
                    format(theRecord.TestingRegistration__r.Last_Name__c),
                    format(''),                    
                    format(theRecord.TestingRegistration__r.DOB__c),
                    format(Gender),
                    format(theFixedAddress),
                    format(theRecord.TestingRegistration__r.City__c),
                    format(theRecord.TestingRegistration__r.State__c),
                    format(theRecord.TestingRegistration__r.Zip_Code__c),
                    format(theRecord.TestingRegistration__r.County_Of_Residence__c),
                    format('USA'),                    
                    format(theRecord.TestingRegistration__r.Phone_Number__c),
                    format(theRecord.TestingRegistration__r.Email_Address__c),
                    format(Race),
                    format(Ethnicity),
                    format(''),
                    format(theRecord.TestingRegistration__r.Reason_For_Testins__c),
                    format(theRecord.TestingRegistration__r.Date_of_Symptoms__c),
                    format(theRecord.TestingRegistration__r.Employer__c),
                    format(theRecord.TestingRegistration__r.Local_Provider__c)
                    });

         } 
          System.Debug(s);
          

          return s;
      
      
      } 
=======
      
  
      
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
      
      
      
    private static String line(String[] cells) {
       return String.join(cells, ',') + '\n';
    }
    private static String format(Date d)    {
        return d != null ? '"' + d.format().escapeCsv() + '"' : '""';
    }
    private static String format(String s) {
        return s != null ? '"' + s.escapeCsv() + '"' : '""';
    }
    private static String format(Decimal d, Integer scale) {
        return d != null ? String.valueOf(d.setScale(scale)) : '';
    }
    private static String format(Decimal d) {
        return format(d, 2);
    }
<<<<<<< HEAD

=======
>>>>>>> 2a90525978adce2efc7b68bdb1f7e2eb83810854
}