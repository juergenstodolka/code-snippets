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

    // Instance method
    drive (distance) {
        this.miles += distance;
    }

    // Static class field
    static get ageFactor () {
        return 0.1;
    }
    static get distanceFactor () {
        return 0.4;
    }

    // Static class method
    static pickBetter (carA, carB) {
        const computeScore = car => car.age * Car.ageFactor + car.distanceTravelled * Car.distanceFactor;

        return computeScore(carA) < computeScore(carB) ? carA : carB;
    }
}

const car1 = new Car(2007);
car1.drive(150000);

const car2 = new Car(2010);
car2.drive(175000);

console.log(Car.pickBetter(car1, car2));

const car = new Car(2007);
car.drive(10);

