'use strict';

// Create an object using Literals
const createPerson = function(name, age, sport, sportFct){
    return {
        name,
        age,
        toString() {
            return `${this.name} ${this.age}`;
        },
        [`play${sport}`] : sportFct
    };
};

const sam = createPerson('Sam', 21, 'Soccer', 
    function() {
        console.log(`${this.name}, kick, don't touch`);
});

console.log(sam.name);
console.log(sam.toString());
sam.playSoccer();