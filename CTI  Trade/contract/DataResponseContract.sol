// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataRequestContract {
    address public dataProvider;
    bool public responseReceived;

    event DataRequest(address indexed dataProvider);
    event DataResponseAccepted(bytes32 indexed responseDataCID, bytes32 indexed responseHash);
    event DataResponseRejected();

    constructor(address _dataProvider) {
        dataProvider = _dataProvider;
        responseReceived = false;
    }

    function sendRequest() public {
        // 在此处发送请求给数据提供者（可以在这个函数中调用另一个合同的接口或方法）
        emit DataRequest(dataProvider);
    }

    function receiveResponse(bytes32 responseDataCID, bytes32 responseHash) public {
        require(msg.sender == dataProvider, "Only the associated DataProvider can send responses");
        require(!responseReceived, "Response has already been received");

        responseReceived = true;
        emit DataResponseAccepted(responseDataCID, responseHash);
    }

    function rejectResponse() public {
        require(msg.sender == dataProvider, "Only the associated DataProvider can reject responses");
        require(!responseReceived, "Response has already been received");

        responseReceived = true;
        emit DataResponseRejected();
    }
}
