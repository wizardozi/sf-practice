public with sharing class ContactSearchController {
    @AuraEnabled
    public static List<Contact> findContacts(String firstName, String lastName){
        List<String> conditions = new List<String>();

        String first = '%' + firstName + '%';
        String last = '%' + lastName + '%';

        if (!String.isBlank(firstName)) {
            conditions.add('FirstName LIKE :first');
        }
        System.debug('FirstName: '+first);
        if (!String.isBlank(lastName)) {
            conditions.add('LastName LIKE :last');
        }
        System.debug('LastName: '+last);
        
        String baseQuery = 'SELECT Id, FirstName, LastName, Email FROM Contact';
        String wherClause = conditions.size() > 0 ? ' WHERE ' + String.join(conditions, ' AND ') : '';
        String fullQuery = baseQuery + wherClause + ' LIMIT 20';
        System.debug(fullQuery);
        return Database.query(fullQuery);
    }
}