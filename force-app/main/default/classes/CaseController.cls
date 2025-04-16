public with sharing class CaseController {
    
    @AuraEnabled(cacheable=true)
    public static List<Case> getOpenCases() {
        // Query cases where Status is not Closed
        return [SELECT Id, CaseNumber, Subject, Status FROM Case WHERE Status != 'Closed' LIMIT 10];
    }
}
