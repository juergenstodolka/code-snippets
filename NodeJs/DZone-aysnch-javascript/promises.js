/*
Promises

Promises are a much more improvised approach of handling and structuring
asynchronous code in comparison to doing the same with callbacks.
To prove this we are going to compare and contrast promises with callbacks
within the same code snippet.
To simulate the delay, instead of calling a third-party API, we would be using
the setTimeout() method just to make things a little simpler.

The Promise receives two callbacks in constructor function: resolve and reject.
These callbacks inside promises provide us with fine-grained control over error
handling and success cases.
The resolve callback is used when the execution of promise performed successfully
and the reject callback is used to handle the error cases.

When calling the promise, we have the method defined over the promise object
which can be used to receive the data from promises accordingly.

Consider the following code snippet:
*/

// Example of Callback  
const getDataCallback = (callback) => {

  setTimeout(() => {
    const temp = Math.floor(Math.random() * 10 + 1);//Generates a random value [1, 10]
    (temp <= 5)
      ? callback(undefined, 'This is the Callback data')
      : callback('This is the Callback error', undefined);
  }, 10);
};

getDataCallback((error, data) => {
  if (error) {
    console.log(error);
  }
  else {
    console.log(data);
  }

});

// Example of Promise  

const myPromise = new Promise((resolve, reject) => {

  setTimeout(() => {
    const temp = Math.floor(Math.random() * 10 + 1);//Generates a random value [1, 10]  
    (temp <= 5)
      ? resolve('This is the Promise data')
      : reject('This is the Promise error');
  }, 10);

});

myPromise.then((data) => {
  console.log(data);
}, (error) => {
  console.log(error);
});

// Example of a function returning a Promise  
const getDataFromPromise = (data) => {
  return new Promise((resolve, reject) => {

    setTimeout(() => {
      (data <= 5)
        ? resolve('This is the function returning Promise data')
        : reject('This is the function returning Promise error');
    }, 1000);
  });
};

getDataFromPromise(3).then((data) => {
  console.log(data);
}, (error) => {
  console.log(error);
});

// Example of a function returning a Promise using Short-Hand syntax  
const getDataFromPromiseUsingShortHandSyntax = (data) =>
  new Promise((resolve, reject) => {

    setTimeout(() => {
      (data <= 5)
        ? resolve('This is the Promise data using Short-Hand syntax')
        : reject('This is the Promise error using Short-Hand syntax');
    }, 1000);
  });

const myPromiseTwo = getDataFromPromiseUsingShortHandSyntax(30);
myPromiseTwo.then((data) => {
  console.log(data);
}, (error) => {
  console.log(error);
});
