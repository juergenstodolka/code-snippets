'use strict';

const stram = require('stream');
const fs = require('fs');
const util = require('util');

// Copy a file using streams
const pipeline = util.promisify(stram.pipeline);

async function fileCopy() {
    try {
        await pipeline(
            fs.createReadStream('file.txt'),
            fs.createWriteStream('write_stream_output.txt')
        );
        console.log('Pipeline succeeded');
    }
    catch (err) {
        console.log('Pipline failed', err);
    }
}

fileCopy();
