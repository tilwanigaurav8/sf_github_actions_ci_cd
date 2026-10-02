@isTest
private class AddSampleBotanicalDataTest {
	
    @testSetup 
    static void setup() {
        // Create Pricebook2
        Pricebook2 testPricebook2 = new Pricebook2(Name = 'Standard Price Book');
        insert testPricebook2;        
    }
    
    @isTest
    static void testAddSampleDataTest() {
        
        Test.startTest();
        	AddSampleBotanicalData.addBotanicalData();
        Test.stopTest();
        List<Order> testOrders = [SELECT Id, Description FROM Order WHERE Status = 'Draft'];
        Assert.areEqual(testOrders.size(), 1);
    }
}