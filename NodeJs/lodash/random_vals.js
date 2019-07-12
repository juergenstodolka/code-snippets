'use strict';

const _ = require("lodash");

// The _.random() function produces random values between the inclusive lower and upper bounds

// We produce a random value between 0 and 10
let r = _.random(10);
console.log(r);

// We produce a random value between 5 and 10
r = _.random(5, 10);
console.log(r);