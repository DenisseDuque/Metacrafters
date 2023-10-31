// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Custom ERC20 token contract that inherits from the OpenZeppelin ERC20 base contract.
contract ERC20Contract is ERC20 {
    address public owner; // Public variable to store the contract owner's address.
    address public user; // Public variable to store the user's address.

    // Constructor to initialize the token with a name, abbreviation, and initial supply.
    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        uint256 initialSupply
    ) ERC20(tokenName, tokenSymbol) {
        // Enxures that token name and symbol are not empty.
        require(bytes(tokenName).length > 0, "Token name cannot be empty");
        require(bytes(tokenSymbol).length > 0, "Token symbol cannot be empty");
        _mint(msg.sender, initialSupply);
        owner = msg.sender; // Set the owner to the contract creator (msg.sender).
    }

    // Function to mint tokens and assign them a specified address.
    function mintTokens(address account, uint256 amount) public {
        // Ensures that the provided address is valid and the amount is greater than zero.
        require(account != address(0), "ERROR: Invalid Address");
        require(amount > 0, "ERROR: Amount should be greater than 0");
        require(msg.sender == owner, "ERROR: Only the owner can mint tokens");
        // Mints the specified amount and assign it to the provided address.
        _mint(account, amount);
    }

    // Function to burn tokens from the user's balance
    function burnTokens(address account, uint256 amount) public {
        // Ensures that there is a sufficient balance to burn the tokens.
        require(balanceOf(account) >= amount, "ERROR: Insufficient balance");
        // Burn the amount from the user's balance.
        _burn(account, amount);
    }

    // Function to change the account address.
    function setAccount(address changeAccount) public {
        user = changeAccount;
    }

    // Transfer function to allow users to transfer tokens.
    function transfer(address spender, uint256 amount) public override returns (bool) {
        // Ensures that the address is valid, amount is greater than 0, and that there is a sufficient balance.
        require(spender != address(0), "ERROR: Invalid Address");
        require(amount > 0, "ERROR: Amount should be greater than 0");
        require(balanceOf(owner) >= amount, "ERROR: Insufficient balance");
        _transfer(user, spender, amount);
        return true;
    }

    // Approve function to allow users to approve spending tokens.
    function approve(address spender, uint256 amount) public override returns (bool) {
        // Ensures that the address is valid.
        require(spender != address(0), "ERROR: Invalid Address");
        _approve(user, spender, amount);
        return true;
    }

    // TransferFrom function to allow users to transfer tokens from an approved allowance.
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        // Ensures that the address is valid, amount is greater than 0, 
        // there' s a sufficient balance, and the amount doesn't exceed alloted allowance.
        require(to != address(0), "ERROR: Invalid Address");
        require(amount > 0, "ERROR: Amount should be greater than 0");
        require(balanceOf(from) >= amount, "ERROR: Insufficient balance");
        require(allowance(from, user) >= amount, "ERROR: Allowance exceeded");
        _transfer(from, to, amount);
        _approve(from, user, allowance(from, user) - amount);
        return true;
    }
}
