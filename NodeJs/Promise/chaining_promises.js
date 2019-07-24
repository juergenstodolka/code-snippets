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
    console.log(result);
    return result + 2;
}).then((result) => {
    console.log(result);
    return result + 2;
}).catch((e) => {
    console.log('error: ', e)
});

/*
    Above, our initial promise is going to resolve in 2000 milliseconds with a value of 1.
    After resolving, the then() handler is called and the value of 1 is alerted to the screen.
    Finally, the value is added to 2, and our new value of 3 is returned.
    This value is passed on to the next then() handler, and the process repeats.
*/