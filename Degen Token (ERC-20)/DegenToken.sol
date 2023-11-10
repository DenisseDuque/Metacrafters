// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    constructor() ERC20("Degen", "DGN") Ownable (msg.sender) {}

    function mintTokens(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "ERROR: Invalid recipient address");
        require(amount > 0, "ERROR: Minted amount must be greater than zero");
        _mint(to, amount);
    }
    
    function burnTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "ERROR: Account has insufficient balance");
        require(amount > 0, "ERROR: Burn amount must be greater than zero");
        _burn(msg.sender, amount);
    }

    function transfer(address recipient, uint256 amount) override public returns (bool) {
        require(recipient != address(0), "ERROR: Invalid recipient address");
        require(amount > 0, "ERROR: Transfer amount must be greater than zero");
        require(balanceOf(_msgSender()) >= amount, "ERROR: Insufficient balance");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function redeemTokens(uint256 choice) public returns (bool) {
        uint256 tokens;
        string memory itemName;

        if (choice == 1) {
            tokens = 100; // Cost for Game Card
            itemName = "Game Card";
        } else if (choice == 2) {
            tokens = 200; // Cost for Coffee Mug
            itemName = "Coffee Mug";
        } else if (choice == 3) {
            tokens = 300; // Cost for Action Figure
            itemName = "Action Figure";
        } else {
            revert("ERROR: Invalid input, please try again");
        }

        require(balanceOf(msg.sender) >= tokens, "ERROR: Account has insufficient balance");
        emit redeemItems(msg.sender, choice, itemName);
        _burn(msg.sender, tokens); // Burn the redeemed tokens.
       return true;
    }
    
    event redeemItems(address indexed player, uint256 amount, string itemName);

    function displayItems() public pure returns (string memory) {
        return "Items in the in-game store:\n 1: Game Card for 100 Tokens\n 2: Coffee Mug for 200 Tokens\n3: Action Figure for 300 Tokens";
    } 
    
    function balanceOf(address account) public view override returns (uint256) {
        require(account != address(0), "ERROR: Invalid address");
        return super.balanceOf(account);
    }

    function pronounceOwnership(address newOwner) external {
        require(owner() == address(0), "ERROR: Ownership already pronounced");
        _transferOwnership(newOwner);
    }
}

