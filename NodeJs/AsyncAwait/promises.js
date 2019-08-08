'use strict';

/*
  This example works together with file index.html.
  Inside index.html change the scr path to appropriate script.
*/

const posts = [
    { title: 'Post One', body: 'This is post one' },
    { title: 'Post Two', body: 'This is post two' }
];

function getPosts () {

    setTimeout(() => {
        let output = '';
        posts.forEach((post, index) => {
            output += `<li>${post.title}</li>`;
        })

        document.body.innerHTML = output;
    }, 1 * 1000);
}


function createPost (post) {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            posts.push(post);

            const error = false;

            if (!error) {
                resolve();
            }
            reject('Something went wrong.');
        }, 2 * 1000);
    });
}

// createPost({ title: 'Post Three!', body: 'This is post three!' })
//     .then(getPosts)
//     .catch(err => console.log(err));

// Promise.all
const promise1 = Promise.resolve('Hello World');
const promise2 = 10;
const promise3 = new Promise((resolve, reject) =>
    setTimeout(resolve, 2000, 'Goodbye'));

const promise4 = fetch('https://jsonplaceholder.typicode.com/users').then(res => res.json());

// Wait until all promises are executed.
Promise.all([promise1, promise2, promise3, promise4]).then(values => console.log(values));
