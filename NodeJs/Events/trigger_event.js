"use strict";

/*
    1. Use the require function to include the 'events' module. With this module, you will be able to create events in Node.js.
    2. Create a new events emitter. This is used to bind the event, which in our case is "data_received" to a callback function which is defined in step3.
    3. We define an event-driven function which says that if in case the "data_received" event is triggered then we should output the text "data_received" to the console.
    4. Finally, we do have a manual trigger of our event using the eventEmiter.emit function. This will trigger the data_received event.
*/
const events = require("events");

const eventEmitter = new events.EventEmitter();

eventEmitter.on("data_received", function () {
  console.log("data received succesfully.");
});

eventEmitter.emit("data_received");

/*
   1. One time event handlers
   Sometimes you may be interested in reacting to an event only the first time it occurs. 
   In these situations, you can use the once() method.

   Here we are using the 'once' method to say that for the event 'request' the callback function should only be executed once.
*/
eventEmitter.once("request", function (counter) {
  console.log("request received succesfully: " + counter);
});

eventEmitter.emit("request", 1);
eventEmitter.emit("request", 2);
