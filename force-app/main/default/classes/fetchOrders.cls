public class fetchOrders {
	@AuraEnabled(cacheable=true)
    public static List<AggregateResult> getHistory(String productId) {
        return [SELECT PurchaseOrder__r.Id, PurchaseOrder__r.Status__c, SUM(ItemTotal__c) FROM PurchaseOrderLineItem__c WHERE Product__r.Id=:productId GROUP BY PurchaseOrder__r.Id, PurchaseOrder__r.Status__c];
    }
}