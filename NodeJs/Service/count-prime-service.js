'use strict';

/*
  This is the example of a small HTTP server.
  Function is_prime() returns a boolean indicating parameter is a prime number or not.
  Function countNumberOfPrimes() returns number of primes between 1 and the given parameter.
  Function handler() parase query string from HTTP request, extracts number and sends the
  result via HTTP response.

  The code when startet runs a cluster of eigth processes that  process the incoming requests concurrently.
*/
const cluster = require('cluster');
const http = require('http');
const url = require('url');
const querystring = require('querystring');

const port = 8084;
const number_of_processes = 8;

//-----------------------------------------------------------
const is_prime = function (number) {
  for (let i = 2; i < number; i++) {
    if (number % i === 0) {
      return false;
    }
  }

  return number > 1;
}

//-----------------------------------------------------------
const countNumberOfPrimes = function (number) {
  let count = 0;

  for (let i = 1; i <= number; i++) {
    if (is_prime(i)) {
      count++;
    }
  }

  return count;
};

//-----------------------------------------------------------
const handler = function (request, response) {

  const params = querystring.parse(url.parse(request.url).query);
  const number = parseInt(params.number);
  const count = countNumberOfPrimes(number);

  response.writeHead(200, { 'Content-Type': 'text/plain' });
  return response.end(`${count}`);
};

//-----------------------------------------------------------
if (cluster.isMaster) {
  for (let i = 0; i < number_of_processes; i++) {
    cluster.fork();
  }
}
else {
  http.createServer(handler).listen(port);
}