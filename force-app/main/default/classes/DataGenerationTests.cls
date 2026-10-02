@isTest
public class DataGenerationTests {

    @TestSetup
    static void dataCreation() {
        // GIVEN
        Account a = TestFactory.getAccount('Muddy Waters Inc.', true);
        Contact c = TestFactory.getContact(a.id, 'Muddy', 'Waters', true);
        Opportunity opp = New Opportunity();
        opp.name = 'Long lost record';
        opp.accountId = a.id;
        opp.closeDate = Date.today().addDays(14);
        opp.stageName = 'prospecting';
        insert opp;
    }

    @IsTest
    static void testUseTestFactoryToCreateAccountsWithContacts() {
    // GIVEN
        List<Account> accts;
        List<Contact> contacts;
        TestFactory.generateAccountWithContacts(5);
        // WHEN
        Test.startTest();
            accts = [SELECT Id FROM Account];
            contacts = [SELECT Id FROM Contact];
        Test.stopTest();
        // THEN
        Assert.isTrue(accts.size() > 0, 'Was expecting to find at least one account');
        Assert.areEqual(5, contacts.size(), 'Was expecting to find 5 contacts');
    }
}