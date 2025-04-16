import { LightningElement, track } from 'lwc';
import findContacts from '@salesforce/apex/ContactSearchController.findContacts';

export default class ContactSearch extends LightningElement {
    @track lastName = '';    
    @track firstName = '';    
    @track contacts;    
    @track error;    
    @track noResults = false;    

    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }
    handleFirstNameChange(event) {
        this.firstName = event.target.value;
    }

    handleSearch() {
        findContacts({ 
            firstName: this.firstName, 
            lastName: this.lastName 
        })
            .then(result => {
                console.log('Last Name: '+this.lastName);
                console.log('First Name: '+this.firstName);
                this.contacts = result;
                this.error = undefined;
                this.noResults = result.length === 0;
            })
            .catch(error => {
                this.error = error.body.message;
                this.contacts = undefined;
                this.noResults = false;
            })
    }
}