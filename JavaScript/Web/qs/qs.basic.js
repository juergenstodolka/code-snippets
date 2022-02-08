'use strict';

var qs = require('qs');
var assert = require('assert');

/*************************************************
 Parsing Objects
 qs.parse(string, [options]);

 ************************************************/

var obj = qs.parse('a=c');
assert.deepEqual(obj, { a: 'c' });

var str = qs.stringify(obj);
assert.equal(str, 'a=c');

/*
  qs allows you to create nested objects within your query strings, 
  by surrounding the name of sub-keys with square brackets []. For example, the string 'foo[bar]=baz' converts to:
*/
assert.deepEqual(qs.parse('foo[bar]=baz'), {
  foo: {
    bar: 'baz',
  },
});

// URI encoded strings work too:
assert.deepEqual(qs.parse('a%5Bb%5D=c'), {
  a: { b: 'c' },
});

// You can also nest your objects, like 'foo[bar][baz]=foobarbaz':
assert.deepEqual(qs.parse('foo[bar][baz]=foobarbaz'), {
  foo: {
    bar: {
      baz: 'foobarbaz',
    },
  },
});

// By default, when nesting objects qs will only parse up to 5 children deep.
// This means if you attempt to parse a string like 'a[b][c][d][e][f][g][h][i]=j' your resulting object will be:
var expected = {
  a: {
    b: {
      c: {
        d: {
          e: {
            f: {
              '[g][h][i]': 'j',
            },
          },
        },
      },
    },
  },
};
var string = 'a[b][c][d][e][f][g][h][i]=j';
assert.deepEqual(qs.parse(string), expected);

// URL params
// To bypass the leading question mark, use ignoreQueryPrefix:
var prefixed = qs.parse('?a=b&c=d', { ignoreQueryPrefix: true });
assert.deepEqual(prefixed, { a: 'b', c: 'd' });

// An optional delimiter can also be passed:
var delimited = qs.parse('a=b;c=d', { delimiter: ';' });
assert.deepEqual(delimited, { a: 'b', c: 'd' });

// Delimiters can be a regular expression too:
var regexed = qs.parse('a=b;c=d,e=f', { delimiter: /[;,]/ });
assert.deepEqual(regexed, { a: 'b', c: 'd', e: 'f' });

// Option allowDots can be used to enable dot notation:
var withDots = qs.parse('a.b=c', { allowDots: true });
assert.deepEqual(withDots, { a: { b: 'c' } });

// If you have to deal with legacy browsers or services, there's also support for decoding percent-encoded octets as iso-8859-1:
var oldCharset = qs.parse('a=%A7', { charset: 'iso-8859-1' });
assert.deepEqual(oldCharset, { a: '§' });

/*
Important: When you specify both the charset option and the charsetSentinel option, the charset will be overridden 
when the request contains a utf8 parameter from which the actual charset can be deduced.
In that sense the charset will behave as the default charset rather than the authoritative charset.
*/
var detectedAsUtf8 = qs.parse('utf8=%E2%9C%93&a=%C3%B8', {
  charset: 'iso-8859-1',
  charsetSentinel: true,
});
assert.deepEqual(detectedAsUtf8, { a: 'ø' });

// Browsers encode the checkmark as &#10003; when submitting as iso-8859-1:
var detectedAsIso8859_1 = qs.parse('utf8=%26%2310003%3B&a=%F8', {
  charset: 'utf-8',
  charsetSentinel: true,
});
assert.deepEqual(detectedAsIso8859_1, { a: 'ø' });

/*************************************
  Parsing Arrays
**************************************/
// qs can also parse arrays using a similar [] notation:
var withArray = qs.parse('a[]=b&a[]=c');
assert.deepEqual(withArray, { a: ['b', 'c'] });

// You may specify an index as well:
var withIndexes = qs.parse('a[1]=c&a[0]=b');
assert.deepEqual(withIndexes, { a: ['b', 'c'] });

var noSparse = qs.parse('a[1]=b&a[15]=c');
assert.deepEqual(noSparse, { a: ['b', 'c'] });

var sparseArray = qs.parse('a[1]=2&a[3]=5', { allowSparse: true });
assert.deepEqual(sparseArray, { a: [, '2', , '5'] });

// Note that an empty string is also a value, and will be preserved:
var withEmptyString = qs.parse('a[]=&a[]=b');
assert.deepEqual(withEmptyString, { a: ['', 'b'] });

var withIndexedEmptyString = qs.parse('a[0]=b&a[1]=&a[2]=c');
assert.deepEqual(withIndexedEmptyString, { a: ['b', '', 'c'] });

// If you mix notations, qs will merge the two items into an object:
var mixedNotation = qs.parse('a[0]=b&a[b]=c');
assert.deepEqual(mixedNotation, { a: { 0: 'b', b: 'c' } });

// You can also create arrays of objects:
var arraysOfObjects = qs.parse('a[][b]=c');
assert.deepEqual(arraysOfObjects, { a: [{ b: 'c' }] });

var arraysOfObjects = qs.parse('a[][b]=c&a[][x]=y');
assert.deepEqual(arraysOfObjects, { a: [{ b: 'c', x: 'y' }] });

// Some people use comma to join array, qs can parse it:
var arraysOfObjects = qs.parse('a=b,c', { comma: true });
assert.deepEqual(arraysOfObjects, { a: ['b', 'c'] });

// Parsing primitive/scalar values (numbers, booleans, null, etc)
// By default, all values are parsed as strings
var primitiveValues = qs.parse('a=15&b=true&c=null');
assert.deepEqual(primitiveValues, { a: '15', b: 'true', c: 'null' });

/************************************************
  Stringify
  
  qs.stringify(object, [options]);
 ***********************************************/

// When stringifying, qs by default URI encodes output. Objects are stringified as you would expect:
assert.equal(qs.stringify({ a: 'b' }), 'a=b');
assert.equal(qs.stringify({ a: { b: 'c' } }), 'a%5Bb%5D=c');

// This encoding can be disabled by setting the encode option to false:
var unencoded = qs.stringify({ a: { b: 'c' } }, { encode: false });
assert.equal(unencoded, 'a[b]=c');

// Encoding can be disabled for keys by setting the encodeValuesOnly option to true:
var encodedValues = qs.stringify({ a: 'b', c: ['d', 'e=f'], f: [['g'], ['h']] }, { encodeValuesOnly: true });
assert.equal(encodedValues, 'a=b&c[0]=d&c[1]=e%3Df&f[0][0]=g&f[1][0]=h');

// When arrays are stringified, by default they are given explicit indices:
// You may override this by setting the indices option to false:
var arraysStringified = qs.stringify({ a: ['b', 'c', 'd'] }, { indices: false });
assert.equal(arraysStringified, 'a=b&a=c&a=d');

// The query string may optionally be prepended with a question mark:
assert.equal(qs.stringify({ a: 'b', c: 'd' }, { addQueryPrefix: true }), '?a=b&c=d');

// If you only want to override the serialization of Date objects, you can provide a serializeDate option:
var date = new Date(7);
assert.equal(qs.stringify({ a: date }), 'a=1970-01-01T00:00:00.007Z'.replace(/:/g, '%3A'));
assert.equal(
  qs.stringify(
    { a: date },
    {
      serializeDate: function (d) {
        return d.getTime();
      },
    }
  ),
  'a=7'
);

// You may use the sort option to affect the order of parameter keys:
function alphabeticalSort(a, b) {
  return a.localeCompare(b);
}
assert.equal(qs.stringify({ a: 'c', z: 'y', b: 'f' }, { sort: alphabeticalSort }), 'a=c&b=f&z=y');
