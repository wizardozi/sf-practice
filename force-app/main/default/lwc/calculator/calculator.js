import { LightningElement, track } from 'lwc';

export default class Calculator extends LightningElement {
    @track displayValue = '';
    @track previousValues = [];
    @track operations = [];
    operators = ['+', '-', '÷', '×'];

    handleClick(event) {
        const clickedButtonLabel = event.target.label;
        // if button click is a number add it to the display
        if (!this.operators.includes(clickedButtonLabel) && clickedButtonLabel !== 'C' && clickedButtonLabel !== '=' && clickedButtonLabel !== '±') {
            this.displayValue += clickedButtonLabel;
        }
        if (clickedButtonLabel === '±') {
            // Check for zero or empty string
            if (this.displayValue === '0' || this.displayValue === '') return;
        
            // Toggle the sign
            if (this.displayValue.startsWith('-')) {
                this.displayValue = this.displayValue.slice(1);  // Remove the negative sign
            } else {
                this.displayValue = '-' + this.displayValue;  // Add the negative sign
            }
        }
             
        if (this.operators.includes(clickedButtonLabel)) {
            // Prevent consecutive operators
            if (this.operations.length > 0 && this.displayValue === '') {
                this.operations[this.operations.length - 1] = clickedButtonLabel;
                return;
            }
            // store the current value
            this.previousValues.push(Number(this.displayValue));
            // clear the input
            this.displayValue = '';
            // store the operation
            this.operations.push(clickedButtonLabel);
        }
        // if button click is '='
        if (clickedButtonLabel === '=') {
            // store the value
            this.previousValues.push(Number(this.displayValue));
            // do the calculation and display the final value
            this.displayValue = this.handleCalculation(this.previousValues, this.operations);
            // clear the previous values and operations
            this.previousValues = [];
            this.operations = [];
        }
        // if button clicked is 'C' clear everything
        if (clickedButtonLabel === 'C') {
            this.previousValues = [];
            this.operations = [];
            this.displayValue = '';
        }
    }

    handleCalculation(nums, ops) {
        let currentValue = nums[0];        
        for (let i = 1; i < nums.length; i++) {
            switch (ops[i - 1]) {
                case '+':
                    currentValue += nums[i];
                    break;
                case '-':
                    currentValue -= nums[i];
                    break;
                case '÷':
                    currentValue /= nums[i];
                    break;
                case '×':
                    currentValue *= nums[i];
                    break;                
            }
        }
        return currentValue.toString();
    }
}
