public with sharing class CSVImportControllerDeaths {
    public Document d {get; set;}
    public CSVImportControllerDeaths(ApexPages.StandardController controller) {
        d = (Document) controller.getRecord();
    }
    public PageReference saveToMemory(){
        boolean res = CSVReaderDeaths.Parseandinsert(d.body.toString() );
        return null;
    }
}