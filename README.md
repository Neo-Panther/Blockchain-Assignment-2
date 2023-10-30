# Blockchain Assignment 2

The `.deps` folder contains dependencies for this project, while the artifacts folder contains the build info, the compiled code and its metadata.
This Project contains two contracts in two solidity files inside `contracts` folder:

## CustomERC20

This contract extends the ERC20 implementation in the openzeppelin library for the purpose of this assignment.

### constructor and state variables
The ERC20 token is created with the name `XYZ Coin` and the symbol `XYZ`, this given initial amount `_supply` is minted only once in the contract (for a limited supply).
The deployer of the contract is saved as the `owner` of the contract. This is always the second contract - `XYZCompany`. A `Log` event is created to log all transfers of tokens (involved addresses and amount).

## XYZCompany

