public class CSVReader {
   
    private string csvString;
    private integer csvStringLength;
    
    private static string COMMA = ',';
    private static string NL = '\n';
    private static string QUOTE = '"';
    private static string DOUBLE_QUOTE = '""';
    private static string SINGLE_QUOTE = '\'';

    
    public static boolean Parseandinsert( string csvString )
    {
        
            
        
         List< TestsPerformed__c > lstRes= new List< TestsPerformed__c >();   
        
        
     List<String> theCSV = new List<String>();
     theCSV = csvString.split('\n');

                
        integer firstRow=0;

        for (String theRow : theCSV)
        {
            system.debug('In For Loop');
            system.debug(theRow);
            List<String> fields = new List<String>();
            fields = theRow.split(',');
        
            system.debug(fields);
            if(firstRow >3)
            {
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,theRow));
       
            
               TestsPerformed__c res = new TestsPerformed__c();
        
                system.debug(fields[12]);
                system.debug(fields[2]);
               
                List<String> days = new List<String>();
                days = fields[12].split('/');
                Date collectionDate = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                res.Collection_Date__c = collectionDate;
                
                days = new List<String>();
                days = fields[2].split('/');
                Date dateOfBirth = Date.newInstance(integer.valueof(days[2]), integer.valueof(days[0]),integer.valueof(days[1]));
                res.Date_of_Birth__c = dateOfBirth;
                         
                res.ELR_Result__c = fields[17];
                res.First_Name__c = fields[1];
                res.Last_Name__c = fields[0];
                res.Mapped_Result__c = fields[18];
                res.Provider__c = fields[14];
                res.Specimen_Type__c = fields[11];
                res.Submitted__c = fields[13];
                res.Test_Type__c = fields[16];
    
                lstRes.Add(res);
            }
            
             firstRow++;
        }


        insert lstRes;
        return true;

    }
 


    
    
}