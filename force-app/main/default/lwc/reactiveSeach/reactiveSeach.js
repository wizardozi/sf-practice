import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class reactiveSearch extends LightningElement {    
    searchKey = '';
    contacts = [];
    handleSearchChange(event) {
        this.searchKey = event.target.value;
    }
    getContacts() {
       getContacts({ searchKey: this.searchKey })
            .then(result => {
                this.contacts = result;
            })
            .catch(error => {
                console.error('Error fetching contacts:', error);
            }); 
    }
    handleSearchClick() {
        this.getContacts();
    }
}
