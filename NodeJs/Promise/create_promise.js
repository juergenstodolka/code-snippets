'use strict';

const computeSqrAsync = function (number) {

  if (number < 0) {
    return Promise.reject('No negative number, please.');
  }

  if (number === 0) {
    return Promise.resolve(0);
  }

  return new Promise((resolve, reject) => {
    setTimeout(() => resolve(Math.sqrt(number)), 1000);
  });
};

const reportOnPromise = function (promise) {
  promise
    .then(result => console.log(`result is ${result}`))
    .catch(error => console.log(`ERROR: ${error}`));
};

// Since the calls are asynchrous, there is no quarantee of order in the printed messages.
const forNegative1 = computeSqrAsync(-1);
const forZero = computeSqrAsync(0);
const forSixteen = computeSqrAsync(16);

reportOnPromise(forNegative1);
reportOnPromise(forZero);
reportOnPromise(forSixteen);