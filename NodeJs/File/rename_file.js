'use strict';

const fs = require('fs');

const newFilename = 'ÂÎ.txt';
const chineseFile = '对象清单对象清单';

console.log(newFilename);

fs.renameSync('test.txt', 'abc.txt', (err) => {
    if (err) {
        console.log('Cannot rename file', err);
    }
});

fs.renameSync('abc.txt', newFilename, (err) => {
    if (err) {
        console.log('Cannot rename file', err);
    }
});

fs.renameSync(newFilename, chineseFile, (err) => {
    if (err) {
        console.log('Cannot rename file', err);
    }
});