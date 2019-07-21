'use strict';
const _ = require('lodash');

/*
   Rest and Spread
   The rest and spread functions allow us to define and invoke functions that accept a variable number
   of arguments. ES6 introduced dedicated syntaxes for both of these operations:
*/
var say = _.rest(function(what, names) {
    var last = _.last(names);
    var initial = _.initial(names);
    var finalSeparator = (_.size(names) > 1 ? ', & ' : '');
    return what + ' ' + initial.join(', ') +
      finalSeparator + _.last(names);
  });
  
  const greeting = say('hello', 'fred', 'barney', 'pebbles');
  // "hello fred, barney, & pebbles"
  console.log(greeting);

  // becomes

const say_es6 = (what, ...names) => {
    const [last, ...initial] = names.reverse();
    const finalSeparator = (names.length > 1 ? ', &' : '');
    return `${what} ${initial.reverse().join(', ')} ${finalSeparator} ${last}`;
  };
  
  const greeting_es6 = say_es6('hello', 'fred', 'barney', 'pebbles');
  // "hello fred, barney, & pebbles"
  console.log(greeting_es6);
