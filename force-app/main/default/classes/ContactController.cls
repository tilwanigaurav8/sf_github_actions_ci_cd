public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        try {
            return [SELECT Id,FirstName,LastName,Email FROM Contact WITH SECURITY_ENFORCED];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsBornAfter(Date birthDate){
        try {
            return [SELECT Id,FirstName,LastName,Email FROM Contact WHERE  Birthdate>:birthDate WITH SECURITY_ENFORCED];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}