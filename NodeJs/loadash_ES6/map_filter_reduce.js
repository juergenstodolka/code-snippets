'use strict';

const _ = require('lodash');
/*
   Map, Filter, Reduce
   These collection methods make transforming data a breeze and with near universal
   support.
   We can pair them with arrow functions to help us write terse alternatives to 
   the implementations offered by Lodash:
*/

const map_result = _.map([1,2, 3], function(n) { return n * 3} );
console.log(map_result);

const reduce_result = _.reduce([1, 2, 3], function (total, n) { return total + n}, 0);
console.log(reduce_result);

const filter_result = _.filter([1, 2, 3], function(n) { return n <= 2});
console.log(filter_result);

// becomes
console.log( '-'.repeat(50));
const map_result_es6 = [1, 2, 3].map(n => n * 3);
console.log(map_result_es6);

const reduce_es6 = [1, 2, 3].reduce((total, n) => total + n);
console.log(reduce_es6);

const filter_result_es6 = [1, 2, 3].filter(n => n <= 2);
console.log(filter_result_es6);
