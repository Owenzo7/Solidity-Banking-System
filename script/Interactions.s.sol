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
    uint256 constant MINIMUM_VALUE = 0.0002 ether;
    uint256 constant WITHDRAWAL_AMOUNT = 4 ether;

    uint256 constant ZERO = 0;

    function bankDeposit(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        Bank(payable(mostRecentlyDeployed)).deposit(STARTING_BALANCE);
        vm.stopBroadcast();
        console.log("BOB Deposited %s", STARTING_BALANCE, "ether");
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "Bank",
            block.chainid
        );
        vm.startBroadcast();
        bankDeposit(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

contract withdrawBank is Script {
    address USER = makeAddr("user");
    address BOB = makeAddr("bob");
    address ALICE = makeAddr("alice");
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant MINIMUM_VALUE = 0.0002 ether;
    uint256 constant WITHDRAWAL_AMOUNT = 4 ether;

    uint256 constant ZERO = 0;

    function bankWithdraw(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        Bank(payable(mostRecentlyDeployed)).withdraw(WITHDRAWAL_AMOUNT);
        vm.stopBroadcast();
        console.log("BOB withdrew %s", WITHDRAWAL_AMOUNT, "ether");
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "Bank",
            block.chainid
        );
        vm.startBroadcast();
        bankWithdraw(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}

// contract transferAmount is Script {}
