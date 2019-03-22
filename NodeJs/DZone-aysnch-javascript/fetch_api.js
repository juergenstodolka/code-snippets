/*
Fetch API

The Fetch API was introduced in relatively newer versions of JavaScript and has
built-in support for Promises. Technically, it is just another method of hitting
HTTP Requests while harnessing the powers and perks of Promises and Promise Chaining.

So in the fetch API, you pass the arguments in the following order:

  - URL
  - { } (This is purely optional, used to customize our Request)

The fetch API simply returns a Promise and hence we can implement handlers
to process the response from the Promise. Based on whether the Promise
resolves or rejects, we can handle that with JavaScript's  then() method.
*/

fetch('http://puzzle.mead.io/puzzle', {}).then((response) => {

  if (response.ok) {
    return response.json();

    /*  
      Actually, the .json() method takes the response and returns a Promise Object and hence  
      We need to add another then() as we have done in Promise Chaining   
    */
  } else {
    throw new Error('Unable to fetch the puzzle');
  }
}).then((data) => {
  console.log(data.puzzle);
}).catch((error) => {
  console.log(error);
});