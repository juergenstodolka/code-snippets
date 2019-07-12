'use strict';

const _ = require("lodash");

// The _.shuffle() function shuffles a collection.

// The example creates three new randomly reorganized arrays from an initial array of words.

const words = ['sky', 'wood', 'forest', 'falcon', 'pear', 'ocean', 'universe'];

console.log(_.shuffle(words));
console.log(_.shuffle(words));
console.log(_.shuffle(words));
console.log(words);