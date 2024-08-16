// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventLogger {
    event ActionPerformed(address indexed _from, string _action);

    function performAction(string memory _action) public {
        emit ActionPerformed(msg.sender, _action);
    }
}
