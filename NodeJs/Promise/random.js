'use strict';

var getRandomWithPromise = error => {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            if (error) {
                reject("some error");
                return;
            }
            resolve(Math.floor(Math.random() * 100));
        }, 200);
    });
};

getRandomWithPromise().then(result => {
    console.log(`Your random number is ${result}!`);
}).catch(error => {
    console.log(`Ups! Something went wrong! Details: ${error}`);
});
