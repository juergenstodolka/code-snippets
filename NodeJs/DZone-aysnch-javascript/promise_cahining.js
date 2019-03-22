/*
Promise Chaining

Suppose we have a function, funcA(). Suppose funcA() returns a number
after multiplying the input by 2; unless the input type is a number,
it will return an error. And, based on the output received from funcA(),
we again want to call the same function (i.e. functA()) by passing the output
received from the first call as an input.

As we did before, while solving the problem above, we would be contrasting
and comparing the callback approach and Promise approach.

Consider the following code snippet (callback approach):
*/

//Callback Approach  
const funcA = (num, callback) => {

  setTimeout(() => {
    if (typeof num === 'number') {
      callback(undefined, 2 * num);
    } else {
      callback('Input type must be number');
    }
  }, 200);
}

funcA(2, (error, data) => {
  if (error) {
    console.log(error);
  }
  else {

    funcA(data, (error, data) => {
      if (error) {
        console.log(error);
      }
      else {
        console.log('Final Output(Using Callback Approach): ' + data);
      }
    });
  }
});

/*
As you can see, it is getting messier as it grows. What we're seeing here is
commonly called callback hell. Yes, there is actually a name for this messier
code and, obviously, we need a better solution which is both manageable
and understandable — Promise Chaining comes to our rescue here.

However, with Promises, we would be seeing two approaches here:

Consider the following code snippet (Promise approach, without Promise Chaining):
*/
const funcB = (num) => new Promise((resolve, reject) => {

  setTimeout(() => {
    (typeof num === 'number')
      ? resolve(2 * num)
      : reject('Input type must be number');
  }, 1000);
});

funcB(3).then((data) => {

  funcB(data).then((data) => {
    console.log('funcB', data);
  }, (error) => {
    console.log('funcB', error);
  });
}, (error) => {
  console.log(error);
});

/*
Even without Promise Chaining, our code looks far leaner with the simple Promise approach
as compared to the bare callback approach.
Now, we would be looking a still better approach which uses Promise Chaining.
Before moving to the code of Promise Chaining, let us put some light on it theoretically:

1.  When we return a Promise from another Promise handler (i.e. then()),
    it is called Promise Chaining.
2.  We can easily attach another then() handler when our Promise resolves
    (the one we have returned) and this can be done n number of times based on our needs.
3.  We can employ a single error handler called catch() which is attached at the very
    last of our Promise Chaining.

Consider the following code snippet (Promise approach, with Promise Chaining):
*/

// As one can see, the code is much much cleaner and concise now, thanks to Promise Chaining.
const funcC = (num) => new Promise((resolve, reject) => {

  setTimeout(() => {
    (typeof num === 'number')
      ? resolve(12 * num)
      : reject('Input type must be number');
  }, 2);
});

funcC(12).then((data) => {
  return funcC(data);
}).then((data) => {
  console.log('funcC ', data);
}).catch((error) => {
  console.log(error);
});