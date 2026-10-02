@isTest
public class MockDatabase {
    public static List<PurchaseOrder__c> purchaseOrders = new List<PurchaseOrder__c>();
    public static List<Product2> products = new List<Product2>();

    public static void setupMockData() {
        // Mock Purchase Orders
        purchaseOrders.add(new PurchaseOrder__c(Status__c = 'Processing'));
        purchaseOrders.add(new PurchaseOrder__c(Status__c = 'Shipped'));

        // Mock Products
        products.add(new Product2(Name = 'Test Product 1', Cost__c = 10,Unit__c=1,Availability__c=90));
        products.add(new Product2(Name = 'Test Product 2', Cost__c = 20,Unit__c=2,Availability__c=80));
        insert products;
        insert purchaseOrders;
    }

    public static List<PurchaseOrder__c> getPurchaseOrders() {
        return purchaseOrders;
    }

    public static List<Product2> getProducts() {
        return products;
    }
}