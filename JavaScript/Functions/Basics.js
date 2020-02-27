'use strict';

// Define a function like in other languages
function add (x, y) {
  return x + y;
}

console.log('Result:', add(3, 4));

// Declare and execute a function in one step
(
  function add (x, y) {
    let sum = x + y;
    console.log('add result is:', sum);
  }
)(4, 6);

// Store function in a variable
function addWithLog (x, y) {
  console.log("ADD:" + (x + y))
};

const sum = function (x, y) {
  console.log("SUM:" + (x + y))
};

addWithLog(3, 4); sum(3, 4);

// Passing functions as Parameters to Another Function
const A = function () {
  console.log("I am A");
};

const B = function (a) {  // ‘a’ is function declaration passed to ‘B'
  if (!(a instanceof Function)) {
    throw new Error('Parameter must be a function.');
  }
  console.log("I am B");
  a(); // note we are actually executing the function ‘a' here
};

// Now let’s call function B here which takes declaration of function A as the parameter
B(A);

// // Now let’s call function B here which takes a string as the parameter
try {
  B("Hello");
} catch (error) {
  console.error(error.message);
}

/**************************************************
  Passing a function as callback
  setTimeout has 2 parameters,

  1. a function to doSomething
  2. timeout value in milliseconds

************************************************* */

// This will write to console after 1 second
setTimeout(function () {

  console.log("Timed out from setTimeout");

}, 1000);

setTimeout(() => {

  console.log("Timed out from anon function setTimeout");

}, 1000);

const doSomething = function () {

  console.log("Timed out from function write");

};

// This also writes to console after 1 second
// Function write is passed to setTimeout function 

setTimeout(doSomething, 1000);

/*
  Summary

  A function is just a declaration until it is explicitly evaluated. The declaration can be assigned to a variable,
  which can then be passed as a parameter to another function.

  Thus, a JavaScript Function is a JavaScript Variable until it is executed (evaluated).
*/

// A simple Logging Utillity
const writeLog = function (txt, format) {

  console.log(format(txt));
  return;
};

const formatErr = function (text) {
  return "[E]" + new Date() + ":" + text;
};

const formatWarn = function (text) {
  return "[W]" + new Date() + ":" + text;
};

const errorOccured = 0;
if (errorOccured) {
  const errText = "Error occurred. Terminating.";
  writeLog(errText, formatErr);
} else {
  const warnText = "Warning occurred. Continuing.";
  writeLog(warnText, formatWarn);
}