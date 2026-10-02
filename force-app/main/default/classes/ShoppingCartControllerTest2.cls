@isTest
public class ShoppingCartControllerTest2 {
    
    @isTest
    static void testGetPurchaseOrderData() {
        // Arrange
        MockDatabase.setupMockData();
        
        // Act
        Test.startTest();
        List<PurchaseOrder__c> result = ShoppingCartController.getPurchaseOrderData();
        Test.stopTest();

        // Assert
        System.assertEquals(2, result.size(), 'Expected 2 purchase orders to be returned');
        System.assertEquals('Processing', result[1].Status__c, 'Expected the first order to be Order 2');
    }

    @isTest
    static void testGetProductData() {
        // Arrange
        MockDatabase.setupMockData();
        
        // Act
        Test.startTest();
        List<Product2> result = ShoppingCartController.getProductData();
        Test.stopTest();

        // Assert
        System.assertEquals(2, result.size(), 'Expected 2 products to be returned');
        System.assertEquals('Test Product 2', result[0].Name, 'Expected the first product to be Product 2');
    }

    @isTest
    static void testCreateOrder() {
        // Arrange
        MockDatabase.setupMockData();

        // Prepare the JSON string for selected rows
        String selectedRows = '[{"Id":"' + MockDatabase.getProducts()[0].Id + '", "Unit__c":2}, {"Id":"' + MockDatabase.getProducts()[1].Id + '", "Unit__c":4}]';
		
        // Act
        Test.startTest();
        String purchaseOrderId = ShoppingCartController.createOrder(selectedRows);
        Test.stopTest();

        // Assert
        System.assertNotEquals(null, purchaseOrderId, 'Expected a purchase order ID to be returned');

        // Verify the Purchase Order and Line Items
        PurchaseOrder__c purchaseOrder = [SELECT Id, Status__c FROM PurchaseOrder__c WHERE Id = :purchaseOrderId];
        System.assertEquals('Processing', purchaseOrder.Status__c, 'Expected the purchase order status to be Processing');

        List<PurchaseOrderLineItem__c> lineItems = [SELECT Id, Product__c, Quantity__c, ItemTotal__c FROM PurchaseOrderLineItem__c WHERE PurchaseOrder__c = :purchaseOrderId];
        System.assertEquals(2, lineItems.size(), 'Expected 2 line items to be created');
        System.assertEquals(MockDatabase.getProducts()[0].Id, lineItems[0].Product__c, 'Expected the first line item to be for Product 1');
        System.assertEquals(2, lineItems[0].Quantity__c, 'Expected the quantity of the first line item to be 2');
        System.assertEquals(20, lineItems[0].ItemTotal__c, 'Expected the total of the first line item to be 20');
    }
}