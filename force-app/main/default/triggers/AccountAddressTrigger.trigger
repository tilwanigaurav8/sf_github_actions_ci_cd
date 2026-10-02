trigger AccountAddressTrigger on Account (before insert, before update) {

    for (Account a : Trigger.new) {

        if (Trigger.isInsert && a.Match_Billing_Address__c) {
            a.ShippingPostalCode = a.BillingPostalCode;
        }

        if (Trigger.isUpdate &&
            a.Match_Billing_Address__c &&
            !Trigger.oldMap.get(a.Id).Match_Billing_Address__c) {

            a.ShippingPostalCode = a.BillingPostalCode;
        }
    }
}