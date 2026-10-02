global class AddSampleBotanicalData {
    @InvocableMethod
    public static void addBotanicalData() {
        // Add account
        Account botAccount = new Account(
            Name = 'Alsarraf Enterprises',
            BillingCity = 'San Francisco',
            Select_Country__c = 'USA'
        );
        try {
            insert botAccount;
        } catch(DmlException e) {
            System.debug('Error inserting Account: ' + e.getMessage());
        }
        
        // Get the Standard Price Book 
        List<PriceBook2> Pricebook2s = [SELECT Id, Name, IsActive FROM Pricebook2 WHERE Name = 'Standard Price Book'];
        Pricebook2 pb2 = new Pricebook2();
        if(Pricebook2s.size() > 0) {
            pb2 = Pricebook2s[0];
        }
        pb2.IsActive = true;
        update pb2;
    
        // Add Products
        List<Product2> botanicalProductsToInsert = new List<Product2>();
        Product2 bonusProduct = new Product2(
            ProductCode = 'BOT-BB-12',
            IsActive = true,
            Name = 'Beautiful Blue Standard Bouquet'
        );
        botanicalProductsToInsert.add(bonusProduct);
        
        Product2 botanicalProduct1 = new Product2(
            ProductCode = 'BOT-WW-12',
            IsActive = true,
            Name = 'Wonderful White Standard Bouquet'
        );
        botanicalProductsToInsert.add(botanicalProduct1);

        Product2 botanicalProduct2 = new Product2(
            ProductCode = 'BOT-RR-12',
            IsActive = true,
            Name = 'Ruby Red Standard Bouquet'
        );
        botanicalProductsToInsert.add(botanicalProduct2);

        Product2 botanicalProduct3 = new Product2(
            ProductCode = 'BOT-YY-12',
            IsActive = true,
            Name = 'Yelpin Yellow Standard Bouquet'
        );
        botanicalProductsToInsert.add(botanicalProduct3);

        Product2 botanicalProduct4 = new Product2(
            ProductCode = 'BOT-GG-12',
            IsActive = true,
            Name = 'Gracious Green Standard Bouquet'
        );
        botanicalProductsToInsert.add(botanicalProduct4);
        
        try {
            insert botanicalProductsToInsert;
        } catch (DmlException e) {
            System.debug('Error inserting Botanical Products: ' + e.getMessage());
            // Handle DML errors appropriately
        }
        
        if(!botanicalProductsToInsert.isEmpty()) {
            List<PricebookEntry> pricebookEntries = new List<PricebookEntry>();
            for(Product2 botanicalProduct : botanicalProductsToInsert) {
                PricebookEntry newPricebookEntry = new PricebookEntry();
                newPricebookEntry.Product2Id = botanicalProduct.Id;
                newPricebookEntry.Pricebook2Id = pb2.Id;
                newPricebookEntry.IsActive = true;
                if(botanicalProduct.ProductCode == 'BOT-BB-12') {
                    newPricebookEntry.UnitPrice = 0;
                } else {
                    newPricebookEntry.UnitPrice = 100;
                }
                pricebookEntries.add(newPricebookEntry);
            }
            try {
                insert pricebookEntries;
            } catch(DmlException e) {
                System.debug('Error inserting PricebookEntry: ' + e.getMessage());
            }
        }
        // Add Contract
        Contract newContract = new Contract(
            AccountId = botAccount.Id,
            Status = 'Draft',
            ContractTerm = 1,
            StartDate = System.Today()
        );
        try {
            insert newContract;
        } catch(DmlException e) {
            System.debug('Error inserting new Contract: ' + e.getMessage());
        }
        
        Contract updateContract = [SELECT Id, Status FROM Contract WHERE Id = :newContract.Id];
        updateContract.Status = 'Activated';
        update updateContract;
        
        // Add Order
        Order newOrder = new Order(
            AccountId = botAccount.Id,
            ContractId = newContract.Id,
            Description = 'Flowers for friend',
            Status = 'Draft',
            EffectiveDate = System.Today()
        );
        try {
            insert newOrder;
        } catch(DmlException e) {
            System.debug('Error inserting new Order: ' + e.getMessage());
        }
    }

}