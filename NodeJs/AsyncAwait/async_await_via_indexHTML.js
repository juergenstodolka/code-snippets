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

// Async / Await
// async function init () {
//     await createPost({ title: 'Post Three!', body: 'This is post three!' });

//     getPosts();
// }

// init();

// Async / Awaut /Fetch
async function fetchUsers () {

    // returns a promise
    const res = await fetch('https://jsonplaceholder.typicode.com/users');

    const data = await res.json();

    console.log(data);
}

fetchUsers();