trigger TaskUpdateTrigger on Task (after update) {
    List<Task> validTasks = new List<Task>();
    for(Task t : trigger.new) {
        Task oldTask = trigger.oldMap.get(t.Id);
        if ((oldTask.Follow_Up__c == false || oldTask.Follow_Up__c == null) && t.Follow_Up__c == true) {
            validTasks.add(t);
        }        
    }
    TaskUpdateHandler.updateTasks(validTasks);
}