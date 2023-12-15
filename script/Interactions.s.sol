// SPDX-License-Identifier: MIT

// Deposit
// Withdraw
// TransferTo

pragma solidity ^0.8.17;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Bank} from "../src/Bank.sol";

contract depositBank is Script {
    address USER = makeAddr("user");
    address BOB = makeAddr("bob");
    address ALICE = makeAddr("alice");
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant MINIMUM_VALUE = 0.0000002 ether;
    uint256 constant ZERO = 0;

    function bankDeposit(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        vm.prank(BOB);
        Bank(payable(mostRecentlyDeployed)).deposit(STARTING_BALANCE);
        vm.stopBroadcast();
        console.log("Bob Deposited %s", STARTING_BALANCE, "ether");
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "Bank",
            block.chainid
        );

        bankDeposit(mostRecentlyDeployed);
    }
}

contract withdrawBank is Script {}

contract transferAmount is Script {}
