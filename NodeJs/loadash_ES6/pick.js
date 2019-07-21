'use strict';
const _ = require('lodash');

/*
  Pick
  The pick utility allows us to select the properties we want from a target object.
  We can achieve the same results using destructuring and shorthand object literals:
*/
var object = { 'a': 1, 'b': '2', 'c': 3 };

const selection = _.pick(object, ['a', 'c']);
// { a: 1, c: 3 }
console.log(selection);

// becomes

const {a, c} = { a: 1, b: 2, c: 3 };

console.log( {a, c} ); 