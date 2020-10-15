global class sendIndividualEmails {

    webservice static String sendCorrectLetter(String theInterviewToUse ){

        String returnMsg ='';

        HAE_Case_Interview__c theInterview = [Select Id, Probable_Case_Score__c, EmailAddress__c, Current_Symptoms__c, LetterSent__c, LetterSent_Date__c, LetterSent_Type__c, LetterLanguage__c, Date_of_Symptoms__c, Infectious_End_Date__c, Primary_Case_Interview__c from HAE_Case_Interview__c where Id =:theInterviewToUse];
        
        theInterview.LetterSent__c = true;
        theInterview.LetterSent_Date__c = System.now();
                
        
        if(theInterview.Primary_Case_Interview__c || theInterview.Probable_Case_Score__c >=2 )
        {
            if(theInterview.LetterLanguage__c == 'Spanish')
            {
                theInterview.LetterSent_Type__c = 'Isolation Letter - Spanish';
                sendIsolationEmailSpanish(theInterview.Id,theInterview.EmailAddress__c);
                returnMsg = 'Spanish Isolation Letter Transmitted';
            }
            else 
            {
                theInterview.LetterSent_Type__c = 'Isolation Letter - English';
                sendIsolationEmail(theInterview.Id,theInterview.EmailAddress__c);
                returnMsg = 'English Isolation Letter Transmitted';
            }
        }
        else 
        {
                if(theInterview.LetterLanguage__c == 'Spanish')
                {
                    theInterview.LetterSent_Type__c = 'Quarantine Letter - Spanish';
                    sendQuarantineEmailSpanish(theInterview.Id,theInterview.EmailAddress__c);
                    returnMsg = 'Spanish Quarantine Letter Transmitted';
                }
                else 
                {
                    theInterview.LetterSent_Type__c = 'Quarantine Letter - English';
                    sendQuarantineEmail(theInterview.Id,theInterview.EmailAddress__c);
                    returnMsg = 'English Quarantine Letter Transmitted';
                }    
        }
        
        update theInterview;

        return returnMsg;

    }



    webservice static void sendIsolationEmail(String theInterview, String EmailAddress){

        List<String> EmailIds = new List<String>();
        EmailIds.add(EmailAddress);
        
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Health FollowUp'];

        PageReference theDoc = Page.letter_Isolation;
        theDoc.getParameters().put('Id',theInterview);
        Blob b;

         if(Test.isRunningTest()){
                b = blob.valueOf('Unit.Test');
            }else{
                b = theDoc.getContentAsPDF();}
                
        String body ='Hello<br /><br />';
        body += 'This is your follow up email from the conversation you had with the Larimer County Department of Health and Environment regarding COVID-19.<br/><br/>';
        body += 'If you are currently experiencing symptoms or have tested positive for coronavirus:<br/>';
        body += 'It is very important for the safety of your friends, family and the larger community that you follow these <a href="https://drive.google.com/file/d/1I_yLlsn3X0mgC3HhZKuSUEf-_ptKTaHV/view">Isolation Guidelines</a>.<br /><br />'; 
        body += 'If you are a close contact of someone who tested positive and are not experiencing symptoms: <br />Follow these <a href="https://drive.google.com/file/d/1r6wxcnDF9cMvS8IsK5WlZKeYSkR1j4vQ/view?usp=sharing">Quarantine Guidelines</a>. In the event that you do develop symptoms during the quarantine period, please follow the Isolation Guidelines provided above to determine when it is appropriate for you to resume your normal activities.<br /><br />';
        body += '*Please note, we are asking for voluntary compliance of these public health orders. Individuals who fail to comply with public health orders may be subject to penalties contained §25-1-114 and 25-1-516, Colorado Revised Statutes, including up to eighteen months imprisonment, or a fine up to five thousand dollars or both. <br /><br/>';
        body += 'Testing:<br/>';    
        body += 'Close contacts of confirmed cases can sign up <a href="https://www.larimer.org/health/communicable-disease/coronavirus-covid-19/home-care-and-testing-information/community-covid">here</a> to be tested for COVID-19 at our community testing events.. We are currently conducting testing for close contacts of confirmed cases who are both symptomatic and asymptomatic (no symptoms). <br/>';
        body += '<ul><li>Please note, a negative test result will not affect the quarantine period (i.e. if a close contact tests negative within 14 days of an exposure, they still need to quarantine for the full 14 days).</li>';
        body += '<li>Test results are most accurate 5-7 days after an exposure to someone with COVID-19. We recommend you schedule testing 5-7 days after your LAST contact with someone who is positive for COVID-19.</li></ul>';
        body += '<br />We know this is a lot of information and you might have questions. Please don’t hesitate to reach out via email at larimerhealthfollowup@co.larimer.co.us, or you can call our Joint Information Center at 970-498-5500. You can also text questions to 970-999-1770.<br /><br />Thank you';


        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
 
        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName('isolationOrder.pdf');
        efa1.setBody(b);
 
        String addresses;
        email.setSubject( 'Followup from Larimer County Department of Health and Environment');
        email.setToAddresses( EmailIds  );
        email.setHtmlBody(body);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
        email.setOrgWideEmailAddressId(owea.Id);
       
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }

     webservice static void sendIsolationEmailSpanish(String theInterview, String EmailAddress ){

        List<String> EmailIds = new List<String>();
        EmailIds.add(EmailAddress);
        
                
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Health FollowUp'];


        
        PageReference theDoc = Page.letter_Isolation_Spanish;
        theDoc.getParameters().put('Id',theInterview);
        Blob b;

         if(Test.isRunningTest()){
                b = blob.valueOf('Unit.Test');
            }else{
                b = theDoc.getContentAsPDF();}

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
 
        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName('isolationOrder.pdf');
        efa1.setBody(b);
 
        String body='Hola,<br /><br />';
        body += 'Este es su correo electrónico de seguimiento de la conversación que mantuvo con el Departamento de Salud y Medio Ambiente del Condado de Larimer con respecto a COVID-19.<br /><br />';
        body += 'Si actualmente experimenta síntomas o ha dado positivo por coronavirus:<br />';
        body += 'Es muy importante para la seguridad de sus amigos, familiares y la comunidad en general que siga estas * <a href="https://drive.google.com/file/d/1q-t-IUButOxhty53Kcj_dgZf0cHc2edR/view">Pautas de aislamiento</a><br />';
        body += 'Si eres un contacto cercano de alguien que dio positivo y no experimenta síntomas:<br />';
        body += 'Siga estas <a href="https://drive.google.com/file/d/1zMy3D0j1m3MGwuMYWe04TBVZfra8xxWP/view?usp=sharing">Pautas de cuarentena</a> . En caso de que desarrolle síntomas durante el período de cuarentena, siga las “Pautas de aislamiento” proporcionadas anteriormente para determinar cuándo es apropiado que reanude sus actividades normales.<br /><br />';
        body += 'Las personas que no cumplan con las órdenes de salud pública pueden estar sujetas a sanciones contenidas en §25-1-114 y 25-1-516, los Estatutos Revisados de Colorado, que incluyen hasta dieciocho meses de prisión, o una multa de hasta cinco mil dólares o ambas.<br /><br />';
        body += 'Pruebas:<br />';
        body += 'Los contactos cercanos de casos confirmados pueden inscribirse <a href="https://www.larimer.org/health/communicable-disease/coronavirus-covid-19/think-or-know-you-have-covid-19/covid-19-testing">aquí</a> para ser probados para COVID-19 en nuestros eventos de pruebas de la comunidad. Actualmente estamos realizando pruebas para contactos cercanos de casos confirmados que son sintomáticos y asintomáticos (sin síntomas).<br />';
        body += '<ul><li>Tenga en cuenta que un resultado negativo de la prueba no afectará el período de cuarentena (es decir, si un contacto cercano resulta negativo dentro de los 14 días posteriores a la exposición, aún deben poner en cuarentena durante los 14 días completos).</li>';
        body += '<li>Los resultados de la prueba son más precisos 5-7 días después de una exposición a alguien con COVID-19. Le recomendamos que programe las pruebas 5-7 días después de su ÚLTIMO contacto con alguien que sea positivo para COVID-19.</li></ul>';
        body += 'Sabemos que esta es mucha información y es posible que tenga preguntas. No dude en comunicarse por correo electrónico a larimerhealthfollowup@co.larimer.co.us, o puede llamar a nuestro Centro de información conjunta al 970-498-5500. También puede enviar sus preguntas al 970-999-1770.<br /><br />';
        body += 'Gracias';

        String addresses;
        email.setSubject( 'Seguimiento del Departamento de Salud del Condado de Larimer');
        email.setToAddresses( EmailIds  );
        email.setHtmlBody(body);
          email.setOrgWideEmailAddressId(owea.Id);
      
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }

     webservice static void sendQuarantineEmail(String theInterview, String EmailAddress ){

        List<String> EmailIds = new List<String>();
        EmailIds.add(EmailAddress);
                
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Health FollowUp'];
        
         
        PageReference theDoc = Page.letter_Quarantine;
        theDoc.getParameters().put('Id',theInterview);
        Blob b;

         if(Test.isRunningTest()){
                b = blob.valueOf('Unit.Test');
            }else{
                b = theDoc.getContentAsPDF();}
        
        String body ='Hello<br /><br />';
        body += 'This is your follow up email from the conversation you had with the Larimer County Department of Health and Environment regarding COVID-19.<br/><br/>';
        body += 'If you are currently experiencing symptoms or have tested positive for coronavirus:<br/>';
        body += 'It is very important for the safety of your friends, family and the larger community that you follow these <a href="https://drive.google.com/file/d/1XAsArqQGwXk9zYPFNPxZKZl0QkijQAyJ/view?usp=sharing">Isolation Guidelines</a>.<br /><br />'; 
        body += 'If you are a close contact of someone who tested positive and are not experiencing symptoms: <br />Follow these <a href="https://drive.google.com/file/d/1r6wxcnDF9cMvS8IsK5WlZKeYSkR1j4vQ/view?usp=sharing">Quarantine Guidelines</a>. In the event that you do develop symptoms during the quarantine period, please follow the Isolation Guidelines provided above to determine when it is appropriate for you to resume your normal activities.<br /><br />';
        body += '*Please note, we are asking for voluntary compliance of these public health orders. Individuals who fail to comply with public health orders may be subject to penalties contained §25-1-114 and 25-1-516, Colorado Revised Statutes, including up to eighteen months imprisonment, or a fine up to five thousand dollars or both. <br /><br/>';
        body += 'Testing:<br/>';    
        body += 'Close contacts of confirmed cases can sign up <a href="https://www.larimer.org/covid-19-testing">here</a> to be tested for COVID-19 at our community testing events.. We are currently conducting testing for close contacts of confirmed cases who are both symptomatic and asymptomatic (no symptoms). <br/>';
        body += '<ul><li>Please note, a negative test result will not affect the quarantine period (i.e. if a close contact tests negative within 14 days of an exposure, they still need to quarantine for the full 14 days).</li>';
        body += '<li>Test results are most accurate 5-7 days after an exposure to someone with COVID-19. We recommend you schedule testing 5-7 days after your LAST contact with someone who is positive for COVID-19.</li></ul>';
        body += '<br />We know this is a lot of information and you might have questions. Please don’t hesitate to reach out via email at larimerhealthfollowup@co.larimer.co.us, or you can call our Joint Information Center at 970-498-5500. You can also text questions to 970-999-1770.<br /><br />Thank you';

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
 
        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName('quarantineOrder.pdf');
        efa1.setBody(b);
 
        String addresses;
        email.setSubject( 'Followup from Larimer County Department of Health and Environment');
        email.setToAddresses( EmailIds  );
        email.setHtmlBody(body);   
          email.setOrgWideEmailAddressId(owea.Id);
           
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }

     webservice static void sendQuarantineEmailSpanish(String theInterview, String EmailAddress ){

        List<String> EmailIds = new List<String>();
        EmailIds.add(EmailAddress);
                
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Health FollowUp'];


        
        PageReference theDoc = Page.letter_Quarantine_Spanish;
        theDoc.getParameters().put('Id',theInterview);
        Blob b;

         if(Test.isRunningTest()){
                b = blob.valueOf('Unit.Test');
            }else{
                b = theDoc.getContentAsPDF();}
        String body='Hola,<br /><br />';
        body += 'Este es su correo electrónico de seguimiento de la conversación que mantuvo con el Departamento de Salud y Medio Ambiente del Condado de Larimer con respecto a COVID-19.<br /><br />';
        body += 'Si actualmente experimenta síntomas o ha dado positivo por coronavirus:<br />';
        body += 'Es muy importante para la seguridad de sus amigos, familiares y la comunidad en general que siga estas * <a href="https://drive.google.com/file/d/1F5s7VKAnNm6pum4Bkg9ihWOq2eFiA4mQ/view?usp=sharing">Pautas de aislamiento</a><br />';
        body += 'Si eres un contacto cercano de alguien que dio positivo y no experimenta síntomas:<br />';
        body += 'Siga estas <a href="https://drive.google.com/file/d/1zMy3D0j1m3MGwuMYWe04TBVZfra8xxWP/view?usp=sharing">Pautas de cuarentena</a> . En caso de que desarrolle síntomas durante el período de cuarentena, siga las “Pautas de aislamiento” proporcionadas anteriormente para determinar cuándo es apropiado que reanude sus actividades normales.<br /><br />';
        body += 'Las personas que no cumplan con las órdenes de salud pública pueden estar sujetas a sanciones contenidas en §25-1-114 y 25-1-516, los Estatutos Revisados de Colorado, que incluyen hasta dieciocho meses de prisión, o una multa de hasta cinco mil dólares o ambas.<br /><br />';
        body += 'Pruebas:<br />';
        body += 'Los contactos cercanos de casos confirmados pueden inscribirse <a href="https://www.larimer.org/covid-19-testing">aquí</a> para ser probados para COVID-19 en nuestros eventos de pruebas de la comunidad. Actualmente estamos realizando pruebas para contactos cercanos de casos confirmados que son sintomáticos y asintomáticos (sin síntomas).<br />';
        body += '<ul><li>Tenga en cuenta que un resultado negativo de la prueba no afectará el período de cuarentena (es decir, si un contacto cercano resulta negativo dentro de los 14 días posteriores a la exposición, aún deben poner en cuarentena durante los 14 días completos).</li>';
        body += '<li>Los resultados de la prueba son más precisos 5-7 días después de una exposición a alguien con COVID-19. Le recomendamos que programe las pruebas 5-7 días después de su ÚLTIMO contacto con alguien que sea positivo para COVID-19.</li></ul>';
        body += 'Sabemos que esta es mucha información y es posible que tenga preguntas. No dude en comunicarse por correo electrónico a larimerhealthfollowup@co.larimer.co.us, o puede llamar a nuestro Centro de información conjunta al 970-498-5500. También puede enviar sus preguntas al 970-999-1770.<br /><br />';
        body += 'Gracias';



        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
 
        Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
        efa1.setFileName('quarantineOrder.pdf');
        efa1.setBody(b);
 
        String addresses;
        email.setSubject( 'Seguimiento del Departamento de Salud del Condado de Larimer');
        email.setToAddresses( EmailIds  );
        email.setHtmlBody(body);
          email.setOrgWideEmailAddressId(owea.Id);
      
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa1});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }
    
    
    webservice static void sendLabResults(String EmailAddress, String Status ){

        List<String> EmailIds = new List<String>();
        EmailIds.add(EmailAddress);
                      
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Testing'];
    
        StaticResource srPositive = [Select  Name, Id, Body From StaticResource where Name = 'letter_Positive_English'];
        StaticResource srNegative = [Select  Name, Id, Body From StaticResource where Name = 'letter_Negative_English'];
        


        Blob b;
        
        if(Status == 'Positive')
        {
            b = srPositive.Body;
            owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Health FollowUp'];
    
        }
        
        if(Status == 'Negative')
        {
        
            b = srNegative.Body;
            owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Testing'];
    
        }
        
       
        if (b != null)
        {
          Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
          efa.setFileName('Result.pdf');
          efa.setBody(b);
          email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        }
        
                
        String body='Hello,<br /><br />';
        
        body +='This letter is to inform you that the results of your COVID-19 test has been completed.  Please review the attachment for additional details.<br /><br />';

        body +='Thank you for taking the time and initiative to be tested. If you have any other questions or concerns, please call our information line Monday through Friday between 9am and 4:30pm at 970-498-5500. Text your questions anytime to 970-999-1770.<br /><br />';
        
        body +='Larimer County Department of Health & Envrionment';

 
        String addresses;
        email.setSubject( 'Lab Result');
        email.setToAddresses( EmailIds  );
        email.setHtmlBody(body);
        email.setOrgWideEmailAddressId(owea.Id);
      

        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }    
    
    webservice static void sendLabResultsCSU(TestingSlot__c rec){

        List<String> EmailIds = new List<String>();
        EmailIds.add(rec.EmailToSendTo__c);
                      
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        Messaging.EmailFileAttachment std = new Messaging.EmailFileAttachment();

                
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Testing'];
    
       
        PageReference theDoc = Page.CSUResultDocument;
        theDoc.getParameters().put('Id',rec.Id);
        Blob b,b2;
        
        if(Test.isRunningTest()){
            b = blob.valueOf('Unit.Test');
        }else{
            b = theDoc.getContentAsPDF();}
       
        StaticResource srPositive = [Select  Name, Id, Body From StaticResource where Name = 'CSUPositive'];
        StaticResource srNegative = [Select  Name, Id, Body From StaticResource where Name = 'CSUNegativeLetter'];
        StaticResource srInconclusive = [Select  Name, Id, Body From StaticResource where Name = 'CSUInconclusive'];
            

        if(b != null)
        {

            if(rec.Lab_Result__c == 'Positive')
            {
                owea = [select Id from OrgWideEmailAddress where DisplayName = : 'Larimer County Health FollowUp'];
                b2 = srPositive.body;
                std.setFileName('ResultLetter.pdf');
                std.setBody(b2);
                efa.setFileName('LabResult.pdf');
                efa.setBody(b);
                email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa,std});
        
            }else {
                if(rec.Lab_Result__c == 'Negative')
                {
                    b2 = srNegative.body;
                    std.setFileName('ResultLetter.pdf');
                    std.setBody(b2);
                    efa.setFileName('LabResult.pdf');
                    efa.setBody(b);
                    email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa,std});
                }
                else 
                {
                    b2 = srInconclusive.body;
                    std.setFileName('ResultLetter.pdf');
                    std.setBody(b2);
                    efa.setFileName('LabResult.pdf');
                    efa.setBody(b);
                    email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa,std}); 
                }

            }
            
            
        }

        if (b != null)
        {
          
        }
        
                
        String body='Hello,<br /><br />';
        
        body +='This letter is to inform you that the results of your COVID-19 test has been completed.  Please review the attachment for additional details.<br /><br />';

        body +='Thank you for taking the time and initiative to be tested. If you have any other questions or concerns, please call our information line Monday through Friday between 9am and 4:30pm at 970-498-5500. Text your questions anytime to 970-999-1770.<br /><br />';
        
        body +='Larimer County Department of Health & Envrionment';

 
        String addresses;
        email.setSubject( 'Lab Result');
        email.setToAddresses( EmailIds  );
        email.setHtmlBody(body);
        email.setOrgWideEmailAddressId(owea.Id);

        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }  
    
    
    
}