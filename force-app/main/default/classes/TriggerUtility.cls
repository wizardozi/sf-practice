public class TriggerUtility {
    private static Set<Id> processedIds = new Set<Id>(); 
    public static void addProcessedIds(List<sObject> sObjects) {        
        for(sObject o : sObjects) {
            processedIds.add(o.Id);
        }
    }
    public static Set<Id> getProcessedIds() {
        return processedIds;
    }
    
    public static void clearProcessedIds() {
        processedIds.clear();
    }
}