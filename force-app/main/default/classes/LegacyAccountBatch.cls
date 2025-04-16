public class LegacyAccountBatch implements Database.Batchable<SObject>{
    Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, CreatedDate, Type FROM Account WHERE CreatedDate < LAST_N_YEARS:5
        ]);
    }
    public void execute(Database.BatchableContext bc, list<Account> scope){
        recordsProcessed += scope.size();
        for(Account a : scope) {
            a.Type = 'Legacy';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Records Processed: ' + recordsProcessed);
    }
}