/*
 Now, moving to the await operator, let us suppose we have an async function,
 processData(), that calls a function, getDataPromise(), which, in turn,
 returns a promise.
 Now, we want to parse/use the returned data. Let's look at how we would solve
 the problem without the await operator.

 Consider the following code snippet:
*/

const getDataPromise = (num) => new Promise((resolve, reject) => {

  setTimeout(() => {
    (typeof num === 'number') ? resolve(num * 2) : reject('Input must be an number');
  }, 2000);

});

const processDataAsycn = async () => {

  return getDataPromise(22).then((data) => {
    return getDataPromise(data);
  });
};

processDataAsycn().then((data) => {
  console.log('Data from processDataAsycn() with async( When promise gets resolved ): ' + data);
}).catch((error) => {
  console.log('Error from processDataAsycn() with async( When promise gets rejected ): ' + error);
});


