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


function createPost (post, callback) {
    setTimeout(() => {
        posts.push(post);
        callback();
    }, 2 * 1000);
}


createPost({ title: 'Post Three', body: 'This is post three' }, getPosts);