'use strict';

const text = new String('live');
const anotherText = 'rats';
const primitiveText = 'part';

String.prototype.reverse = function () {
  return this.split('').reverse().join('');
};

console.log(text.reverse());
console.log(anotherText.reverse());
console.log(primitiveText.reverse());