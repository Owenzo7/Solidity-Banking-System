# Project Description 🗓

The Solidity bank application is a decentralized financial platform developed on the Ethereum blockchain using the Solidity programming language. Users can monitor account balances, deposit Ethereum (ETH) into their personal bank accounts, and withdraw ETH. 

Interactions occur through a smart contract on the Ethereum blockchain. Deposits and withdrawals are initiated through transactions, with the smart contract ensuring account balance updates based on the specified amounts. The decentralized nature ensures security and transparency, with all transactions recorded on the Ethereum blockchain for a tamper-resistant and auditable history. 

## Roles 💵

1. **BankTeller(i_BankTeller)** - Deployer of the protocol, this is a trusted admin that is responsible for tracking account balances, changing account balances and also removing bank accounts from the banking system.
2. **Definitely need a withdraw function (payable).** I need to make sure that he or she withdraws according to the amount that he or she has in his or her bank account through the use of the mapping.
3. **Definitely need a deposit function (payable).** Need to update the mapping each time a new user deposits Eth into his new account.
4. **It may need a payable or fallback function** just in case some client doesnt use the deposit function and probably sends the ether directly to the Contact address.
5. **I may need a mapping** to track the users address together with the amount of eth that he or she contains(bank accounts).

## Technology needed 💻
1. **Foundry** ----> For testing the contract.
2. **Solidity** ---> For builiding the whole funtionality.