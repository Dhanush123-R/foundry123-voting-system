//SPDX-License-Identifier : UNLICENSED

pragma solidity ^0.8.30;

contract Voter {
    struct votePersonDetails {
        uint voterPersonID;
        uint voteDate;
        bool hasVoted;
    }

    uint public nextvoterPersonID = 1;

    mapping(address => votePersonDetails) public voterDetails;
    mapping(uint => address) public idToAddress;
    mapping(uint => bool) public whiteListedID;

    function registerVoter(address _voterAddress, uint _voteDate) public {
        require(
            voterDetails[_voterAddress].voterPersonID == 0,
            "Voter already Participated"
        );
        require(
            idToAddress[nextvoterPersonID] == address(0),
            "This VoterID Already Registered"
        );
        require(
            whiteListedID[nextvoterPersonID],
            "This ID is not Approved for Voting"
        );

        voterDetails[_voterAddress] = votePersonDetails({
            voterPersonID: nextvoterPersonID,
            voteDate: _voteDate,
            hasVoted: false
        });

        idToAddress[nextvoterPersonID] = _voterAddress;
        nextvoterPersonID++;
    }

    function markVoted(address _voterAddress) public {
        require(!voterDetails[_voterAddress].hasVoted, "Already Voted");
        voterDetails[_voterAddress].hasVoted = true;
    }

    function whiteListID(uint _voterPersonID) public {
        require(!whiteListedID[_voterPersonID], "ID Already WhiteListed");
        whiteListedID[_voterPersonID] = true;
    }
}
