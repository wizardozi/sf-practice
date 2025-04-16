public with sharing class ContactController {
    @AuraEnabled(cacheable=true)    
    public static List<Contact> getContacts() {

    }
}