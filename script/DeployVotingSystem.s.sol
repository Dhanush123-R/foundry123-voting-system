// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {VotingSystem} from "../src/VotingSystem.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast(); // Start sending transactions

        VotingSystem votingSystem = new VotingSystem();

        vm.stopBroadcast(); // Stop sending transactions
    }
}
