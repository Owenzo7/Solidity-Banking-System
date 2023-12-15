// SPDX-License-Identifier: MIT

// Deposit
// Withdraw
// TransferTo

pragma solidity ^0.8.17;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Bank} from "../src/Bank.sol";

contract depositBank is Script {
    uint256 constant STARTING_BALANCE = 10 ether;

    uint256 constant WITHDRAWAL_AMOUNT = 4 ether;

    function bankDeposit(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        Bank(payable(mostRecentlyDeployed)).deposit(STARTING_BALANCE);
        vm.stopBroadcast();
        console.log("User Deposited %s", STARTING_BALANCE, "ether");
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
    uint256 constant STARTING_BALANCE = 10 ether;

    uint256 constant WITHDRAWAL_AMOUNT = 4 ether;

    function bankWithdraw(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        Bank(payable(mostRecentlyDeployed)).withdraw(WITHDRAWAL_AMOUNT);
        vm.stopBroadcast();
        console.log("User withdrew %s", WITHDRAWAL_AMOUNT, "ether");
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

contract transferAmountBank is Script {
    uint256 constant STARTING_BALANCE = 10 ether;
    address BOB = makeAddr("Bob");
    address ALICE = makeAddr(" Alice");
    uint256 constant AMOUNT_TO_BE_TRANSFERRED = 4 ether;

    function bankTransferAmount(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        Bank(payable(mostRecentlyDeployed)).transferAmount(
            payable(BOB),
            AMOUNT_TO_BE_TRANSFERRED,
            payable(ALICE)
        );
        vm.stopBroadcast();
        console.log(
            "Bob has transferred %s",
            AMOUNT_TO_BE_TRANSFERRED,
            "ether to Alice"
        );
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "Bank",
            block.chainid
        );
        vm.startBroadcast();
        bankTransferAmount(mostRecentlyDeployed);
        vm.stopBroadcast();
    }
}
