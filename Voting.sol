
---

### **Example Solidity Contract (`contracts/Voting.sol`)**  
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    uint256 public candidateCount;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string memory name) public onlyOwner {
        candidates[candidateCount] = Candidate(name, 0);
        candidateCount++;
    }

    function vote(uint256 candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateId < candidateCount, "Invalid candidate");

        candidates[candidateId].voteCount++;
        hasVoted[msg.sender] = true;
    }

    function getResults() public view returns (Candidate[] memory) {
        Candidate[] memory results = new Candidate[](candidateCount);
        for (uint256 i = 0; i < candidateCount; i++) {
            results[i] = candidates[i];
        }
        return results;
    }
}
