'use strict';

// Example: https://www.section.io/engineering-education/what-are-cookies-nodejs/

const cookieParser = require('cookie-parser');
const express = require('express');

//setup express app
const app = express();

// let’s you use the cookieParser in your application
app.use(cookieParser());

//set a simple for homepage route
app.get('/', (req, res) => {
  res.send('welcome to a simple HTTP cookie server');
});

/*
Step 1 - Set a cookie

We will set a route that will save a cookie in the browser. 
In this case, the cookies will be coming from the server to the client browser. 
To do this, use the res object and pass cookie as the method, i.e. res.cookie() 
as shown below.
*/

/*
Secure cookie
As a precaution, you should always try to make your cookies inaccessible on the client-side using JavaScript.
We can add several attributes to make this cookie more secure.

-  'HTTPonly' ensures that a cookie is not accessible using the JavaScript code. This is the most crucial form of protection against cross-scripting attacks.
-  A 'secure' attribute ensures that the browser will reject cookies unless the connection happens over HTTPS.
- 'sameSite' attribute improves cookie security and avoids privacy leaks.
   By default, sameSite was initially set to none (sameSite = None). This allowed third parties to track users across sites. 
   Currently, it is set to Lax (sameSite = Lax) meaning a cookie is only set when the domain in the URL of the browser 
   matches the domain of the cookie, thus eliminating third party’s domains. 
   'sameSite' can also be set to Strict (sameSite = Strict). This will restrict cross-site sharing even between different domains that the same publisher owns.
-  You can also add the maximum time you want a cookie to be available on the user browser.
   When the set time elapses, the cookie will be automatically deleted from the browser.

   In this case, we are accessing the server on localhost, which uses a non-HTTPS secure origin.
   For the sake of testing the server, you can set secure: false. 
   However, always use true value when you want cookies to be created on an HTTPS secure origin.

   If you run the server again (node app.js) and navigate to http://localhost:8000/setcookie on the browser, 
   you can see that the values of the cookie have been updated with security values.

   Furthermore, you cannot access the cookie using JavaScript, i.e., 'document.cookie.'
*/

// A get route for adding a  secure cookie
app.get('/setcookie', (req, res) => {
  res.cookie(`Cookie token name`, `encrypted cookie string Value`, {
    maxAge: 5000,
    // expires works the same as the maxAge
    expires: new Date('01 12 2021'),
    secure: true,
    httpOnly: true,
    sameSite: 'lax',
  });
  res.send('Cookie have been saved successfully');
});

/*
Step 2 - Using the req.cookies method to check the saved cookies

If the server sends this cookie to the browser, this means we can iterate the incoming 
requests through req.cookies and check the existence of a saved cookie. 
You can log this cookie to the console or send the cookie request as a response 
to the browser. 
Let’s do that.
*/

// get the cookie incoming request
app.get('/getcookie', (req, res) => {
  //show the saved cookies
  console.log(req.cookies);
  res.send(req.cookies);
});

/*
  Step 4 - Deleting a cookie
*/



// Start the server
app.listen(8000, () => console.log('The server is running port 8000...'));
