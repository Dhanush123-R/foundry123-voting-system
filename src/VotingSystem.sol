//SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

import "./Voter.sol";
import "./electionParticipants.sol";

contract VotingSystem is Voter, ElectionParticipants {
    address public head;
    bool public electionStarted;
    bool public electionEnded;
    uint public totalVotes;

    mapping(address => uint) public voteCount; //Mapping to count the Votes

    constructor() {
        head = msg.sender;
    }

    modifier onlyHead() {
        require(msg.sender == head, "Only the Head can call this function");
        _;
    }

    function startElection() public onlyHead {
        require(!electionStarted, "Election already Started");
        electionStarted = true;
        electionEnded = false;
    }

    function endElection() public onlyHead {
        require(electionStarted, "Election has not Started yet");
        require(!electionEnded, "Election already Ended");
        electionStarted = false;
        electionEnded = true;
    }

    function vote(address _participantAddress) public {
        require(electionStarted, "Election has not Started yet");
        require(!electionEnded, "Election has already Ended");
        require(
            voterDetails[msg.sender].voterPersonID != 0,
            "You're not Registered Voter"
        );
        require(!voterDetails[msg.sender].hasVoted, "You have already voted");
        require(
            participantDetailsMapping[_participantAddress].participantID != 0,
            "Invalid Party"
        );
        voteCount[_participantAddress]++;
        markVoted(msg.sender);
        totalVotes++;
    }

    function getVoteCount(
        address _participantAddress
    ) public view returns (uint) {
        return voteCount[_participantAddress];
    }

    function getAllResults()
        public
        view
        returns (address[] memory, uint[] memory)
    {
        uint[] memory counts = new uint[](participantList.length);
        for (uint i = 0; i < participantList.length; i++) {
            counts[i] = voteCount[participantList[i]];
        }
        return (participantList, counts);
    }
}
