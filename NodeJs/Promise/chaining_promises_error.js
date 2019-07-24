'use strict';

/*
    Chaining Promises

    One of the main benefits of Promises is that they allow us to chain asynchronous operations together.
    This means we can specify subsequent operations to start only when the previous operation has succeeded.
    This is called a Promise Chain. Here’s an example:
*/

new Promise(function (resolve, reject) {
    setTimeout(() => resolve(1), 2000);

}).then((result) => {
    console.log(result);
    return result + 2;
}).then((result) => {
    throw new Error('FAILED HERE');
    console.log(result);
    return result + 2;
}).then((result) => {
    console.log(result);
    return result + 2;
}).catch((e) => {
    console.log('error: ', e)
});

/*
   Above I’ve created a simple .catch() that will take the returned error message and log it to the console.
   Lets add in error handling to the previous example now.

   Here’s what happens:

    Our Promise resolves after 2 seconds with a value of 1
    This value is passed to the first .then() and alerted to the screen. 2 is added and a new value of 3 is passed to the second .then()
    A new Error is thrown. Execution stops immediately and the Promise resolves to a rejected state.
    .catch() receives our error value and logs it to the screen. Here’s what it looks like in the console:
*/