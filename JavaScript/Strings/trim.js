'use strict';

const myString = '  Ein Text mit Whitespaces.    ';

const trimmedString = myString.replace(/^\s+|\s*$|\-s/g, '');

console.log(`Original string: [${myString}]`);
console.log(`Trimmed string: [${trimmedString}]`);