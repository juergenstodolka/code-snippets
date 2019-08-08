'use strict';

const axios = require('axios');

function sleep (amount) {
    return new Promise((resolve, reject) => {
        if (amount < 300) {
            reject('That is too fast, cool it down!');
        }
        setTimeout(() => resolve(`Slept for ${amount}`), amount);
    });
}

// Simple call the promise
sleep(500).then((result) => {
    console.log(result);
});

// Define an async function
async function go () {
    // just wait
    await sleep(1000);

    // or capture the returned value
    const response = await sleep(750);
    console.log(response);
}

go();

// make fast search, waiting until both request come back
const getDetails = async function () {
    // Fire both off
    const wesPromise = axios.get('https://api.github.com/users/wesbos');
    const juergenPromise = axios.get('https://api.github.com/users/juergenstodolka');

    // and wait to both to come back
    try {
        const [wes, juergen] = await Promise.all([wesPromise, juergenPromise]);
        console.log(wes);
        console.log(juergen);
    } catch (error) {
        console.log('Download error:', error);
    }
}

//getDetails();

// Create a function without any error handling
async function yolo () {
    // Do something that errors out. 
    const wes = await axios.get('https://no.com');
}

// make a High Order Function (HOF) to handle that error
function handleError (fn) {
    return function (...params) {
        return fn(...params).catch(function (err) {
            // do somethign with the error"
            console.error(`Oops!`, err);
        });
    }
}

// Now wrap function call in a HOF
//const safeYolo = handleError(yolo);
//safeYolo();