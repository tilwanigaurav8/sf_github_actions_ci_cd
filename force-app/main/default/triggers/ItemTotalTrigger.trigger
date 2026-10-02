trigger ItemTotalTrigger on PurchaseOrderLineItem__c (before insert) {
    for (PurchaseOrderLineItem__c pol : Trigger.new) {
        if (pol.Product__c != null) {
            Product2 product = [SELECT Cost__c FROM Product2 WHERE Id = :pol.Product__c LIMIT 1];
            pol.ItemTotal__c = product.Cost__c * pol.Quantity__c;
        } else {
            pol.ItemTotal__c = 0;
        }
    }
}