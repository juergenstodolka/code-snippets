'use strict';

class Person {
  constructor(age) {
    if (!age || age <= 0) {
      throw new Error('Constructor needs age');
    }
    this.age = age;
  }

  play() {
    console.log(`The ${this.age} year old is playing`);
  }

  get years() { return this.age; }
}

const sam = new Person(2);

console.log(sam);
sam.play();
const fieldName = 'age';
const methodName = 'play';

console.log(sam[fieldName]);
sam[methodName];

console.log(`Members of sam: ${Object.keys(sam)}`);

for (const property in sam) {
  console.log(`Property: ${property} value: ${sam[property]}`);
}

console.log(Object.getOwnPropertyNames(Reflect.getPrototypeOf(sam)));