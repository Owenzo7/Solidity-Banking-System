// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Bank {
    address private immutable i_Bankteller;
    mapping(address client => uint256 AccountBalances) S_ClientToAccountBalances;
    uint256 constant MINIMUM_USD = 0.012 ether;
    address[] private s_bankclients;

    // Payable saves 200 on gas
    constructor() payable {
        msg.sender == i_Bankteller;
    }

    error Bank_NotEnoughFunds();
    error Bank_NotEnoughFundsToWithdraw();
    error Bank_NotEnoughFundsToTransfer();
    error Bank_TransferCallFail();
    error Bank_ZeroaddressFail();
    error Bank_AmountisBeloworEqualtoZero();
    error Bank_AmountforWithdrawalBelowOrEqualtozero();
    error Bank_TransferCalltoTheSameAddressFail();
    error Bank_BankAccountNotRegisteredWiththeBank();
    error Bank_BankDepositAmountisANegativeValue();
    error Bank_NottheBankTellerSoCantUpdateBalances();
    error Bank_NottheBankTellerSoyouCanRemoveBankersFromArray();

    function deposit(uint256 amount) public payable {
        uint256 clientBalances = S_ClientToAccountBalances[msg.sender];

        if (amount < MINIMUM_USD || amount == 0) {
            revert Bank_NotEnoughFunds();
        }

        if (amount < 0) {
            revert Bank_BankDepositAmountisANegativeValue();
        }

        // Updates
        clientBalances += amount;
        S_ClientToAccountBalances[msg.sender] = clientBalances;
        // Once a customer deposits amount they get registered in the system(s_bankclients array)
        s_bankclients.push(msg.sender);
    }

    function withdraw(uint256 amount) public payable {
        uint256 clientBalances = S_ClientToAccountBalances[msg.sender];

        // Before withdrawal, it checks to see whether the account is in the system(s_bankclients array) or not
        bool accountExists = false;
        uint256 BankClients = s_bankclients.length;
        for (uint256 i; i < BankClients; i++) {
            if (s_bankclients[i] == msg.sender) {
                accountExists = true;
                break;
            }
        }

        if (!accountExists) {
            revert Bank_BankAccountNotRegisteredWiththeBank();
        }

        if (clientBalances < amount) {
            revert Bank_NotEnoughFundsToWithdraw();
        }

        if (amount <= 0) {
            revert Bank_AmountforWithdrawalBelowOrEqualtozero();
        }

        // Updates
        clientBalances -= amount;
        S_ClientToAccountBalances[msg.sender] = clientBalances;
    }

    function transferAmount(
        address payable clientAddress,
        uint256 amount,
        address payable ToreceiverAddress
    ) public payable {
        uint256 startingBalanceforClient = S_ClientToAccountBalances[
            clientAddress
        ];
        uint256 startingBalanceforreceiver = S_ClientToAccountBalances[
            ToreceiverAddress
        ];

        // Checks to see if both the receiver and the client address are in the system(s_bankclients array)
        bool accountExists = false;
        uint256 BankClients = s_bankclients.length;
        for (uint256 i; i < BankClients; i++) {
            if (s_bankclients[i] == msg.sender) {
                accountExists = true;
                break;
            }
        }

        if (!accountExists) {
            revert Bank_BankAccountNotRegisteredWiththeBank();
        }

        if (address(clientAddress).balance < amount) {
            revert Bank_NotEnoughFundsToTransfer();
        }

        if (clientAddress == ToreceiverAddress) {
            revert Bank_TransferCalltoTheSameAddressFail();
        }

        if (clientAddress == address(0)) {
            revert Bank_ZeroaddressFail();
        }

        if (ToreceiverAddress == address(0)) {
            revert Bank_ZeroaddressFail();
        }

        if (amount <= 0) {
            revert Bank_AmountisBeloworEqualtoZero();
        }

        (bool callSuccess, ) = payable(ToreceiverAddress).call{value: amount}(
            ""
        );

        if (!callSuccess) {
            revert Bank_TransferCallFail();
        }

        // Updates
        startingBalanceforClient -= amount;
        startingBalanceforreceiver += amount;

        S_ClientToAccountBalances[clientAddress] = startingBalanceforClient;
        S_ClientToAccountBalances[
            ToreceiverAddress
        ] = startingBalanceforreceiver;
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
        return i_Bankteller;
    }

    //  ------------------------------------------------------------------------------------->

    //  ! Bank teller privileges
    function changeAccountBalances(
        address client,
        uint256 amount
    ) external returns (uint256) {
        if (msg.sender != i_Bankteller) {
            revert Bank_NottheBankTellerSoCantUpdateBalances();
        }

        return S_ClientToAccountBalances[client] = amount;
    }

    function removeBankersFromArray(uint256 index) external {
        if (msg.sender != i_Bankteller) {
            revert Bank_NottheBankTellerSoyouCanRemoveBankersFromArray();
        }
        delete s_bankclients[index];
    }

    receive() external payable {
        deposit(msg.value);
    }

    fallback() external payable {
        deposit(msg.value);
    }
}
