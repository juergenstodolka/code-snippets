/*
Process.nextTick(callback)

To understand how Promises work in Node.js, it is important to review how process.nextTick()
works in Node.js, as the two are very similar.
Process.nextTick() is a method that adds a callback to the “next tick queue.”
Tasks in the queue are executed after the current operation in the event loop is done and
before the event loop is allowed to continue.
Simply said, there’s another queue beside the event loop that we can use to schedule events.
This queue is even faster than the event loop and it may be drained several times
in a single event loop tick.

In the example below, we can see how process.nextTick works in practice.
We have two setTimeout calls, with callbacks immediately scheduled in the event loop.
We also have two process.nextTick methods with callbacks scheduled in the “next tick queue.”

*/

const log = msg => () => console.log(`NEXT TICK ${msg}`)

const timeout = (time, msg) => {
  setTimeout(() => {
    console.log(`TIMEOUT ${msg}`)
  }, time)
}

process.nextTick(log('ONE'))
timeout(0, 'AFTER-ONE')
process.nextTick(log('TWO'))
timeout(0, 'AFTER-TWO')