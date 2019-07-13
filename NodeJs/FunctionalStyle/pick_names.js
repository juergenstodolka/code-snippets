'use strict';


const words = ['Boat', 'River', 'Tree', 'garden', 'mouse'];

// Given: a list of names
// Action: create a comma separated string with names of length 5, all in uppercase
// Return: a string
const pickNamesInUpperCaseOfLength = function(names, length) {
    return names.filter( function(name) { return name.length === length})
        .map(function(name) { return name.toUpperCase(); } )
        .join(', ');
           
};

const hits = pickNamesInUpperCaseOfLength(words, 5);
console.log(hits);
let str = '_';
console.log(str.repeat(50));


// The same with arrow functions
const pickNamesInUpperCaseOfLength_Arrow = function(names, length) {
    return names.filter( (name) => name.length === length)
        .map( (name) => name.toUpperCase() )
        .join(', ');
           
};
const hits_Arrow = pickNamesInUpperCaseOfLength_Arrow(words, 5);
console.log(hits_Arrow);