public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String searchWord) {
        // SOSL query searching the text across Contact and Lead fields
        List<List<sObject>> searchResults = [
            FIND :searchWord 
            IN ALL FIELDS 
            RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName)
        ];
        
        return searchResults;
    }
}