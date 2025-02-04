// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting {
    // Define a struct to represent a candidate
    struct Candidate {
        string name;       // Name of the candidate
        uint256 voteCount; // Number of votes the candidate has received
    }

    // Mapping to store candidates by their ID
    mapping(uint256 => Candidate) public candidates;

    // Mapping to track whether an address has voted
    mapping(address => bool) public hasVoted;

    // Counter to keep track of the total number of candidates
    uint256 public candidateCount;

    // Address of the contract owner (deployer)
    address public owner;

    // Modifier to restrict access to the owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _; // Continue executing the function if the requirement is met
    }

    // Constructor to set the owner as the deployer of the contract
    constructor() {
        owner = msg.sender;
    }

    // Function to add a new candidate (only callable by the owner)
    function addCandidate(string memory name) public onlyOwner {
        // Add the candidate to the mapping with the current candidateCount as the ID
        candidates[candidateCount] = Candidate(name, 0);
        // Increment the candidate count
        candidateCount++;
    }

    // Function to vote for a candidate
    function vote(uint256 candidateId) public {
        // Ensure the voter hasn't already voted
        require(!hasVoted[msg.sender], "You have already voted");
        // Ensure the candidate ID is valid
        require(candidateId < candidateCount, "Invalid candidate");

        // Increment the vote count for the chosen candidate
        candidates[candidateId].voteCount++;
        // Mark the voter as having voted
        hasVoted[msg.sender] = true;
    }

    // Function to retrieve the voting results
    function getResults() public view returns (Candidate[] memory) {
        // Create a dynamic array to store the results
        Candidate[] memory results = new Candidate[](candidateCount);
        // Loop through all candidates and add them to the results array
        for (uint256 i = 0; i < candidateCount; i++) {
            results[i] = candidates[i];
        }
        // Return the results array
        return results;
    }
}
