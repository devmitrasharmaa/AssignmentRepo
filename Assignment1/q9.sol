// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLedger {
    struct Transaction {
        address sender;
        address receiver;
        uint256 amount;
    }

    Transaction[] public transactions;

    function addTransaction(address _receiver, uint256 _amount) public {
        transactions.push(Transaction({
            sender: msg.sender,
            receiver: _receiver,
            amount: _amount
        }));
    }

    function getTransaction(uint256 _index) public view returns (address, address, uint256) {
        Transaction memory txn = transactions[_index];
        return (txn.sender, txn.receiver, txn.amount);
    }
}
