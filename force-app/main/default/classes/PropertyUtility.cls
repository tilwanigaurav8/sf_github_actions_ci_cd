public class PropertyUtility {
    public static void newListedProperties(){
        List<Property__c> newPropList = [SELECT Name, Days_On_Market__c, Broker__r.Email__c 
            FROM Property__c 
            WHERE Days_On_Market__c < 31];
        for(Property__c prop:newPropList){
            String propEmail=prop.Name+':'+prop.Broker__r.Email__c;
            system.debug(propEmail);
        }                
    }
}