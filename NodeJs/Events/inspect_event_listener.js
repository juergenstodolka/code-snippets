'use strict';

/*
    Inspecting Event Listeners
    At any point in its lifetime, an event emitter can have zero or more listeners attached to it. 
    The listeners for each event type can be inspected in several ways.

    At any point in its lifetime, an event emitter can have zero or more listeners attached to it. 
    The listeners for each event type can be inspected in several ways.
*/
const events = require('events');

// We are defining an eventEmitter type which is required for using the event-related methods.
const eventEmitter = events.EventEmitter;

// We are then defining an object called emitter which will be used to define our event handlers.
const emitter = new eventEmitter();

// We are creating 2 events handlers which basically do nothing. This is kept simple for our example just to show how the listenerCount method works.
emitter.on('data_received', function () { });
emitter.on('data_received', function () { });

// Now when you invoke the listenerCount method on our data_received event,
// it will send the number of event listeners attached to this event in the console log.
console.log(eventEmitter.listenerCount(emitter, 'data_received'));