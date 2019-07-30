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

const getRandomWithAsync = async () => {
    try {
        return await getRandomWithPromise();
    } catch (error) {
        return error;
    }
};

getRandomWithAsync().then((number) => {
    console.log(number);
});

(async function () {
    // Wait for the first promise to be fulfilled. 
    var a = await getRandomWithPromise();

    // Wait for the second promise to be fulfilled. 
    var b = await getRandomWithPromise();
    console.log(`Your random numbers are ${a} and ${b}!`);
}
)();

// Promises run parallel
(async function () {
    // Request the random numbers and save the promises. 
    var aPromise = getRandomWithPromise();
    var bPromise = getRandomWithPromise();
    var a = await aPromise;
    var b = await bPromise;
    console.log(`Your random numbers are ${a} and ${b}!`);
}
)();