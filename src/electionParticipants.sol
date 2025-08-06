//SPDX-License-Identifier : UNLICENSED

pragma solidity ^0.8.30;

contract ElectionParticipants {
    struct participantDetails {
        uint participantID;
        string partyName;
        string candidateName;
        address participantAddress;
    }

    uint public nextparticipantID = 1;

    address[] public participantList;

    mapping(address => participantDetails) public participantDetailsMapping;
    mapping(string => bool) public partyExists;

    function registerParticipant(
        string memory _partyName,
        string memory _candidateName,
        address _participantAddress
    ) public {
        require(!partyExists[_partyName], "Party Already Exists");
        partyExists[_partyName] = true;

        require(
            participantDetailsMapping[_participantAddress].participantID == 0,
            "Participant Already Registered"
        );
        participantDetailsMapping[_participantAddress] = participantDetails({
            participantID: nextparticipantID,
            partyName: _partyName,
            candidateName: _candidateName,
            participantAddress: _participantAddress
        });

        nextparticipantID++;
        participantList.push(_participantAddress);
    }
}
