import { LightningElement, track } from 'lwc';

export default class TrackDemo extends LightningElement {
    @track itemsWithTrack = [];
    itemsWithoutTrack = [];

    addItemWithTrack() {
        const newItem = { id: Date.now(), name: 'Tracked Item ' + (this.itemsWithTrack.length + 1) };
        this.itemsWithTrack.push(newItem);
    }

    addItemWithoutTrack() {
        const newItem = { id: Date.now(), name: 'Untracked Item ' + (this.itemsWithoutTrack.length + 1) };
        this.itemsWithoutTrack.push(newItem);
        this.itemsWithoutTrack = [...this.itemsWithoutTrack]; // Spread operator to force reactivity
    }

    get items() {
        return [...this.itemsWithTrack, ...this.itemsWithoutTrack];
    }
}
