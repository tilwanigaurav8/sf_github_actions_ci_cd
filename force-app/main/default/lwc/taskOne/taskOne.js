import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class TaskOne extends LightningElement {
    handleClick(event){
        this.error='';
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: event.detail.apiName + ' created.',
                variant: 'success',
            })
        )
    }
    error='';
    handleError(event){
        this.error='Record not created';
    }
}