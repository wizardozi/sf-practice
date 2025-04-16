import { LightningElement, api } from 'lwc';

export default class GreetingChild extends LightningElement {
    @api receivedName;
}
