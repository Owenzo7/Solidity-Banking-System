-include .env

build:; forge build

deploy anvil-localchain:
	forge script script/DeployBank.s.sol

deploy anvil-chain:
	forge script script/DeployBank.s.sol --rpc-url $(ANVIL_RPC_URL) --broadcast --private-key $(ANVIL_PRIVATE_KEY)

deploy sepolia-chain:
	forge script script/DeployBank.s.sol:DeployBank --rpc-url $(SEPOLIA_RPC_URL) --broadcast --private-key $(SEPOLIA_PRIVATE_KEY)

