'use strict';
const _ = require('lodash');

/*
   Curry
   Without a higher-level language such as [TypeScript][5] or [Flow][6], we can’t give our functions 
   type signatures, which makes currying quite difficult.
   When we receive curried functions, it’s hard to know how many arguments have already been supplied,
   and which we’ll need to provide next.
   With arrow functions, we can define curried functions explicitly, making them easier to understand
   for other programmers:
*/

function add(a, b) {
    return a + b;
 }

const curriedAdd = _.curry(add);
const add2 = curriedAdd(2);
const sum =  add2(1);
  // 3
  console.log(`Sum=${sum}`);

  // becomes

const add_es6 = a => b => a + b;
const add2_es6 = add_es6(2);
const sum_es6 = add2_es6(1);
// 3
console.log(`Sum_es6=${sum_es6}`);

// These explicitly curried arrow functions are particularly important for debugging:
var lodashAdd = _.curry(function(a, b) {
    return a + b;
  });
  var add3 = lodashAdd(3);
  console.log(add3.length)
  // 0
  console.log(add3);
  // function (a, b) {
  // /* [wrapped with _.curry & _.partial] */
  //   return a + b;
  // }
  
  // becomes
  const es6Add = a => b => a + b;
const add3_es6 = es6Add(3);
console.log(add3_es6.length);
// 1
console.log(add3_es6);
// function b => a + b
