public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer n,String last){
        List<Contact> newContact=new List<Contact>();
        
        for(Integer i=0;i<n;i++){
            Contact c=new Contact(FirstName='Test '+i,LastName=last);
            newContact.add(c);
        }
        insert newContact;
        return newContact;
    }
}