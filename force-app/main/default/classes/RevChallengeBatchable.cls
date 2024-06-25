// Challenge: 
//Create batchable apex that will delete stale Account records. Stale account records are Accounts with no related open opportunities for the last 6 months. 
 
//Create schedulable apex that will execute the batch class above. 
 
//Schedule your schedulable apex to run at 12 am at the first of every month. Take a screenshot of your scheduled job from within the setup menu and include it in the repo 
// In anonynmous apex, I ran the following:
// String cronExpression = '0 0 0 1 * ?';
// System.schedule('RevChallenge Batch Jobs', cronExpression, new RevChallengeScheduleApex);

public with sharing class RevChallengeBatchable implements Database.Batchable<sObject> {

    public RevChallengeBatchable() {}
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('Select Id, Name FROM Account WHERE Id NOT IN (SELECT AccountId FROM Opportunity WHERE (CloseDate >= LAST_N_MONTHS:6))');
    }
    
    public void execute(Database.BatchableContext BC, List<Account> accounts) {
        delete accounts;
    }
    
    public void finish(Database.BatchableContext BC) {}
}