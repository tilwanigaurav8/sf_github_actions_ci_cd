import { LightningElement } from 'lwc';

export default class ParentL extends LightningElement {
    startCounter=0;
    handleStartChange(event){
        this.startCounter=event.target.value;
    }
}