import { LightningElement, api, wire } from 'lwc';
import { reduceErrors } from 'c/ldsUtils';
import getContactsBornAfter from '@salesforce/apex/ContactController.getContactsBornAfter';
export default class CallApexImperative extends LightningElement {
    @api minBirthDate;
    errors;
    handleButtonClick() {
        getContactsBornAfter({
            birthDate: this.minBirthDate
        })
            .then(contacts => {
                // code to execute if the promise is resolved
            })
            .catch(error => {
                this.errors = reduceErrors(error); // code to execute if the promise is rejected
            });
    }
}