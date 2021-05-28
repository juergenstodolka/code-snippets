'use strict';

const fs = require('fs');
const util = require('util');

const cli = require('./lib/readCommandLine.js');

console.log(process.argv);
console.log("-".repeat(80));

let argv = cli.readCommandLineParameters(process.argv);

console.log("-".repeat(80));
console.log(argv);
console.log("-".repeat(80));


if (argv._[0] == 'argFile') {

    console.log(`Read arguments from file [${argv.infile}]`);
    const content = fs.readFileSync(argv.infile, 'utf8');
    const lines = content.split(/\s+/);
    console.log("Content argument file:", lines);
    argv = cli.readCommandLineParameters(process.argv, lines);

    console.log("-".repeat(80));
    console.log('Arguments from file:', argv);
    console.log("-".repeat(80));
}


if (argv._[0] == 'rename' || argv.rename) {
    if (argv.infile && argv.output) {
        console.log(`Rename file ${argv.infile} to to ${argv.output}`);
        fs.renameSync(argv.infile, argv.output, (err) => {
            if (err) {
                console.log('Cannot rename file', err);
                process.exitCode = 1;
            }
        });
        console.log("Renamed");
        process.exitCode = 0;
    }
}
else if (argv._[0] === 'copy' || argv.copy) {

    if (argv.infile && argv.outfile) {
        console.log(`Copy file ${argv.infile} to ${argv.outfile}`);
        fs.copyFile(argv.infile, argv.outfile, err => {
            if (err) {
                console.error(err);
                process.exitCode = 1;
            }
            console.log("Files successfully copied.");
            process.exitCode = 0;
        });
    }
    else {
        console.error('Missing files!');
        process.exitCode = 1;
    }
}
else if (argv._[0] === 'create' && argv.infile) {

    console.log(`Create new empty file ${argv.infile}`);
    //const data = new Uint8Array(Buffer.from('Hello Node.js'));
    const data = new Uint8Array(Buffer.from(''));
    fs.writeFileSync(argv.infile, data, (err) => {
        if (err) {
            console.error(err);
            process.exitCode = 1;
        }
        console.log('The file has been saved!');
    });
    process.exitCode = 0;
}
else {
    console.log(`Unknown command: ${argv._}`);
    process.exitCode = 1;
}

// const filename = 'message.txt'
// const newFilename = 'ÂÎ.txt';
// const chineseFile = '"对象清单对象清单"';