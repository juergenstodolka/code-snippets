'use strict';

const fs = require('fs');
const util = require('util');

/*
  The next step is to run our 2 methods to read the headers of the CSV files:

  The method read1 uses fs.readFile and to read in the entire contents of each CSV and then return the first line (the header). 
  The next method read2 uses streams to read in data from the CSV file and then returns the header.

  The default setting in node.js for createReadStream is to read the file in 16KB chunks at a time. 
  As soon as we have read the first chunk, we get the header of that string and then 
  immediately destroy the stream so that it does not read any more chunks.
  This allows us to have fast performance no matter how big the file size is.


*/

const readFile = util.promisify(fs.readFile);
const readdir = util.promisify(fs.readdir);

async function read1 (file) {
    const label = `read1-${file}`;
    console.time(label);
    const data = await readFile(file, 'utf8');
    const header = data.split(/\n/)[0];
    console.timeEnd(label);
}

async function read2 (file) {
    return new Promise(resolve => {
        let header;
        const label = `read2-${file}`;
        console.time(label);
        const stream = fs.createReadStream(file, { encoding: 'utf8' });
        stream.on('data', data => {
            header = data.split(/\n/)[0];
            stream.destroy();
        });
        stream.on('close', () => {
            console.timeEnd(label);
            resolve();
        });
    });
}

async function startTests (files) {
    for (let file of files) {
        console.log(file);
        await read1(file);
        await read2(file);
    }
}

readdir(__dirname).then(files => {
    startTests(files.filter(file => /dummy\d+\.csv/.test(file)));
});