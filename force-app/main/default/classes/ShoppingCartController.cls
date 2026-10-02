public with sharing class ShoppingCartController {
    @AuraEnabled(cacheable=true)
    public static List<PurchaseOrder__c> getPurchaseOrderData(){
        try {
            return [SELECT Id, Name, Status__c, Order_Total__c FROM PurchaseOrder__c ORDER BY Name DESC LIMIT 1000];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductData(){
        try {
            return [SELECT Id, Name, Cost__c,ProductCode,Unit__c FROM Product2 ORDER BY Name DESC LIMIT 1000];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    
    @AuraEnabled
    public static string createOrder(String selectedRows){
        try {
            System.debug(selectedRows);
            List<Object> rec = (List<Object>)JSON.deserializeUntyped(selectedRows);
			System.debug('1');

            List<Map<String, Object>> parsedData = new List<Map<String, Object>>();
			System.debug('2');
            for(Object o: rec){
                parsedData.add((Map<String, Object>)o);
            }
			System.debug('3');
            // List<Map<String, Object>> parsedData = (List<Map<String, Object>>)JSON.deserializeUntyped(selectedRows);

            System.debug(parsedData);

            List<PurchaseOrderLineItem__c> lineItems = new List<PurchaseOrderLineItem__c>();
            System.debug('4');
            PurchaseOrder__c purchaseOrder = new PurchaseOrder__c(Status__c = 'Processing');
            System.debug('5');
            insert purchaseOrder;
            System.debug('6');

			System.debug(parsedData);
            for(Map<String, Object> product : parsedData){
                System.debug('7');
                PurchaseOrderLineItem__c lineItem = new PurchaseOrderLineItem__c();
                System.debug('p1');
                lineItem.Product__c = (Id)product.get('Id');
                System.debug('p2');
                lineItem.PurchaseOrder__c = purchaseOrder.Id;
                System.debug('p3');
                lineItem.Quantity__c = (Integer)product.get('Unit__c');
                System.debug('p4');
                lineItems.add(lineItem);
                System.debug('8');
            }
			System.debug('9');
            if (lineItems.size() > 0) {
                insert lineItems;
            }
			System.debug('10');
            return purchaseOrder.Id;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}