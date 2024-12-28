# Reverse Auction

## Overview
A Solidity smart contract for a reverse auction.

## Features
- Bidders can place bids up to a maximum amount.
- The lowest bids win.

## How to Run
1. Install Truffle: `npm install -g truffle`.
2. Install Ganache: Download from [Ganache](https://trufflesuite.com/ganache/).
3. Compile and migrate the contract: `truffle migrate --reset --network development`.
4. Interact with the contract using Truffle console.

## Interacting with the Contract via Script or Frontend
1. Import Web3 and the contract's ABI:
   const Web3 = require("web3");
   const abi = require("./build/contracts/ReverseAuction.json").abi;

   const web3 = new Web3("http://127.0.0.1:7545");
   const contractAddress = "YOUR_CONTRACT_ADDRESS_HERE";
   const auction = new web3.eth.Contract(abi, contractAddress);

2. Place a Bid:
   await auction.methods.placeBid().send({
    from: "YOUR_ACCOUNT_ADDRESS",
    value: web3.utils.toWei("0.5", "ether"),
   });

3. End the Auction: 
   await auction.methods.endAuction().send({ from: "YOUR_ACCOUNT_ADDRESS" });

4. View Bids: 
   const bids = await auction.methods.getBids().call();
   console.log(bids);

## Example Input and Output
1. Input:
   numWinners: 2
   maxBidAmount: 1 ETH
   Bids: 
        Account 1: 0.5 ETH
        Account 2: 0.6 ETH
        Account 3: 0.8 ETH
2. Output
   Winning Bids: 0.5 ETH, 0.6 ETH
   Rewards Distributed: 0.6 ETH to each winner.
   Remaining funds returned to the creator.
