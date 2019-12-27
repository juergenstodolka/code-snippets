'use strict';

const text = new String('live');
const anotherText = new String('reats');

text.reverse = function() {
  return this.split('').reverse().join('');
};

try {
  text.reverse();
  anotherText.reverse();
}
catch (err) {
  console.log(err.message);
}

console.log(text.toString());
console.log('Reverted text:', text.reverse());