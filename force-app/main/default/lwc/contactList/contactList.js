import { LightningElement ,wire} from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import {reduceErrors} from 'c/ldsUtils'
import ID from '@salesforce/schema/Contact.Id';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import EMAIL from '@salesforce/schema/Contact.Email'

export default class ContactList extends LightningElement {
    fields=[ID,FIRST_NAME,LAST_NAME,EMAIL];
    columns=[
        {label:'ID',fieldName:ID.fieldApiName,type:'text'},
        {label:'First Name',fieldName:FIRST_NAME.fieldApiName,type:'text'},
        {label:'Last Name',fieldName:LAST_NAME.fieldApiName,type:'text'},
        {label:'Email',fieldName:EMAIL.fieldApiName,type:'text'}
    ]
    data;
    errors;
    @wire(getContacts)
    contacts({data,error}){
        if(data){
            this.data=data;
            console.log("idjas");
            console.log(this.data);
        }
        else{
            console.log("faio");
            this.errors=error;
        }
    };

    connectedCallback(){
        console.log('Success '+this.contacts.data);
    }

    getErrors(){
        return reduceErrors(this.errors);
    }
}