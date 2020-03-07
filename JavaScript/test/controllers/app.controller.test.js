'use strict';

const chai = require('chai');
chai.use(require('chai-string'));
chai.use(require('chai-match'));

const expect = chai.expect;
const sinon = require('sinon');

// import our getIndexPage function
const indexPage = require("../../controllers/app.controller.js");

/*
 We could use a spy and then make some assertions on the spy. Making assertions on a spy is possible because the spy gives us a dummy function that we can use to track our functions execution.
*/

/*
  Stubs
  Stubs are really great. This is because they have all the functionality of spies but unlike spies they replace the whole function.
  This means that with spies the function runs as is but with a stub you are replacing said function.
  This helps in scenarios where we need to test:

  External calls which make tests slow and difficult to write (e.g HTTP calls/ DB calls)
  Triggering different outcomes for a piece of code (e.g. what happens if an error is thrown/ if it passes)
*/


describe("AppController", function () {

  describe("getIndexPage", function () {
    it("should send hey when the user is logged in (spy/stub)", function () {

      // Instantiate a user object wiht an empty isLoggedIn function
      let user = {
        isLoggedIn: function () { }
      };

      // Stub isLoggedIn function and make it return true always
      const isLoggedInStub = sinon.stub(user, "isLoggedIn").returns(true);

      let req = {
        user: user
      };

      // Have `res` have a send key with a function value coz we use
      let res = {
        //replace empty function with a spy
        send: sinon.spy()
      };

      indexPage.getIndexPage(req, res);

      // let's see what we get on res.send
      //console.log(res.send);
      // `res.send` called once
      expect(res.send.calledOnce).to.be.true;

      // expect to get argument `bla`on first call
      expect(res.send.firstCall.args[0]).to.be.equal("Hey");

      // assert that the stub is logged in at least once
      expect(isLoggedInStub.calledOnce).to.be.true;
    });

    it("should send something else when the user is NOT logged in", function () {

      // Instantiate a user object wiht an empty isLoggedIn function
      let user = {
        isLoggedIn: function () { }
      };

      // Stub isLoggedIn function and make it return true always
      const isLoggedInStub = sinon.stub(user, "isLoggedIn").returns(false);

      let req = {
        user: user
      };

      // Have `res` have a send key with a function value coz we use
      let res = {
        //replace empty function with a spy
        send: sinon.spy()
      };

      indexPage.getIndexPage(req, res);

      // let's see what we get on res.send
      //console.log(res.send);
      // `res.send` called once
      expect(res.send.calledOnce).to.be.true;

      // expect to get argument `bla`on first call
      expect(res.send.firstCall.args[0]).to.be.equal("Ooops. You need to log in to access this page");
      expect(res.send.firstCall.args[0]).to.startsWith('Ooops');
      expect(res.send.firstCall.args[0]).to.endsWith('page');
      expect(res.send.firstCall.args[0]).to.match(/Ooops. (\w+) need(.*)page/).and.capture(0).equals('You');

      // assert that the stub is logged in at least once
      expect(isLoggedInStub.calledOnce).to.be.true;
    });

    it("should send hey when the user is logged in (mock)", function () {

      // Instantiate a user object wiht an empty isLoggedIn function
      let user = {
        isLoggedIn: function () { }
      };

      // Stub isLoggedIn function and make it return true always
      const isLoggedInStub = sinon.stub(user, "isLoggedIn").returns(true);

      let req = {
        user: user
      };

      // Have `res` have a send key with a function value coz we use
      let res = {
        //replace empty function with a spy
        send: function() {}
      };

      // mock res
      const mock = sinon.mock(res);
    
      // build how we expect it t work
      mock.expects("send").once().withExactArgs("Hey");

      indexPage.getIndexPage(req, res);
      expect(isLoggedInStub.calledOnce).to.be.true;

      // verify that mock works as expected
      mock.verify();
    });
  });


  describe("User", function () {
    describe("addUser", function () {

      /*
        What if we had an already existing function and we just want to spy on that function? 
        We can simulate this scenario by defining a simple function like so:
      */

      const user = {
        addUser: (name) => {
          this.name = name;
        }
      }

      it("should add a user", function () {
        sinon.spy(user, "addUser");
        user.addUser('John Doe');

        // lets log `addUser` and we see what we get
        console.log(user.addUser);

        expect(user.addUser.calledOnce).to.be.true;
      });

    });
  });
});