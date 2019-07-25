'use strict';

/*
    This was a trick question.
    Callbacks are not async by default, this was a sync call so the message var was not defined
    by the time the callback was called.
    To make this work we need to wrap our call to `cb` in either a `setImmediate` or a `process.nextTick`.
*/
function doAsyncTask(cb) {
    // cb();
  
    setImmediate(() => {
      console.log("Async Task Calling Callback");
      cb();
    });
  
    // process.nextTick(() => {
    //   console.log("Async Task Calling Callback");
    //   cb();
   // });
  }
  
  doAsyncTask(() => console.log(message));
  
  let message = "Callback Called";