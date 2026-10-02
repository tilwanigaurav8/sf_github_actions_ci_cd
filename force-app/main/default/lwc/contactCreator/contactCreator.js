import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import ACCOUNT_OBJECT from '@salesforce/schema/Contact.AccountId';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import EMAIL from '@salesforce/schema/Contact.Email';
export default class ContactCreator extends LightningElement {
    objectAPIName=CONTACT_OBJECT;
    fields=[FIRST_NAME,LAST_NAME,ACCOUNT_OBJECT,EMAIL];

    handleSuccess(event){
        const toastEvent=new ShowToastEvent({
            title:"New Contact Created",
            message:"Contact ID created: "+event.detail.id,
            variant:"success"
        });
        this.dispatchEvent(toastEvent);
    }
}