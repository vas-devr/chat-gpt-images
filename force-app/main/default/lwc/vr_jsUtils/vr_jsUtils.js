import { LightningElement } from 'lwc';

export function parseJSON(data) {
    return JSON.parse(JSON.stringify(data));
}