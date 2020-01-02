'use strict';

const _ = require('lodash/fp');

let sum = _.add(5,2);
console.log(`Sum=${sum}`);

// Auto Curry
let add5 = _.add(5);
console.log(add5(2));

// Add some functions and us them in composed functions
const addOne = _.map((num) => num + 1);
const multByThree = _.map((num) => num * 3);
const removeNumsOver100 = _.filter((num) => num <= 100);
const logAndReturn = function(data) {
 console.log(data);
 return data; 
};

const sumAllNumbers = _.reduce((sum, num) => sum + num)(0);

// Compose the functions
const processNumbers = _.pipe(
  addOne,
  multByThree,
  removeNumsOver100,
  sumAllNumbers,
  console.log
);

processNumbers([5, 8, 20, 40]);