
/*
  Method Currying

  When a function, instead of taking all the arguments at once, takes only one
  argument and returns a function which will then take the rest of the arguments,
  this process is known as method currying.
*/

/*  
  We have a function adderFunction which returns another function.  
  That return function in turn returns the sum.  
 */
const adderFunction = (a) => {
  return (b) => {
    return a + b;
  }
}

const addToTen = adderFunction(10);

console.log(addToTen(12));

console.log(addToTen(-1));

const addToThousand = adderFunction(1000);

console.log(addToTen(18));

console.log(addToTen(121));

console.log(addToThousand(422));