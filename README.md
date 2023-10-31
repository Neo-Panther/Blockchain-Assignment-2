# Blockchain Assignment 2

Here, we offer an overview of all the features implemented within the blockchain. 
The `.deps` folder contains dependencies for this project, while the artifacts folder contains the build info, the compiled code and its metadata.
This Project contains two contracts in two solidity files inside `contracts` folder:

## Deploying the Contracts
To deploy and interact with the project, deploy the XYZCompany contract with the owner's (company's) address. Now this contract can be accessed with any address to call one of its functions (mentioned ahead).

## CustomERC20.sol (XYZToken)

> `contract XYZToken is ERC20`

This contract extends the ERC20 implementation in the openzeppelin library for the purpose of this assignment. This contract is not supposed to be deployed directly.

### constructor and state variables
The ERC20 token is created with the name `XYZ Coin` and the symbol `XYZ`, this given initial amount `_supply` is minted only once in the contract (for a limited supply).
The deployer of the contract is saved as the `owner` of the contract. This is always the second contract - `XYZCompany`. A `TokensFinished` event is emitted on every `issueTokens` transaction if the tokens are finished.

### getRemainingBalance
> `function getRemainingTokens() public view returns(uint256)`

returns the number of tokens remiaining to be issued (these are kept in the owner's account until issued)

### useTokens
> `function useTokens(address customerAddress, uint256 amount) external`

uses up the given amount of tokens of customerAddress. Only the owner is allowed to call this transaction. Customer address is checked for insufficient tokens.

### issueTokens
> `function issueTokens(address customerAddress, uint256 amount) external`

issues tokens to the specified address if enough remain, else emits `TokensFinished` event. Only the owner is allowed to call this transaction.

## XYZCompany.sol

> `contract XYZCompany`

This contract contains the bussiness logic while also acting as a frontend for accessing the features of the blockchain. This contract is supposed to be deployed directly.

### constructor and state variables
`token` represents XYZToken contract, created with the specified `INITIAL_SUPPLY`. `owner` representes the company (the address which deployed this contract). `registeredCustomers` stores the address and name (nickname or username) of the customers registered for this scheme. The `owner` is considered a registered customer with the name owner.
`Logger` event is created to log the flow of tokens in every transaction. `TransactionConfirmed` event is emitted on the the confirmation of a purchase by the owner (containing the address of the customer and the discount achieved). `TransactionRejected` event is emitted on the rejection of a purchase by the owner (containing the concerned customer's address).
`Purchase` struct represents a purchase started by *customerAddress*, with a total of *totalBeforeDiscount* and the customer's wish to use their tokens in *availDiscount*. `pendingPurchases` stores the purchases started by a registered customer, but not yet confirmed/rejected by the company.

### startPurchase
> `function startPurchase(uint256 totalBeforeDiscount, bool availDiscount) external`

a registered customer starts a purchase giving their pre-discount total and wish to avail the discount (use their tokens) as input.

### registerNewCustomer
> `function registerNewCustomer(address customerAddress, string memory name) external`

The owner registers a new customer with the address customerAddress and a non-empty name.

### confirmPurchase
> `function confirmPurchase(uint256 index) public returns(uint256 discount)`

The owner confirms a purchase from the list of `pendingPurchases` giving its index. Using a decision tree logic appropriate discount is returned, new tokens are added and required tokens are used. After execution, the purchase is removed from `pendingPurchases`.

### rejectPurchase
> `function rejectPurchase(uint256 index) public`

The owner rejects a purchase, it is deleted from `pendingPurchases`.

### getRemainingTokens
> `function getRemainingTokens() public view returns(uint256)`

returns the number of tokens remaining to be issued in the system

### getRemainingTokensWithAddress
> `function getRemainingTokensWithAddress(address addr) public view returns(uint256)`

given an address, returns the number of tokens currently assigned to that address.

## Group Information (Name and ID)

1. Aryan Gupta: 2021A7PS0162H
2. Anmol Agarwal: 2021A7PS0136H
3. Ayush Nautiyal: 2021A7PS2607H
4. Mihir Kulkarni: 2021A7PS2689H
5. Aditya Aggarwal: 2021A7PS2380H
