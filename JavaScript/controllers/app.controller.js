'use strict';

/*
  This file is only for test purpose. It is used by spy a function in tests by Sinon framework.
*/
module.exports = {
  getIndexPage: (req, res) => {

    if (req.user.isLoggedIn()) {
      return res.send("Hey");
    }

    res.send("Ooops. You need to log in ti access this page");
  }
}