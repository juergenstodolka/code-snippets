'use strict';

const fs = require('fs');

// Copy a file using streams
// Returns: a promise
const copyStream = () => {

    return new Promise((resolve, reject) => {

        const readableStream = fs.createReadStream('file.txt');
        const writableStream = fs.createWriteStream('write_stream_output.txt');

        readableStream.on('error', (err) => {
            console.log(err);
            reject(new Error('Cannot read from stream' + err));
        });

        writableStream.on('error', (err) => {
            console.log(err);
            reject(new Error('Cannot write to stream' + err));
        });

        readableStream.setEncoding('utf8');

        readableStream.on('data', function (chunk) {
            writableStream.write(chunk);
        });

        // all is good!
        resolve('CopyStream: All right!');
    });

}


const fileCopy = async () => {
    try {
        let result = await copyStream();
        console.log('[I] fileCopy: ', result);
    }
    catch (error) {
        console.log('[E] filecopy: ', error);
    }
}

fileCopy();
