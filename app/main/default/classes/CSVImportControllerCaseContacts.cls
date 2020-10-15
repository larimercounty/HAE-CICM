public with sharing class CSVImportControllerCaseContacts {
    public Document d {get; set;}
    public CSVImportControllerCaseContacts(ApexPages.StandardController controller) {
        d = (Document) controller.getRecord();
    }
    public PageReference saveToMemory(){
        boolean res = CSVReaderCaseContacts.Parseandinsert(d.body.toString() );
        return null;
    }
}