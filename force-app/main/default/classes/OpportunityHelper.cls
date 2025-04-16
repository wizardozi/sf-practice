public class OpportunityHelper {
    
    public static void updateAccountRevenue(List<Opportunity> opps) {        
        Set<Id> accountIds = getAccountIds(opps);  // Step 1: Get Account IDs
        Map<Id, Account> accIdToMap = getAccounts(accountIds);  // Step 2: Query Accounts
        Map<Id, Decimal> accIdToAmount = calculateTotalRevenue(opps);  // Step 3: Calculate Revenue
        applyRevenueUpdates(accIdToMap, accIdToAmount);  // Step 4: Update Accounts
    }

    private static Set<Id> getAccountIds(List<Opportunity> opps) {
        // Extract unique Account IDs from Opportunities
        Set<Id>acountIds = new Set<Id>();
        for(Opportunity opp : opps) {
            if(opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        return accountIds;
    }

    private static Map<Id, Account> getAccounts(Set<Id> accountIds) {
        // Query Accounts from Salesforce and store them in a map
        Map<Id,Account> accIdToMap = new Map<Id, Account>();
        for(Account acc : [SELECT Id, AnnualRevenue FROM Account WHERE Id IN :accountIds]) {
            accIdToMap.put(acc.Id, acc);
        }
        return accIdToMap;
    }

    private static Map<Id, Decimal> calculateTotalRevenue(List<Opportunity> opps) {
        // Sum Opportunity Amounts for each Account
        Map<Id,Decimal> accIdToAmount = new Map<Id, Decimal>();
        for(Opportunity opp : opps) {
            if(opp.AccountId != null) {
                if(!accIdToAmount.containsKey(opp.AccountId)) {
                    accIdToAmount.put(opp.AccountId, 0);
                }
                accIdToAmount.put(opp.AccountId, accIdToAmount.get(opp.AccountId) + (opp.Amount != null ? opp.Amount : 0));
            }
        }
        return accIdToAmount;
    }

    private static void applyRevenueUpdates(Map<Id, Account> accIdToMap, Map<Id, Decimal> accIdToAmount) {
        // Update Account records with new AnnualRevenue values
        List<Account> accountsToUpdate = new List<Account>();
        for(Account acc : accIdToMap.values()) {
            acc.AnnualRevenue = (acc.AnnualRevenue != null ? acc.AnnualRevenue : 0) + (accIdToAmount.containsKey(acc.Id) ? accIdToAmount.get(acc.Id) : 0);
            accountsToUpdate.add(acc);
        }
        if(!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
