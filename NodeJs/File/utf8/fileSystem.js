'use strict';

const fs = require('fs');
const util = require('util');

console.log("-".repeat(80));

// Read aruments fom file
const content = fs.readFileSync("fileSystem.args", 'utf8');
const lines = content.split(/\s+/);
console.log("lines:", lines);

// Parse arguments
const argv = require('yargs')
    .usage('Usage: $0 <command> [options]')
    .command("create", "Create a new empty file")
    .example("$0 create -f foo_copy.js", "Create a new empty file")
    .command("copy", "Make a file copy")
    .example("$0 copy -f foo.js -o foo_copy.js", "Copy a file")
    .command("rename", "Changes the name of a file")
    .alias('rename', 'rename')  // alias --file for the -f option    
    .example("$0 rename -f foo.js -o GrüßGott.js", "Changes the name of the inputfile (option -f) to new name (option -o)")
    .alias('i', 'infile')  // alias --file for the -f option
    .nargs('i', 1)       // set the requirement of one argument for that option, otherwise displayy --help
    .describe('i', 'Input file')  // add descritption for the option
    .demandOption(['i']) // we are demanding option -f   
    .alias('o', 'output')  // alias --output for the -o option
    .nargs('o', 1)       // set the requirement of one argument for that option, otherwise displayy --help
    .describe('o', 'Output file')  // add descritption for the option -o
    .help('h')
    .alias('h', 'help')
    .parse(lines);


console.log(argv);
console.log("-".repeat(80));

if (argv.rename) {
    if (argv.infile && argv.output) {
        console.log(`Rename file ${argv.infile} to to ${argv.output}`);
        fs.renameSync(argv.infile, argv.output, (err) => {
            if (err) {
                console.log('Cannot rename file', err);
            }
        });
        console.log("Renamed");
        process.exitCode = 1;
    }
}
else if (argv.copy) {

    if (argv.infile && argv.output) {
        console.log(`Copy file ${argv.infile} to ${argv.output}`);
        fs.copyFile(argv.infile, argv.output, err => {
            if (err) {
                console.error(err);
                process.exit(1);
            }
            console.log("Copied");
            process.exitCode = 1
        });
    }
}
else if (argv.create && argv.infile) {

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
    console.log(`Unknown command!`);
    process.exitCode = 1;
}

// const filename = 'message.txt'
// const newFilename = 'ÂÎ.txt';
// const chineseFile = '"对象清单对象清单"';