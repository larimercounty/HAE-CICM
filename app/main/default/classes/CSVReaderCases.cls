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
        
      
        
        List<String> theCSV = new List<String>();
        theCSV = csvString.split('\n');

        for (String theRow : theCSV)
        {
           CICMImportProcesses.loadCaseRecord(theRow);
        }

        return true;

    }
 


    
    
}