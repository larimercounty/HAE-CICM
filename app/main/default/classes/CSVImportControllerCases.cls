public with sharing class CSVImportControllerCases {
    public Document d {get; set;}
    public CSVImportControllerCases(ApexPages.StandardController controller) {
        d = (Document) controller.getRecord();
    }
    public PageReference saveToMemory(){
        boolean res = CSVReaderCases.Parseandinsert(d.body.toString() );
        return null;
    }
}