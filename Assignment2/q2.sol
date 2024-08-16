// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract store{
    uint number;
    function set(uint num) public {
        number=num;
    }

    function get() public view returns (uint){
        return number;
    }
}