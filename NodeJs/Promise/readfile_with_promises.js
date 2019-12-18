'use strict';

// fs-extra library provides a wrapper arround the functions of the fs library
// We will use that to read the contents of a file asynchonously, 
// but this time using promises instead of callbacks.

const fs = require('fs-extra');

const countLinesWithText = function (pathToFile) {
  fs.readFile(pathToFile)
    .then(content => content.toString())
    .then(content => content.split("\n"))
    .then(lines => lines.filter(line => line.includes('THIS LINE')))
    .then(lines => lines.length)
    .then(count => checkLineExists(count))
    .then(count => console.log(`Number of lines with THIS LINE is ${count}`))
    .catch(error => console.log(`ERROR: ${pathToFile}, ${error.message}`));
};

const checkLineExists = function (count) {
  if (count === 0) {
    throw new Error('text does not exist in file');
  }
  return count;
};

countLinesWithText('readfile_with_promises.js');
countLinesWithText('random.js');
countLinesWithText('invalid');
countLinesWithText();