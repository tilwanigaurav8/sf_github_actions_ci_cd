import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {
    greeting='Gaurav';

    handleChange(event){
        this.greeting=event.target.value;
    }
}