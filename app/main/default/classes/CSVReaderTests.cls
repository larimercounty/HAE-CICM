public class CSVReaderTests {

    
    public static boolean Parseandinsert( string csvString )
    {
        
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Loading Tests Into System Via Batch Process, you can close this window'));
      
      
        // List<String> theCSV = new List<String>();
        // theCSV = csvString.split('\n');
         
            loadInTests theBatch = new loadInTests();
            
            //theBatch.theList = theCSV;
            theBatch.theFileToProcess = csvString;
            
            ID theBatchJob = Database.executeBatch(theBatch,50);

        return true;

    }
 


    
    
}