trigger OpportunityTrigger on Opportunity (after update) {
    // Call helper class
    list<Opportunitu> closeWonOpps = new list<Opportunitu>();
    for(Opportunity newOpp : trigger.new) {
        Opportunity oldOpp = trigger.oldMap.get(newOpp.Id);
        if(oldOpp.StageName != 'Closed Won' && newOpp.StageName == 'Closed Won') {
            closeWonOpps.add(newOpp);
        }
    }
    OpportunityTriggerHandler.createContracts(closeWonOpps);
}
