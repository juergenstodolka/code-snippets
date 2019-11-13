const fs = require('fs');

/*
  The de facto standard of reading text files in node.js is to use fs.readFile(filename, “utf8"). 
  It’s quick and simple to write code using this function — we just tell node.js to open a text file
  for us and in the callback we get a great big string of text, upon which we can use all kinds
 of javascript string wizardry.

 For quick prototypes, or if we’re just dealing with small text files, this approach is completely fine.
 However, if there is a chance that other people might use our code, or that it may at some point be run 
 on text files of varying sizes, we may as well optimize our code and consider using streams instead.

 Streams allow us to keep data held in memory to a minimum, thus making reading a file that much quicker. 
 They also allow us to pick and choose which parts of the file we want to process and leave the rest of the data unopened.

 I was interested in the trade off between the ease-of-use of fs.readFile and the faster run-time of streams.
 At what file size does it make sense to refactor use of readFile and instead use streams?

 I devised a simple test:
  create dummy data CSVs of various sizes and compare the time taken to extract
  the headers of these CSVs by 2 methods, one fs.readFile and one stream-based.

 The first step is to use node.js to create some CSVs of various lengths:

 Running node makedata.js will create 4 files with varying numbers of rows.
*/

const cols = 8;

function randomChar () {
    return String.fromCharCode(Math.floor(Math.random() * (122 - 65) + 65));
}

function randomString (length) {
    let string = '';
    for (let i = 0; i < length; i++) {
        string += randomChar();
    }
    return string;
}

function randomRow () {
    const cells = [];
    for (let i = 0; i < cols; i++) {
        cells.push(randomString(20));
    }
    return cells.join(',') + '\n';
}

async function writeRow (stream) {
    return new Promise((resolve, reject) => {
        stream.write(randomRow(), 'utf8', () => resolve());
    });
}

async function createCSVs (sizes) {
    sizes.forEach(async size => {
        const stream = fs.createWriteStream(`dummy${size}.csv`);
        for (let i = 0; i < size; i++) {
            await writeRow(stream);
        }
        stream.end();
    });
}

createCSVs([1000, 10000, 100000, 1000000]);