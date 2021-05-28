'use strict';

const readCommandLineParameters = function (argv, lines = null) {

    if (lines) {
        argv = require('yargs').parse(lines);
        console.log('readCommandLineParameters argv:', argv);
    }
    else {
        lines = argv;
    }

    return require('yargs')
        .usage('Usage: $0 <command> [-i \"inputfile"\] [-o \"outputfile"\]')
        .command({
            command: 'copy',
            describe: 'Copy input file to output file',
        })
        .command({
            command: 'argFile',
            describe: 'Read command line parameters from file (first line)',
        })
        .option('infile', {
            alias: 'i',
            description: 'input file (path)',
            type: 'string',
            nargs: 1,
            demandOption: true,
            demand: 'file is required'
        })
        .option('outfile', {
            alias: 'o',
            description: 'output file (path)',
            type: 'string'
        })
        .example("$0 copy -i foo.js -o fooCopy.js", "Copy a file")
        .example("$0 rename -i dummy.ps -o Worker.ps", "Rename a file")
        .example("$0 create -i Job.rdy", "Create an empty file.")
        .example("$0 argFile myargs.txt", "Read arguments from file")
        .alias('h', 'help')
        .showHelpOnFail(false, "Specify --help for available options")
        .wrap(100)
        //.parse(lines);
        .argv;
}


module.exports = {
    readCommandLineParameters
}