// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReverseAuction {
    struct Bid {
        address bidder;
        uint256 amount;
    }

    address public owner;
    uint256 public maxBidAmount;
    uint256 public numWinners;
    Bid[] public bids;
    bool public auctionEnded;

    constructor(uint256 _numWinners, uint256 _maxBidAmount) {
        require(_numWinners > 0, "Number of winners must be greater than 0");
        require(_maxBidAmount > 0, "Max bid amount must be greater than 0");

        owner = msg.sender;
        numWinners = _numWinners;
        maxBidAmount = _maxBidAmount;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function placeBid() external payable {
        require(!auctionEnded, "Auction has ended");
        require(msg.value <= maxBidAmount, "Bid exceeds max amount");

        bids.push(Bid(msg.sender, msg.value));
    }

    function endAuction() external onlyOwner {
        require(!auctionEnded, "Auction already ended");
        auctionEnded = true;

        sortBids();

        uint256 totalWinners = numWinners > bids.length ? bids.length : numWinners;
        uint256 rewardAmount = bids[totalWinners - 1].amount;

        for (uint256 i = 0; i < totalWinners; i++) {
            payable(bids[i].bidder).transfer(rewardAmount);
        }

        payable(owner).transfer(address(this).balance);
    }

    function sortBids() internal {
        uint256 len = bids.length;
        for (uint256 i = 0; i < len; i++) {
            for (uint256 j = i + 1; j < len; j++) {
                if (bids[j].amount < bids[i].amount) {
                    Bid memory temp = bids[i];
                    bids[i] = bids[j];
                    bids[j] = temp;
                }
            }
        }
    }
}
