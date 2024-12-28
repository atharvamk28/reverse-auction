const ReverseAuction = artifacts.require("ReverseAuction");

module.exports = function (deployer) {
    const numWinners = 3; // Number of winners
    const maxBidAmount = web3.utils.toWei("1", "ether"); // Maximum bid amount
    deployer.deploy(ReverseAuction, numWinners, maxBidAmount);
};
