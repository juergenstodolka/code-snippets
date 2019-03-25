/*
 In the example below, the code in the Promise will be scheduled in the
 Microtask queue, but since that action requires the network, it will only
 be resolved after the data is received.
*/
const fetch = require('node-fetch') // only when running in Node.js

const fetchData = fetch('https://api.github.com/users/nearform/repos')
  .then(() => console.log('Hi from fetch!'))
  .catch(e => console.error(e))

console.log('Hi!')

setTimeout(() => {
  console.log('Hi from setTimeout')
}, 0)

fetchData