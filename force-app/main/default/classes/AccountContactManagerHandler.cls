public class AccountContactManagerHandler {
    public static void updateContacts(list<Account> accounts) {
        Set<Id> accountIds = new Set<Id>();
        for(Account a : accounts) {
            accountIds.add(a.Id);
        }
        Map<Id, List<Contact>> accountIdToContactMap = getContacts(accountIds);
        list<Contact> contactsToUpdate = new List<Contact>();
        for(Account a : accounts) {            
            List<Contact> relatedContacts = accountIdToContactMap.get(a.Id);
            if(!relatedContacts.isEmpty()) {
                for(Contact c : relatedContacts) {
                    c.Email = 'bulkupdate' + String.valueOf(c.Id) + '@email.com';
                    contactsToUpdate.add(c);
                }
            }
            
        }
        if(!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }            
    }
    private static Map<Id, List<Contact>> getContacts(Set<Id> accountIds) {
        
        List<Contact> contacts = [SELECT Id, Email, FirstName, LastName, AccountId 
        FROM CONTACT WHERE AccountId IN :accountIds];
        
        Map<Id, List<Contact>> accountIdToContactMap = new Map<Id, List<Contact>>(); 
        for(Contact c : contacts) {
            if(!accountIdToContactMap.containsKey(c.AccountId)) {
                accountIdToContactMap.put(c.accountId, new List<Contact>());
            } 
        
            accountIdToContactMap.get(c.AccountId).add(c);
            
        } 
        return accountIdToContactMap;
    }
}