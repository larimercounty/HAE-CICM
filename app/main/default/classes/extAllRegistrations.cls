public with sharing class extAllRegistrations {

    public extAllRegistrations() {

    }
  
    
    public extAllRegistrations(ApexPages.StandardController controller) {

    }
  
    public List<testingSlot__c> getRegistrations() {

            String theId = ApexPages.currentPage().getParameters().get('Id');
            
            list <TestingDay__c> theDay = new list <TestingDay__c>([Select Id, Day__c from TestingDay__c WHERE Id = :theId]);
            
            if(theDay.size()>0)
            {
            return[SELECT Id,TestId__c,TestingDay__c,TestingRegistration__r.Last_Name__c,TestingRegistration__r.First_Name__c,TestingRegistration__r.Middle_Name__c,TestingRegistration__r.DOB__c,TestingRegistration__r.Gender__c,TestingRegistration__r.Address__c,TestingRegistration__r.City__c,TestingRegistration__r.State__c,TestingRegistration__r.Zip_Code__c,TestingRegistration__r.County_Of_Residence__c,TestingRegistration__r.Phone_Number__c,TestingRegistration__r.Email_Address__c,TestingRegistration__r.Race__c,TestingRegistration__r.Ethnicity__c,TestingRegistration__r.Reason_for_Testins__c,TestingRegistration__r.Employer__c,TestingRegistration__r.Local_Provider__c,TestingRegistration__r.Date_Of_Symptoms__c FROM TestingSlot__c WHERE TestingDay__r.Day__c = :theDay[0].Day__c AND Checked_In__c = true ORDER BY TestId__c];
            }
            else
            {
            return null;
            }
        }
        
   }