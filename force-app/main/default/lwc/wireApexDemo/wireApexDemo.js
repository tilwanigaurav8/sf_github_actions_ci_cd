import { api, LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
export default class WireApexDemo extends LightningElement {
    @api recordId;

    @wire(getContacts,{accId:'$recordId'})
    contacts;


    
}