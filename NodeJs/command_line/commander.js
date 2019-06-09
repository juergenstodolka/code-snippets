'use strict';

var fs = require('fs');
var program = require('commander');
const chalk = require('chalk');

program.version('o.o.1')
  .option('-c, --character', 'Count characters')
  .option('-w, --word', 'Count words')
  .option('-l, --line', 'Count lines')
  .parse(process.argv)

const input = process.argv.pop();
console.log('Read file', input)

fs.readFile(input, 'utf8', (err, content) => {
    if (err) {
        console.log ('FILE read error')
        process.stderr.write(err);
        return false;
    }
    
    var all = process.argv.length === 2;
    
    if (all || program.character) {
        const chars = content.length
        console.log(chalk.yellow(`Characters ${chars}`))
    }

    if (all || program.word) {
        const words = content.split(/[\t \n]/).filter(e => e !== '').length;
        console.log(chalk.red(`Words ${words}`));
    }

    if (all || program.line) {
        const lines = content.split('\n').length;
        console.log(chalk.blue(`Lines ${lines}`))
    }        
});
