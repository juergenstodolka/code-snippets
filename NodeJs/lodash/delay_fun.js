'use strict';

const _ = require("lodash");

// The _.delay() function delays the execution of a function for the specified amount of milliseconds.
// The example outputs two messages. The first one is delayed for 150ms.
function message(){
    console.log("Some message");
}

_.delay(message, 150);
console.log("Some other message");