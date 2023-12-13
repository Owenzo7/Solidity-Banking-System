# Project Description 🗓

The Solidity bank application is a decentralized financial solution built on the Ethereum blockchain using the Solidity programming language. This application allows users to track their account balances, deposit Ethereum (ETH) into their individual bank accounts, and withdraw ETH from those accounts.

Users can interact with the smart contract deployed on the Ethereum blockchain to view their current account balances. To deposit ETH, a user initiates a transaction, specifying the amount they wish to deposit. The smart contract processes the transaction and updates the user's account balance accordingly.

Similarly, users can request withdrawals by initiating a transaction, indicating the desired withdrawal amount. The smart contract verifies the availability of sufficient funds in the user's account before processing the withdrawal and updating the account balance.

The decentralized nature of this bank application ensures security and transparency, as all transactions are recorded on the Ethereum blockchain, providing a tamper-resistant and auditable history of account activities. Users maintain control over their funds through private keys, enhancing the security of their accounts.

## Points to Consider When Building the Bank Application 💵

1. **The Currency to be used by the Bank shall be definitely be in USD or British Pounds.** (Probably I have to use Chainlink priceFeeds).
2. **Definitely need a withdraw function (payable).** I need to make sure that he or she withdraws according to the amount that he or she has in his or her bank account through the use of the mapping.
3. **Definitely need a deposit function (payable).** Need to update the mapping each time a new user deposits USD or British Pounds into his new account.
4. **It may need a payable or fallback function** just in case some client doesnt use the deposit function and probably sends the ether directly to the Contact address.
5. **I may need a mapping** to track the users address together with the amount of eth that he or she contains(bank accounts).

## Technology needed 💻

1. **Chainlink Oracles** ---> For the PriceFeeds.
2. **Foundry** ----> For testing the contract.
3. **Solidity** ---> For builiding the whole funtionality.