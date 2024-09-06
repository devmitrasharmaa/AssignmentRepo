// What if I ask you that the input string should start with devadnani26 ? How would the code change?

// code remains similar to q1.js , only change will be 'devadnani' instead of 'input_string'
const crypto = require('crypto');

function findinghash(prefix){
    const base_string = "devadnani26";
    let i =0;
    while (true){
        const input_string=`${base_string}${i}`;
        const hashwala= crypto.createHash('sha256').update(input_string).digest('hex');

        if (hashwala.startsWith(prefix)){
            return {input_string, hashwala};
        }

        i++;
    }

}


const result = findinghash("0000");
console.log(`Input String: ${result.input_string}`)