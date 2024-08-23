# Lottery Smart Contract

## Overview

This repository contains a Solidity smart contract for a lottery system. The contract allows users to purchase lottery tickets and distributes the prize funds between the winner and the contract owner. The contract is designed to:

- Allow users to buy tickets.
- Close the lottery once all tickets are sold.
- Announce a winner and distribute 80% of the funds to the winner and 20% to the owner.
- Emit an event with the winner’s address and the prize distribution details.

## Features

- **Ticket Purchase:** Users can purchase tickets by sending Ether to the contract. Each ticket costs a fixed price.
- **Lottery States:** The contract has three states: `ACTIVE`, `INACTIVE`, and `COMPLETED`.
- **Winner Selection:** Once all tickets are sold, the contract owner can announce the winner.
- **Prize Distribution:** 80% of the funds are sent to the winner, and 20% are sent to the owner.
- **Events:** The contract emits an event when the winner is announced.

## Contract Details

### Contract: `Lottery`

- **State Variables:**
  - `address public admin` - The address of the contract owner.
  - `uint public totalTickets` - Maximum number of tickets available.
  - `uint public pricePerTicket` - Price per ticket in wei.
  - `uint public ticketsSold` - Number of tickets sold.
  - `address[] public participants` - List of participants in the lottery.
  - `State public lotteryState` - Current state of the lottery.

- **Constructor:**
  ```solidity
  constructor(uint _totalTickets, uint _pricePerTicket)
