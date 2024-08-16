// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Owner{
    address private owner;

    constructor(){
        owner= msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner, "Not the contract owner");
        _;
    }
    function onlyforyou() public view onlyOwner returns (string memory){
        return "Youre the One";
    }
}