import { LightningElement} from 'lwc';

export default class SquareNumbers extends LightningElement {
    inputNumber;
    result;
    calculateSquare(number) {
        this.result = number*number
        return this.result;
    }
    handleInputChange(event) {
        this.squareBefore  = event.target.value;
    }
    handleButtonClick() {
        const number = parseInt(this.squareBefore);
        const result = this.calculateSquare(number);
        console.log(`The square of ${number} is ${result}`);
    }
    
}