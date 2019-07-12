'use strict';

const _ = require("lodash");

// The _.chunk() function creates an array of elements split into groups
// the length of the specified size.

// The example chunks the nums array into an array of two and three element subarrays.
const nums = [1,2,3,4,5,6,7,8,9];
console.log(nums);

let c2 = _.chunk(nums, 2);
console.log(c2);

let c3 = _.chunk(nums, 3);
console.log(c3);
