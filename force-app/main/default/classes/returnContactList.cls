public with sharing class returnContactList {
    @AuraEnabled
    public static List<Contact> contactList(){
        try {
            return [SELECT FirstName,LastName,Email FROM Contact];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}