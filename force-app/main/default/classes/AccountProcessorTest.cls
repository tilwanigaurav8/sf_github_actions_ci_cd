@isTest
public class AccountProcessorTest {

    @isTest
    static void testCountContacts() {

        // Create Account
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Create Contacts
        List<Contact> contacts = new List<Contact>();

        contacts.add(new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            AccountId = acc.Id
        ));

        contacts.add(new Contact(
            FirstName = 'Jane',
            LastName = 'Doe',
            AccountId = acc.Id
        ));

        insert contacts;

        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{acc.Id});
        Test.stopTest(); // Executes the future method

        Account updatedAcc = [
            SELECT Number_Of_Contacts__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(
            2,
            updatedAcc.Number_Of_Contacts__c
        );
    }
}