'use strict';
import { strict as assert } from 'node:assert'
import { Readable } from 'stream'


/*
 See: https://nodesource.com/blog/understanding-streams-in-nodejs/
*/ 
async function readableToString2(readable) {
  let result = '';
  for await (const chunk of readable) {
    result += chunk;
  }
  return result;
}

try {
  const readable = Readable.from('Good morning!', {encoding: 'utf8'});
  assert.equal(await readableToString2(readable), 'Good morning!');
} catch (error) {
  console.error(error);
}