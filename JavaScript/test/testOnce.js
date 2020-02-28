'use strict';

const assert = require('assert');

const sinon = require('sinon');

const once = require('../lib/once');

describe('Sinon stub test', function () {

  it('calls the original function', function () {
    var callback = sinon.fake();
    var proxy = once(callback);

    proxy();

    assert(callback.called);
  });

})
