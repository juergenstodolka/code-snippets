'use strict';
const _ = require('lodash');

/*
   Chaining & Flow
   Lodash provides some functions for helping us write chained statements. 
   In many cases, the built-in collection methods return an array instance
   that can be directly chained, but in some cases where the method mutates the collection,
   this isn’t possible.
*/

// However, we can define the same transformations as an array of arrow functions:

const loadash_result = _([1, 2, 3])
.tap(function(array) {
  // Mutate input array.
  array.pop();
})
.reverse()
.value();
// [2, 1]

console.log(loadash_result);

// becomes

const pipeline = [
    array => { array.pop(); return array; },
    array => array.reverse()
  ];
  
const es6_res =  pipeline.reduce((xs, f) => f(xs), [1, 2, 3]);
console.log(es6_res);

// This way, we don’t even have to think about the difference between tap and thru. 
// Wrapping this reduction in a utility function makes a great general purpose tool:
const pipe = functions => data => {
    return functions.reduce(
      (value, func) => func(value),
      data
    );
  };
  
  const pipeline_es6 = pipe([
    x => x * 2,
    x => x / 3,
    x => x > 5,
    b => !b
  ]);
  
  pipeline_es6(5);
  // true
  pipeline_es6(20);
  // false



