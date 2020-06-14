public with sharing class CSVImportController {
    public Document d {get; set;}
    public CSVImportController(ApexPages.StandardController controller) {
        d = (Document) controller.getRecord();
    }
    public PageReference saveToMemory(){
        boolean res = CSVReaderTests.Parseandinsert(d.body.toString() );
        return null;
    }
}