'use strict';

const _ = require('lodash');

/*
  Partial
  As with currying, we can use arrow functions to make partial application easy and explicit:
*/

var greet = function(greeting, name) {
    return greeting + ' ' + name;
  };
  
  var sayHelloTo = _.partial(greet, 'hello');
 console.log( sayHelloTo('fred') );
  // "hello fred"

  // becomes

const sayHelloTo_es6 = name => greet('hello', name);
console.log(sayHelloTo_es6('fred'));
// "hello fred"

// It’s also possible to use rest parameters with the spread operator to partially apply variadic functions:
const sayHelloTo_spread = (name, ...args) => greet('hello', name, ...args);
console.log( sayHelloTo_spread('fred', 1, 2, 3)  );