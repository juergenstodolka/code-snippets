/*
    Promise Chaining
    To demonstrate promise chaining, the following function will be used to simulate an
    asynchronous task. In reality, it’s just adding up a couple of numbers, waiting two seconds,
    and fulfilling the promise with the sum.
*/
const add = (a, b) => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (a < 0 || b < 0) {
        return reject('Numbers must be non-negative')
      }
      resolve(a + b)
    }, 2000)
  })
}

add(1, 2).then((sum) => {
  console.log(sum) // Will print 3
  return add(sum, 4)
}).then((sum2) => {
  console.log(sum2) // Will print 7
}).catch((e) => {
  console.log(e)
})