'use strict';
const _ = require('lodash');

/*
  Operators
  Lodash comes with a number of functions that reimplement syntactical operators as functions, 
  so that they can be passed to collection methods.

  In most cases, arrow functions make them simple and short enough that we can define them inline instead:
*/

_.eq(3, 3);
// true
_.add(10, 1);
// 11
_.map([1, 2, 3], function(n) {
  return _.multiply(n, 10);
});
// [10, 20, 30]
_.reduce([1, 2, 3], _.add);
// 6

// becomes

3 === 3;
10 + 1;
[1, 2, 3].map(n => n * 10);
[1, 2, 3].reduce( (total, n) => total + n);
