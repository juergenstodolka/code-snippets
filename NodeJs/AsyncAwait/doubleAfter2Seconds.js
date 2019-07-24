'use strict';

// Next, we create our new Promise that we’ll be returning.
// Note that for the sake of simplicity, we’re not handling rejections/errors.
function doubleAfter2Seconds (x) {
    return new Promise(resolve => {
        setTimeout(() => {
            resolve(x * 2); // Good!
        }, 2000);
    });
}

// Now that you’ve created an async function, we can make use of the await keyword which will pause our code
// until the Promise has resolved. Here’s how easy that is:
async function addAsync (x) {
    const a = await doubleAfter2Seconds(10);
    console.log(`a=${a}`);

    const b = await doubleAfter2Seconds(20);
    console.log(`b=${b}`);

    const c = await doubleAfter2Seconds(30);
    console.log(`c=${c}`);

    return x + a + b + c;
}


addAsync(10).then((sum) => {
    console.log(sum);
});