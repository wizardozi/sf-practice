import { LightningElement } from 'lwc';

export default class GreetingParent extends LightningElement {
    // your code here    
    userName = "";
    handleInputChange(event) {
        this.userName = event.target.value;
    }
}
