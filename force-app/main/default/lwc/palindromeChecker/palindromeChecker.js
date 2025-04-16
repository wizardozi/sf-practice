import { LightningElement, track } from 'lwc';
import checkPalindrome from '@salesforce/apex/PalindromeCheckerController.checkPalindrome';

export default class PalindromeChecker extends LightningElement {
    @track palindrome = '';
    @track result;
    @track error; 
    handleChange(event) {
        this.palindrome = event.target.value;
    }
    handleClick() {
            checkPalindrome({ 
                palindrome: this.palindrome                 
            })
                .then(result => {
                    console.log('Input: '+this.palindrome)
                    this.result = result;
                    console.log('palindrome check result: '+this.result);
                    this.error = undefined;                    
                })
                .catch(error => {
                    this.error = error.body.message;                                        
                })
        }
}