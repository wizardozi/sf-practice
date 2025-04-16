public with sharing class MyApexClass {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        System.debug('Apex called from controller');
        List<Contact> contacts = [SELECT Id, Name, Phone FROM Contact LIMIT 10];
        System.debug('Sending back queried contacts: '+contacts);
        return contacts;
    }
}
