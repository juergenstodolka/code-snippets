'use strict';

const _ = require("lodash");

const words = ["tank", "boy", "tourist", "ten",
        "pen", "car", "marble", "sonnet", "pleasant",
        "ink", "atom"];

// Ugly
const result = _.compact(_.map(words, (e) => {
    if (_.startsWith(e, 't')) {
       return e
    }
}))

console.log(result);
console.log(_.repeat('-', 50));

// Better
const filtered_result = _.filter(words, (e) => {
    return _.startsWith(e, 't');
})

console.log(filtered_result);