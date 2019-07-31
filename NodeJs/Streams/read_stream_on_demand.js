'use strict';

const { Readable } = require('stream');

const inStream = new Readable({

    // Push data on demand, when a consumer asks for it.
    // We can do that by implementing the read() method.
    read (size) {
        this.push(String.fromCharCode(this.currentCharCode++));

        if (this.currentCharCode > 90) {
            // We need to stop this cycle somewhere, and that’s why an if statement to push null
            // when the currentCharCode is greater than 90 (which represents Z).
            this.push(null);
        }
    }
});

// For example, we can push one letter at a time, starting with character code 65 (which represents A), 
// and incrementing that on every push.
inStream.currentCharCode = 65;

// To consume this simple readable stream, we can simply pipe it into the writable stream process.stdout.
inStream.pipe(process.stdout);