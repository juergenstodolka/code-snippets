'use strict';

const fs = require("fs");

let stream;
stream = fs.createWriteStream("write_data.txt");

stream.write("Tutorial on Node.js")
stream.write("Introduction")
stream.write("Events")
stream.write("Generators")
stream.write("Data Connectivity")
stream.write("Using Jasmine") 