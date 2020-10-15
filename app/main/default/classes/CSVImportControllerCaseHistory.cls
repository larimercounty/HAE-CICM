public with sharing class CSVImportControllerCaseHistory {
    public Document d {get; set;}
    public CSVImportControllerCaseHistory(ApexPages.StandardController controller) {
        d = (Document) controller.getRecord();
    }
    public PageReference saveToMemory(){
        boolean res = CSVReaderCaseHistory.Parseandinsert(d.body.toString() );
        return null;
    }
}