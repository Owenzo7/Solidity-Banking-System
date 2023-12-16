# Project Description 🗓

The Solidity bank application is a decentralized financial platform developed on the Ethereum blockchain using the Solidity programming language. Users can monitor account balances, deposit Ethereum (ETH) into their personal bank accounts, and withdraw ETH. 

Interactions occur through a smart contract on the Ethereum blockchain. Deposits and withdrawals are initiated through transactions, with the smart contract ensuring account balance updates based on the specified amounts. The decentralized nature ensures security and transparency, with all transactions recorded on the Ethereum blockchain for a tamper-resistant and auditable history. 



## Compatibilities

1. Solc version ^0.8.17
2. Chain(s) to deploy contract to:
    (a). Sepolia
3. Tokens ---> None

## Roles 

1. **BankTeller(i_BankTeller)** - Deployer of the protocol, this is a trusted admin that is responsible for tracking account balances, changing account balances and also removing bank accounts from the banking system.
2. **S_ClientToAccountBalances &&  s_bankclients** - The **S_ClientToAccountBalances mapping** ---> Used to track the clients balances && **s_bankclients address array** ---> This is used to track the account addresses that are registered withing the banking systeme.


## Technology needed 💻
1. **Foundry** ----> For testing the contract.
2. **Solidity** ---> For builiding the whole funtionality.