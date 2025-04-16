import { LightningElement } from 'lwc';

export default class UserGreeting extends LightningElement {
    userName = '';

    handleInputChange(event) {
        this.userName = event.target.value;
    }
}
