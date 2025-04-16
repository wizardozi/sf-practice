public with sharing class ContactDuplicateCheckHandler {
    public static checkDuplicates(list<Contact> newContacts) {
        // create a set from the Emails of the new contacts skip contacts with no Email
        Set<String> newContactEmails = new Set<String>();
        for(Contact c : newContacts) {
            if(c.Email != null){
                newContactEmails.add(c.Email);
            }
        }
        // Create a List of Contacts by querying the database
        // based on the Emails of the new contacts and save them to a map
        Map<String, Set<Id>> emailToAccountMap = new Map<String, Set<Id>>();
        if(!newContactEmails.isEmpty()) {
            for(Contact c : [SELECT 
                            Email, AccountId 
                            FROM Contact
                            WHERE Email IN :newContactEmails]) {
                if(!emailToAccountMap.containsKey(c.Email)) {
                    emailToAccountMap.put(c.Email, new Set<Id>());
                }
                emailToAccountMap.get(c.Email).add(c.AccountId);     
            }
        }
        // duplicate emails are only blocked if the Contact is under the same Account   
        for(Contact c : newContacts) {            
            if (c.Email != null && emailToAccountMap.containsKey(c.Email) && emailToAccountMap.get(c.Email).contains(c.AccountId)) {
                c.addError('This contact already exists in the system');
            }            
        }        
    }
}
