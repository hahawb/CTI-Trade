// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataTransaction {
    address public dataProvider;
    address public dataConsumer;
    uint256 public dataPrice;
    uint256 public securityDeposit;
    uint256 public transactionHash;
    bool public dataReceived;
    
    uint256 public reputationProvider;
    uint256 public reputationConsumer;

    constructor(address provider, address consumer, uint256 price, uint256 deposit, uint256 hash, uint256 initialReputationProvider, uint256 initialReputationConsumer) {
        dataProvider = provider;
        dataConsumer = consumer;
        dataPrice = price;
        securityDeposit = deposit;
        transactionHash = hash;
        reputationProvider = initialReputationProvider;
        reputationConsumer = initialReputationConsumer;
    }

    modifier onlyDataProvider() {
        require(msg.sender == dataProvider, "Only the data provider can perform this action.");
        _;
    }

    modifier onlyDataConsumer() {
        require(msg.sender == dataConsumer, "Only the data consumer can perform this action.");
        _;
    }

    function receiveData(uint256 receivedHash) public onlyDataConsumer {
        require(receivedHash == transactionHash, "Data integrity check failed.");
        dataReceived = true;
    }

    function lockFunds() public onlyDataConsumer payable {
        require(msg.value == dataPrice + securityDeposit, "Incorrect amount sent.");
    }

    function refundDeposit() public onlyDataProvider {
        require(dataReceived, "Data has not been received yet.");
        payable(dataProvider).transfer(securityDeposit);
        securityDeposit = 0;
    }

    function releasePayment() public onlyDataProvider {
        require(dataReceived, "Data has not been received yet.");
        payable(dataProvider).transfer(dataPrice);
        dataPrice = 0;
    }
}
