'use strict';

const _ = require("lodash");

const words = ['sky', 'wood', 'forest', 'falcon', 'pear', 'ocean', 'universe'];

// Return the first and last array element
let fel = _.first(words);
let lel = _.last(words);

console.log(words);
console.log(`First element: ${fel}`);
console.log(`Last element: ${lel}`);