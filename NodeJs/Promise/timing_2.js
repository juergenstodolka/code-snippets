'use strict';


/*
    Instead of running immediately, the passed-in function is put on a microtask queue, 
    which means it runs later when the queue is emptied at the end of the current run of the JavaScript event loop, i.e. pretty soon.
*/

const wait = ms => new Promise(resolve => setTimeout(resolve, ms));

wait().then(() => console.log(4));
Promise.resolve().then(() => console.log(2)).then(() => console.log(3));
console.log(1); // 1, 2, 3, 4