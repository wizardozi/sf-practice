public class AccountContactCounter {
    public static Map<Id, Integer> getContactCountsByAccount() {
        Map<Id, Integer> conIdToCount = new Map<Id, Integer>();
        for(AggregateResult agg : [SELECT AccountId, COUNT(Id) totalContacts FROM Contact WHERE AccountId != null GROUP BY AccountId]) {
            conIdToCount.put((Id) agg.get('AccountId'), ((Long) agg.get('totalContacts')).intValue()); 
        }
        return conIdToCount;
    }
}