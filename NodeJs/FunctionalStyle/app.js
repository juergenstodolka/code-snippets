
'use strict';
const { curry, pipe, compose } = require('./atjs');

const doubleNum = function (num) {
    return num + num;
};

const totalIt = function (n1, n2, n3, n4) {
    return n1 + n2 + n3 + n4;
};

const doArray = function (num1, num2) {
    return [num1, num2];
};

const curriedTotalIt = curry(totalIt);
const curriedDoArray = curry(doArray);

const result = curriedTotalIt(4)(3)(2)(1);
console.log("Result of curried function 'totalIt'", result);

/*
  What happens:
  - Execute functions doubleNum, curriedTotalIt and curriedDoArray one after another.
  - Function pipe returns a function that is assigned to newFunction.
  - When calling newFunction with one parameter, this value will be passed to doubleNum().
    The result value is passed to the curried function curriedTotalIt() that returns a curried function.
    Then we pass number 3 to this function. The result is a curried function again, and so on
    until to the last parameter. After it the totalIt is executed with 4 parameters.
  - This result is passed as second parameter to the curried function curriedDoArray() that
    returns an array with two values.
*/
const newFunction = pipe(
    doubleNum,
    curriedTotalIt(3)(2)(1),
    curriedDoArray(50)
);

const nf = newFunction(5);
console.log("Result of newFunction:", nf);
















