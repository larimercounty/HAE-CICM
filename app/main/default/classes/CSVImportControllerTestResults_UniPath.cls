public with sharing class CSVImportControllerTestResults_UniPath {
    public Document d {get; set;}
    public CSVImportControllerTestResults_UniPath(ApexPages.StandardController controller) {
        d = (Document) controller.getRecord();
    }
     public PageReference saveToMemory(){
        boolean res = CSVReaderTests_UniPath.Parseandinsert(d.body.toString() );
        return null;
    }
}