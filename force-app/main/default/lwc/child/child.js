import { api, LightningElement } from 'lwc';

export default class Child extends LightningElement {
    upperCaseItemName='default value';

    @api
    get itemName(){
        return this.upperCaseItemName;
    }

    set itemName(value){
        this.upperCaseItemName=value.toUpperCase();
    }
}