// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Bank {
    address private immutable i_owner;
    mapping(address client => uint256 AccountBalances) S_ClientToAccountBalances;
    uint256 constant MINIMUM_USD = 0.012 ether;
    address[] private s_bankclients;

    constructor() {
        msg.sender == i_owner;
    }

    error Bank_NotEnoughFunds();
    error Bank_NotEnoughFundsToWithdraw();

    function deposit() public payable {
        if (msg.value < MINIMUM_USD) {
            revert Bank_NotEnoughFunds();
        }

        S_ClientToAccountBalances[msg.sender] += msg.value;
        s_bankclients.push(msg.sender);
    }

    function withdraw(uint256 amount) public payable {
        if (S_ClientToAccountBalances[msg.sender] < amount) {
            revert Bank_NotEnoughFundsToWithdraw();
        }

        S_ClientToAccountBalances[msg.sender] -= amount;
    }

    // View and getter functions

    function getClientToAccountBalances(
        address BankAdress
    ) external view returns (uint256) {
        return S_ClientToAccountBalances[BankAdress];
    }

    function getBankClient(uint256 index) external view returns (address) {
        return s_bankclients[index];
    }

    function getOwner() external view returns (address) {
        return i_owner;
    }

    receive() external payable {
        deposit();
    }

    fallback() external payable {
        deposit();
    }
}
