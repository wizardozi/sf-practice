public with sharing class ReactiveSearchController {
    @AuraEnabled(cacheable=true)
   public static List<Contact> getContacts(String searchKey) {
        // Check if searchKey is null or empty
        if (String.isEmpty(searchKey)) {return new List<Contact>();}
        // Use a case-insensitive search for first and last names
        String searchKeyLower = '%' + searchKey.toLowerCase() + '%';
        List<Contact> contacts = [
            SELECT Id, FirstName, LastName 
            FROM Contact
            WHERE FirstName LIKE :searchKeyLower
            OR LastName LIKE :searchKeyLower            
            LIMIT 10
        ];
        return contacts;
   }
}