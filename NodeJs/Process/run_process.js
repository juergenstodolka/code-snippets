'use strict';
import { spawn } from 'child_process'


//const { spawn } = require('child_process');

/**
 * @param {string} executable
 * @param {string[]} args
 * @param {import('child_process').SpawnOptions} opts
 * @return {Promise<number>} return code
 * */
async function run(executable, args, opts = {}) {
  return new Promise((resolve, reject) => {
    const child = spawn(executable, args, {
      shell: true,
      stdio: ['pipe', process.stdout, process.stderr],
      ...opts,
    });
    child.on('error', reject);
    child.on('exit', (code) => {
      if (code === 0) {
        resolve(code);
      } else {
        const e = new Error('Process exited with error code ' + code);
        e.code = code;
        reject(e);
      }
    });
  });
}

(async function main () {

  try {
      const file = 'T:\\keep\\js\\Plossys-5\\test_args.ps1';
      const code = await run('powershell', ["-executionpolicy", "unrestricted", "-file", file, 'xxx']);
      process.exit(code);
  } catch (e) {
      console.error(e);
      process.exit(e.code || 1);
  }
 }

)();