'use strict';

// Returns a promis that will resolve after time
function delay (time) {
    return new Promise(function (resolve) {
        return setTimeout(resolve, time)
    });
}

function logHi () {
    console.log('hi');
}

// We use the then() method to register callbacks to receive either the eventual fulfilled or rejected value.
delay(2000).then(logHi);