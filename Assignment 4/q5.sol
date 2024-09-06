// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Donation {
    mapping(address => uint256) public donations; // Tracks total donations per recipient

    event Donated(address indexed donor, address indexed recipient, uint256 amount);

    // Donate ETH to a specific recipient
    function donate(address recipient) external payable {
        require(msg.value > 0, "Donation must be greater than zero");
        donations[recipient] += msg.value;
        emit Donated(msg.sender, recipient, msg.value);
    }

    // Withdraw accumulated donations
    function withdraw() external {
        uint256 amount = donations[msg.sender];
        require(amount > 0, "No funds available");
        donations[msg.sender] = 0; // Reset balance before transfer
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed");
    }

    // Fallback to receive ETH
    receive() external payable {}
}
