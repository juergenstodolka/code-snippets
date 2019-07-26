'use strict';

/*
    Timing
    To avoid surprises, functions passed to then() will never be called synchronously, even with an already-resolved promise:
*/
Promise.resolve().then(() => console.log(2));
console.log(1);
