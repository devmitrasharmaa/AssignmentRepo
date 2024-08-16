// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract store_retrieve_user{
    string private name;

    function setName(string memory _name) public {
        name=_name;
    }

    function get() public view returns (string memory){
        return name;
    }

}