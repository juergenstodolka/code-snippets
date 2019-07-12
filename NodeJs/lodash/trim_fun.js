'use strict';

const _ = require("lodash");

// Remove leading and trailing whitespaces from string
const name = '   hallo Jürgen  ';
let trimmed_name = _.trim(name);

console.log(`[${name}]`);
console.log(`[${trimmed_name}]`);