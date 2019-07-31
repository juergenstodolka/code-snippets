'use strict';

/*
    Code Explanation:-

    We first need to include the 'fs' modules which contain all the functionality required to create streams.
    Next we create a readable stream by using the method – createReadStream. As an input, we give the location of our data.txt file.
    The steam.on function is an event handler and in it, we are specifying the first parameter as 'data.'
    This means that whenever data comes in the stream from the file, then execute a callback function. 
    In our case, we are defining a callback function which will carry out 2 basic steps. 
    The first is to convert the data read from the file as a string.
    The second would be to send the converted string as an output to the console.
    We are taking each chunk of data which is read from the data stream and converting it to a string.
    Finally, we are sending the output of each string converted chunk to the console.
*/

const fs = require('fs');

let stream;
stream = fs.createReadStream('data.txt');

stream.on('data', (data) => {
    const chunk = data.toString();
    console.log(chunk);
})