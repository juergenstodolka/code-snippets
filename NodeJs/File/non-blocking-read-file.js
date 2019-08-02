var fs = require('fs');
const util = require('util');

// Default way to read a file using asnyc method
fs.readFile("DATA.txt", 'utf8', (err, contents) => {
  if (err) {
    console.log('ERROR', err);
  }
  console.log(contents);
});

console.log('after calling readFile');

// Reading a file using async/await
const read = util.promisify(fs.readFile);
(async () => {
  try {
    const chunk = await read('DATA.txt', 'utf8');
    console.log('-'.repeat(80));
    console.log(chunk);
  }
  catch (error) {
    console.log('ERROR', error);
  }
})();