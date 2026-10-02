import { LightningElement, api, wire } from 'lwc';
import { reduceErrors } from 'c/ldsUtils';
import getContactsBornAfter from '@salesforce/apex/ContactController.getContactsBornAfter';
export default class WireApexFunction extends LightningElement {
    @api minBirthDate;
    errors;
    @wire(getContactsBornAfter, { birthDate: '$minBirthDate' })
    wiredContacts({data, error}) {
        if (error)
            this.errors = reduceErrors(error);
    }
}