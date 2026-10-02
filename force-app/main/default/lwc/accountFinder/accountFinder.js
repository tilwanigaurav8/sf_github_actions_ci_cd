import { LightningElement, wire } from 'lwc';
import queryAccountsByRevenue from '@salesforce/apex/AccountListControllerLwc.queryAccountsByRevenue';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
const COLUMNS = [
    { label: 'Account Name', fieldName: NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Annual Revenue', fieldName: REVENUE_FIELD.fieldApiName, type: 'currency' }
];
export default class AccountFinder extends LightningElement {
    fields = COLUMNS;
    annualRevenue=null;
    @wire(queryAccountsByRevenue, {annualRevenue: '$annualRevenue'})
    accounts
    handleChange(event) {
        this.annualRevenue = event.detail.value;
    }

    reset(){
        this.annualRevenue = null;
    }
}