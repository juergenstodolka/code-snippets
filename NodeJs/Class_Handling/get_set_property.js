'use strict';

class Car {
    constructor (year) {
        this.year = year;
        this.miles = 0;
    }

    // Create a read/write property
    // getter
    get distanceTravelled () {
        return this.miles;
    }

    //setter
    set distanceTravelled (value) {
        if (value < this.miles) {
            throw new Error("Sorry, can't set value to less than current distance traveled.");
        }
        this.miles = value;
    }

    drive (distance) {
        this.miles += distance;
    }
}

const car = new Car(2007);
car.drive(10);
console.log('Distance travelled:', car.distanceTravelled);

car.distanceTravelled = 14;
console.log('Distance travelled:', car.distanceTravelled);

try {
    car.distanceTravelled = 1;
} catch (error) {
    console.log(error.message);
}


