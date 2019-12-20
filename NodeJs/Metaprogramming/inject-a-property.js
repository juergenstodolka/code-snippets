'use strict';

let today = new Date();

Object.defineProperty(today, 'isInLeapYear', {
  get: function () {
    const year = this.getFullYear();
    return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
  },
  set: function () {

  }
});

console.log(`${today.getFullYear()} is a leap year?: ${today.isInLeapYear}`);
console.log('-'.repeat(80));

// Another example: property always return the same string
var pattern = {
  get: function () {
    return 'I always return this string, whatever you have assigned';
  },
  set: function () {
    this.myname = 'this is my name string';
  }
};


function TestDefineSetAndGet () {
  Object.defineProperty(this, 'myproperty', pattern);
}


var instance = new TestDefineSetAndGet();
instance.myproperty = 'test';
console.log(instance.myproperty); // I always return this string, whatever you have assigned

console.log(instance.myname); // this is my name string