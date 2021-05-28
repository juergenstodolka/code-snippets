'use strict';

const chai = require('chai');
const expect = chai.expect;
const sinon = require('sinon');

// import our getIndexPage function
const indexPage = require("../../controllers/app.controller.js");

/*
  Mocks
  With mocks we can specify how we want something to work and use mock.verify() to make sure it works. This means less and cleaner code. With our already existing tests we could:

  -  mock our res object
  -  expect send to be called once with the argument Hey
  -  then call mock.verify()
*/

describe("AppController", function () {

  describe("getIndexPage", function () {
    it("should return index page", function () {

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
        send: function () { }
      };

      const mock = sinon.mock(res);

      // build how we expect it to work
      mock.expects("send").once().withExactArgs("Hey");

      indexPage.getIndexPage(req, res);


    });
  });


  describe("User", function () {
    describe("addUser", function () {

      /*
        What if we had an already existing function and we just want to spy on that function? We can simulate this scenario by defining a simple function like so:
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