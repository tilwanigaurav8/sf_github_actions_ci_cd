import { api, LightningElement, wire } from 'lwc';
import getHistory from '@salesforce/apex/fetchOrders.getHistory';
import PO from '@salesforce/schema/PurchaseOrder__c.Id';
import STATUS from '@salesforce/schema/PurchaseOrder__c.Status__c';
export default class LwcOne extends LightningElement {
    @api recordId;


    @wire(getHistory,{productId:'$recordId'})
    records;

    setColumns=[
        {label:"Purchase Id", fieldName:"Id", type:"text"},
        {label:"Order Status", fieldName:"Status__c", type:"text"},
        {label:"Total", fieldName:"expr0", type:"number"}
    ]

}