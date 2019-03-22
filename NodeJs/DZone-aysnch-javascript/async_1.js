/*
 We have the async function and the await operator.
 When we use them together we get a new way to structure and work with
 Promises that makes our code a whole lot easier to work with.
 So, what do async and await do?

 As you can see, adding the async keyword to a function makes it work
 a bit differently.
 It starts returning a promise.
 The promise we get back from an async function gets resolved with
 whatever value we return from that function.
 As with any function returning promises, we can handle the response (i.e. promise)
 from an async function using handlers like catch and then.
*/
const processDataAsycn = async (num) => {

  if (typeof num === 'number') {
    return 2 * num;
  }
  else {
    throw new Error('Something went wrong');
  }
};

processDataAsycn(21).then((data) => {
  console.log('Data from processDataAsycn() with async( When promise gets resolved ): ' + data);
}).catch((error) => {
  console.log('Error from processDataAsycn() with async( When promise gets rejected ): ' + error);
});

/*
 Now, moving to the await operator, let us suppose we have an async function,
 processData(), that calls a function, getDataPromise(), which, in turn,
 returns a promise.
 Now, we want to parse/use the returned data. Let's look at how we would solve
 the problem without the await operator.

 Consider the following code snippet:
*/

