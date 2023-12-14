// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

// Took me 290102 gas to deploy this contract
// Took me 376543 gas to deploy this contract
//  Took me 283029 gas to deploy this contract
// Took me 373753 gas to deploy this contract
contract Bank {
    address private immutable i_Bankteller;
    mapping(address client => uint256 AccountBalances) S_ClientToAccountBalances;
    uint256 constant MINIMUM_USD = 0.012 ether; //$25
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

    function deposit(uint256 amount) public payable {
        uint256 clientBalances = S_ClientToAccountBalances[msg.sender];

        if (amount < MINIMUM_USD || amount == 0) {
            revert Bank_NotEnoughFunds();
        }

        if (amount < 0) {
            revert Bank_BankDepositAmountisANegativeValue();
        }

        clientBalances += amount;
        S_ClientToAccountBalances[msg.sender] = clientBalances;
        s_bankclients.push(msg.sender);
    }

    function withdraw(uint256 amount) public payable {
        uint256 clientBalances = S_ClientToAccountBalances[msg.sender];
        // address bankAccounts = s_bankclients[index];

        bool accountExists = false;
        for (uint256 i = 0; i < s_bankclients.length; i++) {
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

        clientBalances -= amount;
        S_ClientToAccountBalances[msg.sender] = clientBalances;
    }

    function transferAmount(
        address clientAddress,
        uint256 amount,
        address payable ToreceiverAddress
    ) public payable {
        uint256 startingBalanceforClient = S_ClientToAccountBalances[
            clientAddress
        ];
        uint256 startingBalanceforreceiver = S_ClientToAccountBalances[
            ToreceiverAddress
        ];

        bool accountExists = false;
        for (uint256 i = 0; i < s_bankclients.length; i++) {
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

    receive() external payable {
        deposit(msg.value);
    }

    fallback() external payable {
        deposit(msg.value);
    }
}
