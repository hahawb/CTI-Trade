// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReputationSystem {
    address public consumer;

    struct Review {
        uint8 DQ; // Data Quality
        uint8 OT; // On-Time Delivery
        uint8 DS; // Data Security
        uint8 DI; // Data Integrity
        string comments;
    }

    mapping(address => Review) public userReviews;

    constructor(address _consumer) {
        consumer = _consumer;
    }

    modifier onlyConsumer() {
        require(msg.sender == consumer, "Only the consumer can perform this action.");
        _;
    }

    function uploadReview(uint8 DQ, uint8 OT, uint8 DS, uint8 DI, string memory comments) public onlyConsumer {
        require(DQ >= 0 && DQ <= 10, "DQ score must be between 0 and 10.");
        require(OT >= 0 && OT <= 10, "OT score must be between 0 and 10.");
        require(DS >= 0 && DS <= 10, "DS score must be between 0 and 10.");
        require(DI >= 0 && DI <= 10, "DI score must be between 0 and 10.");

        userReviews[msg.sender] = Review(DQ, OT, DS, DI, comments);
    }

    function getReview() public view returns (uint8 DQ, uint8 OT, uint8 DS, uint8 DI, string memory comments) {
        Review memory review = userReviews[msg.sender];
        return (review.DQ, review.OT, review.DS, review.DI, review.comments);
    }
}
