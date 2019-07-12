'use strict';

const _ = require("lodash");

/*
  A quick introduction to two Lodash methods I found recently, _.get and _.set, 
  to help work with deeply nested objects.
*/

// Let's say I have this object and I want to get the name.
const a = {
    b: [
      {
        c: {
          name: 'Arya'
        }
      }
    ]
  };

/*
  Normally, we would be able to do a.b[0].c.name but what if one of the values 
  turned out to be null? 
  This is common when we are waiting for data from an HTTP request or another source.
  We usually solve this by constructing this big mess that checks for falsy values at each step
*/
const name = a && a.b && a.b[0] && a.b[0].c && a.b[0].c.name;
console.log(name);

// Let's clean this up using Lodash's get method.
const get_name = _.get(a, 'b[0].c.name');
console.log(get_name);

// We can also provide a default value as the third argument.
const name_valid = _.get(a, 'b[0].c.name', 'A girl has no name');
console.log(name_valid);
// => 'Arya'

var name_default = _.get(a, 'b[1].c.name', 'A girl has no name');
console.log(name_default);
// => 'A girl has no name'

// We can also generate the object using _.set.
let nameArray = {};

_.set(nameArray, 'b[0].c.name', 'Arya');
// => {b: [{c: {name: 'Arya'}}]}
console.log(_.repeat('-', 50));
console.log(nameArray);
