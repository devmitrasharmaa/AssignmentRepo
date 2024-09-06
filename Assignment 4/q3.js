// What if I ask you to find a nonce for the following input -
// Dev => Karan | Rs 100
// Karan => Darsh | Rs 10


//ANS: To get a nonce for your input, we need to get a condition to be fulfilled, 
// as we aren't specified any condition we will use the question 1 condition.
const cryptog= require('crypto');

function noncefinder(input_str, condition){
    let nonce=0;

    while (true){
        const input_string= `${input_str}${nonce}`;

        const hashwala= cryptog.createHash('sha256').update(input_string).digest('hex');

        if (hashwala.startsWith(condition)){
            return {nonce,hashwala };
        }
        nonce++;
    }

}

const input_str=
`
Dev => Karan | Rs 100
Karan => Darsh | Rs 10`;

const conditional='00000';

result = noncefinder(input_str, conditional)
console.log(`Nonce Value: ${result.nonce}`)