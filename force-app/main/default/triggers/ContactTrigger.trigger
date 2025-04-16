trigger ContactTrigger on Contact (before insert) {
    if(Trigger.isBefore && Trigger.isInsert) {
        ContactTriggerHelper.preventDuplicateContacts(Trigger.new);
    }
}