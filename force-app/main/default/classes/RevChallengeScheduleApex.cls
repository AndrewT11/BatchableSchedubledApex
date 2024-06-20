global class RevChallengeScheduleApex implements Schedulable {
    global void execute(SchedulableContext sc) {
        RevChallengeBatchable b = new RevChallengeBatchable();
        Database.executeBatch(b);
    }
}