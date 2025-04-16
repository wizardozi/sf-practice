public class AccountRevenueCalculator implements Database.Batchable<sObject>{
    private Map<Id,Decimal> accountToAmountMap;

    public AccountRevenueCalculator() {
        accountToAmountMap = new Map<Id, Decimal>();        
        for(AggregateResult agg : [SELECT AccountId, sum(Amount) amountSum FROM Opportunity WHERE StageName = 'Closed Won' GROUP BY AccountId]) {
            Id accountId = (Id) agg.get('AccountId');
            Decimal oppSum = (Decimal) agg.get('amountSum');
            this.accountToAmountMap.put(accountId, oppSum);
        }
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
                                
        return Database.getQueryLocator([SELECT Id, Total_Revenue__c FROM Account WHERE Id IN :accountToAmountMap.keySet()]);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        
        if(accountToAmountMap == null || accountToAmountMap.isEmpty()) {
            return;
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        for(Account a : scope) {            
            a.Total_Revenue__c = accountToAmountMap.containsKey(a.Id) ? accountToAmountMap.get(a.Id) : 0;
            accountsToUpdate.add(a);
        }

        if(!accountsToUpdate.isEmpty()) {

            update accountsToUpdate;
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Process Completed');
    }
}