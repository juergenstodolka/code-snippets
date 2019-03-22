/*
 A new Promise is in the pending state.
 If a Promise succeeds it is put in a resolved state otherwise it is rejected.
 Instead of using the original callback mechanism, code using Promises creates a Promise object.
 We use Promises typically with two callback handlers – resolved invoked when
 the operation was successful and rejected called whenever an error has occurred.
*/

// Converting a callback based method to a method that returns Promise

const fs = require('fs')

const readTextFromFile = () => new Promise((resolve, reject) => {

  fs.readFile('file.txt', (err, data) => {
    if (err) {
      return reject(err)
    }
    resolve(data)
  })
})

// Usage of a method that returns Promise
readTextFromFile().then(data => console.log(data)).catch(e => console.log(e))