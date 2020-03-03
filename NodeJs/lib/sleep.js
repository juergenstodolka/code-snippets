'use strict';

const parse = require('parse-duration');

const sleep = function (duration) {
  return new Promise((resolve) => {
    setTimeout(resolve, parse(duration));
  });
};

module.exports = sleep;