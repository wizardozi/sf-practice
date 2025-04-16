public class SLATrackerBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            [SELECT Id, SLA_Expiration_Date__c, SLA_Status__c, OwnerId FROM Case 
             WHERE Status != 'Closed' 
             AND SLA_Expiration_Date__c <= :DateTime.now().addHours(12)]
        );
    }
    
    public void execute(Database.BatchableContext bc, List<Case> cases){
        // process each batch of records
        for(Case c : cases) {
            if (c.SLA_Expiration_Date__c > DateTime.now() && c.SLA_Expiration_Date__c <= DateTime.now().addHours(12)) {
                c.SLA_Status__c = 'Near SLA';
            } else if (c.SLA_Expiration_Date__c <= DateTime.now()) {
                c.SLA_Status__c = 'Overdue';
            }
            
        }
        update cases;
    }    
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug('Records Processed');
    }    
}