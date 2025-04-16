public class DuplicateContactResolver {
    public static Map<String, Contact> getMostRecentContactsByEmail() {
        Map<String,Contact> emailToContactMap = new Map<String,Contact>();
        for(Contact c : [SELECT Email, Id, LastModifiedDate FROM Contact WHERE Email != null]) {
            
            Datetime lastModified = c.LastModifiedDate;

            if(!emailToContactMap.containsKey(c.Email)) {
                emailToContactMap.put(c.Email, c);
            }
            else if(emailToContactMap.containsKey(c.Email) && emailToContactMap.get(c.Email).LastModifiedDate < c.LastModifiedDate) {
                emailToContactMap.put(c.Email, c);
            }
                        
        }
        return emailToContactMap;
    }
}
