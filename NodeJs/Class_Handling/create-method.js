'use strict';

class Car {
    constructor (year) {
        this.year = year;
        this.miles = 0;
    }

    drive (distance) {
        this.miles += distance;
    }
}