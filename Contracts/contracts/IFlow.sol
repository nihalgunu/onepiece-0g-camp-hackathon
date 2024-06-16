// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

interface IFlow {
    // Events
    event Submit(address indexed sender, bytes32 indexed digest, uint256 indexed index, uint256 startIndex, uint256 length, Submission submission);
    event NewEpoch(address indexed sender, uint256 indexed epoch, bytes32 indexed root, uint256 submissionIndex, uint256 currentLength, bytes32 contextDigest);

    // Structs
    struct Submission {
        bytes32[] nodes; // Array of nodes
        uint256[] heights; // Heights corresponding to nodes
        uint256 sectorCount; // Number of sectors
        uint256 epochNumber; // Epoch number
        bytes32 userHash; // User hash
        address workerAddress; // Address of worker
        uint256 age; // The size;
    }

    struct MineContext {
        uint256 epoch;
        uint256 mineStart;
        bytes32 flowRoot;
        uint256 flowLength;
        bytes32 blockDigest;
        bytes32 digest;
    }

    struct EpochRange {
        uint128 start;
        uint128 end;
    }

    struct EpochRangeWithContextDigest {
        uint128 start;
        uint128 end;
        bytes32 digest;
    }

    // Functions
    function batchSubmit(Submission[] memory submissions) external payable returns (uint256[] memory indexes, bytes32[] memory digests, uint256[] memory startIndexes, uint256[] memory lengths);

    function submit(Submission memory submission) external payable returns (uint256 index, bytes32 digest, uint256 startIndex, uint256 length);

    function makeContext() external;

    function getContext() external view returns (MineContext memory);

    function getEpochRange(bytes32 digest) external view returns (EpochRange memory);

    function numSubmissions() external view returns (uint256);
}
