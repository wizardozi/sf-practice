public class CaseEscalationService {
    
    @InvocableMethod(label='Reassign Cases' description='Apex method for reassigning cases')
    public static void reassignHighPriorityCases() {

        List<Case> casesToUpdate = new List<Case>();
        List<Group> queueList = [SELECT Id FROM Group WHERE Type = 'Queue' AND Name = 'Senior Support Team'];
        if(queueList.isEmpty()) {
            System.debug('Senior Support Team queue not found');
            return;
        }

        for (Case c : [SELECT Id, Status, CreatedDate, Priority FROM Case
               WHERE Priority = 'High' AND CreatedDate < :Date.today().addDays(-3)]) {
            c.OwnerId = queueList[0].Id;
            casesToUpdate.add(c);            
        }

        if(!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        } else {
            System.debug('No updates made');
        }
    }
}