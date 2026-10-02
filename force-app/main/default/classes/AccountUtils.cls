public class AccountUtils {
    public static List<Account> accountsByState (String accountState){
        List<Account> searchedResults = [SELECT Name FROM Account WHERE BillingState= :accountState];
        return searchedResults;
    }
}