'use strict';

const _ = require('lodash');

/*
  Head & Tail
  Destructuring syntax allows us to get the head and tail of a list 
  without utility functions:
*/

console.log(_.head([1, 2, 3]));
// 1
console.log(_.tail([1, 2, 3]));
// [2, 3]

// becomes

const [head, ...tail] = [1, 2, 3];
console.log(`head=${head}`);
console.log(`tail=${tail}`);

// It’s also possible to get the initial elements and the last element in a similar way:
console.log( '-'.repeat(50));

console.log( _.initial([1, 2, 3]) );
// -> [1, 2]
console.log( _.last([1, 2, 3]) );
// 3

// becomes

const [last_es6, ...initial_es6] = [1, 2, 3].reverse();
console.log(`last_es6=${last_es6}`);
console.log(`initial_es6=${initial_es6.reverse()}`);

/*
   If you find it annoying that reverse mutates the data structure,
   then you can use the spread operator to clone the array before calling reverse:
*/
console.log( '-'.repeat(50));

const xs = [1, 2, 3];
const [last_copy, ...initial_copy] = [...xs].reverse();

console.log(`xs=${xs}`);
console.log(`last_copy=${last_copy}`);
console.log(`initial_copy=${initial_copy}`);
console.log(`xs=${xs}`);