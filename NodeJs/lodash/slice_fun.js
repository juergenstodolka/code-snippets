'use strict';

const _ = require("lodash");

// The _.slice() method gets a slice from an array. 
// It takes two indexes: the starting and ending index, where the
// starting index is inclusive and the ending is exclusive.

const nums = [1,2,3,4,5,6,7,8,9];
console.log(nums);

let c1 = _.slice(nums, 2, 6);
console.log(c1);

let c2 = _.slice(nums, 0, 8);
console.log(c2);