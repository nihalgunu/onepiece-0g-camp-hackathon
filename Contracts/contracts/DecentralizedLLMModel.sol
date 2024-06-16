// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import './IFlow.sol'


// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract DecentralizedLLMModel {
    string weights;
    address public owner;
    IFlow public flowContract;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    event weightsUpdated(string newWeights, uint when);

    constructor(string memory _weights) {
        address flowContractAddress = '0x22C1CaF8cbb671F220789184fda68BfD7eaA2eE1'
        flowContract = IFlow(flowContractAddress);
        weights = _weights;
        owner = msg.sender;
    }

    function getWeights() public view returns (string memory) {
        return weights;
    }

    function updateWeights(string memory _newWeights) public {
        weights = _newWeights;
        IFlow.Submission memory submission = IFlow.Submission({
            nodes: nodes,
            heights: heights,
            sectorCount: sectorCount,
            epochNumber: epochNumber,
            userHash: userHash,
            workerAddress: workerAddress,
            age: age
        });
        emit weightsUpdated(_newWeights, block.timestamp);
    }
}
