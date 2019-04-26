var fs = require('fs');

var contents = fs.readFileSync('DATA.txt', 'utf8');
console.log(contents);