'use strict';
const _ = require('lodash');

/*
  Paths
  Many of Lodash’s functions take paths as strings or arrays. 
  We can use arrow functions to create more reusable paths instead:
*/

var object = { 'a': [{ 'b': { 'c': 3 } }, 4] };

_.at(object, ['a[0].b.c', 'a[1]']);
// [3, 4]
_.at(['a', 'b', 'c'], 0, 2);
// ['a', 'c']

// becomes

[
  obj => obj.a[0].b.c,
  obj => obj.a[1]
].map(path => path(object));

[
    arr => arr[0],
    arr => arr[2]
  ].map(path => path(['a', 'b', 'c']));

 // Because these paths are “just functions”, we can compose them too:
const getFirstPerson = people => people[0];
const getPostCode = person => person.address.postcode;
const getFirstPostCode = people => getPostCode(getFirstPerson(people));

// We can even make higher-order paths that accept parameters:
const getFirstNPeople = n => people => people.slice(0, n);

const getFirst5People = getFirstNPeople(5);
const getFirst5PostCodes = people => getFirst5People(people).map(getPostCode);

