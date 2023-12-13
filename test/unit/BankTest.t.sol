// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Test} from "forge-std/Test.sol";

import {Bank} from "../../src/Bank.sol";

contract BankTest is Test {
    Bank bank;
    address USER = makeAddr("user");
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() public returns (Bank) {
        bank = new Bank();

        vm.deal(USER, STARTING_BALANCE);
        return bank;
    }

    function testAddressUserBalance() public view {
        assert(address(USER).balance == STARTING_BALANCE);
    }
}
