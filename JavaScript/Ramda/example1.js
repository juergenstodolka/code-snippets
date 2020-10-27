"use strict";

const R = require("ramda");

const addOne = R.map((num) => num + 1);
const multByThree = R.map((num) => num * 3);
const removeNumsOver100 = R.filter((num) => num <= 100);

const logAndReturn = function (data) {
  console.log(data);
  return data;
};

const sumAllNumbers = R.reduce((sum, num) => sum + num)(0);

// Compose functions with pipe function.
const processnumbers = R.pipe(addOne, multByThree, removeNumsOver100, logAndReturn, sumAllNumbers, console.log);

processnumbers([5, 8, 20, 40]);
