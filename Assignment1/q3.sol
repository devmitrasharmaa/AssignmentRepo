// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract greet{
    string private message;
    
    function set(string memory greeting) public {
        message= greeting;
    }

    function get() public view returns (string memory){
        return message;
    } 
}