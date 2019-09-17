'use strict';

const highOrder = require('./lib/atjs.js');

const scores = [50, 6, 100, 0, 10, 75, 8, 60, 90, 80, 0, 30, 110];

const boostSingleScores = scores.map(val => (val < 10) ? val * 10 : val);

const rmvOverScores = boostSingleScores.filter(val => val <= 100);

const rmvZeroScores = rmvOverScores.filter(val => val > 0);

const scoresSum = rmvZeroScores.reduce((sum, val) => sum + val, 0);

const scoresCnt = rmvZeroScores.reduce((cnt, val) => cnt + 1, 0);

//Convert each statement to a function that can accept and act on any array.
const singleScoresByTen = function (arr) {
    return arr.map(val => (val < 10) ? val * 10 : val);
};

const rmvOverScoresFct = function (arr) {
    return arr.filter(val => val <= 100);
};

const rmvZeroScoresFct = function (arr) {
    return arr.filter(val => val > 0);
};

const scoresSumFct = function (arr) {
    return arr.reduce((sum, val) => sum + val, 0)
};

const scoresCntFct = function (arr) {
    return arr.reduce((cnt, val) => cnt + 1, 0);
};

console.log('Scores:', scores);
console.log('-'.repeat(70));
console.log(singleScoresByTen(scores));
console.log(rmvOverScoresFct(scores));
console.log(rmvZeroScoresFct(scores));
console.log(scoresSumFct(scores));
console.log(scoresCntFct(scores));

//Compose a function that will remove both zero or lower scores and scores over 100. Test it using the scores array.
const rmvZeroAndOver100Scores = highOrder.pipe(
    rmvZeroScoresFct,
    rmvOverScoresFct
);

//Compose a function that will do all the modifications to an array. Test it using the scores array.
const prepareScores = highOrder.pipe(
    rmvZeroAndOver100Scores,
    singleScoresByTen);

const preparedArray = prepareScores(scores);

//Create a function that will accept an array and return the average. Use the function that sums scores and the function that counts scores or the length property.
const sumScoresFct = highOrder.pipe(
    rmvZeroAndOver100Scores,
    scoresSumFct
);

const computeAverage = function (arr) {
    return scoresSumFct(arr) / arr.length;
};


//Compose a function that will do all the modifications on an array and return an average.
const prepareAndComputeAve = highOrder.pipe(
    prepareScores,
    computeAverage
);

const ave = prepareAndComputeAve(scores);

console.log('Average:', ave);
console.log('-'.repeat(70));
console.log('Scores:', scores);