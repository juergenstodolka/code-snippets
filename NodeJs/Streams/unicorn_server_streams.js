'use strict';

const https = require('https');
const http = require('http');
const server = http.createServer(requestHandler);

const source = 'https://libuv.org/images/libuv-bg.png';

function requestHandler (clientRequest, clientResponse) {

  https.request(source, handleImgResponse).end();
  
  function handleImgResponse (imgResponseStream) {

    imgResponseStream
      .on('data', (data) => console.log(`Chunk size: ${data.length} bytes`)) // Emmited when data is read from the stream
      .on('end', () => console.log('End event emitted')) // Emitted when no more data will be read from the stream
      .on('close', () => console.log('Close event emitted')) // Emitted when server closes connection (in HTTP cases)
      .on('error', (error) => console.error(error)) // This could be emited at any time, and will handle any errors related with the Stream
      .pipe(clientResponse);
  }

}


server.listen(process.env.PORT || 3000)