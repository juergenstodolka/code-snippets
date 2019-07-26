'use strict';

const sleep_1 = () => { return new Promise(resolve => { return setTimeout(resolve, 1000 * 1) }) };
const sleep_2 = () => { return new Promise(resolve => { return setTimeout(resolve, 1000 * 2) }) };
const sleep_3 = () => { return new Promise(resolve => { return setTimeout(resolve, 1000 * 3) }) };

// Minimalistic
(async (failureCallback) => {
    try {
        await sleep_1();
        console.log('After 1 second');
        await sleep_2();
        console.log('After 2 seconds');
        await sleep_3();
        console.log('After 3 seconds');
        await sleep_1();
        console.log('After 1 second');
    }
    catch (error) {
        failureCallback(error);
    }
})(error => { console.log('FAILURE:', error) });

// More readable
//foo(error => { console.log('FAILURE:', error) });