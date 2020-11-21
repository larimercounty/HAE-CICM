public with sharing class extAllLettersToSend {

    public extAllLettersToSend() {

    }
  
    
    public extAllLettersToSend(ApexPages.StandardController controller) {

    }
  
    public List< HAE_Case_Interview__c > getLetters() {

            
            return[Select Id,Iso_Quar_Until__c,
                    HAE_Individual__r.Email_Address__c,
                    HAE_Individual__r.First_Name__c,
                    HAE_Individual__r.Last_Name__c,
                    HAE_Individual__r.Middle_Name__c,
                    HAE_Individual__r.Full_Name__c,                   
                    HAE_Individual__r.Address1__c,
                    HAE_Individual__r.City__c,
                    HAE_Individual__r.State__c,
                    HAE_Individual__r.Zip__c,
                    LetterSent_Date__c,
                    Letter_Type_To_Send__c,
                    Quarantine_Until__c,
                    Isolate_Until__c
                    FROM HAE_Case_Interview__c 
                    Where 
                    Iso_Quar_Until__c >= TODAY
                    AND
                    HAE_Individual__r.Email_Address__c = NULL
                    AND
                    Completed_Date__c <> NULL
                    AND
                    LetterSent__c = FALSE
                    AND 
                    Interview_Status__c IN ('Complete', 'Lost To Follow-Up', 'Not Needed')
                    AND
                    No_Letter_Needed__c = FALSE
                    AND
                    Can_Receive_A_Letter__c = TRUE
                    AND 
                    (
                    Interview_Not_Needed_Status__c = NULL
                    OR
                    Interview_Not_Needed_Status__c = 'Electronically Contacted'
                    )
                    ORDER BY HAE_Individual__r.Full_Name__c
                    ];
        }
        
   }