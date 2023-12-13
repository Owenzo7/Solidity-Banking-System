// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Test, console} from "forge-std/Test.sol";

import {Bank} from "../../src/Bank.sol";

contract BankTest is Test {
    Bank bank;
    address USER = makeAddr("user");
    address BOB = makeAddr("bob");
    address ALICE = makeAddr("alice");
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant MINIMUM_VALUE = 0.0000002 ether;
    uint256 constant ZERO = 0;

    function setUp() public returns (Bank) {
        bank = new Bank();

        vm.deal(USER, STARTING_BALANCE);
        return bank;
    }

    function testAddressUserBalance() public view {
        assert(address(USER).balance == STARTING_BALANCE);
    }

    // ! test FailDepositSection

    function testRevertdepositandCheckAccountBalance() public {
        hoax(BOB, MINIMUM_VALUE);
        vm.expectRevert();
        bank.deposit(MINIMUM_VALUE);
    }

    function testRevertdepositwithjustZero() public {
        hoax(BOB, ZERO);
        vm.expectRevert();
        bank.deposit(ZERO);
    }

    // ------------------------------------------------------------------------->

    //  !  test Fail withdrawal Section

    function testRevertWithdrawOnlyWithZero() public {
        vm.prank(USER);
        console.log("================================");
        uint256 userStartingBalance = address(USER).balance;
        console.log("%s", userStartingBalance);
        bank.deposit(STARTING_BALANCE);
        console.log("================================");
        uint256 userEndingBalanceAfterDeposit = address(USER).balance;
        console.log("%s", userEndingBalanceAfterDeposit);

        console.log("================================");
        vm.expectRevert();
        bank.withdraw(0 ether);
    }

    function testRevertWithdraw() public {
        vm.prank(USER);
        console.log("================================");
        uint256 userStartingBalance = address(USER).balance;
        console.log("%s", userStartingBalance);
        bank.deposit(STARTING_BALANCE);
        console.log("================================");
        uint256 userEndingBalanceAfterDeposit = address(USER).balance;
        console.log("%s", userEndingBalanceAfterDeposit);

        console.log("================================");
        vm.expectRevert();
        bank.withdraw(11 ether);

        uint256 userEndingBalanceAfterWithdrawal = address(USER).balance;
        console.log("%s", userEndingBalanceAfterWithdrawal);
    }

    function testRevertWithdrawFundsWithoutMakingAbankAccount() public {
        vm.expectRevert();
        bank.withdraw(11 ether);
    }

    // ------------------------------------------------------------------------------->

    // ! test transferFail section

    function testReverttransferofFundsToAZeroAddress() public {
        vm.prank(USER);
        bank.deposit(STARTING_BALANCE);

        assert(address(USER).balance == 10 ether);

        vm.expectRevert();
        bank.transferAmount(USER, 4 ether, payable(address(0)));
    }

    function testReverttransferofFundstheFromAddressBalanceisLessthanAmounttoBeSent()
        public
    {
        vm.prank(USER);
        bank.deposit(STARTING_BALANCE);

        assert(address(USER).balance == 10 ether);

        vm.expectRevert();
        bank.transferAmount(USER, 11 ether, payable(address(0)));
    }

    function testReverttransferOfFundstoAddressUsingZeroEther() public {
        vm.prank(USER);
        bank.deposit(STARTING_BALANCE);

        assert(address(USER).balance == 10 ether);

        vm.expectRevert();
        bank.transferAmount(USER, 0 ether, payable(ALICE));
    }

    function testReverttransferofFundsTotheSameAdressFail() public {
        vm.prank(USER);
        bank.deposit(STARTING_BALANCE);

        assert(address(USER).balance == 10 ether);

        vm.expectRevert();
        bank.transferAmount(USER, 6 ether, payable(USER));
    }

    //  ------------------------------------------------------------------------------------------>

    // * test pass Deposit section

    // function testUserhasDepositedInthebank() public {}
}
