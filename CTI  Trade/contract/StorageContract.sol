// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageContract {
    struct Data {
        bytes32 cid;
        string ctiMetadata;
        bytes32 checksum;
        string grouping;
        uint256 price;
        uint256 reputationRequirement;
    }

    mapping(uint256 => Data) private dataMap;
    uint256 private nextIndex;

    event DataAdded(
        uint256 indexed index,
        bytes32 cid,
        string ctiMetadata,
        bytes32 checksum,
        string grouping,
        uint256 price,
        uint256 reputationRequirement
    );

    function addData(
        bytes32 _cid,
        string memory _ctiMetadata,
        bytes32 _checksum,
        string memory _grouping,
        uint256 _price,
        uint256 _reputationRequirement
    ) public {
        dataMap[nextIndex] = Data(
            _cid,
            _ctiMetadata,
            _checksum,
            _grouping,
            _price,
            _reputationRequirement
        );

        emit DataAdded(
            nextIndex,
            _cid,
            _ctiMetadata,
            _checksum,
            _grouping,
            _price,
            _reputationRequirement
        );

        nextIndex++;
    }

    function searchDataByKeyword(string memory keyword)
        public
        view
        returns (string[] memory groupings, uint256[] memory prices, uint256[] memory reputationRequirements)
    {
        uint256 resultCount = 0;
        string[] memory matchingGroupings = new string[](nextIndex);
        uint256[] memory matchingPrices = new uint256[](nextIndex);
        uint256[] memory matchingReputationRequirements = new uint256[](nextIndex);

        for (uint256 i = 0; i < nextIndex; i++) {
            Data storage data = dataMap[i];
            if (
                bytes(data.ctiMetadata).length > 0 &&
                containsKeyword(data.ctiMetadata, keyword)
            ) {
                matchingGroupings[resultCount] = data.grouping;
                matchingPrices[resultCount] = data.price;
                matchingReputationRequirements[resultCount] = data.reputationRequirement;
                resultCount++;
            }
        }

        string[] memory resultsGroupings = new string[](resultCount);
        uint256[] memory resultsPrices = new uint256[](resultCount);
        uint256[] memory resultsReputationRequirements = new uint256[](resultCount);

        for (uint256 i = 0; i < resultCount; i++) {
            resultsGroupings[i] = matchingGroupings[i];
            resultsPrices[i] = matchingPrices[i];
            resultsReputationRequirements[i] = matchingReputationRequirements[i];
        }

        return (resultsGroupings, resultsPrices, resultsReputationRequirements);
    }

    function containsKeyword(string memory text, string memory keyword)
        internal
        pure
        returns (bool)
    {
        bytes memory textBytes = bytes(text);
        bytes memory keywordBytes = bytes(keyword);

        for (uint256 i = 0; i <= textBytes.length - keywordBytes.length; i++) {
            bool found = true;
            for (uint256 j = 0; j < keywordBytes.length; j++) {
                if (textBytes[i + j] != keywordBytes[j]) {
                    found = false;
                    break;
                }
            }
            if (found) {
                return true;
            }
        }

        return false;
    }
}
