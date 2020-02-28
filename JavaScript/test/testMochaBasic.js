//const assert = require('assert');
const { assert } = require('assertthat');

describe('Array', function () {

  describe('#indexOf()', function () {
    it('should return -1 when the value is not present', function () {
      assert.that([1, 2, 3].indexOf(4)).is.equalTo(-1);
    });
  });

  describe('#length()', function () {
    it('should return the array length', function () {
      const actual = [1, 2, 3].length;
      assert.that(actual).is.equalTo(3);
    });
  });

});
