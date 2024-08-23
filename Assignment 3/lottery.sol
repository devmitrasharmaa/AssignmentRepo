// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {
    address public admin;
    uint public totalTickets;
    uint public pricePerTicket;
    uint public ticketsSold;
    address[] public participants;
    enum State { ACTIVE, INACTIVE, COMPLETED }
    State public lotteryState;

    // Event to log the winner
    event WinnerAnnounced(address indexed winner, uint winnerAmount, uint adminAmount);

    constructor(uint _totalTickets, uint _pricePerTicket) {
        admin = msg.sender;
        totalTickets = _totalTickets;
        pricePerTicket = _pricePerTicket;
        lotteryState = State.ACTIVE;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _;
    }

    modifier inState(State _state) {
        require(lotteryState == _state, "Invalid state");
        _;
    }

    function purchaseTicket() public payable inState(State.ACTIVE) {
        require(msg.value == pricePerTicket, "Incorrect ticket price");
        require(ticketsSold < totalTickets, "Tickets sold out");
        
        participants.push(msg.sender);
        ticketsSold++;

        if (ticketsSold == totalTickets) {
            lotteryState = State.INACTIVE;
        }
    }

    function announceWinner() public onlyAdmin inState(State.INACTIVE) {
        require(participants.length > 0, "No participants");

        uint winnerIndex = generateRandom() % participants.length;
        address winner = participants[winnerIndex];

        uint totalFunds = address(this).balance;
        uint winnerShare = (totalFunds * 80) / 100; // 80% for the winner
        uint adminShare = (totalFunds * 20) / 100;  // 20% for the admin

        payable(winner).transfer(winnerShare);
        payable(admin).transfer(adminShare);

        // Emit an event to log the winner
        emit WinnerAnnounced(winner, winnerShare, adminShare);

        lotteryState = State.COMPLETED;
    }

    function closeLottery() public onlyAdmin inState(State.INACTIVE) {
        lotteryState = State.COMPLETED;
    }

    function generateRandom() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, participants)));
    }

    function getParticipants() public view returns (address[] memory) {
        return participants;
    }
}
