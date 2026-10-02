@isTest
public class AddPrimaryContactTest {

    @isTest
    static void testAddPrimaryContact() {

        List<Account> accounts = new List<Account>();

        // 50 NY Accounts
        for(Integer i = 0; i < 50; i++) {
            accounts.add(
                new Account(
                    Name = 'NY Account ' + i,
                    BillingState = 'NY'
                )
            );
        }

        // 50 CA Accounts
        for(Integer i = 0; i < 50; i++) {
            accounts.add(
                new Account(
                    Name = 'CA Account ' + i,
                    BillingState = 'CA'
                )
            );
        }

        insert accounts;

        Contact templateContact = new Contact(
            FirstName = 'Primary',
            LastName = 'Contact'
        );

        Test.startTest();

        AddPrimaryContact job =
            new AddPrimaryContact(templateContact, 'CA');

        System.enqueueJob(job);

        Test.stopTest();

        List<Contact> insertedContacts = [
            SELECT Id, AccountId
            FROM Contact
            WHERE FirstName = 'Primary'
            AND LastName = 'Contact'
        ];

        System.assertEquals(
            50,
            insertedContacts.size(),
            'Exactly 50 Contacts should be created for CA Accounts'
        );
    }
}