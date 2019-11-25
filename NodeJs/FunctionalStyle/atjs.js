'use  strict';


function curry (fn, arity = fn.length) {
    return (function nextCurried (prevArgs) {
        return function curried (nextArg) {
            console.log("prevArgs", prevArgs);
            console.log("nextArg", nextArg);
            var args = [...prevArgs, nextArg];
            if (args.length >= arity) {
                return fn(...args);
            }
            else {
                return nextCurried(args);
            }
        };
    })([]);
}

const pipe = function (...fns) {
    return function (x) {
        return fns.reduce(function (v, f) {
            return f(v);
        }, x);
    }
};

const compose = function (...fns) {
    return function (x) {
        return fns.reduceRight(function (v, f) {
            return f(v);
        }, x);
    }
};

module.exports = {
    curry,
    pipe,
    compose
};