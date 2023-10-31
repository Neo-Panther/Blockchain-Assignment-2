// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./CustomERC20.sol";

// Tokens initially assigned to this contract
// The address of this contract is the owner

contract XYZCompany {
    XYZToken immutable private token;
    uint256 constant INITIAL_SUPPLY = 1000;
    event Logger(uint256 prevTokens, uint256 addedTokens, uint256 spentTokens);
    constructor() {
        token = new XYZToken(INITIAL_SUPPLY);
    }

    function validatePurchase(uint256 total) private pure returns(bool){
        // The company checks the validity of transaction
        return total > 0;
    }

    function completePurchase(uint256 totalBeforeDiscount, bool availDiscount) public returns(uint256 discount){
        require(totalBeforeDiscount > 0, "Total should be greater than 0");
        require(validatePurchase(totalBeforeDiscount), "Invalid Purchase");
        address customerAddress = msg.sender;
        uint256 prevTokens = token.balanceOf(msg.sender);
        uint256 newTokens = totalBeforeDiscount / 500;
        uint256 spentTokens = 0;
        if (!availDiscount || prevTokens < 5){
            discount = 0;
        } else if(10 > prevTokens &&  prevTokens >= 5) {
            discount = 5;
            spentTokens = 5;
        } else if(20 > prevTokens && prevTokens >= 10){
            discount = 10;
            spentTokens = 10;
        } else if(30 > prevTokens && prevTokens >= 20){
            discount = 20;
            spentTokens = 20;
        } else if(40 > prevTokens && prevTokens >= 30){
            discount = 35;
            spentTokens = 30;
        } else {
            discount = 50;
            spentTokens = 40;
        }
        emit Logger(prevTokens, newTokens, spentTokens);
        token.useTokens(customerAddress, spentTokens);
        token.issueTokens(customerAddress, newTokens);
    }

    function getRemainingTokens() public view returns(uint256) {
        return token.getRemainingTokens();
    }

    function getRemainingTokensWithAddress(address addr) public view returns(uint256) {
        return token.balanceOf(addr);
    }
}