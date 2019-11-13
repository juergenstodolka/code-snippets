'use strict';

const numbers = [1, 5, 2, 6, 8, 3, 4, 9, 7, 6];

let totalOfDoubleOfEven = 0;

for (const number of numbers) {
  if (number % 2 === 0) {
    totalOfDoubleOfEven += number * 2;
  }
}

console.log(totalOfDoubleOfEven);

console.log('-'.repeat(50));
console.log('The same');
console.log('-'.repeat(50));

let compute = function (numbers) {
  return numbers.filter((number) => number % 2 == 0)
    .map(e => e * 2)
    .reduce((total, e) => total + e)
};

console.log(compute(numbers));