public with sharing class AccountHandler {
    public static void CreateNewOpportunity(List<Account> accts) {
        for(Account acct : accts) {
            Opportunity opp = new Opportunity();
            opp.Name = acct.Name + ' Opportunity';
            opp.AccountId = acct.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.Today().addMonths(1);
            insert opp;
        }
    }
}