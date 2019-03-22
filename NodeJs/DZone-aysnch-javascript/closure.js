// Example 1: 
// A closure is a function that has access to the variables defined in 
// outer (and enclosing) functions. As far as scope is concerned, the closure
// has access to global variables, its own variables, and variables of 
// outer (and enclosing) functions.
const myFunction = () => {
  const message = 'My New message'
  const printMessage = () => {
    console.log(message)
  }
  printMessage();
}

myFunction();

// Example 2:
const myFunction2 = () => {
  const message = 'My new Message Two'
  return () => {
    console.log(message)
  }
}

const myPrintMessage = myFunction2()
myPrintMessage()