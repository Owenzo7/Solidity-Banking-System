// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {Script} from "forge-std/Script.sol";
import {Bank} from "../src/Bank.sol";

contract DeployBank is Script {
    Bank bank;

    function run() public returns (Bank) {
        vm.startBroadcast();
        bank = new Bank();
        vm.stopBroadcast();
        return bank;
    }
}
