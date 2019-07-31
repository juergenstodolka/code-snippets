'use strict';

/*
  The 'newListener' event.

  Each time a new event handler is registered, the event emitter emits a newListener event.
  This event is used to detect new event handlers.
  You typically use newListener event when you need to allocate resources or perform some action for each new event handler.
*/

const events = require('events');

const eventEmitter = events.EventEmitter;
const emitter = new eventEmitter();

emitter.on("newListener", function (eventName, listener) {
    console.log("Added listener for " + eventName + " events");
});

emitter.on('data_received', function () { });
emitter.on('data_received', function () { }); 