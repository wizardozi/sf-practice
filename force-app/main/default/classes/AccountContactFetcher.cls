public class AccountContactFetcher {
    public static Map<Id, List<Contact>> getAccountContacts() {
        Map<Id, List<Contact>> accountContacts = new Map<Id, List<Contact>>();
        for(Account account : [SELECT Id, (SELECT Id FROM Contacts) FROM Account]) {
            if (!accountContacts.containsKey(account.Id)) {
                accountContacts.put(account.Id, new List<Contact>());
            }
            if(account.Contacts != null) {
                accountContacts.get(account.Id).addAll(account.Contacts);
            }
        }
        System.debug('Accounts: ' + accountContacts);
        return accountContacts;
    }
}