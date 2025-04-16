import { LightningElement } from 'lwc';

export default class ToggleMessage extends LightningElement {
    isVisible = false;

    handleToggle() {
        this.isVisible = !this.isVisible;
    }
}   
