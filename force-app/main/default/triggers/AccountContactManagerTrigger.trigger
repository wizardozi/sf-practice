trigger AccountContactManagerTrigger on Account (after update) {
    List<Account> validAccounts = new List<Account>();
    for(Account a : trigger.new) {
        Account oldAccount = trigger.oldMap.get(a.Id);
        if(oldAccount.Industry != 'Technology' && a.Industry == 'Technology') {
            validAccounts.add(a);
        }
    }
    
    AccountContactManagerHandler.UpdateContacts(validAccounts);
}