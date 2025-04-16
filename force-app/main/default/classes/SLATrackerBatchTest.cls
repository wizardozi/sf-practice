@isTest
private class SLATrackerBatchTest {
    
    @isTest
    static void testSLABatchJob() {
        // 🔹 Insert Cases Normally (Trigger Will Set SLA Date)
        Case nearingSLA = new Case(
            Priority = 'High',
            Origin = 'Phone'
        );
    
        Case overdueCase = new Case(
            Priority = 'High',
            Origin = 'Email'
        );
    
        insert new List<Case>{ nearingSLA, overdueCase };
    
        // 🔹 Manually Override SLA Expiration to Fit Batch Criteria
        nearingSLA.SLA_Expiration_Date__c = DateTime.now().addHours(6);  // ✅ Within batch range
        overdueCase.SLA_Expiration_Date__c = DateTime.now().addHours(-5); // ✅ Already expired
    
        update new List<Case>{ nearingSLA, overdueCase };
    
        // 🔹 Run the Batch Job
        Test.startTest();
        Database.executeBatch(new SLATrackerBatch(), 200);
        Test.stopTest();
    
        // 🔹 Query Updated Cases
        List<Case> updatedCases = [SELECT Id, SLA_Status__c FROM Case WHERE Id IN :new List<Id>{nearingSLA.Id, overdueCase.Id}];
    
        // 🔹 Assert Correct SLA Status Updates
        for (Case c : updatedCases) {
            if (c.Id == nearingSLA.Id) {
                System.assertEquals('Near SLA', c.SLA_Status__c, 'Case should be marked as Nearing SLA.');
            } else if (c.Id == overdueCase.Id) {
                System.assertEquals('Overdue', c.SLA_Status__c, 'Case should be marked as Overdue.');
            }
        }
    }
    
}
