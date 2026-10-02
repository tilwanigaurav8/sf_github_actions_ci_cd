public with sharing class VishalK {
    @AuraEnabled
    public static void saveCon(String fn,String ln){
        try {
            Contact c=new Contact(FirstName=fn,LastName=ln);
            insert c;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}