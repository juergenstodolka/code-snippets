//import { fs } from 'fs';
import { exec } from 'node:child_process'

/**
 * Node.js runs in a single-thread mode, but it uses an event-driven paradigm to handle concurrency. 
 * It also facilitates creation of child processes to leverage parallel processing on multi-core CPU based systems.
 * 
 * exec − child_process.exec method runs a command in a shell/console and buffers the output.
 * exec method runs a command in a shell and buffers the output.
 * 
 */

for(var i=0; i<3; i++) {
   var workerProcess = exec('node support.js '+i, function (error, stdout, stderr) {
      
      if (error) {
         console.log(error.stack);
         console.log('Error code: '+error.code);
         console.log('Signal received: '+error.signal);
      }
      console.log('stdout: ' + stdout);
      console.log('stderr: ' + stderr);
   });

   workerProcess.on('exit', function (code) {
      console.log('Child process exited with exit code '+code);
   });
}