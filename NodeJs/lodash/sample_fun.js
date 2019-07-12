'use strict';

const _ = require("lodash");

// With the _.sample() finction, we can pick a random element from an array.

const words = ['sky', 'wood', 'forest', 'falcon', 'pear', 'ocean', 'universe'];

let word = _.sample(words);
console.log(word);