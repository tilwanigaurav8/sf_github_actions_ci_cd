@isTest
public class TestRestrictContactByName {
	@isTest
    static void testContact(){
        Contact c=new Contact(LastName='INVALIDNAME');
        Test.startTest();
        Database.SaveResult sr=Database.insert(c);
        Test.stopTest();
        
        System.assertEquals('The Last Name INVALID is not allowed for DML',sr.getErrors()[0].getMessage());
    }
}