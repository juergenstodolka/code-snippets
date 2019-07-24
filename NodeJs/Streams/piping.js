'use strict';

/*
  Piping
  Piping is a great mechanism in which you can read data from the source and write to destination
  without managing the flow yourself. Take a look at the following snippet:
*/

const fs = require('fs');

const readableStream = fs.createReadStream('file.txt');
const writableStream = fs.createWriteStream('file2.txt');

readableStream.pipe(writableStream);

/*
 The above snippet makes use of the pipe() function to write the content of file1 to file2.
 As pipe() manages the data flow for you, you should not worry about slow or fast data flow.
 This makes pipe() a neat tool to read and write data.
 You should also note that pipe() returns the destination stream.
 So, you can easily utilize this to chain multiple streams together. Let’s see how!
*/