public class CSVReaderTests_UniPath {

    
    public static boolean Parseandinsert( string csvString )
    {
        
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Loading Tests Into System Via Batch Process, you can close this window'));
      
      
        // List<String> theCSV = new List<String>();
        // theCSV = csvString.split('\n');
         
            loadInTests_UniPath theBatch = new loadInTests_UniPath();
            
            //theBatch.theList = theCSV;
            theBatch.theFileToProcess = csvString;
            
            ID theBatchJob = Database.executeBatch(theBatch,1);

        return true;

    }
 


    
    
}