trigger ContactDuplicateCheck on Contact (before insert) {
    // Implement logic here
    ContactDuplicateCheckHandler.checkDuplicates(trigger.new);
}
