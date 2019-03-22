/*
Now, we're implementing the same logic with the await keyword so that we can
compare and contrast the two methods.
Actually, the await keyword makes JavaScript wait until that promise settles
and returns its result.
So, it looks like the code is synchronous but it is indeed asynchronous.

So with async and await operator, we can structure our code that uses promises
to look more like regular old synchronous code. 
We can perform one operation after the other. This code is never going to run
until the previous promise either resolves or rejects the return statement.

Consider the following code snippet:
*/

const getDataPromise = (num) => new Promise((resolve, reject) => {

  setTimeout(() => {
    (typeof num === 'number') ? resolve(num * 2) : reject('Input must be an number');
  }, 2000);
});

// This is the good way, so resolve function is called
const processDataAsycn = async () => {

  let data = await getDataPromise(2);
  data = await getDataPromise(data);
  return data;
};

processDataAsycn().then((data) => {
  console.log('Data from processDataAsycn() with async( When promise gets resolved ): ' + data);
}).catch((error) => {
  console.log('Error from processDataAsycn() with async( When promise gets rejected ): ' + error);
});



// This is the errounous way, so the promes is rejected and an exception is thrown.
// The catch function is called.
const processDataAsycnWithError = async () => {

  let data = await getDataPromise('2');
  data = await getDataPromise(data);
  return data;
};

processDataAsycnWithError().then((data) => {
  console.log('Data from processDataAsycn() with async( When promise gets resolved ): ' + data);
}).catch((error) => {
  console.log('Error from processDataAsycn() with async( When promise gets rejected ): ' + error);
});