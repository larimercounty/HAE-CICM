public class CSVReaderCases {
   
    private string csvString;
    private integer csvStringLength;
    
    private static string COMMA = ',';
    private static string NL = '\n';
    private static string QUOTE = '"';
    private static string DOUBLE_QUOTE = '""';
    private static string SINGLE_QUOTE = '\'';

    
    public static boolean Parseandinsert( string csvString )
    {
        
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Loading Tests Into System Via Batch Process, you can close this window'));
      
      
        // List<String> theCSV = new List<String>();
        // theCSV = csvString.split('\n');
         
            loadInCases theBatch = new loadInCases();
            
            //theBatch.theList = theCSV;
            theBatch.theFileToProcess = csvString;
            
            ID theBatchJob = Database.executeBatch(theBatch,6);

        return true;



     /* 
        
        List<String> theCSV = new List<String>();
        theCSV = csvString.split('\n');

        for (String theRow : theCSV)
        {
           CICMImportProcesses.loadCaseRecord(theRow,'SmallBatch');
        }

        return true;
*/
    }
 


    
    
}