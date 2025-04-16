public  class TaskUpdateHandler {
    public static void updateTasks(List<Task> tasks) {
        List<Task> tasksToUpdate = new List<Task>();
        for (Task t : tasks) {
            if (t.ActivityDate == null || t.ActivityDate != Date.today().addDays(7)) {
                t.ActivityDate = Date.today().addDays(7);
                tasksToUpdate.add(t);
            }
        }
        
        if(!tasksToUpdate.isEmpty()) {
            update tasksToUpdate;
        }
    }
}