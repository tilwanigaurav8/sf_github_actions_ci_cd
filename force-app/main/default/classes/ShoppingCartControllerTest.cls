@isTest
public class ShoppingCartControllerTest {
    
    @isTest
    static void testGetPurchaseOrderData() {
        // Arrange: Create test data
        List<PurchaseOrder__c> testOrders = new List<PurchaseOrder__c>{
            new PurchaseOrder__c(Status__c = 'Processing'),
            new PurchaseOrder__c(Status__c = 'Shipped')
        };
        insert testOrders;

        // Act: Call the method
        Test.startTest();
        List<PurchaseOrder__c> result = ShoppingCartController.getPurchaseOrderData();
        Test.stopTest();

        // Assert: Verify the results
        System.assertEquals(2, result.size(), 'Expected 2 purchase orders');
    }

    @isTest
    static void testGetProductData() {
        // Arrange: Create test data
        List<Product2> testProducts = new List<Product2>{
            new Product2(Name = 'Test Product 1', Cost__c = 10,Unit__c=1,Availability__c=90),
            new Product2(Name = 'Test Product 2', Cost__c = 20,Unit__c=2,Availability__c=80)
        };
        insert testProducts;

        // Act: Call the method
        Test.startTest();
        List<Product2> result = ShoppingCartController.getProductData();
        Test.stopTest();

        // Assert: Verify the results
        System.assertEquals(2, result.size(), 'Expected 2 products');
        System.assertEquals('Test Product 2', result[0].Name, 'Expected the first product to be Test Product 2');
    }

    @isTest
    static void testCreateOrder() {
        // Arrange: Prepare test data
        List<Map<String, Object>> productData = new List<Map<String, Object>>{
            new Map<String, Object>{
                'Unit__c' => 2,
                'Cost__c' =>20,
                'Availability__c' => 28
            },
            new Map<String, Object>{
                'Unit__c' => 3,
                'Cost__c' =>50,
                'Availability__c' => 23
            }
        };
        String selectedRows = JSON.serialize(productData);

        Product2 testProduct1 = new Product2( Name = 'Test Product 1', Cost__c = 10,Unit__c=1,Availability__c=90);
        Product2 testProduct2 = new Product2( Name = 'Test Product 2', Cost__c = 20,Unit__c=2,Availability__c=50);
        insert new List<Product2>{ testProduct1, testProduct2 };

        Test.startTest();
        String purchaseOrderId = ShoppingCartController.createOrder(selectedRows);
        System.debug(purchaseOrderId);
        Test.stopTest();

        //System.assertNotEquals(null, purchaseOrderId, 'Expected a purchase order ID to be returned');
        List<PurchaseOrderLineItem__c> lineItems = [SELECT Id, Product__c, Quantity__c, ItemTotal__c FROM PurchaseOrderLineItem__c];
        System.assertEquals(2, lineItems.size(), 'Expected 2 line items to be created');
    }
}