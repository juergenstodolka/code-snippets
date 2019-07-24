'use strict';

/*
  There is also another way to read from stream. You just need to call read() on the stream instance repeatedly
  until every chunk of data has been read.
  The read() function reads some data from the internal buffer and returns it. When there is nothing to read, it returns null.
  So, in the while loop we check for null and terminate the loop.
  Note that the readable event is emitted when a chunk of data can be read from the stream.
*/

const fs = require('fs');

const readableStream = fs.createReadStream('file.txt');
let data = '';
let chunk;

readableStream.setEncoding('utf8');

readableStream.on('readable', function () {
 while ((chunk = readableStream.read()) != null) {
  data += chunk;
 }
});

console.log('-'.repeat(70));

readableStream.on('end', function () {
 console.log(data)
});

