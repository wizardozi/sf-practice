trigger SetCaseSLATrigger on Case (before insert) {         
    SetCaseSLAHelper.setSLA(Trigger.new);
}