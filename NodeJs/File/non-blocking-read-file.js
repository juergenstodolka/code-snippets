var fs = require('fs');

fs.readFile("DATA.txt", 'utf8', (err, contents) => {
  if (err) {
    console.log('ERROR', err);
  }
  console.log(contents);
});

console.log('after calling readFile');