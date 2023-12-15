// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Test, console} from "forge-std/Test.sol";

import {Bank} from "../../src/Bank.sol";
import {DeployBank} from "../../script/DeployBank.s.sol";
import {depositBank, withdrawBank} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    depositBank Depositbank;
    withdrawBank Withdrawbank;
    DeployBank deploybank;
    Bank bank;
    address USER = makeAddr("user");
    address BOB = makeAddr("bob");
    address ALICE = makeAddr("alice");
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant MINIMUM_VALUE = 0.0000002 ether;
    uint256 constant ZERO = 0;
    int256 negativeEther = -2 ether;

    function setUp() external {
        deploybank = new DeployBank();
        bank = deploybank.run();

        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanDepositInteractions() public {
        Depositbank = new depositBank();

        Depositbank.bankDeposit(address(bank));

        Withdrawbank = new withdrawBank();

        Withdrawbank.bankWithdraw(address(bank));
    }
}
