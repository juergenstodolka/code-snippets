'use strict';

/*
   The following function takes a function as its argument and returns a new function.
   You can call the resulting function as many times as you want,
   but the original function will only be called once:
*/
function once (fn) {
  var returnValue, called = false;
  return function () {
    if (!called) {
      called = true;
      returnValue = fn.apply(this, arguments);
    }
    return returnValue;
  };
}

module.exports = once;
