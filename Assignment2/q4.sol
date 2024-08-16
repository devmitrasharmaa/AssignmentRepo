// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract keep_count{
    uint private count;

    function increment() public{
        count+=1;
    }

    function get() public view returns (uint){
        return count;
    }

}