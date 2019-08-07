'use strict';

const stream = require('stream');
const fs = require('fs');
const util = require('util');

// Copy a file using streams
const pipeline = util.promisify(stream.pipeline);

(async () => {
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
})();