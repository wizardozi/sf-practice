global class SLATrackerScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        // Run the SLA Tracker Batch job
        Database.executeBatch(new SLATrackerBatch(), 200);
    }
}
