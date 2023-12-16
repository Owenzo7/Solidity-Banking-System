## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```







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