public class ContactTriggerHelper {
    public static void preventDuplicateContacts(List<Contact> newContacts) {
        // make a set of unique emails from the list of contacts
        set<String> newContactEmails = new Set<String>();
        for(Contact c : newContacts) {
            if(c.Email != null) {
                newContactEmails.add(c.Email);
            }
        }
        // check if an email is already in the database by querying existing contacts using the set of emails of new contacts
        Map<String, Contact> emailToContactMap = new Map<String, Contact>();
        for (Contact c : [SELECT Email, Id FROM Contact WHERE Email IN :newContactEmails]) {
            emailToContactMap.put(c.Email, c);
        }
        // compare the new contact email to the map of existing contact emails and prevent insert if theres a match
        for(Contact c : newContacts) {
            if(emailToContactMap.containsKey(c.Email)) {
                c.addError('Duplicate Contact found.');
            }
        }

    }
}