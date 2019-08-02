'use strict';

// A class factory creates dynamically a class with fileds provided as parameteres.
const createClass = function (...fileds) {

    return class {
        constructor (...values) {
            fileds.forEach((field, index) => this[field] = values[index]);
        }
    };
};

// Create two different classes
const Book = createClass('title', 'subtitle', 'pages');
const Actor = createClass('firstName', 'lastName', 'yearStarted');

// Create new instance of class Actor and assign values to fields.
const fisher = new Actor('Carrie', 'Fisher', 1969);
console.log(fisher);
