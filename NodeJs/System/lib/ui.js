'use strict';

const ui = {
  abort (message, errorCode) {
    message = errorCode ? `Error ${errorCode}: ${message}` : message;
    /* eslint-disable no-console, no-process-exit */
    console.error(message);
    console.trace();
    process.exit(1);
    /* eslint-disable no-console, no-process-exit */
  },

  checkStatus (exitCode, errorMessage) {
    if (exitCode > 0) {
      ui.abort(errorMessage, exitCode);
    }
  },

  notify (message) {
    // eslint-disable-next-line no-console
    console.log(message);
  }
};

module.exports = ui;