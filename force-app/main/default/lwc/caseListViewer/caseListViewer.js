import { LightningElement, wire } from 'lwc';
import getOpenCases from '@salesforce/apex/CaseController.getOpenCases';

export default class CaseListViewer extends LightningElement {
    cases;

    @wire(getOpenCases)
    wiredCases({ data, error }) {
        if (data) {
            this.cases = data;
        } else if (error) {
            console.error(error);
        }
    }
}
