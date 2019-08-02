'use strict';

// The variable contains the value evaluated from a templater string.
const NYD = `New Year's day`;

class Holidays {
    constructor () {
        // Define properties using template string
        this[NYD] = 'January 1';
        this["Valentine's day"] = 'February 14';
    }

    // Define a method using template literal
    ['list holidays'] () {
        return Object.keys(this);
    }
}

// In addition to defining computed files and method within the class,
// we can add them to an instance.
// The object is an instance of Holidays class but has an additional computed field named '4th of July'
const usHolidays = new Holidays();
usHolidays['4th of Juls'] = 'July 4';

console.log(usHolidays["Valentine's day"]);
const methodName = 'list holidays';
console.log(usHolidays[methodName]());