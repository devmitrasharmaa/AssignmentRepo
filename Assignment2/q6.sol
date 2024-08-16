// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(string => uint) private votes;
    string[] private candidateNames;

    function vote(string memory _name) public {
        // Check if the candidate is new
        if (votes[_name] == 0) {
            candidateNames.push(_name);
        }
        votes[_name] += 1;
    }

    function getVotes(string memory _name) public view returns (uint) {
        return votes[_name];
    }

    function getAllCandidates() public view returns (string[] memory) {
        return candidateNames;
    }

    function getAllVotes() public view returns (uint[] memory) {
        uint[] memory allVotes = new uint[](candidateNames.length);
        for (uint i = 0; i < candidateNames.length; i++) {
            allVotes[i] = votes[candidateNames[i]];
        }
        return allVotes;
    }
}
