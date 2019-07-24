'use strict';

/*
  Assume that you have an archive and want to decompress it.
  There are a number of ways to achieve this.
  But the easiest and cleanest way is to use piping and chaining. Have a look at the following snippet:

  First, we create a simple readable stream from the file Streams.tar.gz.
  Next, we pipe this stream into another stream zlib.createGunzip() to un-gzip the content.
  Lastly, as streams can be chained, we add a writable stream in order to write the un-gzipped content to the file.
*/

const fs = require('fs');
const zlib = require('zlib');

fs.createReadStream('Streams.tar.gz')
 .pipe(zlib.createGunzip())
 .pipe(fs.createWriteStream('output.txt'));