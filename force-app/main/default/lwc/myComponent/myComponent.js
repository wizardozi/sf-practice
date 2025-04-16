import { LightningElement, wire, track } from 'lwc';
import getContacts from '@salesforce/apex/MyApexClass.getContacts';

export default class MyComponent extends LightningElement {
    @track contacts;
    columns = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' },
        { label: 'Phone', fieldName: 'Phone' }
        // Add other fields as needed
    ];
    
    @wire(getContacts)
    wiredContacts({ error, data }) {
        if (data) {
            console.log('Fetched contacts:', data);
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            console.error('Error fetching contacts:', error);
            this.contacts = undefined;
            this.error = error;
        }
    }    
}
