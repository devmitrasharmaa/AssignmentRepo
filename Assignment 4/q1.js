/// 1: What if I ask you the following question — Give me an input string that outputs 
// a SHA-256 hash that starts with 00000 . How will you do it?

const crypto = require('crypto');

function findinghash(prefix){
    const base_string = "input_string";
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


const result = findinghash("00000");
console.log(`Input String: ${result.input_string}`)