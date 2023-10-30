// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../.deps/npm/@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Tokens after use assigned to this contract

contract XYZToken is ERC20 {
    address immutable public owner;
    event Log(address msgSender, address tokenOwner, address destinationAddress, uint256 amount);
    constructor(uint _supply) ERC20 ("XYZ Coin", "XYZ") {
        owner = msg.sender;
        _mint(owner, _supply);
    }
    event TokensFinished();

    function getRemainingTokens() public view returns(uint256){
        return balanceOf(owner);
    }

    function useTokens(address customerAddress, uint256 amount) external {
        require(msg.sender == owner, "Tokens can be transferred only after company's verificaton.");
        emit Log(msg.sender, customerAddress, address(this), amount);
        if (amount > 0){
            _transfer(customerAddress, address(this), amount);
        }
    }

    function issueTokens(address customerAddress, uint256 amount) external {
        require(msg.sender == owner, "Only the company can issue tokens");
        emit Log(msg.sender, owner, customerAddress, amount);
        uint256 remainingSupply = getRemainingTokens();
        if (amount > remainingSupply){
            if (remainingSupply > 0){
                _transfer(owner, customerAddress, remainingSupply);
            }
            emit TokensFinished();
        } else {
            _transfer(owner, customerAddress, amount);
        }
    }
}