'use strict';

const text = new String('live');

try {
  text.reverse();
} catch (error) {
  console.log(error.message);
}

// reverse function is only injected to a single instance not to the String class.
text.reverse = function () {
  return this.split('').reverse().join('');
}

console.log(text.reverse());