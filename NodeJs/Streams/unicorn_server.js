'use strict';

const https = require('https');
const http = require('http');
const server = http.createServer(requestHandler);

const source = 'https://libuv.org/images/libuv-bg.png';

function requestHandler (clientRequest, clientResponse) {

  https.request(source, handleImgResponse).end();
  
  function handleImgResponse (imgResponseStream) {
    imgResponseStream.pipe(clientResponse);
  }
}


server.listen(process.env.PORT || 3000)