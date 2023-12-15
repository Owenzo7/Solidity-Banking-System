// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Test, console} from "forge-std/Test.sol";

import {Bank} from "../../src/Bank.sol";
import {DeployBank} from "../../script/DeployBank.s.sol";
import {depositBank, withdrawBank, transferAmountBank} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    depositBank Depositbank;
    withdrawBank Withdrawbank;
    transferAmountBank Transferamountbank;
    DeployBank deploybank;
    Bank bank;
    address BOB = makeAddr("BOB");

    function setUp() external {
        deploybank = new DeployBank();
        bank = deploybank.run();

        // vm.deal(USER, STARTING_BALANCE);
    }

    function testUserBankInteractions() public {
        Depositbank = new depositBank();

        Depositbank.bankDeposit(address(bank));

        Withdrawbank = new withdrawBank();

        Withdrawbank.bankWithdraw(address(bank));

        Transferamountbank = new transferAmountBank();

        vm.expectRevert();
        Transferamountbank.bankTransferAmount(address(bank));
    }
}
