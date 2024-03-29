@isTest
private class test_CSVImporter{
    
     public static testMethod void testMyClass(){
       
       

        PageReference pg = Page.CSVImportNewTests;
        Test.setCurrentPage(pg);
        Document d;
        d = new Document();
         
        String csvTest = '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,1/1/1990,5,6,7,8,9,10,11,1/1/1990,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,1/1/1990,5,6,7,8,9,10,11,1/1/1990,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,1/1/1990,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,1/1/1990,15,16,17,18,19,20,21,22,23' + '\r\n' +                         
                         '1,2,3,4,5,6,7,8,9,10,11,12,1/1/1990,1/1/1990,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,3,4,5,6,7,8,9,10,11,12,1/1/1990,1/1/1990,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n';
        d.Body = blob.valueOf(csvTest);
       
        
        ApexPages.StandardController controller2;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(d);
        CSVImportController controller = new CSVImportController(sc);
       
        PageReference pageRef = Page.CSVImportNewTests;
        controller.saveToMemory();
        
        
        
    }
    
     public static testMethod void testMyClass2(){
    
    
        PageReference pg = Page.CSVImportNewTests;
        Test.setCurrentPage(pg);
        Document d;
        d = new Document();
         
        String csvTest = '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' + '\r\n';
        d.Body = blob.valueOf(csvTest);
       
        
        ApexPages.StandardController controller2;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(d);
        CSVImportController controller = new CSVImportController(sc);
       
        PageReference pageRef = Page.CSVImportNewTests;
        controller.saveToMemory();
    
    }

  public static testMethod void testDeathLoads(){
    
    
        PageReference pg = Page.CSVImportNewTests;
        Test.setCurrentPage(pg);
        Document d;
        d = new Document();
         
        String csvTest = '1,2,3,1/1/1990,5,6,7,8,9,1/1/1990,11,1/1/1990,13,14,15,16,17,18,19,20,21,22,23,1/1/1990,1/1/1990,26,27,28,29,30,31,32,33' + '\r\n' +
                         '1,2,3,1/1/1990,5,6,7,8,9,1/1/1990,11,1/1/1990,13,14,15,16,17,18,19,20,21,22,23,1/1/1990,1/1/1990,26,27,28,29,30,31,32,33' + '\r\n' +
                         '1,2,3,1/1/1990,5,6,7,8,9,1/1/1990,11,1/1/1990,13,14,15,16,17,18,19,20,21,22,23,1/1/1990,1/1/1990,26,27,28,29,30,31,32,33' + '\r\n' +
                         '1,2,1/1/1990,4,5,6,7,8,1/1/1990,10,1/1/1990,12,13,14,15,16,17,18,19,20,21,22,1/1/1990,1/1/1990,25,26,27,28,29,30,31,32,33' + '\r\n' +
                         '1,2,3,4,1/1/1990,6,7,8,9,10,1/1/1990,12,1/1/1990,14,15,16,17,18,19,20,21,22,23,24,1/1/1990,1/1/1990,27,28,29,30,31,32,33' + '\r\n';
                        
        d.Body = blob.valueOf(csvTest);
       
        
        ApexPages.StandardController controller2;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(d);
        CSVImportControllerDeaths controller = new CSVImportControllerDeaths(sc);
       
        PageReference pageRef = Page.CSVImportNewDeaths;
        controller.saveToMemory();
    
    }



    public static testMethod void testNewCaseLoader(){
    
    
        PageReference pg = Page.CSVImportNewCases;
        Test.setCurrentPage(pg);
        Document d;
        d = new Document();
         
        String csvTest = '0,COVID-19,Confirmed,1/1/1990,1/1/1990,5,6,7,8,9,10,11,12,13,14,Male,1/1/1990,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,1/1/1990,1/1/1990,63,64,65,66,67,68,1/1/1990,1/1/1990,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99' + '\r\n'+
                        '0,COVID-19,Confirmed,1/1/1990,1/1/1990,5,6,7,8,9,10,11,12,13,14,Male,1/1/1990,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,1/1/1990,62,63,64,65,66,67,68,1/1/1990,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99' + '\r\n'+
                        '0,COVID-19,Confirmed,1/1/1990,1/1/1990,5,6,7,8,9,10,11,12,13,14,Male,1/1/1990,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,1/1/1990,62,63,64,65,66,67,68,1/1/1990,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99' + '\r\n'+
                        '0,COVID-19,Confirmed,1/1/1990,1/1/1990,5,6,7,8,9,10,11,12,13,14,Male,1/1/1990,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,1/1/1990,62,63,64,65,66,67,68,1/1/1990,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99' + '\r\n'+
                        '0,COVID-19,Confirmed,1/1/1990,1/1/1990,5,6,7,8,9,10,11,12,13,14,Male,1/1/1990,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,1/1/1990,62,63,64,65,66,67,68,1/1/1990,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99' + '\r\n';
                        
                         
                         
        d.Body = blob.valueOf(csvTest);
       
        
        ApexPages.StandardController controller2;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(d);
        CSVImportControllerCases controller = new CSVImportControllerCases(sc);
       
        PageReference pageRef = Page.CSVImportNewCases;
        controller.saveToMemory();
    
    }

 
     public static testMethod void testUniPathImport(){
    
    
        PageReference pg = Page.CSVImportTests_UniPath;
        Test.setCurrentPage(pg);
        Document d;
        d = new Document();
         
        String csvTest = '1,2,1/1/1990,4,5,6,7,8,9,10,11,12,1/1/1990,14,15,16,17,18,19,20,21,22,23' ;
        d.Body = blob.valueOf(csvTest);
       
        
        ApexPages.StandardController controller2;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(d);
        CSVImportControllerTestResults_UniPath controller = new CSVImportControllerTestResults_UniPath(sc);
       
        PageReference pageRef = Page.CSVImportTests_UniPath;
        controller.saveToMemory();
    
    }
    
    public static testMethod void testCaseContactRecord(){
    
    HAE_Case__c newcase = new HAE_Case__c(Event_Id__c = '01234321');
    insert newcase;
      
    PageReference pg = Page.CSVImportCaseContacts;
        Test.setCurrentPage(pg);
        Document d;
        d = new Document();
         
        String csvTest = '01234321,High,First Name,Last Name,1/1/1990,5,6,7,8,9,10,11,12,13,14,15' + '\r\n'+
                        '01234321,High,First Name,Last Name,1/1/1990,5,6,7,8,9,10,11,12,13,14,15' + '\r\n'+
                        '01234321,High,First Name,Last Name,1/1/1990,5,6,7,8,9,10,11,12,13,14,15' + '\r\n'+
                        '01234321,High,First Name,Last Name,1/1/1990,5,6,7,8,9,10,11,12,13,14,15' + '\r\n'+
                        '01234321,Low,First Name,Last Name,1/1/1990,5,6,7,8,9,10,11,12,13,14,15' + '\r\n'+
                        '01234321,Low,First Name,Last Name,1/1/1990,5,6,7,8,9,10,11,12,13,14,15' + '\r\n'+
                        '01234321,Low,First Name,Last Name,1/1/1990,5,6,7,8,9,10,11,12,13,14,15' + '\r\n'+
                        '01234321,Low,First Name,Last Name,1/1/1990,5,6,7,8,9,10,11,12,13,14,15' + '\r\n';
                        
                         
                         
        d.Body = blob.valueOf(csvTest);
       
        
        ApexPages.StandardController sc = new ApexPages.StandardController(d);
        CSVImportControllerCaseContacts controller = new CSVImportControllerCaseContacts(sc);
       
        PageReference pageRef = Page.CSVImportCaseContacts;
        controller.saveToMemory();
    
    
    }
    

}