'use strict';

const net = require('net');

const server = net.createServer(function (connection) {

    console.log('client connected');

    connection.on('end', function () {
        console.log('client disconnected');
    });

    connection.write('SERVER sends: Hello World!\r\n');
    connection.pipe(connection);
});

server.listen(8080, function () {
    console.log('server is listening');
});

